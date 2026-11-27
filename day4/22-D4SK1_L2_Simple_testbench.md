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

### Pass Condition

From the [CPU code](../src/basic_riscv_cpu.tlv):

```tlv
// Pass when x15 holds 1+2+...+9 = 45
*passed = |cpu/xreg[15]>>1$value == 32'd45;
*failed = *cyc_cnt > 60;
```

| Part | Meaning |
|---|---|
| `\|cpu/xreg[15]` | Register `x15` in the CPU register file |
| `>>1$value` | Its value one cycle earlier |
| `== 32'd45` | Passes when that value is 45 |
| `*cyc_cnt > 60` | Triggers failure once the cycle count is above 60 |

The test program is designed to add the numbers from 1 to 9, store the sum with `sw` and load it into `x15` with `lw`. This test does not check every supported instruction.

### Simulation Log

**Pending:** the Makerchip simulation log has not been added yet.

---

## Summary

- Decide the expected result before running the test.
