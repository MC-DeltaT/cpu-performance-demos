# Demo - MOV Elimination

## Overview

`mov` elimination is an optimisation where the CPU may elide unnecessary `mov` instructions. An eliminated `mov` is resolved as part of register renaming and does not need to be executed, improving execution latency and throughput.

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

This demonstration consists of two almost identical assembly programs, `with-mov.s` and `without-mov.s`. Each program contains a loop which simply counts down a counter. In `with-mov`, there is an extraneous `mov` in the loop dependency chain. In `without-mov`, the extra `mov` is not present.  
Naively, we would expect `with-mov` to require more cycles to complete, since the extra `mov` typically adds one cycle of latency to the loop.

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

The reason is that the extra `mov` in `with-mov` is eliminated, because it is not strictly necessary. Consider if `rdi` was replaced with `rax` in the instruction sequence, then there is no need to execute `mov rax, rdi`. Modern CPUs are able to detect scenario like this and do such register replacement as a part of the register renaming pipeline stage.  
The result is that the `mov` is not executed and does not add any latency to the loop iteration.
