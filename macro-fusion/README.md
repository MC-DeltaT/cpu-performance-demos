# Demo - Macro-op Fusion

## Overview

A demonstration of macro-op fusion, an optimisation where two instructions combine into one within the execution unit of the CPU.

The assembly program `macro-fused.s` contains a minimal loop that only count down a counter. This is implemented as a `dec` instruction followed by a `jnz` instruction.

## Requirements

CPU:

- Intel x86-64 since Core
- AMD x86-64 since Bulldozer

Software:

- GCC
- Make
- perf

## Build & Run

To build, run in this directory:

```bash
make
```

Then run and check the number of instructions and cycles:

```bash
perf stat -e instructions,cycles ./macro-fused
```

You may also want to check the number of micro-instructions issued:

```bash
perf stat -e uops_issued.any ./macro-fused
```

## Explanation

If your CPU supports macro-fusion, you should observe that the program runs in about 10G cycles, and at roughly two instructions per cycle. With 10G loop iterations, that is one cycle per iteration. Additionally, you should see approximately 10G micro-instructions issued.

Naively, it would be expected that since each iteration requires the completion of two instructions in sequence, an iteration should take at least two cycles. With macro-fusion, however, certain pairs of consecutive instructions may be combined during instruction decoding, and then executed as a single micro-instruction, rather than two micro-instructions. The most common instruction pairings are `inc`/`dec`/`add`/`sub`/`test`/`cmp` with `jCC` (`CC` being some conditional code).

In this program, the `dec` and `jnz` can be fused. The resulting micro-instruction has one cycle of execution latency, allowing the loop to execute at one iteration per cycle.
