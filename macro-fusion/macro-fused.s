.intel_syntax

.global main

.text

main:
    mov     %rax, 10000000000   # Loop counter
.p2align 3      # JCC alignment issue on Skylake (unimportant)
loop:
    dec     %rax    # Decrement loop counter
    jnz     loop    # Loop if not 0
    ret
