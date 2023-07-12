.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 0
    mov     %r8, 0
    mov     %r9, 0

.p2align 4      # JCC alignment issue on Skylake (unimportant)
loop:
    lea     %rcx, [%r8+10]      # Independent arithmetic on R8
    shl     %rcx, 11
    add     %r8, %rcx

    lea     %rdx, [%r9+20]      # Independent arithmetic on R9
    shl     %rdx, 12
    add     %r9, %rdx

    dec     %rax            # Loop counter & condition
    jnz     loop
    ret
