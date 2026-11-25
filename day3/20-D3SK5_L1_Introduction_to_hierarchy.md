# 20-D3SK5_L1_Introduction_to_hierarchy

## Overview

Hierarchy builds a larger design from smaller, repeated blocks.

---

## Key Concepts

TL-Verilog can replicate logic with a bracketed range:

```tlv
/lane[3:0]
   $sum[8:0] = $a[7:0] + $b[7:0];
```

This creates four copies, each with its own signals. Behavioural hierarchy keeps repeated structures compact. A register file is a useful example: many entries share the same logic.

---

## My Lab Work and Results

**To do:** Create a small replicated block and view its diagram.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec20/
     Format: ![Description](images/lec20/screenshot.png) -->

---

## Summary

- Replication avoids writing the same logic many times.
