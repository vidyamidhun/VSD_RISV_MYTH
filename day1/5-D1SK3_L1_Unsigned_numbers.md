# 5-D1SK3_L1_Unsigned_numbers

## Overview

An unsigned number uses every bit for magnitude.

---

## Key Concepts

Bit *i* has the weight 2^i. For example, 1011 in binary is 8 + 0 + 2 + 1 = 11.

With N bits there are 2^N patterns, covering 0 to 2^N - 1.

| Width | Largest unsigned value |
|---|---|
| 8 bits (byte) | 255 |
| 32 bits (word) | 4,294,967,295 |
| 64 bits (doubleword) | 18,446,744,073,709,551,615 |

Unsigned arithmetic in C wraps around modulo 2^N. In 8 bits, 255 + 1 gives 0.

---

## My Lab Work and Results

**To do:** Print the largest `unsigned long long int` value from a C program.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec5/
     Format: ![Description](images/lec5/screenshot.png) -->

---

## Summary

- N bits cover 0 to 2^N - 1.
