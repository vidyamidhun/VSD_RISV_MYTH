# 7-D1SK3_L3_Signed_and_unsigned_lab

## Overview

The same bit pattern can mean different values depending on how it is read.

---

## Key Concepts

In 8 bits, `1111 1111` is 255 when unsigned and -1 when signed.

| C type (RV64, LP64) | Size | Format |
|---|---|---|
| `unsigned int` | 32 bits | `%u` |
| `int` | 32 bits | `%d` |
| `unsigned long long int` | 64 bits | `%llu` |
| `long long int` | 64 bits | `%lld` |

The 64-bit signed range is -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807.

RISC-V has separate instructions where the interpretation matters, such as `slt` and `sltu`, or `lb` (sign-extends) and `lbu` (zero-extends). Overflow of signed integers is undefined behaviour in C, so do not rely on it wrapping.

---

## My Lab Work and Results

**To do:** Print the signed and unsigned 64-bit limits and explain the output.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec7/
     Format: ![Description](images/lec7/screenshot.png) -->

---

## Summary

- Bits have no sign by themselves; the instruction or type decides.
