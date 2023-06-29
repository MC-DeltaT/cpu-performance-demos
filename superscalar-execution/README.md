# Demo - Superscalar Execution

## Overview

A demonstration of superscalar instruction execution, a CPU architecture design in which multiple instructions can be executed simultaneously to improve throughput.

## Requirements

CPU:

- Any Intel x86-64
- Any AMD x86-64

Software:

- Linux
- GCC
- Make
- perf

## Tutorial

The assembly program `superscalar.s` consists of a loop with three independent arithmetic operations per iteration.

To build the program, run in this directory:

```bash
make
```

Then run and check the number of instructions per cycle:

```bash
perf stat -e instructions,cycles ./superscalar
```

You should observe that the program executes with more than one instruction per cycle on average.

The reason is that x86 CPUs are "superscalar" processors, meaning they are able to execute multiple instructions in parallel. Each loop iteration performs three arithmetic instructions - which each take one cycle. However, their data operands are independent of each other, allowing the CPU to execute them simultaneously instead of one at a time.
