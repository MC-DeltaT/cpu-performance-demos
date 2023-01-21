.intel_syntax
.global main
.text

main:
    movq    %rcx, 25698         # Random state
    movq    %rdx, 2000000000    # Loop counter
    movq    %rax, 0             # Result accumulator

loop:
    movq    %rdi, %rcx      # Generate next number in sequence
    sarq    %rcx, 13
    addq    %rcx, %rdi
    testq   %rcx, 1         # Check if number is even/odd
    jnz     branch          # Jump if odd
    addq    %rax, 3141      # Branch 1
    jmp     tail
branch:
    addq    %rax, 5926      # Branch 2
    jmp     tail
    nop
tail:
    decq    %rdx            # Loop counter & condiiton
    jnz     loop

    ret
