\m4_TLV_version 1d: tl-x.org
\SV
   // RVMYTH running a 2x2 GEMM program: @TITLE@
   // GENERATED FILE: edit scripts/rvmyth_template.tlv, then run scripts/make_tlv.py
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)

\TLV
   // Program: machine code of c/gemm.c and c/start.s (see asm/gemm.objdump.txt)
   \SV_plus
      logic [31:0] instrs [0:@LAST@];
@PROGRAM@

   |cpu
      @0
         $reset = *reset;

@PC@
         $imem_rd_addr[6:0] = $pc[8:2];

      @1
         // Instruction memory
         /imem[@LAST@:0]
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
@VALID@
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
                  \$display("================ GEMM REPORT: @TITLE@ ================");
@PRINT_MATRICES@
                  \$display("-----------------------------------------------------");
                  \$display("Latency (clock cycles)     : %0d", $cnt_cycles);
                  \$display("Instructions executed      : %0d", $cnt_instr);
                  \$display("CPI                        : %0d.%03d", $cnt_cycles / $cnt_instr,
                            (($cnt_cycles % $cnt_instr) * 1000) / $cnt_instr);
                  \$display("Conditional branches       : %0d", $cnt_branch);
                  \$display("Taken branches             : %0d", $cnt_taken);
                  \$display("Loads                      : %0d", $cnt_load);
                  \$display("Jumps (jal, jalr)          : %0d", $cnt_jump);
@PENALTY@
                  \$display("=====================================================");
               end
            end

   // Pass when the program has ended and every element of C is correct.
   // >>9 raises "passed" 4 cycles after the report prints, so the log is not cut off
   *passed = |cpu>>9$done &&
@PASS@
   *failed = *cyc_cnt > @FAILCYC@;
\SV
   endmodule
