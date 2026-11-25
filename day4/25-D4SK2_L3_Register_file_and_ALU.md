# 25-D4SK2_L3_Register_file_and_ALU

## Overview

The register file supplies operands, and the arithmetic logic unit (ALU) works on them.

---

## Key Concepts

RV32I has 32 registers of 32 bits. A typical CPU register file has two read ports, for `rs1` and `rs2`, and one write port, for `rd`.

Reading is enabled only when the instruction uses that source. The ALU selects a result according to the decoded instruction:

| Instruction | Result |
|---|---|
| `add` | rs1 value + rs2 value |
| `addi` | rs1 value + immediate |

---

## My Lab Work and Results

**To do:** Show register reads and the ALU result for one `add` and one `addi`.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec25/
     Format: ![Description](images/lec25/screenshot.png) -->

---

## Summary

- Two read ports let both operands be read together.
