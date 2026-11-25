# 19-D3SK4_L2_Calculator_with_memory

## Overview

A single-value memory lets a calculator save a result and use it later, like the memory keys on a handheld calculator.

---

## Key Concepts

It needs two actions:
- **Store:** copy the current result into the memory.
- **Recall:** select the stored value as the calculator output.

The memory must hold its value in every other cycle and clear on reset. In logic, this is a chain of choices: reset, then store, then keep the previous value. Extend the operation select to cover the new actions.

---

## My Lab Work and Results

**To do:** Write the memory logic yourself and show a store followed by a recall.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec19/
     Format: ![Description](images/lec19/screenshot.png) -->

---

## Summary

- State must say what happens when it is not being updated.
