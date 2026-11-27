// Plain-Verilog copy of the CPU in tlv/, for simulation with Icarus Verilog.
// PIPELINED = 1 : fetch every cycle, with bypass and cancellation
// PIPELINED = 0 : one instruction at a time (3 cycles each)
// Stage names (@0 ... @5) match the TL-Verilog pipeline.
`timescale 1ns/1ps
module rvmyth_core #(parameter PIPELINED = 1) (input wire clk, input wire reset);
   reg [31:0] imem [0:127];
   reg [31:0] xreg [0:31];
   reg [31:0] dmem [0:63];

   // pipeline registers, named after the stage that reads them
   reg        rst1, rst2, rst3;                  // reset travelling down the pipe
   reg        slot1, slot2, slot3;               // non-pipelined instruction slot
   reg [31:0] pc1, pc2, pc3;
   reg [31:0] instr2, instr3;
   reg [31:0] src1_3, src2_3, btgt3, jtgt3;
   // @4 (memory) and @5 (load data)
   reg        st4, ld4, ld5;
   reg [31:0] result4, wdata4, rdata5;
   reg [4:0]  rd4, rd5;
   // history of the instructions 1 and 2 cycles ahead of @3
   reg        redir1, redir2;
   reg        wr_en1;
   reg [4:0]  wr_idx1;
   reg [31:0] wr_data1;
   // held PC (the instruction fetched last cycle)
   reg [31:0] last_pc;
   reg        start_prev;
   reg [2:0]  slot_hist;                         // slot of the last 3 fetch cycles

   // ---------------- @3 : execute ----------------
   wire [6:0] op  = instr3[6:0];
   wire [2:0] f3  = instr3[14:12];
   wire       alt = instr3[30];
   wire [4:0] rd  = instr3[11:7];
   wire is_r = op == 7'b0110011, is_imm = op == 7'b0010011;
   wire is_load = op == 7'b0000011, is_store = op == 7'b0100011;
   wire is_b = op == 7'b1100011, is_jal = op == 7'b1101111, is_jalr = op == 7'b1100111;
   wire is_lui = op == 7'b0110111, is_auipc = op == 7'b0010111;

   function [31:0] immediate(input [31:0] i);
      case (i[6:0])
         7'b0000011, 7'b0010011, 7'b1100111: immediate = {{21{i[31]}}, i[30:20]};
         7'b0100011: immediate = {{21{i[31]}}, i[30:25], i[11:7]};
         7'b1100011: immediate = {{20{i[31]}}, i[7], i[30:25], i[11:8], 1'b0};
         7'b0110111, 7'b0010111: immediate = {i[31:12], 12'b0};
         7'b1101111: immediate = {{12{i[31]}}, i[19:12], i[20], i[30:21], 1'b0};
         default: immediate = 32'b0;
      endcase
   endfunction

   wire [31:0] imm3 = immediate(instr3);
   wire valid = !rst3 && (PIPELINED ? !(redir1 || redir2) : slot3);

   wire taken = is_b && (
      (f3 == 3'b000) ? (src1_3 == src2_3) :
      (f3 == 3'b001) ? (src1_3 != src2_3) :
      (f3 == 3'b100) ? ($signed(src1_3) <  $signed(src2_3)) :
      (f3 == 3'b101) ? ($signed(src1_3) >= $signed(src2_3)) :
      (f3 == 3'b110) ? (src1_3 <  src2_3) :
      (f3 == 3'b111) ? (src1_3 >= src2_3) : 1'b0);

   wire valid_taken = valid && taken;
   wire valid_load  = valid && is_load;
   wire valid_jal   = valid && is_jal;
   wire valid_jalr  = valid && is_jalr;
   wire redirect    = valid_taken || valid_load || valid_jal || valid_jalr;

   wire [4:0]  shamt = is_r ? src2_3[4:0] : imm3[4:0];
   wire [31:0] op2   = is_r ? src2_3 : imm3;
   wire        lt_u  = src1_3 < op2;
   wire        lt_s  = $signed(src1_3) < $signed(op2);
   wire [31:0] sra   = $signed(src1_3) >>> shamt;

   reg [31:0] result;
   always @* begin
      result = 32'b0;
      if (is_load || is_store)    result = src1_3 + imm3;
      else if (is_jal || is_jalr) result = pc3 + 4;
      else if (is_lui)            result = imm3;
      else if (is_auipc)          result = btgt3;
      else if (is_r || is_imm)
         case (f3)
            3'b000: result = (is_r && alt) ? src1_3 - src2_3 : src1_3 + op2;
            3'b001: result = src1_3 << shamt;
            3'b010: result = {31'b0, lt_s};
            3'b011: result = {31'b0, lt_u};
            3'b100: result = src1_3 ^ op2;
            3'b101: result = alt ? sra : src1_3 >> shamt;
            3'b110: result = src1_3 | op2;
            3'b111: result = src1_3 & op2;
         endcase
   end

   wire rd_valid = is_r || is_imm || is_load || is_jalr || is_jal || is_lui || is_auipc;
   // rd5 / ld5 belong to the instruction 2 cycles ahead, whose load data is ready now
   wire        wr_en   = (valid && rd_valid && !is_load && rd != 0) || (ld5 && rd5 != 0);
   wire [4:0]  wr_idx  = ld5 ? rd5 : rd;
   wire [31:0] wr_data = ld5 ? rdata5 : result;

   // ---------------- @0 : program counter ----------------
   wire start = rst1 && !reset;                 // rst1 = reset one cycle ago
   wire slot  = reset ? 1'b0 : start ? 1'b1 : slot_hist[2];
   wire [31:0] pc =
      rst1        ? 32'd0 :
      valid_taken ? btgt3 :
      (PIPELINED && valid_load) ? pc3 + 4 :
      valid_jal   ? btgt3 :
      valid_jalr  ? jtgt3 :
      PIPELINED   ? pc1 + 4 :
      valid       ? pc3 + 4 :
                    last_pc;

   // ---------------- @2 : register read with bypass ----------------
   wire [4:0]  rs1 = instr2[19:15], rs2 = instr2[24:20];
   wire [31:0] src1 = (wr_en && wr_idx == rs1) ? wr_data : xreg[rs1];
   wire [31:0] src2 = (wr_en && wr_idx == rs2) ? wr_data : xreg[rs2];
   wire [31:0] imm2 = immediate(instr2);

   // ---------------- performance counters ----------------
   reg started, done;
   integer cnt_cycles, cnt_instr, cnt_branch, cnt_taken, cnt_load, cnt_jump;
   wire halt_now = valid && instr3 == 32'h0000006F;
   wire count_on = (started || valid) && !done && !halt_now;

   integer k;
   always @(posedge clk) begin
      // @0 -> @1 -> @2 -> @3
      rst1 <= reset;  rst2 <= rst1;  rst3 <= rst2;
      slot1 <= slot;  slot2 <= slot1; slot3 <= slot2;
      slot_hist <= {slot_hist[1:0], slot};
      pc1 <= pc;      pc2 <= pc1;     pc3 <= pc2;
      last_pc <= pc;
      instr2 <= imem[pc1[8:2]];       instr3 <= instr2;
      src1_3 <= src1; src2_3 <= src2;
      btgt3  <= pc2 + imm2;
      jtgt3  <= (src1 + imm2) & 32'hFFFF_FFFE;
      redir1 <= redirect;             redir2 <= redir1;
      // @3 -> @4 -> @5
      st4 <= valid && is_store;       ld4 <= valid_load;
      result4 <= result;              wdata4 <= src2_3;   rd4 <= rd;
      ld5 <= ld4;                     rd5 <= rd4;
      rdata5 <= dmem[result4[7:2]];
      if (st4) dmem[result4[7:2]] <= wdata4;
      if (wr_en) xreg[wr_idx] <= wr_data;

      if (reset || rst3) begin
         started <= 0; done <= 0;
         cnt_cycles <= 0; cnt_instr <= 0; cnt_branch <= 0;
         cnt_taken <= 0;  cnt_load <= 0;  cnt_jump <= 0;
      end else begin
         if (valid) started <= 1;
         if (halt_now) done <= 1;
         if (count_on) begin
            cnt_cycles <= cnt_cycles + 1;
            if (valid)         cnt_instr  <= cnt_instr + 1;
            if (valid && is_b) cnt_branch <= cnt_branch + 1;
            if (valid_taken)   cnt_taken  <= cnt_taken + 1;
            if (valid_load)    cnt_load   <= cnt_load + 1;
            if (valid_jal || valid_jalr) cnt_jump <= cnt_jump + 1;
         end
      end
      if (reset) begin
         for (k = 0; k < 32; k = k + 1) xreg[k] <= 0;
         for (k = 0; k < 64; k = k + 1) dmem[k] <= 0;
         redir1 <= 0; redir2 <= 0; st4 <= 0; ld4 <= 0; ld5 <= 0; slot_hist <= 0;
      end
   end
endmodule
