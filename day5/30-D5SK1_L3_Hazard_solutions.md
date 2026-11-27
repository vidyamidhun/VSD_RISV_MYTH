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

### 3-cycle RISC-V CPU

The CPU issues one valid instruction every three cycles and runs the program that adds 1 to 9.

Code: [lec30_hazard_print.tlv](../src/lec30_hazard_print.tlv)

- Only valid instructions write registers: `$rf_wr_en = $valid && $rd_valid && $rd != 5'b0;`
- Only a valid branch redirects the PC: `$valid_taken_br = $valid && $taken_br;`
- The PC takes its values from the previous valid instruction with `>>3`.

**Result:** the simulation **passed**. The pass condition checks that `x10` equals 45.

### Hazard detection

Each check compares the current instruction with the previous valid instruction.

```tlv
$raw_rs1 = $valid && >>3$rf_wr_en && $rf_rd_en1 && ($rf_rd_index1 == >>3$rf_wr_index);
$raw_rs2 = $valid && >>3$rf_wr_en && $rf_rd_en2 && ($rf_rd_index2 == >>3$rf_wr_index);
$ctrl_hazard = $valid_taken_br;
```

`$display` inside `\SV_plus` prints the PC, instruction and details in the Makerchip Log.

### Simulation log

![Hazard messages and simulation pass](images/lec30/1.png)

| Hazard | PC | Messages | What it shows |
|---|---|---|---|
| Data (RAW) | `0x04` | 1 | Reads `x10`, written by the previous instruction |
| Data (RAW) | `0x10` | 1 | Reads `x13`, written by the previous instruction |
| Data (RAW) | `0x18` | 10 | `blt` reads `x13` just after `addi` updates it (values 1 to 10) |
| Control | `0x18` | 9 | Branch taken: next PC is `0x10`, not `0x1c` |

There are 12 data-hazard and 9 control-hazard messages. The last `blt` is not taken, so it has no control-hazard message. No `rs2` data hazard was reported.

These messages mark dependencies and taken branches. In this 3-cycle CPU they do not cause a wrong result: the values read are up to date, and the program passes. They need handling, such as register bypass and branch squash, when an instruction is issued every cycle.

### Waveform

![Waveform showing data hazard detection](images/lec30/2.png)

In this early part of the run, `$raw_rs1` pulses for the instructions at PC `0x04` (`00050733`) and `0x10` (`00e68733`). `$rf_wr_en` is high for one cycle in three.

**Taken-branch waveform:** Pending. This view ends before the first taken branch.

### Makerchip diagram

![3-cycle CPU diagram](images/lec30/3.png)

### One instruction every cycle: register bypass and branch squash

The next version starts an instruction every cycle, with logic in `@1`, `@2` and `@3`.

Code: [lec30_branch_squash.tlv](../src/lec30_branch_squash.tlv)

```tlv
$valid = ! $reset && ! (>>1$valid_taken_br || >>2$valid_taken_br);

$pc[31:0] = >>1$reset          ? 32'd0 :
            >>3$valid_taken_br ? >>3$br_tgt_pc :
                                 >>1$inc_pc;
```

```tlv
$bypass_rs1 = $rf_rd_en1 && >>1$rf_wr_en && (>>1$rf_wr_index == $rf_rd_index1);
$bypass_rs2 = $rf_rd_en2 && >>1$rf_wr_en && (>>1$rf_wr_index == $rf_rd_index2);

$src1_value[31:0] = $bypass_rs1 ? >>1$result : $rf_rd_data1;
$src2_value[31:0] = $bypass_rs2 ? >>1$result : $rf_rd_data2;
```

#### Waveform: register bypass

![Waveform showing register bypass](images/lec30/4.png)

Cycle 0 is the first cycle after reset. `@0$pc` increases by 4 every cycle. The signals below are in `@2`.

| Cycle | Instruction reading in `@2` | Register file value (`$rf_rd_data1`) | Value used (`$src1_value`) | `$bypass_rs1` |
|---|---|---|---|---|
| 3 | `add x14, x10, x0` | `0000000a` | `00000000` | 1 |
| 6 | `add x14, x13, x14` | `0000000d` | `00000000` | 1 |
| 8 | `blt x13, x12, -8` | `00000000` | `00000001` | 1 |

In each case the register file still gives the old value, and the bypass supplies the result of the previous instruction. No `rs2` bypass occurs in this view.

**Branch squash waveform and simulation log:** Pending. This view ends before the first `blt` reaches `@3`.

#### Makerchip diagram

![Diagram of the pipeline with register bypass](images/lec30/5.png)

---

## Summary

- A cancelled instruction must not change registers, memory or the PC.
