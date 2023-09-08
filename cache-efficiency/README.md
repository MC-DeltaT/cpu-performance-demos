# Demo - Cache Efficiency

## Overview

A demonstration of the performance gained by utilising the cache efficiently. Cache is a limited but fast buffer between the CPU and main memory which stores recently accessed data for later use.
Accessing memory in "cache-friendly" patterns improves execution latency and throughput.

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

- &lt;&lt; 260MB of cache per core

## Tutorial

This demonstration consists of two nearly identical assembly programs, `sequential.s` and `random.s`. Both allocate a large array of memory, then sum up the bytes in the array. The only difference is that `sequential` reads the bytes sequentially, whereas `random` reads them in an essentially random order. Sequential memory reads are more likely to be cache-friendly, leading increased performance.

To build the programs, run in this directory:

```bash
make
```

Then run each program and measure the number of cycles, along with some memory access information:

```bash
perf stat -e instructions,cycles,mem_load_retired.l1_hit,l1d_pend_miss.pending_cycles ./sequential
perf stat -e instructions,cycles,mem_load_retired.l1_hit,l1d_pend_miss.pending_cycles ./random
```

The information we gathered here is:

- `mem_load_retired.l1_hit` - Number of load instructions where data was already in level 1 cache ("hit").
- `l1d_pend_miss.pending_cycles` - Number of cycles waiting for data to be loaded from higher cache levels or memory.

Note that the loop has one billion iterations and the same number of memory loads.

You should observe that `random` takes far more cycles to execute than `sequential` (10-20x on the machine I tested). Furthermore, for `sequential`, almost all loads are cache hits. Meanwhile, for `random`, only a very small proportion of loads are cache hits, and almost all cycles taken by the program are spent waiting for data to be loaded from memory.

The reason for these results is due to the nature of the function of the cache.  
Firstly, data in the cache is divided into "lines" - commonly 64 bytes - to make implementation efficient and on the assumption that nearby data is likely to be accessed simultaneously. Subsequently, when loading data from main memory, an entire line is loaded at once.  
Secondly, the cache can contain only a small subset of main memory at a time. This means that loading a new line from memory requires evicting another line from the cache.  
If an array is read sequentially, as in `sequential`, then we get multiple read hits to the same cache line after just one memory load. However, if data is read randomly, then after loading one cache line and reading one byte, we jump to another cache line. The chance that line is already in the cache is low if the array is much larger than the cache. In this latter case, which is exhibited by `random`, more loads are required on average to read the same number of bytes. As memory loads are slow, performance drops significantly.
