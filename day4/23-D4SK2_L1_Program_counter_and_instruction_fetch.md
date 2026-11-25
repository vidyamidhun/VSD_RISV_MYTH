# 23-D4SK2_L1_Program_counter_and_instruction_fetch

## Overview

The program counter selects the next instruction to fetch.

---

## Key Concepts

After reset, the PC starts at the first instruction. RV32I instructions are 4 bytes, so by default:

```text
next PC = current PC + 4
```

A taken branch or a jump supplies a different target. Instruction memory is often indexed by word, so the two lowest address bits are not part of the index. For an aligned 32-bit instruction, they are 00.

---

## My Lab Work and Results

**To do:** Show the PC sequence from reset in your waveform.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec23/
     Format: ![Description](images/lec23/screenshot.png) -->

---

## Summary

- The PC counts bytes, so it advances by 4.
