# 10-D2SK1_L3_Load_add_and_store_instructions

## Overview

RISC-V is a load-store architecture: arithmetic works on registers, and only load and store instructions access memory.

---

## Key Concepts

To compute `A[1] = h + A[2]` for a doubleword array, with the base of A in `x23` and h in `x9`:

```asm
ld  x8, 16(x23)     # load A[2]: offset 2 x 8
add x8, x9, x8      # add h
sd  x8, 8(x23)      # store into A[1]: offset 1 x 8
```

| Instruction | Format | Fields used |
|---|---|---|
| `ld` | I-type | rd, rs1, 12-bit immediate |
| `add` | R-type | rd, rs1, rs2 |
| `sd` | S-type | rs1, rs2, split 12-bit immediate |

The 12-bit offset is signed, from -2048 to 2047.

---

## My Lab Work and Results

**To do:** Write the three instructions for different array indexes.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec10/
     Format: ![Description](images/lec10/screenshot.png) -->

---

## Summary

- The offset in a load or store is in bytes.
