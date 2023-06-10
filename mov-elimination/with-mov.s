.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
.p2align 6      # JCC alignment issue on Skylake (unimportant)
loop:
    lea     %rdi, [%rax-1]
    mov     %rax, %rdi
    test    %rax, %rax
    jnz     loop
    ret
