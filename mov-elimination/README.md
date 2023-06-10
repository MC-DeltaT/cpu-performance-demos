# Demo - MOV Elimination

## Overview

A demonstration of `mov` elimination, an optimisation done by the CPU where unnecessary `mov` instructions may be elided.

This demo consists of two almost identical assembly programs, `with-mov.s` and `without-mov.s`. Each program contains a loop which simply counts down a counter.  
In `with-mov`, there is an extraneous `mov` in the loop dependency chain. In `without-mov`, the extra `mov` is not present.

## Requirements

CPU:
- Most Intel x86 since Ivy Bridge
- AMD x86 since Zen

Software:
- GCC
- Make
- perf

## Build & Run

To build, run in this directory:

```bash
make
```

Then run each program and check the number of cycles taken:

```bash
perf stat -e cycles ./with-mov
perf stat -e cycles ./without-mov
```

You may also want to check the number of micro-instructions executed:
```bash
perf stat -e uops_executed.core ./with-mov
perf stat -e uops_executed.core ./without-mov
```

## Explanation

If your CPU supports `mov` elimination, both programs should take roughly the same number of cycles to run, and execute roughly the same number of micro-instructions.

Naively, this is unexpected, since a `mov` instruction usually adds one cycle of latency. The loop in `with-mov` should therefore need one more cycle per iteration than in `without-mov`, leading to an overall higher number of cycles required.

However, note that the `mov` is not strictly necessary. If `rdi` was replaced with `rax` in the instruction sequence, then there is no need to execute `mov %rax, %rdi`. Modern CPUs are able to detect scenario like this and do such register replacement as a part of the register renaming pipeline stage.  
The result is that the `mov` is not executed and does not add any latency to the loop iteration.
