# 34-D5SK3_L2_Jump_instructions

## Overview

Jumps always change the flow of control.

---

## Key Concepts

| Instruction | Target | Value written to rd |
|---|---|---|
| `jal` | jump PC + J immediate | jump PC + 4 |
| `jalr` | (rs1 value + I immediate), with bit 0 cleared | jump PC + 4 |

In a pipeline, instructions fetched from the wrong path must be invalidated, as for a taken branch. `jalr` depends on a register, so it needs the correct (possibly bypassed) value. A function return, `ret`, is `jalr x0, 0(ra)`.

---

## My Lab Work and Results

**To do:** Test both jumps and check the return address and target.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec34/
     Format: ![Description](images/lec34/screenshot.png) -->

---

## Summary

- The link value lets a program return to the caller.
