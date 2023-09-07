.intel_syntax noprefix

.global main

.text

main:
    mov     rax, 10000000000    # Loop counter
    mov     rcx, 10

.p2align 4      # Skylake JCC alignment issue (unimportant)
loop:
    add     rcx, 7      # 1-instruction dependency chain

    dec     rax         # 1-instruction dependency chain
    jnz     loop

    ret
