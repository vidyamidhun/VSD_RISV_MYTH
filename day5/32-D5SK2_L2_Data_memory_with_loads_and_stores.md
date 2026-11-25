# 32-D5SK2_L2_Data_memory_with_loads_and_stores

## Overview

Data memory is accessed by loads and stores.

---

## Key Concepts

For both, the address is:

```text
address = rs1 value + sign-extended immediate
```

| Signal | Load | Store |
|---|---|---|
| Read enable | On for a valid load | Off |
| Write enable | Off | On for a valid store |
| Write data | Not used | rs2 value |

A word-indexed memory uses the address bits above the lowest two. A simple test stores a result, loads it into another register and checks that the two match.

A teaching CPU may treat every load and store as a word. Full RV32I also defines byte and halfword accesses.

---

## My Lab Work and Results

**To do:** Add a store and a load to your test program and update its pass condition.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec32/
     Format: ![Description](images/lec32/screenshot.png) -->

---

## Summary

- Memory enables must include the valid signal.
