# Demo - MOV Elimination

## Overview

A demonstration of `mov` elimination, an optimisation where unnecessary `mov` instructions may be elided. An eliminated `mov` is resolved as part of register renaming and does not need to be executed, improving execution latency and throughput.

## Requirements

CPU:

- Most Intel x86-64 since Ivy Bridge
- AMD x86-64 since Zen

Software:

- Linux
- GCC
- Make
- perf

## Tutorial

This demonstration consists of two almost identical assembly programs, `with-mov.s` and `without-mov.s`. Each program contains a loop which simply counts down a counter.  
In `with-mov`, there is an extraneous `mov` in the loop dependency chain. In `without-mov`, the extra `mov` is not present.

To build the programs, run in this directory:

```bash
make
```

Then run each program and check the number of cycles taken and micro-instructions executed:

```bash
perf stat -e cycles,uops_executed.core ./with-mov
perf stat -e cycles,uops_executed.core ./without-mov
```

If your CPU supports `mov` elimination, both programs should take roughly the same number of cycles to run, and execute roughly the same number of micro-instructions.

Naively, this is unexpected, since `with-mov` has one more `mov` instruction, usually adding one cycle of latency. However, note that the `mov` is not strictly necessary. If `rdi` was replaced with `rax` in the instruction sequence, then there is no need to execute `mov %rax, %rdi`. Modern CPUs are able to detect scenario like this and do such register replacement as a part of the register renaming pipeline stage.  
The result is that the `mov` is not executed and does not add any latency to the loop iteration.
