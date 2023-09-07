# Demo - Register Renaming

## Overview

Register renaming is an optimisation where the CPU can break data dependencies between registers by introducing a dynamic mapping ("renaming") from ISA registers to hardware registers. Multiple instructions using the same architectural register need not use the same physical register if there is no dependency on the register value.  
The elimination of data dependencies enables more instructions to be executed in parallel, improving latency and throughput.

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

This demonstration consists primarily of two nearly-identical assembly programs, `same-register.s` and `diff-register.s`. Each of these programs contains a loop with two read-modify-write arithmetic calculations on registers `r8` and `r9`. The arithmetic requires an intermediate register. In `same-register`, both calculations use the same intermediate register (`rcx`); in `diff-register`, the calculations use different intermediate registers (`rcx` and `rdx`).

If registers were not renamed, then the CPU could not simultaneously execute the arithmetic on `r8` and `r9` in `same-register`, since both require the use of `rcx`. Meanwhile, `diff-register` allows simultaneous (superscalar) execution because one arithmetic uses `rdx` instead. In this case, we would expect `diff-register` to complete in significantly fewer cycles than `same-register`.

To build the programs, run in this directory:

```bash
make
```

Then run each program and check the number of cycles taken and instructions executed:

```bash
perf stat -e instructions,cycles ./same-register
perf stat -e instructions,cycles ./diff-register
```

`same-register` and `diff-register` take approximately the same number of cycles to complete due to register renaming. Note the initial `lea` instruction for each arithmetic block overwrites `rcx` and does not rely on its previous value. Modern CPUs exploit this scenario by assigning a new hardware register in place of `rcx`, rather than waiting for `rcx` to be ready. Subsequent instructions that read `rcx` will read from this hardware register. `rcx` is said to have been "renamed" to a different hardware register.  
As a result, in both `same-register` and `diff-register`, the arithmetic operations on `r8` and `r9` can execute independently and in parallel.

To prove that the two arithmetic blocks do run at least partially in parallel, a third program, `true-dep.s`, is provided for comparison. It contains similar instructions as `same-register` and `diff-register`, but with an unavoidable data dependency between the modifications of `r8` and `r9` via `rcx`. The sum of individual instruction latencies remains the same as `same-register` and `diff-register`.  
Run it to check the performance:

```bash
perf stat -e instructions,cycles ./true-dep
```

You should observe that it requires significantly more cycles to complete. This is because the `shl` instruction in the first arithmetic block writes the value which is read by the `lea` instruction in the second block, a dependency which cannot be broken by renaming.  
Thus the second block cannot begin execution until the first `shl` completes, descreasing the instructions per cycle.
