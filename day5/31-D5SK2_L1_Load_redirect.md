# 31-D5SK2_L1_Load_redirect

## Overview

A load's data arrives later than an ALU result, so the following instructions may not be able to use it in time.

---

## Key Concepts

One simple solution is a **redirect and replay**:
1. Detect a valid load.
2. Mark the instructions in its shadow as invalid.
3. Fetch again from the instruction after the load, once the pipeline can safely continue.
4. Write the loaded data into the load's destination register when it arrives.

The destination register number must travel with the load, or be taken from the correct earlier stage. The write path then selects between ALU data and load data.

---

## My Lab Work and Results

**To do:** Show a load followed by an instruction that uses the loaded value.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec31/
     Format: ![Description](images/lec31/screenshot.png) -->

---

## Summary

- The length of the load shadow depends on your pipeline.
