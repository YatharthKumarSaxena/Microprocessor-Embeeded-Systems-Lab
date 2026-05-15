global fibonacci

section .text

fibonacci:

    mov rcx,rdi
    cmp rcx,0
    je .zero
    cmp rcx,1
    je .one
    mov rax,0
    mov rbx,1
    mov rcx,1

.loop:
    cmp rcx,rdi
    je .done
    mov rdx,rbx
    add rbx,rax
    mov rax,rdx
    inc rcx
    jmp .loop

.done:
    mov rax,rbx
    ret
.one:
    mov rax,1
    ret
.zero:
    mov rax,0
    ret