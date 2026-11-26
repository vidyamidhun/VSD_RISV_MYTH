# 4-D1SK2_L3_Spike_simulation_and_debug

## Overview

Spike is a RISC-V ISA simulator. With the proxy kernel (`pk`), it can run a compiled program and step through it.

---

## Key Concepts

```bash
spike pk sum1ton.o          # run the program
spike -d pk sum1ton.o       # start the interactive debugger
```

| Debugger command | Action |
|---|---|
| `until pc 0 <address>` | Run core 0 until the program counter reaches the address |
| `reg 0 a0` | Show register a0 of core 0 |
| Enter | Execute one instruction |
| `q` | Quit |

Take the address of `main` from your own disassembly. Check a register before and after an instruction to confirm what it changed.

---

## My Lab Work and Results

**To do:** Show that Spike gives the same output as the host run, then trace two instructions and note the register changes.

### Disassembly with -O1

![Disassembly of main with O1](images/lec3/1.png)

| Setting | Instructions in `main` |
|---|---|
| `-O1` | 11 |

### Observations

- `main` starts at address `0x10184` and ends with `ret` at `0x101ac`, giving 11 instructions.
- No summing loop appears in `main`. `li a2,55` loads the result directly, which shows the compiler calculated the sum during compilation.
- `li a1,10` loads the value of N for `printf`.

---

## Summary

- Simulation checks software behaviour without RISC-V hardware.
