.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
.p2align 6      # JCC alignment issue on Skylake (unimportant)
loop:
    lea     %rax, [%rax-1]
    test    %rax, %rax
    jnz     loop
    ret
