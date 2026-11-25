# 28-D5SK1_L1_Pipeline_hazards

## Overview

In a pipelined CPU, several instructions are in progress at once. A hazard occurs when one cannot safely proceed as planned.

---

## Key Concepts

![Pipeline overlap and hazard](../images/diagrams/pipeline_hazard.svg)

- **Data hazard:** an instruction needs a result that is not yet available. In a **read-after-write** case, it reads a register that an earlier instruction has not yet written.
- **Control hazard:** the CPU fetches more instructions before it knows where a branch or jump goes.
- **Structural hazard:** two instructions need the same hardware at once.

Which hazards occur, and how many cycles they cost, depends on the pipeline design.

---

## My Lab Work and Results

**To do:** Identify a dependent instruction pair in your test program.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec28/
     Format: ![Description](images/lec28/screenshot.png) -->

---

## Summary

- Pipelining creates overlap, and overlap creates dependencies.
