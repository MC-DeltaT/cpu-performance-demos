.intel_syntax

.global main

.text

main:
    sub     %rsp, 8     # Stack alignment for call
    push    %r12
    push    %r13
    mov     %r12, 0xfffffff     # Array size

    mov     %rdi, %r12
    call    malloc              # Allocate array
    mov     %r13, %rax          # Save array pointer

    mov     %rdi, %r13          # Write to array to force page-in
    mov     %rsi, 42
    mov     %rdx, %r12
    call    memset

    mov     %rcx, 1000000000    # Loop counter
    mov     %rdx, 0             # Index sequence start
    mov     %rax, 0             # Result accumulator

# TODO
.p2align 5      # Skylake JCC alignment issue (unimportant)
loop:
    mov     %rdi, %rdx
    and     %rdi, %r12      # Mask index to array size
    movzx   %rsi, BYTE PTR [%r13+%rdi]   # Read from array index
    add     %rax, %rsi

    lea     %rdx, [%rdx+1] # Generate next array index
    dec     %rcx        # Loop counter & condiiton
    jnz     loop

    pop     %r13
    pop     %r12
    add     %rsp, 8
    ret
