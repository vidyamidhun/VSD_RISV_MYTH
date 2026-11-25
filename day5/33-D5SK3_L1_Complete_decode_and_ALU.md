# 33-D5SK3_L1_Complete_decode_and_ALU

## Overview

After the first instructions work, the decoder and ALU are extended to the rest of the integer set.

---

## Key Concepts

| Group | RV32I instructions |
|---|---|
| Arithmetic | `add`, `addi`, `sub` |
| Logical | `and`, `andi`, `or`, `ori`, `xor`, `xori` |
| Shifts | `sll`, `slli`, `srl`, `srli`, `sra`, `srai` |
| Comparisons | `slt`, `slti`, `sltu`, `sltiu` |
| Upper immediate | `lui`, `auipc` |
| Jumps | `jal`, `jalr` |

- Register shifts use only the lowest 5 bits of the second operand.
- `sra` keeps the sign bit; `srl` fills with zeros.
- `sltiu` sign-extends its immediate, then compares as unsigned.

`fence`, `ecall` and `ebreak` are also in RV32I. A teaching core may leave them out; state this if yours does.

---

## My Lab Work and Results

**To do:** List the instructions your core supports and how you tested them.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec33/
     Format: ![Description](images/lec33/screenshot.png) -->

---

## Summary

- Decoding an instruction is not enough; test its result too.
