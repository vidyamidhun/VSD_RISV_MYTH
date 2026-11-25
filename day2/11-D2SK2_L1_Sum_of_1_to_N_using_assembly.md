# 11-D2SK2_L1_Sum_of_1_to_N_using_assembly

## Overview

A C program can call an assembly function when both follow the ABI. The loop for 1 to N can be written in assembly.

---

## Key Concepts

![C and assembly function call](../images/diagrams/c_asm_call.svg)

The algorithm:
1. Take the start value in `a0` and the limit (N + 1) in `a1`.
2. Set a running sum and a counter in temporary registers.
3. Add the counter to the sum, then add 1 to the counter.
4. Repeat while the counter is less than the limit (`blt`).
5. Put the sum in `a0` and return with `ret`.

In C, declare the function with `extern` so the compiler knows its arguments and return type.

---

## My Lab Work and Results

**To do:** Write your own assembly function from these steps and add it to `src/`.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec11/
     Format: ![Description](images/lec11/screenshot.png) -->

---

## Summary

- `a0` carries the first argument and the return value.
