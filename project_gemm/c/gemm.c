/*
 * GEMM (General Matrix Multiply), simplest case: C = A x B, 3x3 integers.
 * RV32I has no multiply instruction, so soft_mul() uses shift-and-add.
 *
 * Data memory map (byte addresses):
 *   A : 0x00 - 0x20    B : 0x24 - 0x44    C : 0x48 - 0x68
 */
#ifdef HOST            /* build on a PC to get the expected answer */
#include <stdio.h>
static int mem[27];
#define A (mem)
#define B (mem + 9)
#define C (mem + 18)
#else                  /* build for the RISC-V CPU */
#define A ((volatile int *)0x00)
#define B ((volatile int *)0x24)
#define C ((volatile int *)0x48)
#endif

#define N 3

static __attribute__((noinline)) int soft_mul(int a, int b)
{
    unsigned int x = a, y = b, product = 0;

    while (y != 0) {
        if (y & 1)
            product += x;
        x <<= 1;
        y >>= 1;
    }
    return (int)product;
}

static void gemm(void)
{
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            int sum = 0;
            for (int k = 0; k < N; k++)
                sum += soft_mul(A[i * 3 + k], B[k * 3 + j]);   /* i*3: shift + add */
            C[i * N + j] = sum;
        }
    }
}

int main(void)
{
    /* A = 1..9 and B = 9..1, row by row */
    for (int i = 0; i < N * N; i++) {
        A[i] = i + 1;
        B[i] = N * N - i;
    }

    gemm();

#ifdef HOST
    for (int i = 0; i < N * N; i++)
        printf("%d%c", C[i], (i % N == N - 1) ? '\n' : ' ');
#endif
    return 0;
}
