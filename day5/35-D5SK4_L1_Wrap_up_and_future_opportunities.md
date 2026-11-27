# 35-D5SK4_L1_Wrap_up_and_future_opportunities

## Overview

The workshop path connects software, the ISA and a hardware implementation.

---

## Key Concepts

Topics to review:
- RISC-V toolchain, integer representation and ABI
- Combinational, sequential and pipelined logic
- CPU fetch, decode, execute, memory access and hazards

Possible next steps:
- Test more instructions and corner cases.
- Study the official RISC-V compliance and architecture tests.
- Try the design on an FPGA, or explore an RTL-to-GDSII flow.
- Learn about interrupts, caches, branch prediction and extensions.

---

## My Lab Work and Results

### What I built

I started with software. I compiled C programs for RISC-V with GCC, read the assembly with `objdump`, used Spike, and checked signed and unsigned limits. I also called an assembly routine from a C program and ran a sum program on a RISC-V CPU in simulation.

Next, I learned TL-Verilog in Makerchip by building logic circuits, calculators and pipelines with validity.

Then I built a small RISC-V CPU step by step:

1. Program counter, instruction fetch and decode
2. Register file, `add` and `addi`, and branches
3. A version that runs one instruction every three cycles
4. A pipeline with register bypass and branch handling
5. Load, store and data memory
6. Decode for more RV32I instructions, and control for `jal` and `jalr`

My 3-cycle CPU passed its test in Makerchip: the program added 1 to 9 and `x10` reached 45. The messages in its log also showed me where data and control hazards occur.

### What was difficult

- **TL-Verilog layout:** wrong indentation caused compile errors. `%s` inside a `$display` message also stopped the compile.
- **Reading waveforms:** signals were sometimes collapsed or out of view. An instruction also appears one cycle after its PC.
- **Timing between instructions:** I had to understand what `>>1`, `>>2` and `>>3` mean in each version.
- **Hazards:** a result may be needed before it is in the register file, and instructions after a branch or load may have to be cancelled.

### Where my CPU stands

- It is a learning CPU, not a complete RV32I core.
- Many instructions are decoded but their ALU operations are not added yet.
- `sb` and `sh` are not handled as byte and half-word stores.
- For the later pipeline versions, I have not yet recorded a passing simulation log on their pages.
- Some results are still marked **Pending**, including the `jal` and `jalr` waveform.

### What I will try next

1. Record the pending waveforms and simulation logs.
2. Complete the ALU and test each instruction with normal and edge-case values.
3. Add byte and half-word loads and stores.
4. Run the official RISC-V architecture tests when the core supports enough instructions.
5. Try the design on an FPGA.
6. Explore connecting my own logic to a RISC-V core such as SHAKTI or VEGA.

---

## Summary

- A working core is a starting point for verification and further design.
