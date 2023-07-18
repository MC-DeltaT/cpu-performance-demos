.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 10

# TODO
.p2align 4      # JCC alignment issue on Skylake (unimportant)
loop:
    add     %rcx, 7     # 4-cycle dependency
    shl     %rcx, 6
    sub     %rcx, 5
    xor     %rcx, 4321

    dec     %rax        # Loop counter & condition
    jnz     loop

    ret
