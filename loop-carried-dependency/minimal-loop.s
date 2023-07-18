.intel_syntax

.global main

.text

main:
# TODO
.p2align 2      # JCC alignment issue on Skylake (unimportant)
loop:
    jmp     loop
