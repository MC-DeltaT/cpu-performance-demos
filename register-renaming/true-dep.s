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
    add     %rcx, %r8       # Arithmetic on R8 & RCX
    shl     %rcx, 11
    add     %r8, %rcx

    add     %rcx, %r9       # Arithmetic on R9 & RCX
    shl     %rcx, 12
    add     %r9, %rcx

    dec     %rax            # Loop counter & condition
    jnz     loop
    ret