.intel_syntax

.global main

.text

main:
    sub     %rsp, 8     # Stack alignment for call
    push    %r12
    push    %r13
    mov     %r12, 0xfffffff     # Array size

    mov     %rdi, %r12          # Allocate array
    call    malloc
    mov     %r13, %rax          # Save array pointer

    mov     %rdi, %r13          # Write to array to force page-in
    mov     %rsi, 42
    mov     %rdx, %r12
    call    memset

    mov     %rcx, 0             # Random state
    mov     %rdx, 500000000     # Loop counter
    mov     %rax, 0             # Result accumulator

# TODO
.p2align 5      # Skylake JCC alignment issue (unimportant)
loop:
    mov     %rdi, %rcx      # Generate next array index
    add     %rcx, 1
    add     %rcx, %rdi
    mov     %rdi, %rcx
    and     %rdi, %r12
    movzx   %rsi, BYTE PTR [%r13+%rdi]   # Read from array index
    add     %rax, %rsi

    dec     %rdx            # Loop counter & condiiton
    jnz     loop

    pop     %r13
    pop     %r12
    add     %rsp, 8
    ret
