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

**To do:** Draw your stage assignment and show the valid signal waveform.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec29/
     Format: ![Description](images/lec29/screenshot.png) -->

---

## Summary

- Change one thing at a time and keep the test passing.
