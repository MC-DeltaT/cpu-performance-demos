.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 314

.p2align 5      # Skylake JCC alignment issue (unimportant)
loop:
    imul    %rcx, %rcx, 10
    add     %rcx, 20
    shl     %rcx, 13

    dec     %rax            # Loop counter & condition
    jnz     loop
    ret
