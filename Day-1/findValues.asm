section .text
global findValues

findValues:

    push ebp
    mov ebp, esp
    sub esp, 4            ; Allocate 4 bytes on stack to hold secMin

    ; Save call-saving registers
    push ebx
    push esi
    push edi

    mov esi, [ebp+8]      ; esi = arr pointer
    mov ecx, [ebp+12]     ; ecx = n (size of array)

    ; Prevent crash if array is empty
    cmp ecx, 0
    jle finish_early

    ; Initialization
    mov ebx, [esi]        ; ebx (max) = arr[0]
    mov edi, [esi]        ; edi (min) = arr[0]
    mov edx, 0x80000000   ; edx (secMax) = INT_MIN (-2147483648)
    mov dword [ebp-4], 0x7FFFFFFF ; [ebp-4] (secMin) = INT_MAX (2147483647)

    mov ecx, 1            ; loop counter i = 1

loop_start:
    cmp ecx, [ebp+12]     ; compare i with n
    jge finish            ; if i >= n, we are done

    mov eax, [esi + ecx*4]; eax = arr[i]

check_max:
    cmp eax, ebx          ; compare arr[i] with max
    jle check_sec_max     ; if arr[i] <= max, skip to secMax check
    
    ; Here found a new max
    mov edx, ebx          ; old max becomes secMax
    mov ebx, eax          ; arr[i] becomes new max
    jmp check_min         ; skip secMax check

check_sec_max:
    cmp eax, ebx          
    je check_min          ; Skip if arr[i] == max (we only want strictly 2nd max)
    cmp eax, edx          ; compare arr[i] with secMax
    jle check_min         ; if arr[i] <= secMax, move on
    mov edx, eax          ; secMax = arr[i]

check_min:
    cmp eax, edi          ; compare arr[i] with min
    jge check_sec_min     ; if arr[i] >= min, skip to secMin check
    
    ; If we are here, we found a new min
    mov eax, edi          ; move old min into eax temporarily
    mov dword [ebp-4], eax; old min becomes secMin
    mov eax, [esi + ecx*4]; reload arr[i] back into eax
    mov edi, eax          ; arr[i] becomes new min
    jmp next

check_sec_min:
    cmp eax, edi          
    je next               ; Skip if arr[i] == min (we only want strictly 2nd min)
    cmp eax, dword [ebp-4]; compare arr[i] with secMin
    jge next              ; if arr[i] >= secMin, move on
    mov dword [ebp-4], eax; secMin = arr[i]

next:
    inc ecx
    jmp loop_start

finish:
    ; Writing Results here
    mov eax, [ebp+16]     ; pointer to max
    mov [eax], ebx

    mov eax, [ebp+20]     ; pointer to min
    mov [eax], edi

    mov eax, [ebp+24]     ; pointer to secMax
    mov [eax], edx

    mov eax, [ebp+28]     ; pointer to secMin
    mov ecx, dword [ebp-4]
    mov [eax], ecx

finish_early:
    ; Restore callee-saved registers in reverse order of pushing
    pop edi
    pop esi
    pop ebx

    mov esp, ebp          ; Cleans up local variables (our secMin allocation)
    pop ebp
    ret

section .note.GNU-stack noalloc noexec nowrite progbits