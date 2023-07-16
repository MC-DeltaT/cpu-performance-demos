.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 314
    mov     %rdx, 159
    mov     %rsi, 265

.p2align 5      # JCC alignment issue on Skylake (unimportant)
loop:
    imul    %rcx, %rcx, 10
    add     %rdx, 20
    shl     %rsi, 13

    dec     %rax            # Loop counter & condition
    jnz     loop
    ret
