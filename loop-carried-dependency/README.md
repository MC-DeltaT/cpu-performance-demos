# Demo - Loop-carried Dependencies

## Overview

Loop-carried dependencies are chains of data dependencies which span across loop iterations. They are one of the primary limiting factors of loop speed: the average cycles per iteration cannot be lower than the execution latency of a loop-carried dependency.

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

- &gt;= 2 scalar ALU execution units/ports
- Basic scalar ALU instructions have 1 cycle latency
- Predicted jump instructions have 1 cycle latency

## Tutorial

This demonstration consists of several assembly programs, each containing a loop with a different loop-carried dependency. The programs will be explained in order of increasing complexity.

To build the programs, run in this directory:

```bash
make
```

### 1-chain

`1-chain.s` contains the most basic loop with a condition. It does nothing other than decrement the loop counter (`rax`) to zero, then exit.

The loop-carried dependency here is a chain with one instruction: `dec %rax`. The `dec` depends on the previous value of `rax`, and produces the next value of `rax`. This data dependency means that one `dec` cannot begin execution until the previous `dec` has finished. Consequently, one loop iteration cannot begin until the previous iteration has completed.  
Note the behaviour of the loop is also dependent on the `jnz` instruction, which depends on the `dec`. However, if this branch is predicted correctly, the CPU can begin execution of the next loop iteration without waiting for the `jnz`<sup>1</sup>. In this way, predictable jump instructions can be effectively disregarded from performance considerations.

Run the program and measure the number of cycles required:

```bash
perf stat -e instructions,cycles ./1-chain
```

Divide the number of cycles by one billion (the number of loop iterations) to find the latency of one iteration. On modern CPUs, this value should be near one cycle per iteration.  
We can justify this result by examining how the instructions may be scheduled. Assuming `dec` and `jnz` take one cycle each, which is true on modern CPUs, the best instruction scheduling which preserves data dependencies is as follows:

```text
Cycle       Instruction (iteration)
1           dec %rax (1)
2           dec %rax (2)  +  jnz (1)
3           dec %rax (3)  +  jnz (2)
...         ...
```

Overall, the loop performance is nearly exclusively defined by the latency of the loop-carried dependency, `dec rax`.

### 1-1-chains

`1-1-chains.s` contains a loop with two independent loop-carried dependency chains of one instruction each. One chain is the `dec %rax` loop counter, as in `1-chain`. The other chain is an `add %rcx`, which behaves similarly.  
Each of these loop-carried dependency chains limits the maximum performance of the loop, but since they do not interact, may still execute in parallel.

Run the program and measure the number of cycles required:

```bash
perf stat -e instructions,cycles ./1-1-chains
```

You should observe that the loop executes with the same latency as in `1-chain`, approximately one cycle per iteration on modern CPUs.  
Assuming all instructions take one cycle each, the best instruction scheduling which preserves data dependencies is:

```text
Cycle       Instruction (iteration)
1           add %rcx (1)  +  dec %rax (1)
2           add %rcx (2)  +  dec %rax (2)  +  jnz (1)
3           add %rcx (3)  +  dec %rax (3)  +  jnz (2)
...         ...
```

While two loop-carried dependencies are present, they are independent and have the same latency, and so the loop iteration latency remains the same.

### 1-3-chains

`1-3-chains.s` contains a loop with two independent loop-carried dependency chains. One chain is the `dec %rax` loop counter, as previously. The other chain consists of three arithmetic instructions on `rcx`.  
Again, each of these chains does not affect the other, and so may execute in parallel.

Run the program and measure the number of cycles required:

```bash
perf stat -e instructions,cycles ./1-3-chains
```

You should observe that the loop executes with more than one cycle per iteration - approximately three cycles per iteration on modern CPUs. This corresponds to the three cycles required for the `rcx` loop-carried dependency.  
Assuming all instructions take one cycle each, the best instruction scheduling which preserves data dependencies is:

```text
Cycle       Instruction (iteration)
1           add %rcx (1)  +  dec %rax (1)
2           shl %rcx (1)  +  dec %rax (2)  +  jnz (1)
3           xor %rcx (1)  +  dec %rax (3)  +  jnz (2)
4           add %rcx (2)  +  dec %rax (4)  +  jnz (3)
5           shl %rcx (2)  +  dec %rax (5)  +  jnz (4)
6           xor %rcx (2)  +  dec %rax (6)  +  jnz (5)
...         ...
```

Notice that three cycles are required to complete the `rcx` arithmetic chain, and this becomes the limiting factor in the loop performance. Even if the executions of `dec` and `jnz` proceed at a faster pace initially, ultimately we must still wait for the `rcx` chain to complete. The number of cycles per iteration cannot be less than the latency of the slowest loop-carried dependency.

### Notes

<small><sup>1</sup>The astute among you may notice that on modern CPUs, the `dec` and `jnz` macro-fuse into one micro-instruction that has a latency of one cycle. This does not affect the explanation, because it is still due to branch prediction that branches are removed from dependency chains. Even with macro-op fusion, the lack of branch prediction would cause large stalls in instruction fetching, preventing a new instruction from being executed each cycle.</small>
