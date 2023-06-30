.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
.p2align 4      # JCC alignment issue on Skylake (unimportant)
loop:
    lea     %rdi, [%rax-1]  # Decrement loop counter
    mov     %rax, %rdi      # Extraneous register shuffle
    test    %rax, %rax      # Loop if not 0
    jnz     loop
    ret
