# 30-D5SK1_L3_Hazard_solutions

## Overview

The usual solutions are to wait, to forward results or to cancel wrong instructions.

---

## Key Concepts

- **Stall:** hold a dependent instruction until its data is ready.
- **Register bypass (forwarding):** if an earlier instruction is writing the register now being read, send the ALU result directly to the operand. The check needs a valid register write and matching register numbers.
- **Branch squash:** continue fetching in sequence, and if a branch is taken, redirect the PC and mark the wrong-path instructions invalid.

The number of earlier cycles to check or cancel follows from the stage in which each result becomes available.

---

## My Lab Work and Results

**To do:** Compare the waveforms before and after adding your bypass and branch handling.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec30/
     Format: ![Description](images/lec30/screenshot.png) -->

---

## Summary

- A cancelled instruction must not change registers, memory or the PC.
