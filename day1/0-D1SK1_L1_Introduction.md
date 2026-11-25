# 0-D1SK1_L1_Introduction

## Overview

RISC-V is an open instruction set architecture (ISA). This page introduces the words used throughout the workshop.

---

## Key Concepts

| Term | Meaning |
|---|---|
| ISA | The agreement between software and hardware: instructions, registers and how they behave |
| RISC | Reduced Instruction Set Computer, a design style built on simple, regular instructions |
| Microarchitecture | One particular hardware implementation of an ISA |
| XLEN | Width of an integer register: 32 bits in RV32, 64 bits in RV64 |
| RV32I / RV64I | The base integer instruction sets |
| Extension | An optional group of instructions added to a base ISA |

Common extensions are **M** (multiply and divide), **A** (atomics), **F** and **D** (single and double precision floating point) and **C** (compressed 16-bit instructions). For example, RV64IMAC is the 64-bit base with the M, A and C extensions.

A **pseudo-instruction** is a convenient assembly name that the assembler turns into real instructions. `mv a0, a1` becomes `addi a0, a1, 0`.

---

## My Lab Work and Results

**To do:** Note the ISA string used in your toolchain labs and explain each letter.

### ISA String Used: `rv64i`

It was set with the compiler option `-march=rv64i`.

| Part | Meaning |
|---|---|
| `rv` | RISC-V architecture |
| `64` | XLEN is 64, so the integer registers are 64 bits wide |
| `i` | Base integer instruction set |

**What `i` includes:** integer addition and subtraction, logical operations, shifts, comparisons, loads, stores, branches and jumps.

**What it does not include:** hardware multiply and divide (`M`), atomic operations (`A`), floating point (`F` and `D`) and compressed instructions (`C`).

In RV64I, registers are 64 bits wide, but the standard instructions are still 32 bits (4 bytes) long.

---

## Summary

- The ISA says what a processor does; the microarchitecture says how.
- RISC-V has a small base that extensions build on.
