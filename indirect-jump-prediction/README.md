# Demo - Indirect Jump Prediction

## Overview

A demonstration of the utility of indirect jump prediction.

This demo consists of two almost identical assembly programs, `predictable.s` and `unpredictable.s`. Each program generates a sequence of integers, and for each integer, performs a slightly different operation depending if it's even or odd.  
However, `unpredictable`'s sequence is largely random, while `predictable`'s sequence alternates perfectly between even and odd.

## Requirements

- GCC
- Make

## Build & Run

To build both programs, run in this directory:

```bash
make
```

Then run each program and check their performance:

```bash
time ./predictable
time ./unpredictable
```

You may want to confirm the branch prediction hit rate - which is inclusive of indirect jumps:

```bash
perf stat -e branches,branch-misses ./predictable
perf stat -e branches,branch-misses ./unpredictable
```

## Explanation

You should find that `predictable.s` runs significantly faster than `unpredictable.s` (about 50% faster on the machines I have tested).

The reason is indirect jump prediction. Modern CPUs try to guess the target location of an indirection jump to avoid stalling the instruction pipeline waiting for the calculation of the location. If the guess is correct, the speedup can be significant; however, if the guess is wrong, the CPU must "go back" and redo execution on the correct instruction path.

If the target location is essentially random - as is the case in `unpredictable.s` - the CPU cannot do much better than 50% prediction accuracy.  
On the other hand, if the target location follows a pattern that the CPU can recognise - as is the case in `predictable.s` - the prediction rate can be near 100%.
