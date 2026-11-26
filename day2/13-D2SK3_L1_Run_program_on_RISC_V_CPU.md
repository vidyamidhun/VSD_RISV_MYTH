# D2SK3 L1: Running a Program on a RISC-V CPU Using iverilog

## Overview

A RISC-V CPU written in Verilog can run a compiled program in simulation. Icarus Verilog (`iverilog`) is the simulator.

---

## Key Concepts

![Program to simulation flow](../images/diagrams/verification_flow.svg)

1. Compile the program for RISC-V.
2. Convert it to a hex file that the testbench can load into memory.
3. Simulate the CPU and testbench.
4. Compare the CPU result with the expected result.

The general commands, using your lab's file names:

```bash
iverilog -o cpu_sim testbench.v cpu.v
vvp cpu_sim
```

The CPU must support every instruction that the compiled program uses.

---

## My Lab Work and Results

### Commands Used

The lab files were already on my system, so I did not need to clone them again. For first-time setup:

```bash
cd
git clone https://github.com/kunalg123/riscv_workshop_collaterals.git
```

To run the lab:

```bash
cd
cd riscv_workshop_collaterals/labs
ls -ltr
chmod 777 rv32im.sh
./rv32im.sh
```

### What the Script Does

1. Compiles the C and assembly files for `rv32im` with the `ilp32` ABI.
2. Links the program and converts it into `firmware32.hex`.
3. Compiles `testbench.v` and the PicoRV32 CPU (`picorv32.v`) using `iverilog`.
4. Runs the simulation using `vvp`. The testbench loads the hex file into memory.

### Output

![Output of the iverilog simulation](images/lec13/1.png)

```text
Sum of number from 1 to 2 is 3
```

### Result

The C program sets `count = 2` and calls `load(0, 3)`. The expected sum is 0 + 1 + 2 = **3**, which matches the simulation output.

### Reference

Lab files: [riscv_workshop_collaterals by kunalg123](https://github.com/kunalg123/riscv_workshop_collaterals)

---

## Summary

- A testbench provides the clock, reset and memory, and the program is loaded into that memory.
- `iverilog` compiles the simulation and `vvp` runs it.
- The simulation output matched the expected result for this test program.
