.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
    mov     %rcx, 0
    mov     %rdx, 0
    mov     %rdi, 0
    mov     %rsi, 0
    mov     %r8, 0
    mov     %r9, 0
    mov     %r10, 0
    mov     %r11, 0
.p2align 6      # JCC alignment issue on Skylake (unimportant)
loop:
    inc     %rcx
    inc     %rdx
    inc     %rdi
    inc     %rsi
    inc     %r8
    inc     %r9
    inc     %r10
    inc     %r11
    dec     %rax    # Decrement loop counter
    nop
    jnz     loop    # Loop if not 0
    ret
