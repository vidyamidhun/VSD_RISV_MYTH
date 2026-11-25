# 16-D3SK2_L1_Counter_and_sequential_calculator

## Overview

Sequential logic stores state, which changes on a clock edge. D flip-flops are the basic storage element.

---

## Key Concepts

In TL-Verilog, `>>1$signal` means the value of the signal one cycle earlier. A free-running counter:

```tlv
$cnt[7:0] = $reset ? 0 : >>1$cnt + 1;
```

Reset gives the state a known starting value. A sequential calculator feeds its previous output back as one operand.

---

## My Lab Work and Results

**To do:** Extend your calculator so it uses the previous result, and attach the waveform.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec16/
     Format: ![Description](images/lec16/screenshot.png) -->

---

## Summary

- Feedback through a flip-flop gives a circuit memory.
