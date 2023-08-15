# CPU Performance Demonstrations

A collection of microbenchmarks demonstrating low-level concepts and optimisations that affect performance on modern x86 CPUs.

*Warning: CPU microarchitecture ahead!*

## How To Start

If you are new to the world of CPU architecture and microarchitecture, you may want to read [Primer.md](Primer.md), which covers some basic concepts that are prerequisite knowledge for many of the demonstrations.

Some demonstrations inherently build on topics discussed in other demonstrations. You may want to try the demonstrations in this order for ease of understanding:

1. [Superscalar execution](superscalar-execution)
2. [Out-of-order execution](out-of-order-execution)
3. [Branch prediction](branch-prediction)
4. [Indirect jump prediction](indirect-jump-prediction)
5. [Loop-carried dependencies](loop-carried-dependency)
6. [Register renaming](register-renaming)
7. [MOV elimination](mov-elimination)
8. [Zeroing idioms](zeroing-idiom)
9. [Macro-op fusion](macro-fusion)

Enjoy!

## Notes

### Performance disclaimer

Naturally, the exact results of microbenchmarks depend significantly on your CPU's microarchitecture - demonstrating microarchitecture in a microarchitecture-agnostic manner is difficult. Some factors that may contribute to differing results include:

- Feature is not implemented on all CPUs.
- Particular instruction latencies are assumed.
- A minimum amount of parallel execution capacity (execution ports) is assumed.

The demonstrations were written and tested with Intel x86-64 CPUs from Skylake onwards in mind. I have tried my best to indicate in each demonstration broadly which CPUs are supported and what assumptions are made.

### What's this "Skylake JCC alignment issue"?

In almost every demonstration's assembly code, you will see something like this:

```
.p2align 4      # Skylake JCC alignment issue (unimportant)
loop:
    ...
```

The `.p2align` enforces memory address alignment on the start of the loop. This alignment ensures the loop's trailing jump instruction is placed correctly to avoid a performance pessimisation on some Intel CPUs (see [Intel's paper](https://www.intel.com/content/dam/support/us/en/documents/processors/mitigations-jump-conditional-code-erratum.pdf) for details).  
Please ignore this issue - it does not affect the correctness of the demonstrations.
