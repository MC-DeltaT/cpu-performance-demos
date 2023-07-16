# Demo - Out of Order Execution

## Overview

Out of order execution is a CPU microarchitecture design in which the execution ordering of instructions is dynamically decided based on data dependencies. An instruction *A* executes before an instruction *B* if *B* depends on the result of *A*; otherwise, they can be reordered.  
The reordering can increase parallelism in execution, improving latency and throughput.

Out of order execution can be thought of as an extension or generalisation of superscalar execution.

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

TODO
