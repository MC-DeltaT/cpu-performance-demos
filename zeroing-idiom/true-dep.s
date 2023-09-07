.intel_syntax noprefix

.global main

.text

main:
    mov     rax, 10000000000    # Loop counter
    mov     rcx, 314
    mov     rdx, 159

.p2align 5      # Skylake JCC alignment issue (unimportant)
loop:
    xor     rcx, rdx
    shl     rcx, 3
    add     rcx, 17

    dec     rax             # Loop counter & condition
    jnz     loop
    ret
