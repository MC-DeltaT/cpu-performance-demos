.intel_syntax

.global main

.text

main:
    mov     %rax, 20000000000   # Loop counter
    mov     %rcx, 314
    mov     %rdx, 159
    mov     %rsi, 265
.p2align 4      # JCC alignment issue on Skylake (unimportant)
loop:
    add     %rcx, %rcx      # Arithmetic 1
    sub     %rdx, 3         # Arithmetic 2
    rol     %rsi, 5         # Arithmetic 3
    dec     %rax            # Loop counter & condition
    jnz     loop
    ret
