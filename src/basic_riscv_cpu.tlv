\TLV
   |cpu
      @1
         $reset = *reset;
         $valid = ! $reset;

         // 1. Program counter (counts instructions, so +1)
         $pc[31:0] = >>1$reset    ? 32'd0       :
                     >>1$taken_br ? >>1$br_tgt  :
                                    >>1$pc + 32'd1;

         // 2. Instruction memory: sum 1 to 9, store it, load it back
         $instr[31:0] = ($pc == 32'd0) ? 32'h00000513 :  // addi x10, x0, 0
                        ($pc == 32'd1) ? 32'h00A00613 :  // addi x12, x0, 10
                        ($pc == 32'd2) ? 32'h00100693 :  // addi x13, x0, 1
                        ($pc == 32'd3) ? 32'h00D50533 :  // add  x10, x10, x13
                        ($pc == 32'd4) ? 32'h00168693 :  // addi x13, x13, 1
                        ($pc == 32'd5) ? 32'hFEC6CCE3 :  // blt  x13, x12, -8
                        ($pc == 32'd6) ? 32'h00A02223 :  // sw   x10, 4(x0)
                        ($pc == 32'd7) ? 32'h00402783 :  // lw   x15, 4(x0)
                                         32'h00000063;   // beq  x0, x0, 0

         // 3. Decoder
         $opcode[6:0] = $instr[6:0];
         $rd[4:0]     = $instr[11:7];
         $funct3[2:0] = $instr[14:12];
         $rs1[4:0]    = $instr[19:15];
         $rs2[4:0]    = $instr[24:20];
         $funct7[6:0] = $instr[31:25];

         $is_add  = $opcode == 7'b0110011 && $funct3 == 3'b000 && $funct7 == 7'b0000000;
         $is_sub  = $opcode == 7'b0110011 && $funct3 == 3'b000 && $funct7 == 7'b0100000;
         $is_addi = $opcode == 7'b0010011 && $funct3 == 3'b000;
         $is_lw   = $opcode == 7'b0000011 && $funct3 == 3'b010;
         $is_sw   = $opcode == 7'b0100011 && $funct3 == 3'b010;
         $is_beq  = $opcode == 7'b1100011 && $funct3 == 3'b000;
         $is_bne  = $opcode == 7'b1100011 && $funct3 == 3'b001;
         $is_blt  = $opcode == 7'b1100011 && $funct3 == 3'b100;
         $is_br   = $is_beq || $is_bne || $is_blt;

         // Immediate (S, B or I format)
         $imm[31:0] = $is_sw ? {{20{$instr[31]}}, $instr[31:25], $instr[11:7]} :
                      $is_br ? {{20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0} :
                               {{20{$instr[31]}}, $instr[31:20]};

         // 4. Register file read
         $src1[31:0] = /xreg[$rs1]>>1$value;
         $src2[31:0] = /xreg[$rs2]>>1$value;

         // 5. ALU
         $result[31:0] = $is_add  ? $src1 + $src2 :
                         $is_sub  ? $src1 - $src2 :
                         $is_addi ? $src1 + $imm  :
                                    32'd0;

         // 6. Branch logic (byte offset divided by 4)
         $taken_br = $valid && (
                     ($is_beq && ($src1 == $src2)) ||
                     ($is_bne && ($src1 != $src2)) ||
                     ($is_blt && (($src1 < $src2) ^ ($src1[31] != $src2[31]))));
         $br_tgt[31:0] = $pc + {{2{$imm[31]}}, $imm[31:2]};

         // 7. Data memory (8 words)
         $addr[31:0] = $src1 + $imm;
         $sw_en = $valid && $is_sw;

         /dmem[7:0]
            $wr = |cpu$sw_en && (|cpu$addr[4:2] == #dmem);
            $value[31:0] = |cpu$reset ? 32'd0 :
                           $wr        ? |cpu$src2 :
                                        >>1$value;

         $ld_data[31:0] = /dmem[$addr[4:2]]>>1$value;

         // 8. Register file write (x0 stays zero)
         $wr_en = $valid && ($is_add || $is_sub || $is_addi || $is_lw) && ($rd != 5'd0);
         $wr_data[31:0] = $is_lw ? $ld_data : $result;

         /xreg[31:0]
            $wr = |cpu$wr_en && (|cpu$rd == #xreg);
            $value[31:0] = |cpu$reset ? 32'd0 :
                           $wr        ? |cpu$wr_data :
                                        >>1$value;

   // Pass when x15 holds 1+2+...+9 = 45
   *passed = |cpu/xreg[15]>>1$value == 32'd45;
   *failed = *cyc_cnt > 60;
\SV
   endmodule
