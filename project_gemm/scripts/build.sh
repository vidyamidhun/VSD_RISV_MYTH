#!/bin/sh
# Compile the C program for RV32I and create the assembly, disassembly and machine code.
set -e
cd "$(dirname "$0")/.."
CC=riscv64-unknown-elf-gcc
FLAGS="-march=rv32i -mabi=ilp32 -Os -ffreestanding -fno-asynchronous-unwind-tables"
$CC $FLAGS -S c/gemm.c -o asm/gemm.s
$CC $FLAGS -nostdlib -T c/link.ld c/start.s c/gemm.c -o asm/gemm.elf
riscv64-unknown-elf-objdump -d -M numeric asm/gemm.elf > asm/gemm.objdump.txt
riscv64-unknown-elf-objcopy -O binary -j .text asm/gemm.elf asm/gemm.bin
python3 scripts/bin2hex.py asm/gemm.bin asm/gemm.hex
rm asm/gemm.elf asm/gemm.bin
echo "Done: see the asm folder"
