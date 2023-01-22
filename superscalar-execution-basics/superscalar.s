.intel_syntax

.global main

.text

main:
    movq    %rax, 20000000000   # Loop counter
    movq    %rcx, 314
    movq    %rdx, 159
    movq    %rsi, 265
.p2align 4      # JCC alignment issue on Skylake (unimportant)
loop:
    addq    %rcx, %rcx      # Arithmetic 1
    subq    %rdx, 3         # Arithmetic 2
    rol     %rsi, 5         # Arithmetic 3
    decq    %rax            # Loop counter & condition
    jnz     loop
    ret
