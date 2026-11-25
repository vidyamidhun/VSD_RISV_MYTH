# 15-D3SK1_L2_Mux_and_calculator_lab

## Overview

A multiplexer (mux) selects one of several inputs. It is the basis of a simple calculator.

---

## Key Concepts

A two-input mux:

```tlv
$out[7:0] = $sel ? $in1[7:0] : $in0[7:0];
```

For more choices, conditions can be chained. A calculator computes sum, difference, product and quotient, then uses a 2-bit operation select to choose one result with a 4:1 mux.

---

## My Lab Work and Results

**To do:** Build your calculator and test all four operations.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec15/
     Format: ![Description](images/lec15/screenshot.png) -->

---

## Summary

- A chained conditional gives priority to the first true condition.
