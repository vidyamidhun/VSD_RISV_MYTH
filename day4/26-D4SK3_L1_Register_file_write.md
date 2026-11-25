# 26-D4SK3_L1_Register_file_write

## Overview

The result of an instruction is written back to its destination register.

---

## Key Concepts

Writing is enabled only when:
- the instruction is valid,
- it has a destination register, and
- the destination is not `x0`.

Stores and conditional branches have no destination register. Writes to `x0` must have no effect, so that it always reads as zero. A register file is an array: the write index chooses which entry changes, while the other entries keep their values.

---

## My Lab Work and Results

**To do:** Test a write to a normal register and an attempted write to `x0`.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec26/
     Format: ![Description](images/lec26/screenshot.png) -->

---

## Summary

- An incorrect write enable can silently corrupt registers.
