section .text
global fibonacci
extern printf          ; Tell assembler we are using C's printf function

fibonacci:
    ; --- Standard Function Setup 
    push ebp
    mov ebp, esp
    
    ; --- Get Argument ---
    mov eax, [ebp + 8]      ; Get 'n' (the first argument) from the stack
    cmp eax, 0              ; Compare n with 0
    jle .done               ; If n <= 0, jump straight to the end

    ; --- Initialize Fibonacci sequence ---
    mov ecx, 0              ; ecx = current term (starts at 0)
    mov edx, 1              ; edx = previous term (starts at 1)
    mov esi, 0              ; esi = loop counter (i=0)

.loop:
    ; --- Save Registers before printf ---
    ; eax, ecx, and edx. We save them first.
    push eax                ; Save 'n'
    push ecx                ; Save 'current'
    push edx                ; Save 'previous'

    ; --- Print the current number ---
    push ecx                ; Arg 2: The number to print (current)
    push format             ; Arg 1: The format string ("%d ")
    call printf
    add esp, 8              ; Clean up 2 arguments from printf call

    ; --- Restore Registers ---
    ; Pop them back in reverse order
    pop edx                 ; Restore 'previous'
    pop ecx                 ; Restore 'current'
    pop eax                 ; Restore 'n'

    ; --- Calculate next Fibonacci number ---
    ; (Now our registers are safe)
    mov ebx, ecx            ; temp = current
    add ecx, edx            ; current = current + previous
    mov edx, ebx            ; previous = temp
    
    ; --- Loop Control ---
    inc esi                 ; counter++
    cmp esi, eax            ; Compare counter with n
    jl .loop                ; If (counter < n), loop again

.done:
    ; --- Standard Function Cleanup ---
    pop ebp
    ret

; --- Data Section ---
section .data
    format db "%d ", 0      ; The format string, null-terminated (0)

; --- Stack Note ---
; This section to prevent linker warnings
section .note.GNU-stack