# Demo - Superscalar Execution

## Overview

A demonstration of superscalar instruction execution.

The assembly program `superscalar.s` consists of a loop with three independent arithmetic operations per iteration.

## Requirements

- GCC
- Make
- perf

## Build & Run

To build, run in this directory:

```bash
make
```

Then run and check the number of instructions per cycle:

```bash
perf stat -e instructions,cycles ./superscalar
```

## Explanation

x86 CPUs are "superscalar" processors, meaning they are able to execute multiple instructions in parallel. Each loop iteration performs three arithmetic instructions - which each take one cycle - but their operands are independent of each other, allowing the CPU to execute them simultaneously. The result is that the program executes more than one instruction per cycle.
