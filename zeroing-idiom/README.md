# Demo - Zeroing Idioms

## Overview

Zeroing idioms, (sometimes referred to as dependency-breaking instructions), are arithmetic instructions which always result in zero no matter the input values. CPUs can detect such instructions and recognise that they do not depend on previous values, breaking data dependencies.  
Such an optimisation can increase parallelism in execution, improving latency and throughput.

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

- &gt;= 3 scalar integer execution units/ports

## Tutorial

This demonstration contains two nearly identical assembly programs, `zeroed-dep.s` and `true-dep.s`. Each program consists of a loop with arithmetic on `RCX`. In `zeroed-dep`, the first arithmetic instruction is a zeroing `xor %rcx, %rcx`, while in `true-dep` there is a real data dependency on the previous iteration's value of `RCX`.

To build the programs, run in this directory:

```bash
make
```

Then run and check the number of cycles:

```bash
perf stat -e instructions,cycles ./zeroed-dep
perf stat -e instructions,cycles ./true-dep
```

You should see that `zeroed-dep` runs in significantly fewer cycles than `true-dep` (about one third on the machine I tested) for the same number of instructions executed.

The reason is the use of a zeroing idiom in `zeroed-dep`. The CPU can recognise that certain arithmetic always results in zero when both operands are the same register, such as `xor`, `sub`, and their floating-point and vector equivalents. Here, `xor %rcx, %rcx` is recognised as independent of the previous value of `RCX`, breaking the loop-carried dependency on `RCX`. Meanwhile in `true-dep`, the result of `xor %rcx, %rdx` does depend on the previous value of `RCX`, causing a loop-carried dependency.

The outcome is that `zeroed-dep` exhibits higher execution parallelism, requiring fewer cycles to complete.
