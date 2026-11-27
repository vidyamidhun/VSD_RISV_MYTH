\m4_TLV_version 1d: tl-x.org
\SV
   // RVMYTH running a 2x2 GEMM program: NON-PIPELINED
   // GENERATED FILE: edit scripts/rvmyth_template.tlv, then run scripts/make_tlv.py
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)

\TLV
   // Program: machine code of c/gemm.c and c/start.s (see asm/gemm.objdump.txt)
   \SV_plus
      logic [31:0] instrs [0:56];
      assign instrs[0] = 32'h10000113;   // 000: li x2,256
      assign instrs[1] = 32'h008000ef;   // 004: jal c <main>
      assign instrs[2] = 32'h0000006f;   // 008: j 8 <halt>
      assign instrs[3] = 32'h00100713;   // 00c: li x14,1
      assign instrs[4] = 32'h04e02023;   // 010: sw x14,64(x0) # 40 <main+0x34>
      assign instrs[5] = 32'h00200793;   // 014: li x15,2
      assign instrs[6] = 32'h04f02223;   // 018: sw x15,68(x0) # 44 <main+0x38>
      assign instrs[7] = 32'h00300693;   // 01c: li x13,3
      assign instrs[8] = 32'h04d02423;   // 020: sw x13,72(x0) # 48 <main+0x3c>
      assign instrs[9] = 32'h00400693;   // 024: li x13,4
      assign instrs[10] = 32'h04d02623;   // 028: sw x13,76(x0) # 4c <main+0x40>
      assign instrs[11] = 32'h04f02823;   // 02c: sw x15,80(x0) # 50 <main+0x44>
      assign instrs[12] = 32'h04e02a23;   // 030: sw x14,84(x0) # 54 <main+0x48>
      assign instrs[13] = 32'h04e02c23;   // 034: sw x14,88(x0) # 58 <main+0x4c>
      assign instrs[14] = 32'h04f02e23;   // 038: sw x15,92(x0) # 5c <main+0x50>
      assign instrs[15] = 32'h00000613;   // 03c: li x12,0
      assign instrs[16] = 32'h00000513;   // 040: li x10,0
      assign instrs[17] = 32'h05800313;   // 044: li x6,88
      assign instrs[18] = 32'h00400e13;   // 048: li x28,4
      assign instrs[19] = 32'h05000713;   // 04c: li x14,80
      assign instrs[20] = 32'h01060893;   // 050: addi x17,x12,16
      assign instrs[21] = 32'h0300006f;   // 054: j 84 <main+0x78>
      assign instrs[22] = 32'h0016fe93;   // 058: andi x29,x13,1
      assign instrs[23] = 32'h000e8463;   // 05c: beqz x29,64 <main+0x58>
      assign instrs[24] = 32'h00b787b3;   // 060: add x15,x15,x11
      assign instrs[25] = 32'h00159593;   // 064: slli x11,x11,0x1
      assign instrs[26] = 32'h0016d693;   // 068: srli x13,x13,0x1
      assign instrs[27] = 32'hfe0696e3;   // 06c: bnez x13,58 <main+0x4c>
      assign instrs[28] = 32'h00e886b3;   // 070: add x13,x17,x14
      assign instrs[29] = 32'h010787b3;   // 074: add x15,x15,x16
      assign instrs[30] = 32'h00f6a023;   // 078: sw x15,0(x13)
      assign instrs[31] = 32'h00470713;   // 07c: addi x14,x14,4
      assign instrs[32] = 32'h02670e63;   // 080: beq x14,x6,bc <main+0xb0>
      assign instrs[33] = 32'h04062683;   // 084: lw x13,64(x12)
      assign instrs[34] = 32'h00072783;   // 088: lw x15,0(x14)
      assign instrs[35] = 32'h00000813;   // 08c: li x16,0
      assign instrs[36] = 32'h02078063;   // 090: beqz x15,b0 <main+0xa4>
      assign instrs[37] = 32'h0017f593;   // 094: andi x11,x15,1
      assign instrs[38] = 32'h00059863;   // 098: bnez x11,a8 <main+0x9c>
      assign instrs[39] = 32'h00169693;   // 09c: slli x13,x13,0x1
      assign instrs[40] = 32'h0017d793;   // 0a0: srli x15,x15,0x1
      assign instrs[41] = 32'hfedff06f;   // 0a4: j 90 <main+0x84>
      assign instrs[42] = 32'h00d80833;   // 0a8: add x16,x16,x13
      assign instrs[43] = 32'hff1ff06f;   // 0ac: j 9c <main+0x90>
      assign instrs[44] = 32'h04462583;   // 0b0: lw x11,68(x12)
      assign instrs[45] = 32'h00872683;   // 0b4: lw x13,8(x14)
      assign instrs[46] = 32'hfb5ff06f;   // 0b8: j 6c <main+0x60>
      assign instrs[47] = 32'h00250513;   // 0bc: addi x10,x10,2
      assign instrs[48] = 32'h00860613;   // 0c0: addi x12,x12,8
      assign instrs[49] = 32'hf9c514e3;   // 0c4: bne x10,x28,4c <main+0x40>
      assign instrs[50] = 32'h00000513;   // 0c8: li x10,0
      assign instrs[51] = 32'h00008067;   // 0cc: ret
      assign instrs[52] = 32'h00000013;   // nop (padding)
      assign instrs[53] = 32'h00000013;   // nop (padding)
      assign instrs[54] = 32'h00000013;   // nop (padding)
      assign instrs[55] = 32'h00000013;   // nop (padding)
      assign instrs[56] = 32'h00000013;   // nop (padding)

   |cpu
      @0
         $reset = *reset;

         // One instruction at a time: a new one starts every 3rd cycle
         $start = >>1$reset && ! $reset;
         $slot  = $reset ? 1'b0 :
                  $start ? 1'b1 :
                           >>3$slot;

         // The PC changes only after the previous instruction has finished
         $pc[31:0] = >>1$reset          ? 32'd0 :
                     >>3$valid_taken_br ? >>3$br_tgt_pc :
                     >>3$valid_jal      ? >>3$br_tgt_pc :
                     >>3$valid_jalr     ? >>3$jalr_tgt_pc :
                     >>3$valid          ? >>3$inc_pc :
                                          >>1$pc;
         $imem_rd_addr[6:0] = $pc[8:2];

      @1
         // Instruction memory
         /imem[56:0]
            $word[31:0] = *instrs\[#imem\];
         $instr[31:0] = /imem[$imem_rd_addr]$word;

         $inc_pc[31:0] = $pc + 32'd4;

         // Instruction fields
         $opcode[6:0] = $instr[6:0];
         $funct3[2:0] = $instr[14:12];
         $rd[4:0]     = $instr[11:7];
         $rs1[4:0]    = $instr[19:15];
         $rs2[4:0]    = $instr[24:20];

         // Instruction type and immediate
         $is_r_instr = $opcode == 7'b0110011;
         $is_i_instr = $opcode == 7'b0000011 || $opcode == 7'b0010011 || $opcode == 7'b1100111;
         $is_s_instr = $opcode == 7'b0100011;
         $is_b_instr = $opcode == 7'b1100011;
         $is_u_instr = $opcode == 7'b0110111 || $opcode == 7'b0010111;
         $is_j_instr = $opcode == 7'b1101111;

         $imm[31:0] = $is_i_instr ? {{21{$instr[31]}}, $instr[30:20]} :
                      $is_s_instr ? {{21{$instr[31]}}, $instr[30:25], $instr[11:7]} :
                      $is_b_instr ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0} :
                      $is_u_instr ? {$instr[31:12], 12'b0} :
                      $is_j_instr ? {{12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0} :
                                    32'b0;

         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;

         // Only word loads and stores (lw, sw) are supported
         $is_load  = $opcode == 7'b0000011;
         $is_store = $is_s_instr;

         // Instruction decode
         $dec_bits[10:0] = {$instr[30], $funct3, $opcode};

         $is_lui   = $dec_bits ==? 11'bx_xxx_0110111;
         $is_auipc = $dec_bits ==? 11'bx_xxx_0010111;
         $is_jal   = $dec_bits ==? 11'bx_xxx_1101111;
         $is_jalr  = $dec_bits ==? 11'bx_000_1100111;

         $is_beq   = $dec_bits ==? 11'bx_000_1100011;
         $is_bne   = $dec_bits ==? 11'bx_001_1100011;
         $is_blt   = $dec_bits ==? 11'bx_100_1100011;
         $is_bge   = $dec_bits ==? 11'bx_101_1100011;
         $is_bltu  = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu  = $dec_bits ==? 11'bx_111_1100011;

         $is_addi  = $dec_bits ==? 11'bx_000_0010011;
         $is_slti  = $dec_bits ==? 11'bx_010_0010011;
         $is_sltiu = $dec_bits ==? 11'bx_011_0010011;
         $is_xori  = $dec_bits ==? 11'bx_100_0010011;
         $is_ori   = $dec_bits ==? 11'bx_110_0010011;
         $is_andi  = $dec_bits ==? 11'bx_111_0010011;
         $is_slli  = $dec_bits ==? 11'b0_001_0010011;
         $is_srli  = $dec_bits ==? 11'b0_101_0010011;
         $is_srai  = $dec_bits ==? 11'b1_101_0010011;

         $is_add   = $dec_bits ==? 11'b0_000_0110011;
         $is_sub   = $dec_bits ==? 11'b1_000_0110011;
         $is_sll   = $dec_bits ==? 11'b0_001_0110011;
         $is_slt   = $dec_bits ==? 11'b0_010_0110011;
         $is_sltu  = $dec_bits ==? 11'b0_011_0110011;
         $is_xor   = $dec_bits ==? 11'b0_100_0110011;
         $is_srl   = $dec_bits ==? 11'b0_101_0110011;
         $is_sra   = $dec_bits ==? 11'b1_101_0110011;
         $is_or    = $dec_bits ==? 11'b0_110_0110011;
         $is_and   = $dec_bits ==? 11'b0_111_0110011;

      @2
         // Register file read, with bypass of the value being written now
         $src1_value[31:0] = (>>1$rf_wr_en && (>>1$rf_wr_index == $rs1)) ? >>1$rf_wr_data :
                                                                          /xreg[$rs1]>>2$value;
         $src2_value[31:0] = (>>1$rf_wr_en && (>>1$rf_wr_index == $rs2)) ? >>1$rf_wr_data :
                                                                          /xreg[$rs2]>>2$value;

         $br_tgt_pc[31:0]   = $pc + $imm;
         $jalr_tgt_pc[31:0] = ($src1_value + $imm) & 32'hFFFF_FFFE;

      @3
         // Only one instruction is in flight, so nothing has to be cancelled
         $valid = ! $reset && $slot;
         $valid_load = $valid && $is_load;
         $valid_jal  = $valid && $is_jal;
         $valid_jalr = $valid && $is_jalr;
         $valid_jump = $valid_jal || $valid_jalr;

         // Branch decision (no predictor: fetch always continues as "not taken")
         $taken_br = $is_beq  ? ($src1_value == $src2_value) :
                     $is_bne  ? ($src1_value != $src2_value) :
                     $is_blt  ? ($src1_value <  $src2_value) ^ ($src1_value[31] != $src2_value[31]) :
                     $is_bge  ? ($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31]) :
                     $is_bltu ? ($src1_value <  $src2_value) :
                     $is_bgeu ? ($src1_value >= $src2_value) :
                                1'b0;
         $valid_taken_br = $valid && $taken_br;

         // ALU
         $shamt[4:0]      = $is_r_instr ? $src2_value[4:0] : $imm[4:0];
         $op2[31:0]       = $is_r_instr ? $src2_value : $imm;
         $less_u          = $src1_value < $op2;
         $less_s          = $less_u ^ ($src1_value[31] != $op2[31]);
         $sra_wide[63:0]  = {{32{$src1_value[31]}}, $src1_value} >> $shamt;

         $result[31:0] = ($is_load || $is_store) ? $src1_value + $imm :
                         ($is_jal || $is_jalr)   ? $inc_pc :
                         $is_lui                 ? $imm :
                         $is_auipc               ? $br_tgt_pc :
                         ($is_addi || $is_add)   ? $src1_value + $op2 :
                         $is_sub                 ? $src1_value - $src2_value :
                         ($is_slli || $is_sll)   ? $src1_value << $shamt :
                         ($is_srli || $is_srl)   ? $src1_value >> $shamt :
                         ($is_srai || $is_sra)   ? $sra_wide[31:0] :
                         ($is_slti || $is_slt)   ? {31'b0, $less_s} :
                         ($is_sltiu || $is_sltu) ? {31'b0, $less_u} :
                         ($is_xori || $is_xor)   ? $src1_value ^ $op2 :
                         ($is_ori  || $is_or)    ? $src1_value | $op2 :
                         ($is_andi || $is_and)   ? $src1_value & $op2 :
                                                   32'b0;

         // Register file write: ALU result, or load data from the load 2 cycles ago
         $rf_wr_en         = ($valid && $rd_valid && ! $is_load && $rd != 5'b0) ||
                             (>>2$valid_load && >>2$rd != 5'b0);
         $rf_wr_index[4:0] = >>2$valid_load ? >>2$rd      : $rd;
         $rf_wr_data[31:0] = >>2$valid_load ? >>2$ld_data : $result;

         /xreg[31:0]
            $wr = |cpu$rf_wr_en && (|cpu$rf_wr_index == #xreg);
            $value[31:0] = |cpu$reset ? 32'b0 :
                           $wr        ? |cpu$rf_wr_data :
                                        $RETAIN;

         // ----- Performance counters -----
         // "j halt" (0x0000006f) marks the end of the program and is not counted
         $halt_now = $valid && ($instr == 32'h0000006F);
         $done     = $reset ? 1'b0 : (>>1$done || $halt_now);
         $started  = $reset ? 1'b0 : (>>1$started || $valid);
         $count_on = $started && ! $done;

         $cnt_cycles[31:0] = $reset ? 32'b0 : >>1$cnt_cycles + {31'b0, $count_on};
         $cnt_instr[31:0]  = $reset ? 32'b0 : >>1$cnt_instr  + {31'b0, $count_on && $valid};
         $cnt_branch[31:0] = $reset ? 32'b0 : >>1$cnt_branch + {31'b0, $count_on && $valid && $is_b_instr};
         $cnt_taken[31:0]  = $reset ? 32'b0 : >>1$cnt_taken  + {31'b0, $count_on && $valid_taken_br};
         $cnt_load[31:0]   = $reset ? 32'b0 : >>1$cnt_load   + {31'b0, $count_on && $valid_load};
         $cnt_jump[31:0]   = $reset ? 32'b0 : >>1$cnt_jump   + {31'b0, $count_on && $valid_jump};

         $report = $halt_now && ! >>1$done;

      @4
         // Data memory: 64 words
         $dmem_wr_en         = $valid && $is_store;
         $dmem_addr[5:0]     = $result[7:2];
         $dmem_wr_data[31:0] = $src2_value;

         /dmem[63:0]
            $wr = |cpu$dmem_wr_en && (|cpu$dmem_addr == #dmem);
            $value[31:0] = |cpu$reset ? 32'b0 :
                           $wr        ? |cpu$dmem_wr_data :
                                        $RETAIN;

         $dmem_rd_data[31:0] = /dmem[$dmem_addr]>>1$value;

      @5
         $ld_data[31:0] = $dmem_rd_data;

         // ----- Report, printed once when the program ends -----
         \SV_plus
            always_ff @(posedge *clk) begin
               if ($report) begin
                  \$display("================ GEMM REPORT: NON-PIPELINED ================");
                  \$display("Input matrix A (2x2)");
                  \$display("   %4d %4d", /dmem[16]>>1$value, /dmem[17]>>1$value);
                  \$display("   %4d %4d", /dmem[18]>>1$value, /dmem[19]>>1$value);
                  \$display("Input matrix B (2x2)");
                  \$display("   %4d %4d", /dmem[20]>>1$value, /dmem[21]>>1$value);
                  \$display("   %4d %4d", /dmem[22]>>1$value, /dmem[23]>>1$value);
                  \$display("Output matrix C = A x B");
                  \$display("   %4d %4d", /dmem[24]>>1$value, /dmem[25]>>1$value);
                  \$display("   %4d %4d", /dmem[26]>>1$value, /dmem[27]>>1$value);
                  \$display("-----------------------------------------------------");
                  \$display("Latency (clock cycles)     : %0d", $cnt_cycles);
                  \$display("Instructions executed      : %0d", $cnt_instr);
                  \$display("CPI                        : %0d.%03d", $cnt_cycles / $cnt_instr,
                            (($cnt_cycles % $cnt_instr) * 1000) / $cnt_instr);
                  \$display("Conditional branches       : %0d", $cnt_branch);
                  \$display("Taken branches             : %0d", $cnt_taken);
                  \$display("Loads                      : %0d", $cnt_load);
                  \$display("Jumps (jal, jalr)          : %0d", $cnt_jump);
                  \$display("Branch misses              : 0  (next fetch waits for the branch)");
                  \$display("Branch penalty cycles      : 0  (every instruction takes 3 cycles)");
                  \$display("Check: 3 x instructions    = %0d", 3 * $cnt_instr);
                  \$display("=====================================================");
               end
            end

   // Pass when the program has ended and every element of C is correct.
   // >>9 raises "passed" 4 cycles after the report prints, so the log is not cut off
   *passed = |cpu>>9$done &&
             |cpu/dmem[24]>>5$value == 32'd4 &&
             |cpu/dmem[25]>>5$value == 32'd5 &&
             |cpu/dmem[26]>>5$value == 32'd10 &&
             |cpu/dmem[27]>>5$value == 32'd11;
   *failed = *cyc_cnt > 560;
\SV
   endmodule
