# CPU Architecture Primer

If you are not familiar with CPU architecture and microarchitecture, you may find it useful to read this document before diving into the demonstrations.

## CPU Operation Fundamentals

Fundamentally, a CPU executes a stream of *instructions*. In its most basic form, a CPU reads instructions from memory (RAM), executes them, updates its internal state, and writes results back to memory.

What instructions a CPU can perform is defined by the *instruction set architecture*, or *architecture* for short.

Each instruction is a small computation or other operation that the CPU can execute directly. Examples are adding two integers (x86 `add` instruction) or loading data from memory (x86 `mov` instruction).  
Unlike textual source code, instructions are stored in memory as *machine code*, which are raw byte values with particular meanings to the CPU.

In addition to memory, the CPU has internal state called *registers*. Registers are the go-to data storage facility within the CPU. Most instructions operate on registers, not memory locations.

Physical CPU chips these days usually contain more than one logical CPU, called *cores*. Each core operates mostly independently from the others. In these demonstrations, the focus is on the behaviour and performance of a single core. References to "the CPU" mean one CPU core.

## Assembly

While instructions are stored in memory as machine code, there exists a human-readable form known as *assembly*, which maps (mostly) directly to/from machine code.

Assembly is useful because it allows us to see exactly what instructions the CPU will execute, and hence is the language of choice for these demonstration programs.  
The downside of assembly is that it is tedious to write and understand. I would recommend finding an (x86) assembly tutorial online to ensure you know roughly how assembly works.

## x86 Architecture

x86 is the relevant instruction set architecture examined in these demonstrations. It has been around since the 1970s, and is now ubiquitous in desktops, laptops, and servers.

Since the early 2000s, x86 has been extended to support 64-bit data types, called x86-64. Today, since 64-bit is the most common variation everywhere, the names x86 and x86-64 are used mostly synonymously.  
Further extensions to the instruction set have been added, the most notable being the vector instruction sets AVX, AVX2, and AVX-512.

The x86 architecture defines a set of instructions and registers and how they interact. To understand these demonstrations, you should know common load/store, arithmetic, logic, comparison, and branch instructions, as well as the available registers. There is too much to explain here, so I would recommend searching for an x86 assembly tutorial online to learn the basics.

For specific reference of x86 instructions, see here: [https://www.felixcloutier.com/x86](https://www.felixcloutier.com/x86/)  
For reference of x86-64 registers, see here: [https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/x64-architecture](https://learn.microsoft.com/en-us/windows-hardware/drivers/debugger/x64-architecture)

## Microarchitecture

The instruction set architecture defines the high-level interface to the CPU, but at a lower level, CPU hardware can vary significantly. The exact hardware implementation and performance characteristics of a CPU is referred to as its *microarchitecture*.

One major source of variation between microarchitectures is performance, with manufacturers implementing many features over the years in to try to make x86 code run faster.

The major x86 CPU manufacturers are Intel and AMD. Traditionally, Intel CPUs have been dominant in single-core performance, and often implement performance-enhancing features before AMD. These demonstrations are therefore mostly focused on Intel CPUs.  
A list of Intel x86 microarchitectures can be found here: [https://en.wikichip.org/wiki/intel/microarchitectures](https://en.wikichip.org/wiki/intel/microarchitectures)  
A list of AMD x86 microarchitectures can be bound here: [https://en.wikichip.org/wiki/amd/microarchitectures](https://en.wikichip.org/wiki/amd/microarchitectures)

## Instruction Pipeline

It is infeasible to implement CPU hardware that is able to read, parse, and execute an instruction all at once. Instead, instructions flow through a *pipeline* with multiple stages, each stage performing a different operation necessary to execute the instruction.  
Ideally, an instruction will progress to the next pipeline stage every *clock cycle*. One cycle is the smallest unit of time that the CPU operates on. (If your CPU is labelled "3GHz", that is three billion cycles per second.)

The classic pipeline stage are:

1. Fetch - load the instruction from memory.
2. Decode - figure out what needs to be done for the instruction.
3. Execute - compute the instruction results.
4. Write back - commit results to registers and memory.

However, the complexity of modern x86 microarchitecture has led to more pipeline stages. A typical Intel pipeline might look like:

1. Branch prediction - predict which instruction will come next.
2. Fetch - load instructions from memory.
3. Decode - emit micro-instructions for each instruction (see next section).
4. Register renaming - map register names to hardware registers.
5. Reorder buffer & scheduling - reorder micro-instructions based on data dependencies.
6. Execute - execute the micro-instruction.
7. Retire - commit results to registers and memory.

Some of these stages may be broken down even further, for a total of 10-20 stages.  
It is not critical to know everything about all the stages for the purposes of these demonstrations; particularly interesting/relevant stages will be discussed within the demonstrations.

## Micro-instructions

There are hundreds of x86 instructions, too many for CPU hardware to execute directly. To be more efficient, modern x86 CPUs decode machine code instructions into a smaller number of even more fundamental operations, called *micro-instructions*, which the CPU hardware can execute directly.

One instruction maps to some number of micro-instructions as part of the "decode" pipeline stage, from which point onwards the CPU deals in terms of micro-instructions only. Common, basic instructions such as integer arithmetic and logic are typically one micro-instruction. More complex instructions may be multiple micro-instructions. Each micro-instruction takes at least one cycle to execute (with a few exceptions).

## References

Much of the information on x86 microarchitecture I have learnt is from Agner Fog's guide, which I would like to credit here: "*The microarchitecture of Intel, AMD and VIA CPUs: An optimization guide for assembly programmers and compiler makers*", available at [https://www.agner.org/optimize/#manuals](https://www.agner.org/optimize/#manuals). This guide is a wealth of information and I highly recommend reading it if you want to know more about microachitecture.  
Additionally, their guide "*Instruction tables: Lists of instruction latencies, throughputs and micro-operation breakdowns for Intel, AMD and VIA CPUs*" is a useful reference to understand the performance of various instructions.
