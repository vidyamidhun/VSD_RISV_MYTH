/*
 * GEMM (General Matrix Multiply), simplest case: C = A x B, 2x2 integers.
 * RV32I has no multiply instruction, so soft_mul() uses shift-and-add.
 *
 * The size is small so that both CPU versions finish within Makerchip's cycle limit.
 *
 * Data memory map (byte addresses):
 *   A : 0x40 - 0x4C    B : 0x50 - 0x5C    C : 0x60 - 0x6C
 */
#ifdef HOST            /* build on a PC to get the expected answer */
#include <stdio.h>
static int mem[12];
#define A (mem)
#define B (mem + 4)
#define C (mem + 8)
#else                  /* build for the RISC-V CPU */
#define A ((volatile int *)0x40)
#define B ((volatile int *)0x50)
#define C ((volatile int *)0x60)
#endif

#define N 2

static inline __attribute__((always_inline)) int soft_mul(int a, int b)
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
                sum += soft_mul(A[i * N + k], B[k * N + j]);
            C[i * N + j] = sum;
        }
    }
}

int main(void)
{
    /* A = [1 2; 3 4]   B = [2 1; 1 2] */
    A[0] = 1;  A[1] = 2;  A[2] = 3;  A[3] = 4;
    B[0] = 2;  B[1] = 1;  B[2] = 1;  B[3] = 2;

    gemm();

#ifdef HOST
    for (int i = 0; i < N * N; i++)
        printf("%d%c", C[i], (i % N == N - 1) ? '\n' : ' ');
#endif
    return 0;
}
