# 21-D4SK1_L1_Single_cycle_CPU_architecture

## Overview

A single-cycle CPU completes one instruction in each clock cycle.

---

## Key Concepts

![Single-cycle CPU datapath](../images/diagrams/cpu_datapath.svg)

| Block | Role |
|---|---|
| Program counter (PC) | Holds the address of the instruction |
| Instruction memory | Supplies the instruction at that address |
| Decoder | Finds the operation, registers and immediate |
| Register file | Reads two source registers and writes one destination |
| ALU | Computes results |
| Branch logic | Chooses the next PC |
| Data memory | Serves loads and stores |

---

## My Lab Work and Results

**To do:** Add the diagram of your own CPU from Makerchip.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec21/
     Format: ![Description](images/lec21/screenshot.png) -->

---

## Summary

- A single cycle must be long enough for the slowest instruction.
