# 9-D2SK1_L2_Memory_allocation_and_registers

## Overview

Memory is byte addressed, and RISC-V is normally little-endian.

---

## Key Concepts

A 64-bit value can be held in one RV64 register, or in 8 consecutive bytes of memory. Little-endian means the least significant byte is at the lowest address. For `0x1122334455667788` stored at address 0:

| Address | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|---|
| Byte | 88 | 77 | 66 | 55 | 44 | 33 | 22 | 11 |

Consecutive doublewords are 8 addresses apart. Element `A[i]` of a doubleword array is at *base + 8i*.

| Registers | ABI names | Use |
|---|---|---|
| x0 | zero | Constant zero |
| x1, x2 | ra, sp | Return address, stack pointer |
| x3, x4 | gp, tp | Global and thread pointers |
| x5-x7, x28-x31 | t0-t6 | Temporaries |
| x8, x9, x18-x27 | s0-s11 | Saved registers (s0 can be the frame pointer) |
| x10-x17 | a0-a7 | Arguments; a0 and a1 also return values |

---

## My Lab Work and Results

**To do:** Work out the address of `A[3]` for a base address of your choice.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec9/
     Format: ![Description](images/lec9/screenshot.png) -->

---

## Summary

- Addresses count bytes, so doublewords step by 8.
