.intel_syntax noprefix

.global main

.text

main:
    mov     rax, 10000000000    # Loop counter
    mov     rcx, 314
    mov     rdx, 159
    mov     rsi, 265

.p2align 5      # Skylake JCC alignment issue (unimportant)
loop:
    imul    rcx, rcx, 10
    add     rdx, 20
    shl     rsi, 13

    dec     rax             # Loop counter & condition
    jnz     loop
    ret
