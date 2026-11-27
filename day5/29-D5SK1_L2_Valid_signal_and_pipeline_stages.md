# 29-D5SK1_L2_Valid_signal_and_pipeline_stages

## Overview

A good way to build a pipeline is to first make it work with gaps, then place logic into stages.

---

## Key Concepts

Start by issuing one valid instruction every few cycles, for example every third cycle in a three-cycle loop. A one-cycle start pulse after reset can circulate through two flip-flop delays to create this pattern.

Invalid cycles must not change state, so use the valid signal to control:
- register writes,
- memory writes, and
- PC redirects.

Once this works, distribute fetch, decode, register read, execute and write-back across stages. Later, increase the issue rate to every cycle and handle the hazards that appear.

---

## My Lab Work and Results

`$start` gives the first `$valid` pulse after reset. `>>3$valid` then repeats the pulse every third cycle. `$valid` does not control the CPU yet.

Code: [lec29_valid3.tlv](../src/lec29_valid3.tlv)

### Valid logic

```tlv
$start = >>1$reset && ! $reset;

$valid = $reset ? 1'b0 :
         $start ? 1'b1 :
                  >>3$valid;
```

### Stage assignment

| Stage | Logic in this version |
|---|---|
| `@0` | Reset, `$start`, `$valid`, PC and instruction memory address |
| `@1` | Instruction read, decode, register read and write, ALU and branch logic |

### Makerchip diagram

![Diagram with the 3-cycle valid loop](images/lec29/1.png)

### Valid waveform

![Waveform showing a valid pulse every third cycle](images/lec29/2.png)

`@0$valid` (bottom row) is high for one cycle in every three. Counting from PC 0 at cycle 0, the first pulses in this view are:

| Cycle | `@0$pc` | `$valid` |
|---|---|---|
| 3 | `0x0c` | 1 |
| 4–5 | `0x10`, `0x14` | 0 |
| 6 | `0x18` | 1 |
| 7–8 | `0x10`, `0x14` | 0 |
| 9 | `0x18` | 1 |

The PC and registers still change every cycle because `$valid` does not control the CPU yet.

**`$start` pulse at cycle 0:** Pending. This view begins after cycle 0.

---

## Summary

- Change one thing at a time and keep the test passing.
