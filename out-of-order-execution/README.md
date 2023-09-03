# Demo - Out of Order Execution

## Overview

Out-of-order execution is a CPU microarchitecture design in which the execution ordering of instructions is dynamically decided based on data dependencies. An instruction *A* executes before an instruction *B* if *B* depends on the result of *A*; otherwise, they can be reordered.  
The reordering can increase parallelism in execution, improving latency and throughput.

Out-of-order execution can be thought of as an extension or generalisation of superscalar execution.

## Requirements

CPU:

- Any Intel x86-64
- Any AMD x86-64

Software:

- Linux
- GCC
- Make
- perf

Other microarchitectural assumptions:

- &gt;= 2 scalar integer execution units/ports

## Tutorial

This demonstration contains two assembly programs, `out-of-order.s` and `in-order.s`, each of which consist of a loop of three arithmetic instructions. The first arithmetic instruction is a multiplication, which takes a few cycles (three on modern CPUs at the time of writing). The second and third instructions are faster (one cycle each on modern CPUs).  
The difference between the two programs is that the arithmetic instructions in `out-of-order` are independent, while the arithmetic instructions of `in-order` are part of a data dependency chain. A data dependency occurs when an instruction depends on the result of another instruction. In `in-order`, each arithmetic instruction depends on the result of the last.

To build the programs, run in this directory:

```bash
make
```

Then run each program and check the number of cycles taken and instructions executed:

```bash
perf stat -e instructions,cycles ./out-of-order
perf stat -e instructions,cycles ./in-order
```

You should observe that `out-of-order` completes in significantly fewer cycles and with more instructions per cycle than `in-order`.

The reason is that modern x86 CPUs execute instructions out of order as data dependencies permit. If an instruction's operands are ready, then it can be executed immediately regardless of its position in program order. Since the arithmetic in `out-of-order` are independent, all three instructions may execute in parallel. On the other hand, the arithmetic instructions in `in-order` depend on each other, and hence they must be executed sequentially, in order.  
The increased possibility for parallel execution in `out-of-order` reduces the cycles required for each loop iteration, increasing the performance.

It is important to note that with out-of-order execution, data dependencies become a primary limiting factor for performance.
