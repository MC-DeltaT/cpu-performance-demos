# Demo - Macro-op Fusion

## Overview

A demonstration of macro-op fusion, an optimisation where two consecutive instructions combine into one micro-instruction for execution within the CPU. This reduces resource usage in all stages of the pipeline after decoding, possibly increasing execution throughput.

## Requirements

CPU:

- Intel x86-64 since Core
- AMD x86-64 since Bulldozer

Software:

- Linux
- GCC
- Make
- perf

## Tutorial

This demonstration has two assembly programs, `with-fusion.s` and `without-fusion.s`. Both consist of a loop with more arithmetic instructions than the CPU can execute simultaneously<sup>1</sup>. The difference is that in `with-fusion`, macro-op fusion can occur.

To build the programs, run in this directory:

```bash
make
```

Then run and check the number of instructions, cycles, and micro-instructions issued:

```bash
perf stat -e instructions,cycles,uops_issued.any ./with-fusion
perf stat -e instructions,cycles,uops_issued.any ./without-fusion
```

If your CPU supports macro-op fusion, you should see that `with-fusion` completes with fewer micro-instructions issued and cycles, for the same number of instructions overall.

The reason is macro-op fusion. Certain pairs of consecutive instructions can macro-fuse; the most common being `inc`/`dec`/`add`/`sub`/`test`/`cmp` with `jCC` (`CC` being some conditional code). In `with-fusion`, the `dec %rax` and `jnz` can be fused, whereas in `without-fusion` they are not consecutive and cannot fuse.

As a result, each loop iteration, `with-fusion` has one fewer issued (i.e scheduled for execution) micro-instruction over `without-fusion`, which is reflected by the `uops_issued.any` counter. When the bottleneck is parallel instruction execution, as in these programs, more cycles are required to execute the extra micro-instruction.

### Notes

<small><sup>1</sup>The exact number of arithmetic instructions a CPU can execute simultaneously depends on the microarchitecture, specifically the configuration of execution units. But I don't think there are any current CPUs which have nine arithmetic units.</small>
