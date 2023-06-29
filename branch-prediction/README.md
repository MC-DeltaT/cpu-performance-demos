# Demo - Branch Prediction

## Overview

A demonstration of branch prediction, an optimisation where the CPU predicts the result of a branch (jump) instruction, allowing execution to continue without waiting.

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

This demonstration consists of two almost identical assembly programs, `predictable.s` and `unpredictable.s`. Each program generates a sequence of integers, and for each integer, branches to slightly different operations depending if it's even or odd.  
However, `unpredictable`'s sequence is largely random, while `predictable`'s sequence alternates perfectly between even and odd.

To build the programs, run in this directory:

```bash
make
```

Then run each program and check the number of cycles taken and the branch prediction rate:

```bash
perf stat -e cycles,branches,branch-misses ./predictable
perf stat -e cycles,branches,branch-misses ./unpredictable
```

You should find that `predictable` runs in significantly fewer cycles than `unpredictable` - about 50% less on the machines I have tested.

The reason is branch prediction. Modern CPUs try to guess the result of a conditional jump instruction to avoid stalling the pipeline on waiting for the jump condition to be executed. If the guess is correct, the speedup can be significant; however, if the guess is wrong, the CPU must "go back" and redo execution on the correct instruction path.

If the result of the comparison is essentially random - as is the case in `unpredictable` - the CPU cannot do much better than 50% prediction accuracy. On the other hand, if the comparison result follows a pattern that the CPU can recognise - as is the case in `predictable` - the prediction rate can be near 100%. This is highlighted in the `branch-misses` counter, which shows how many branches were predicted incorrectly.
