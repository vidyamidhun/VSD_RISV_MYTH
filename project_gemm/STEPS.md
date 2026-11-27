# Steps to finish the project

Save every screenshot with **exactly** the name shown. The README then displays it automatically.
Use PNG format (names ending in `.png`, lowercase).

## Step 1: Assembly screenshot

Option A, Compiler Explorer (https://godbolt.org):
1. Language: **C**.
2. Compiler: **RISC-V (32-bits) gcc 13.2.0**.
3. Compiler options: `-march=rv32i -mabi=ilp32 -O1 -ffreestanding`
4. Paste `c/gemm.c`.
5. Screenshot showing the C code and the assembly.

The assembly may differ slightly from `asm/gemm.s`. The CPUs run the code in `asm/gemm.hex`.

Save as `images/01_assembly.png`

## Step 2: Pipelined CPU in Makerchip

1. Open https://makerchip.com and start the IDE.
2. Delete everything in the editor.
3. Paste all of `tlv/rvmyth_pipelined.tlv`.
4. Compile (Ctrl+Enter).
5. Open the **Log** tab and find `GEMM REPORT: PIPELINED`.

| File name | What to show |
|---|---|
| `images/02_pipelined_diagram.png` | **Diagram** tab, whole CPU |
| `images/03_pipelined_log.png` | **Log** tab: the full GEMM report and `Simulation PASSED` |
| `images/04_pipelined_waveform.png` | **Waveform** tab, zoomed on one taken branch |

Waveform signals (expand `|cpu`): `@0 $pc`, `@3 $valid`, `@3 $valid_taken_br`.
Show a pulse of `$valid_taken_br`, then `$valid` low for **2 cycles**.

## Step 3: Non-pipelined CPU in Makerchip

Repeat Step 2 with `tlv/rvmyth_nonpipelined.tlv`.

| File name | What to show |
|---|---|
| `images/05_nonpipelined_diagram.png` | **Diagram** tab |
| `images/06_nonpipelined_log.png` | **Log** tab: the full GEMM report and `Simulation PASSED` |
| `images/07_nonpipelined_waveform.png` | **Waveform** tab, zoomed to a few instructions |

Show that `$valid` is high **once every 3 cycles** and `$pc` stays the same in between.

## Step 4: Compare

Expected values:

| | Non-pipelined | Pipelined |
|---|---:|---:|
| Latency (cycles) | 2994 | 1580 |
| Instructions | 998 | 998 |
| Branch misses | 0 | 87 |
| Branch penalty cycles | 0 | 174 |

If your log shows different values, or there is an error, or the run stops before the report
appears, keep the log and fix the problem before submitting. Do not edit the numbers by hand.

## Step 5: Add the screenshots on GitHub

First, the `project_gemm` folder must be in the repository.

1. Open `project_gemm/images` in your repository on GitHub.
2. Click **Add file** > **Upload files**.
3. Drag in your PNG files.
4. Click **Commit changes**.
5. Open `project_gemm/README.md` and check that the pictures appear.

## Step 6: Submit

Repository folder link:
https://github.com/vidyamidhun/VSD_RISV_MYTH/tree/main/project_gemm
