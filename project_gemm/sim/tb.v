// Runs both CPUs on the same program and prints the comparison.
`timescale 1ns/1ps
module tb;
   reg clk = 0, reset = 1;
   always #5 clk = ~clk;

   rvmyth_core #(.PIPELINED(1)) pipe (.clk(clk), .reset(reset));
   rvmyth_core #(.PIPELINED(0)) nonp (.clk(clk), .reset(reset));

   integer i, errors, cycle;
   reg [31:0] expect_c [0:3];

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
      $readmemh("asm/gemm.hex", pipe.imem, 0, 51);
      $readmemh("asm/gemm.hex", nonp.imem, 0, 51);
      expect_c[0]=4;  expect_c[1]=5;  expect_c[2]=10;  expect_c[3]=11;
      if ($test$plusargs("vcd")) begin $dumpfile("sim/gemm.vcd"); $dumpvars(0, tb); end
      repeat (5) @(posedge clk);
      #1 reset = 0;
      cycle = 0;
      while (!(pipe.done && nonp.done) && cycle < 10000) begin @(posedge clk); cycle = cycle + 1; end
      repeat (3) @(posedge clk);
      errors = (pipe.done && nonp.done) ? 0 : 1;
      for (i = 0; i < 4; i = i + 1) begin
         if (pipe.dmem[24+i] !== expect_c[i]) errors = errors + 1;
         if (nonp.dmem[24+i] !== expect_c[i]) errors = errors + 1;
      end
      $display("Input matrix A (2x2)");
      for (i = 16; i < 20; i = i + 2) $display("   %4d %4d", pipe.dmem[i], pipe.dmem[i+1]);
      $display("Input matrix B (2x2)");
      for (i = 20; i < 24; i = i + 2) $display("   %4d %4d", pipe.dmem[i], pipe.dmem[i+1]);
      $display("Output matrix C = A x B");
      for (i = 24; i < 28; i = i + 2) $display("   %4d %4d", pipe.dmem[i], pipe.dmem[i+1]);
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
