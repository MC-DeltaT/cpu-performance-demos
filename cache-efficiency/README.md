# Demo - Cache Efficiency

## Overview

TODO

## Requirements

TODO

## Tutorial

TODO

```bash
perf stat -e instructions,cycles,mem_inst_retired.all_loads,mem_load_retired.l1_hit,mem_load_retired.l1_miss,l1d_pend_miss.pending_cycles ./predictable
perf stat -e instructions,cycles,mem_inst_retired.all_loads,mem_load_retired.l1_hit,mem_load_retired.l1_miss,l1d_pend_miss.pending_cycles ./unpredictable
```
