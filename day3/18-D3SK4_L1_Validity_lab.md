# 18-D3SK4_L1_Validity_lab

## Overview

Validity marks the cycles in which a pipeline carries meaningful data.

---

## Key Concepts

A `?$valid` condition applies to the logic inside it:

```tlv
|calc
   @1
      $valid = ! $reset && $start;
   ?$valid
      @2
         $total[31:0] = $in[31:0] + 1;
```

Benefits:
- Waveforms are easier to debug, because invalid values are treated as don't-care.
- Mistakes that use invalid data are easier to find.
- Clocks can be gated for idle logic, which can save power.

To **accumulate** a total, keep the previous value when the cycle is invalid and add the new value when it is valid.

---

## My Lab Work and Results

**To do:** Add validity to your calculator or distance pipeline, including an accumulated total.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec18/
     Format: ![Description](images/lec18/screenshot.png) -->

---

## Summary

- A valid signal separates real data from don't-care cycles.
