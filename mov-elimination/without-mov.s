.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
.p2align 4      # Skylake JCC alignment issue (unimportant)
loop:
    lea     %rax, [%rax-1]  # Decrement loop counter
    test    %rax, %rax      # Loop if not 0
    jnz     loop
    ret
