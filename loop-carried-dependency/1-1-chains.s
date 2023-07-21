.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 10

# TODO
.p2align 4      # JCC alignment issue on Skylake (unimportant)
loop:
    add     %rcx, 7     # 1-cycle dependency chain

    dec     %rax        # 1-cycle dependency chain
    jnz     loop

    ret
