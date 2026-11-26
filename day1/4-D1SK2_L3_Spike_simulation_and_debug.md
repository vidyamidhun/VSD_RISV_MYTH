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

## My Lab Work and Results

## My Lab Work and Results

**To do:** Show that Spike gives the same output as the host run, then trace two instructions and note the register changes.

### Spike Boot Sequence

![Spike boot sequence before reaching main](images/lec3/2.png)

### What This Shows

- Spike executes one instruction each time Enter is pressed on an empty line.
- Each instruction line shows the core number, address (PC), machine code and assembly instruction.
- The trace begins at `0x1000` in boot code, not at `main`.
- `auipc t0, 0x0` places `0x1000` in `t0`.
- `addi a1, t0, 32` places `0x1020` in `a1`.
- `csrr a0, mhartid` reads the hardware thread ID into `a0`.
- `ld t0, 24(t0)` loads a jump address, and `jr t0` jumps to it. The next instruction is at `0x80000000`.
- In `do_reset`, the proxy kernel starts setting registers such as `ra`, `sp`, `gp` and `tp` to zero.

## Summary

- Simulation checks software behaviour without RISC-V hardware.
