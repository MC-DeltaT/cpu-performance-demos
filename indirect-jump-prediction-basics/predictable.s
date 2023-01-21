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
    movq    %rdi, %rcx      # Compute jump table offset
    andq    %rdi, 1
    shlq    %rdi, 3         # Even -> RDI=0, odd -> RDI=8
    leaq    %rsi, [targets+%rip]    # Load jump table
    jmpq    [%rsi+%rdi]     # Even -> target1, odd -> target2
target1:
    addq    %rax, 3141
    jmp     tail
target2:
    addq    %rax, 5926
    jmp     tail
    nop
tail:
    decq    %rdx            # Loop counter & condiiton
    jnz     loop
    ret

.data
targets:    # Target jump table
    .quad  target1, target2
