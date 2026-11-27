#!/bin/sh
# Usage: sh sim/run.sh        (add +vcd to also write a waveform file)
set -e
cd "$(dirname "$0")/.."
iverilog -g2012 -o sim/gemm.vvp sim/rvmyth_core.v sim/tb.v
vvp sim/gemm.vvp "$@" | tee logs/iverilog_simulation.log
rm sim/gemm.vvp
