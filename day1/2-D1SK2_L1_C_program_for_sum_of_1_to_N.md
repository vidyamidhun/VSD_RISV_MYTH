# 2-D1SK2_L1_C_program_for_sum_of_1_to_N

## Overview

A short C loop that adds the integers from 1 to N is a simple first program for exploring the toolchain.

---

## Key Concepts

```c
#include <stdio.h>

int main(void) {
    int n = 10, sum = 0;
    for (int i = 1; i <= n; i++)
        sum += i;
    printf("Sum of 1 to %d is %d\n", n, sum);
    return 0;
}
```

The result can be checked with the formula N(N + 1) / 2. For N = 10, this is 55.

First compile and run it with the host compiler, so that you have a reference result:

```bash
gcc sum1ton.c -o sum1ton
./sum1ton
```

---

## My Lab Work and Results

**To do:** Run the program for your own value of N and attach the code and output.

<!-- Add your own code, observations and screenshots here.
     Screenshot folder: images/lec2/
     Format: ![Description](images/lec2/screenshot.png) -->

---

## Summary

- A reference result makes later RISC-V runs easy to check.
