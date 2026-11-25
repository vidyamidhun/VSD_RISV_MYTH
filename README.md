# RISC-V based MYTH Program Notes

This repository contains day-wise notes, lab writeups, and lecture documentation for the RISC-V based MYTH (Microprocessor for You in Thirty Hours) program by VLSI System Design.

The workshop covered:
- RISC-V ISA and GNU toolchain
- ABI and verification flow
- Digital logic with TL-Verilog and Makerchip
- Basic and pipelined RISC-V CPU microarchitecture

(Project links, source files and screenshots are at the end.)

---

## Day 1 - Introduction to RISC-V ISA and GNU Compiler Toolchain

### D1SK1 - Introduction to RISC-V basic keywords
- [0-D1SK1_L1 Introduction](day1/0-D1SK1_L1_Introduction.md)
- [1-D1SK1_L2 From apps to hardware](day1/1-D1SK1_L2_From_apps_to_hardware.md)

### D1SK2 - RISC-V software toolchain lab
- [2-D1SK2_L1 C program for sum of 1 to N](day1/2-D1SK2_L1_C_program_for_sum_of_1_to_N.md)
- [3-D1SK2_L2 GCC compile and disassemble](day1/3-D1SK2_L2_GCC_compile_and_disassemble.md)
- [4-D1SK2_L3 Spike simulation and debug](day1/4-D1SK2_L3_Spike_simulation_and_debug.md)

### D1SK3 - Integer number representation
- [5-D1SK3_L1 Unsigned numbers](day1/5-D1SK3_L1_Unsigned_numbers.md)
- [6-D1SK3_L2 Signed numbers](day1/6-D1SK3_L2_Signed_numbers.md)
- [7-D1SK3_L3 Signed and unsigned lab](day1/7-D1SK3_L3_Signed_and_unsigned_lab.md)

---

## Day 2 - Introduction to ABI and Basic Verification Flow

### D2SK1 - Application Binary Interface
- [8-D2SK1_L1 Introduction to ABI](day2/8-D2SK1_L1_Introduction_to_ABI.md)
- [9-D2SK1_L2 Memory allocation and registers](day2/9-D2SK1_L2_Memory_allocation_and_registers.md)
- [10-D2SK1_L3 Load add and store instructions](day2/10-D2SK1_L3_Load_add_and_store_instructions.md)

### D2SK2 - Function calls using the ABI
- [11-D2SK2_L1 Sum of 1 to N using assembly](day2/11-D2SK2_L1_Sum_of_1_to_N_using_assembly.md)
- [12-D2SK2_L2 Simulate C program with function call](day2/12-D2SK2_L2_Simulate_C_program_with_function_call.md)

### D2SK3 - Verification flow using iverilog
- [13-D2SK3_L1 Run program on RISC-V CPU](day2/13-D2SK3_L1_Run_program_on_RISC_V_CPU.md)

---

## Day 3 - Digital Logic with TL-Verilog and Makerchip

### D3SK1 - Combinational logic
- [14-D3SK1_L1 Logic gates and Makerchip](day3/14-D3SK1_L1_Logic_gates_and_Makerchip.md)
- [15-D3SK1_L2 Mux and calculator lab](day3/15-D3SK1_L2_Mux_and_calculator_lab.md)

### D3SK2 - Sequential logic
- [16-D3SK2_L1 Counter and sequential calculator](day3/16-D3SK2_L1_Counter_and_sequential_calculator.md)

### D3SK3 - Pipelined logic
- [17-D3SK3_L1 Pipelined logic lab](day3/17-D3SK3_L1_Pipelined_logic_lab.md)

### D3SK4 - Validity
- [18-D3SK4_L1 Validity lab](day3/18-D3SK4_L1_Validity_lab.md)
- [19-D3SK4_L2 Calculator with memory](day3/19-D3SK4_L2_Calculator_with_memory.md)

### D3SK5 - Hierarchy
- [20-D3SK5_L1 Introduction to hierarchy](day3/20-D3SK5_L1_Introduction_to_hierarchy.md)

---

## Day 4 - Basic RISC-V CPU Microarchitecture

### D4SK1 - Microarchitecture and testbench
- [21-D4SK1_L1 Single cycle CPU architecture](day4/21-D4SK1_L1_Single_cycle_CPU_architecture.md)
- [22-D4SK1_L2 Simple testbench](day4/22-D4SK1_L2_Simple_testbench.md)

### D4SK2 - Fetch decode and execute
- [23-D4SK2_L1 Program counter and instruction fetch](day4/23-D4SK2_L1_Program_counter_and_instruction_fetch.md)
- [24-D4SK2_L2 Instruction decode](day4/24-D4SK2_L2_Instruction_decode.md)
- [25-D4SK2_L3 Register file and ALU](day4/25-D4SK2_L3_Register_file_and_ALU.md)

### D4SK3 - RISC-V control logic
- [26-D4SK3_L1 Register file write](day4/26-D4SK3_L1_Register_file_write.md)
- [27-D4SK3_L2 Branch instructions](day4/27-D4SK3_L2_Branch_instructions.md)

---

## Day 5 - Complete Pipelined RISC-V CPU Microarchitecture

### D5SK1 - Pipelining the CPU
- [28-D5SK1_L1 Pipeline hazards](day5/28-D5SK1_L1_Pipeline_hazards.md)
- [29-D5SK1_L2 Valid signal and pipeline stages](day5/29-D5SK1_L2_Valid_signal_and_pipeline_stages.md)
- [30-D5SK1_L3 Hazard solutions](day5/30-D5SK1_L3_Hazard_solutions.md)

### D5SK2 - Load store instructions and memory
- [31-D5SK2_L1 Load redirect](day5/31-D5SK2_L1_Load_redirect.md)
- [32-D5SK2_L2 Data memory with loads and stores](day5/32-D5SK2_L2_Data_memory_with_loads_and_stores.md)

### D5SK3 - Completing the RISC-V CPU
- [33-D5SK3_L1 Complete decode and ALU](day5/33-D5SK3_L1_Complete_decode_and_ALU.md)
- [34-D5SK3_L2 Jump instructions](day5/34-D5SK3_L2_Jump_instructions.md)

### D5SK4 - Wrap up
- [35-D5SK4_L1 Wrap up and future opportunities](day5/35-D5SK4_L1_Wrap_up_and_future_opportunities.md)

---

## Project Links, Files and Screenshots

Screenshots go in [images](images/) and source code in [src](src/).

<!-- ![Block Diagram](images/BlockDiagram.png) -->
<!-- [Open the source file](src/your_file.v) -->
<!-- [Open the project online](https://your-link) -->
