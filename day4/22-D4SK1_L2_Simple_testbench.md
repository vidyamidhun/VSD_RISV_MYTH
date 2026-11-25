# 22-D4SK1_L2_Simple_testbench

## Overview

A testbench checks whether the CPU gives the expected result.

---

## Key Concepts

A self-checking test:
1. Load a program whose result is known, such as a sum of integers.
2. Wait for the result to reach a chosen register.
3. Set `*passed` when it matches the expected value.
4. Set `*failed` if the simulation runs too long.

A cycle limit stops a faulty design from appearing to run for ever. Passing one program does not prove every instruction works, so test different cases.

---

## My Lab Work and Results

**To do:** Record your pass condition and the simulation log.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec22/
     Format: ![Description](images/lec22/screenshot.png) -->

---

## Summary

- Decide the expected result before running the test.
