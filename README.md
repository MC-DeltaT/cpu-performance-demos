# CPU Performance Demonstrations

A collection of microbenchmarks demonstrating low-level concepts and optimisations that affect performance on modern x86 CPUs.

Warning: CPU microarchitecture ahead!

If you are new to the world of CPU architecture and microarchitecture, you may want to read [Primer.md](Primer.md), which covers some basic concepts that are prerequisite knowledge for many of the demonstrations.

---

Please note: naturally, the exact results of these microbenchmarks depend significantly on your CPU's microarchitecture. The demonstrations were written and tested with "modern" Intel x86-64 CPUs in mind, with "modern" being roughly Skylake or newer. Many of the more general demonstrations will likely work on modern AMD x86-64 CPUs as well.  
I have tried to indicate in each demonstration broadly which CPUs are supported, however this may not be completely accurate, particularly for older CPUs.
