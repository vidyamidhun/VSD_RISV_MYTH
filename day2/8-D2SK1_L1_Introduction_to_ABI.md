# 8-D2SK1_L1_Introduction_to_ABI

## Overview

The Application Binary Interface (ABI) is the set of rules that lets separately compiled code work together.

---

## Key Concepts

It covers how registers are used, how arguments and return values are passed, how the stack is organised and the sizes of data types. A program asks the operating system for services through a **system call**, made in RISC-V with the `ecall` instruction.

RISC-V has 32 integer registers, `x0` to `x31`. Their width is XLEN, and `x0` always reads as zero. The program counter is separate.

Register fields in instructions are 5 bits wide, because 2^5 = 32.

---

## My Lab Work and Results

**To do:** Identify the registers that hold arguments in your disassembly.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec8/
     Format: ![Description](images/lec8/screenshot.png) -->

---

## Summary

- The ISA defines the registers; the ABI agrees how software uses them.
