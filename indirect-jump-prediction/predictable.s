.intel_syntax noprefix

.global main

.text

main:
    mov     rcx, 25698          # Random state
    mov     rdx, 2000000000     # Loop counter
    mov     rax, 0              # Result accumulator
.p2align 3      # Skylake JCC alignment issue (unimportant)
loop:
    mov     rdi, rcx        # Generate next number in sequence
    sar     rcx, 13
    add     rcx, rdi
    mov     rdi, rcx        # Compute jump table offset
    and     rdi, 1
    shl     rdi, 3          # Even -> rdi=0, odd -> rdi=8
    lea     rsi, [targets+rip]  # Load jump table
    jmp     [rsi+rdi]       # Even -> target1, odd -> target2
target1:
    add     rax, 3141
    jmp     tail
target2:
    add     rax, 5926
    jmp     tail
    nop
tail:
    dec     rdx             # Loop counter & condiiton
    jnz     loop
    ret

.data

targets:    # Target jump table
    .quad  target1, target2
