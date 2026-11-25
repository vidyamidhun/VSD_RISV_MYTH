# 12-D2SK2_L2_Simulate_C_program_with_function_call

## Overview

The C file and assembly file are compiled together, then run and inspected.

---

## Key Concepts

Replace the file names with your own:

```bash
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum_asm.o main.c sum.S
spike pk sum_asm.o
riscv64-unknown-elf-objdump -d sum_asm.o | less
```

In the disassembly, check that the arguments are loaded into `a0` and `a1` before the call, that the call saves a return address in `ra`, and that the result is read from `a0`.

---

## My Lab Work and Results

**To do:** Attach your program output and the disassembly of the caller and the function.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec12/
     Format: ![Description](images/lec12/screenshot.png) -->

---

## Summary

- The linker joins the C and assembly code into one program.
