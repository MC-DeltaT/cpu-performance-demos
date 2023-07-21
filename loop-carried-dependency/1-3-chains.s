.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 10

# TODO
.p2align 4      # JCC alignment issue on Skylake (unimportant)
loop:
    add     %rcx, 7     # 3-cycle dependency
    shl     %rcx, 6
    xor     %rcx, 4321

    dec     %rax        # 1-cycle dependency
    jnz     loop

    ret
