# 27-D4SK3_L2_Branch_instructions

## Overview

A conditional branch changes the PC only when its comparison is true.

---

## Key Concepts

| Instruction | Taken when |
|---|---|
| `beq` | operands are equal |
| `bne` | operands differ |
| `blt` | first is less than second, signed |
| `bge` | first is greater than or equal, signed |
| `bltu` | first is less than second, unsigned |
| `bgeu` | first is greater than or equal, unsigned |

The target is *branch instruction PC + sign-extended B immediate*. If the branch is not taken, execution continues at PC + 4.

---

## My Lab Work and Results

**To do:** Show one branch that is taken and one that is not.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec27/
     Format: ![Description](images/lec27/screenshot.png) -->

---

## Summary

- Signed and unsigned comparisons can give different answers.
