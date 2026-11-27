// Runs both CPUs on the same program and prints the comparison.
`timescale 1ns/1ps
module tb;
   reg clk = 0, reset = 1;
   always #5 clk = ~clk;

   rvmyth_core #(.PIPELINED(1)) pipe (.clk(clk), .reset(reset));
   rvmyth_core #(.PIPELINED(0)) nonp (.clk(clk), .reset(reset));

   integer i, errors, cycle;
   reg [31:0] expect_c [0:8];

   task check_and_report(input [8*14:1] name, input integer cycles, input integer instr,
                         input integer branches, input integer taken,
                         input integer loads, input integer jumps);
      begin
         $display("---------- %0s ----------", name);
         $display("Latency (clock cycles) : %0d", cycles);
         $display("Instructions executed  : %0d", instr);
         $display("CPI                    : %0.3f", 1.0 * cycles / instr);
         $display("Conditional branches   : %0d   taken: %0d", branches, taken);
         $display("Loads: %0d   Jumps: %0d", loads, jumps);
      end
   endtask

   initial begin
      for (i = 0; i < 128; i = i + 1) begin pipe.imem[i] = 32'h13; nonp.imem[i] = 32'h13; end
      $readmemh("asm/gemm.hex", pipe.imem, 0, 74);
      $readmemh("asm/gemm.hex", nonp.imem, 0, 74);
      expect_c[0]=30;  expect_c[1]=24;  expect_c[2]=18;
      expect_c[3]=84;  expect_c[4]=69;  expect_c[5]=54;
      expect_c[6]=138; expect_c[7]=114; expect_c[8]=90;
      if ($test$plusargs("vcd")) begin $dumpfile("sim/gemm.vcd"); $dumpvars(0, tb); end
      repeat (5) @(posedge clk);
      #1 reset = 0;
      cycle = 0;
      while (!(pipe.done && nonp.done) && cycle < 10000) begin @(posedge clk); cycle = cycle + 1; end
      repeat (3) @(posedge clk);
      errors = (pipe.done && nonp.done) ? 0 : 1;
      for (i = 0; i < 9; i = i + 1) begin
         if (pipe.dmem[18+i] !== expect_c[i]) errors = errors + 1;
         if (nonp.dmem[18+i] !== expect_c[i]) errors = errors + 1;
      end
      $display("Result C (pipelined CPU):");
      for (i = 0; i < 3; i = i + 1)
         $display("   %4d %4d %4d", pipe.dmem[18+3*i], pipe.dmem[19+3*i], pipe.dmem[20+3*i]);
      check_and_report("NON-PIPELINED", nonp.cnt_cycles, nonp.cnt_instr, nonp.cnt_branch,
                       nonp.cnt_taken, nonp.cnt_load, nonp.cnt_jump);
      check_and_report("PIPELINED", pipe.cnt_cycles, pipe.cnt_instr, pipe.cnt_branch,
                       pipe.cnt_taken, pipe.cnt_load, pipe.cnt_jump);
      $display("Branch misses          : %0d", pipe.cnt_taken);
      $display("Branch penalty cycles  : %0d (2 per miss)", 2 * pipe.cnt_taken);
      $display("Load penalty cycles    : %0d", 2 * pipe.cnt_load);
      $display("Jump penalty cycles    : %0d", 2 * pipe.cnt_jump);
      $display("Speed-up in cycles     : %0.3f", 1.0 * nonp.cnt_cycles / pipe.cnt_cycles);
      if (errors == 0) $display("RESULT: PASSED (both CPUs computed the correct C)");
      else             $display("RESULT: FAILED (%0d errors)", errors);
      $finish;
   end
endmodule
