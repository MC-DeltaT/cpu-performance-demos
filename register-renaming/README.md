# Demo - Register Renaming

## Overview

A demonstration of register renaming, an optimisation where the CPU can break data dependencies between registers by introducing a dynamic mapping ("renaming") from ISA registers to hardware registers. Multiple instructions using the same architectural register need not use the same physical register if there is no dependency on the previous register value.  
The elimination of data dependencies enables more instructions to be executed in parallel, improving latency and throughput.

## Requirements

CPU:

TODO

Software:

- Linux
- GCC
- Make
- perf

## Tutorial

This demonstration consists primarily of two nearly-identical assembly programs, `same-register.s` and `diff-register.s`. Each of these programs contains a loop with two read-modify-write arithmetic calculations on registers `R8` and `R9`. The arithmetic requires the use of an intermediate register. In `same-register`, both calculations use the same intermediate register (`RCX`); in `diff-register`, the calculations use different intermediate registers (`RCX` and `RDX`).

Additionally, a third program `true-dep.s` contains similar instructions, but with an unavoidable data dependency between the modifications of `R8` and `R9` via `RCX`. The sum of individual instruction latencies remains the same as `same-register` and `diff-register`.

To build the programs, run in this directory:

```bash
make
```

Then run each program and check the number of cycles taken and instructions executed:

```bash
perf stat -e instructions,cycles ./same-register
perf stat -e instructions,cycles ./diff-register
perf stat -e instructions,cycles ./true-dep
```

You should see that `same-register` and `diff-register` take approximately the same number of cycles to complete, while `true-dep` is significantly slower (about 50% more cycles on the machine I tested).

If registers were not renamed, then the CPU could not simultaneously execute the arithmetic on `R8` and `R9` in `same-register`, since both require the use of `RCX`. Meanwhile, `diff-register` allows simultaneous (superscalar) execution because one arithmetic uses `RDX` instead. IIn this case, we would expect `diff-register` to complete in significantly fewer cycles than `same-register`.

However, in reality we observe little to no performance difference, because of register renaming. Note the initial `lea` instruction for each arithmetic block overwrites `RCX` and does not rely on its previous value. Modern CPUs exploit this scenario by assigning a new hardware register in place of `RCX`, rather than waiting for `RCX` to be ready. Subsequent instructions that read `RCX` will read from this hardware register. `RCX` is said to have been "renamed" to a different hardware register.  
As a result, in both `same-register` and `diff-register`, the arithmetic operations on `R8` and `R9` can execute independently and in parallel.

To prove that the two arithmetic blocks do run at least partially in parallel, observe the performance of `true-dep`. This program depends on the previous value of `RCX` in both arithmetic blocks. The `shl` instruction in the first block writes the value which is read by the `lea` instruction in the second block, a dependency which cannot be broken by renaming.  
Thus the second block cannot begin execution until the first `shl` completes, descreasing the instructions per cycle.
