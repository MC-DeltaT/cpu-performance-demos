.intel_syntax
.global main
.text

main:
    mov     %rcx, 25698         # Random state
    mov     %rdx, 2000000000    # Loop counter
    mov     %rax, 0             # Result accumulator

loop:
    mov     %rdi, %rcx      # Generate next number in sequence
    sar     %rcx, 13
    add     %rcx, %rdi
    test    %rcx, 1         # Check if number is even/odd
    jnz     branch          # Jump if odd
    add     %rax, 3141      # Branch 1
    jmp     tail
branch:
    add     %rax, 5926      # Branch 2
    jmp     tail
    nop
tail:
    dec     %rdx            # Loop counter & condiiton
    jnz     loop

    ret
