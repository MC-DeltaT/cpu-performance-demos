.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 10

.p2align 5      # JCC alignment issue on Skylake (unimportant)
loop:
    add     %rcx, 7     # 3-instruction dependency
    shl     %rcx, 6
    xor     %rcx, 4321

    dec     %rax        # 1-instruction dependency
    jnz     loop

    ret
