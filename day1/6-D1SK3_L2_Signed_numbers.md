# 6-D1SK3_L2_Signed_numbers

## Overview

RISC-V represents signed integers in two's complement.

---

## Key Concepts

The most significant bit has a negative weight, -2^(N-1). All other bits keep their positive weights.

To negate a number, invert every bit and add 1. In 8 bits:

```text
 5      = 0000 0101
 invert = 1111 1010
 add 1  = 1111 1011  = -5
```

The range is -2^(N-1) to 2^(N-1) - 1, which is -128 to 127 for 8 bits. The same adder works for both signed and unsigned values.

---

## My Lab Work and Results

**To do:** Convert two negative numbers by hand and check them with a program.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec6/
     Format: ![Description](images/lec6/screenshot.png) -->

---

## Summary

- The top bit tells the sign.
- There is one more negative value than positive.
