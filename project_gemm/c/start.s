# Startup code: set the stack pointer, run main, then stop.
    .section .text.start
    .globl _start
_start:
    li   sp, 256          # top of the 64-word data memory
    call main
halt:
    j    halt             # a jump to itself marks the end of the program
