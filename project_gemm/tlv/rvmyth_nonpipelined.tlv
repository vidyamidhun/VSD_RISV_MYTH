\m4_TLV_version 1d: tl-x.org
\SV
   // RVMYTH running a 3x3 GEMM program: NON-PIPELINED
   // GENERATED FILE: edit scripts/rvmyth_template.tlv, then run scripts/make_tlv.py
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)

\TLV
   // Program: machine code of c/gemm.c and c/start.s (see asm/gemm.objdump.txt)
   \SV_plus
      logic [31:0] instrs [0:79];
      assign instrs[0] = 32'h10000113;   // 000: li x2,256
      assign instrs[1] = 32'h044000ef;   // 004: jal 48 <main>
      assign instrs[2] = 32'h0000006f;   // 008: j 8 <halt>
      assign instrs[3] = 32'h00050713;   // 00c: mv x14,x10
      assign instrs[4] = 32'h00058793;   // 010: mv x15,x11
      assign instrs[5] = 32'h02058663;   // 014: beqz x11,40 <soft_mul+0x34>
      assign instrs[6] = 32'h00000513;   // 018: li x10,0
      assign instrs[7] = 32'h0100006f;   // 01c: j 2c <soft_mul+0x20>
      assign instrs[8] = 32'h00171713;   // 020: slli x14,x14,0x1
      assign instrs[9] = 32'h0017d793;   // 024: srli x15,x15,0x1
      assign instrs[10] = 32'h00078a63;   // 028: beqz x15,3c <soft_mul+0x30>
      assign instrs[11] = 32'h0017f693;   // 02c: andi x13,x15,1
      assign instrs[12] = 32'hfe0688e3;   // 030: beqz x13,20 <soft_mul+0x14>
      assign instrs[13] = 32'h00e50533;   // 034: add x10,x10,x14
      assign instrs[14] = 32'hfe9ff06f;   // 038: j 20 <soft_mul+0x14>
      assign instrs[15] = 32'h00008067;   // 03c: ret
      assign instrs[16] = 32'h00058513;   // 040: mv x10,x11
      assign instrs[17] = 32'h00008067;   // 044: ret
      assign instrs[18] = 32'hfd010113;   // 048: addi x2,x2,-48
      assign instrs[19] = 32'h02112623;   // 04c: sw x1,44(x2)
      assign instrs[20] = 32'h02812423;   // 050: sw x8,40(x2)
      assign instrs[21] = 32'h02912223;   // 054: sw x9,36(x2)
      assign instrs[22] = 32'h03212023;   // 058: sw x18,32(x2)
      assign instrs[23] = 32'h01312e23;   // 05c: sw x19,28(x2)
      assign instrs[24] = 32'h01412c23;   // 060: sw x20,24(x2)
      assign instrs[25] = 32'h01512a23;   // 064: sw x21,20(x2)
      assign instrs[26] = 32'h01612823;   // 068: sw x22,16(x2)
      assign instrs[27] = 32'h01712623;   // 06c: sw x23,12(x2)
      assign instrs[28] = 32'h00000713;   // 070: li x14,0
      assign instrs[29] = 32'h00000793;   // 074: li x15,0
      assign instrs[30] = 32'h00a00593;   // 078: li x11,10
      assign instrs[31] = 32'h00900613;   // 07c: li x12,9
      assign instrs[32] = 32'h00178793;   // 080: addi x15,x15,1
      assign instrs[33] = 32'h00f72023;   // 084: sw x15,0(x14)
      assign instrs[34] = 32'h40f586b3;   // 088: sub x13,x11,x15
      assign instrs[35] = 32'h02d72223;   // 08c: sw x13,36(x14)
      assign instrs[36] = 32'h00470713;   // 090: addi x14,x14,4
      assign instrs[37] = 32'hfec796e3;   // 094: bne x15,x12,80 <main+0x38>
      assign instrs[38] = 32'h00000a93;   // 098: li x21,0
      assign instrs[39] = 32'h00300b13;   // 09c: li x22,3
      assign instrs[40] = 32'h02400b93;   // 0a0: li x23,36
      assign instrs[41] = 32'h04c0006f;   // 0a4: j f0 <main+0xa8>
      assign instrs[42] = 32'h015987b3;   // 0a8: add x15,x19,x21
      assign instrs[43] = 32'h0127a023;   // 0ac: sw x18,0(x15)
      assign instrs[44] = 32'h001a0a13;   // 0b0: addi x20,x20,1
      assign instrs[45] = 32'h00498993;   // 0b4: addi x19,x19,4
      assign instrs[46] = 32'h036a0863;   // 0b8: beq x20,x22,e8 <main+0xa0>
      assign instrs[47] = 32'hfdc98413;   // 0bc: addi x8,x19,-36
      assign instrs[48] = 32'h000a8493;   // 0c0: mv x9,x21
      assign instrs[49] = 32'h00000913;   // 0c4: li x18,0
      assign instrs[50] = 32'h0004a503;   // 0c8: lw x10,0(x9)
      assign instrs[51] = 32'h00042583;   // 0cc: lw x11,0(x8)
      assign instrs[52] = 32'hf3dff0ef;   // 0d0: jal c <soft_mul>
      assign instrs[53] = 32'h00a90933;   // 0d4: add x18,x18,x10
      assign instrs[54] = 32'h00448493;   // 0d8: addi x9,x9,4
      assign instrs[55] = 32'h00c40413;   // 0dc: addi x8,x8,12
      assign instrs[56] = 32'hff3414e3;   // 0e0: bne x8,x19,c8 <main+0x80>
      assign instrs[57] = 32'hfc5ff06f;   // 0e4: j a8 <main+0x60>
      assign instrs[58] = 32'h00ca8a93;   // 0e8: addi x21,x21,12
      assign instrs[59] = 32'h017a8863;   // 0ec: beq x21,x23,fc <main+0xb4>
      assign instrs[60] = 32'h04800993;   // 0f0: li x19,72
      assign instrs[61] = 32'h00000a13;   // 0f4: li x20,0
      assign instrs[62] = 32'hfc5ff06f;   // 0f8: j bc <main+0x74>
      assign instrs[63] = 32'h00000513;   // 0fc: li x10,0
      assign instrs[64] = 32'h02c12083;   // 100: lw x1,44(x2)
      assign instrs[65] = 32'h02812403;   // 104: lw x8,40(x2)
      assign instrs[66] = 32'h02412483;   // 108: lw x9,36(x2)
      assign instrs[67] = 32'h02012903;   // 10c: lw x18,32(x2)
      assign instrs[68] = 32'h01c12983;   // 110: lw x19,28(x2)
      assign instrs[69] = 32'h01812a03;   // 114: lw x20,24(x2)
      assign instrs[70] = 32'h01412a83;   // 118: lw x21,20(x2)
      assign instrs[71] = 32'h01012b03;   // 11c: lw x22,16(x2)
      assign instrs[72] = 32'h00c12b83;   // 120: lw x23,12(x2)
      assign instrs[73] = 32'h03010113;   // 124: addi x2,x2,48
      assign instrs[74] = 32'h00008067;   // 128: ret
      assign instrs[75] = 32'h00000013;   // nop (padding)
      assign instrs[76] = 32'h00000013;   // nop (padding)
      assign instrs[77] = 32'h00000013;   // nop (padding)
      assign instrs[78] = 32'h00000013;   // nop (padding)
      assign instrs[79] = 32'h00000013;   // nop (padding)

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
         /imem[79:0]
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
                  \$display("Result C = A x B");
                  \$display("   %4d %4d %4d", /dmem[18]>>1$value, /dmem[19]>>1$value, /dmem[20]>>1$value);
                  \$display("   %4d %4d %4d", /dmem[21]>>1$value, /dmem[22]>>1$value, /dmem[23]>>1$value);
                  \$display("   %4d %4d %4d", /dmem[24]>>1$value, /dmem[25]>>1$value, /dmem[26]>>1$value);
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

   // Pass when the program has ended and every element of C is correct
   *passed = |cpu>>5$done &&
             |cpu/dmem[18]>>5$value == 32'd30 &&
             |cpu/dmem[19]>>5$value == 32'd24 &&
             |cpu/dmem[20]>>5$value == 32'd18 &&
             |cpu/dmem[21]>>5$value == 32'd84 &&
             |cpu/dmem[22]>>5$value == 32'd69 &&
             |cpu/dmem[23]>>5$value == 32'd54 &&
             |cpu/dmem[24]>>5$value == 32'd138 &&
             |cpu/dmem[25]>>5$value == 32'd114 &&
             |cpu/dmem[26]>>5$value == 32'd90;
   *failed = *cyc_cnt > 4000;
\SV
   endmodule
