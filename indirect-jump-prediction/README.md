# Demo - Indirect Jump Prediction

## Overview

A demonstration of indirect jump prediction, a part of branch prediction. This optimisation enables the CPU to predict the target location of an indirect jump instruction, allowing execution to continue without waiting.

It may be useful to first see the `branch-prediction` demonstration to familiarise yourself with branch prediction.

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

This demonstration consists of two almost identical assembly programs, `predictable.s` and `unpredictable.s`. Each program generates a sequence of integers, and for each integer, jumps to different locations in code depending if it's even or odd.  
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

Note the branch-related counters are inclusive of indirect jumps.

You should find that `predictable` runs in significantly fewer cycles than `unpredictable` - about 50% less on the machines I have tested.

The reason is indirect jump prediction. Modern CPUs try to guess the target location of an indirect jump to avoid stalling the pipeline waiting for the calculation of the location. If the guess is correct, the speedup can be significant; however, if the guess is wrong, the CPU must "go back" and redo execution on the correct instruction path.

If the target location is essentially random - as is the case in `unpredictable.s` - the CPU cannot do much better than 50% prediction accuracy. On the other hand, if the target location follows a pattern that the CPU can recognise - as is the case in `predictable.s` - the prediction rate can be near 100%. This is highlighted in the `branch-misses` counter, which shows how many jumps were predicted incorrectly.
