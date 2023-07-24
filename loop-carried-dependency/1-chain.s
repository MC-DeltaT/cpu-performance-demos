.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter

# TODO
.p2align 3      # JCC alignment issue on Skylake (unimportant)
loop:
    dec     %rax        # 1-cycle dependency chain
    jnz     loop

    ret