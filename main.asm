oceuli proc
    push ebp                            ; Prologue: Save the base pointer
    mov ebp, esp
    sub esp, 100                        ; Allocate 100 bytes on the stack for local storage

    ; Initialize the stack with 4-digit numeric chunks (First 20-digit number segments)
    mov dword ptr [ebp+4], 1234  
    mov dword ptr [ebp+8], 5678  
    mov dword ptr [ebp+12], 9012 
    mov dword ptr [ebp+16], 3456 
    mov dword ptr [ebp+20], 7890 

    ; Initialize the stack with the second set of 4-digit chunks (Second 20-digit number segments)
    mov dword ptr [ebp+24], 9876 
    mov dword ptr [ebp+28], 5432 
    mov dword ptr [ebp+32], 1098 
    mov dword ptr [ebp+36], 7654 
    mov dword ptr [ebp+40], 3210 
    
    mov dword ptr [ebp+64], 0           ; Initialize carry placeholder to 0

    ; Clear general-purpose registers
    xor eax, eax  
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    xor esi, esi
    xor edi, edi

    mov ecx, 1                          ; Initialize loop counter/index

    ; Perform initial addition for the first chunk to bootstrap the pipeline
    mov eax, dword ptr [ebp+ecx*4]      ; Load first segment from number 1
    add eax, dword ptr [ebp+20+ecx*4]   ; Add corresponding segment from number 2

mimateba:                               ; Main loop for chunk-based addition
    mov ebx, eax                        ; Backup the current addition result to preserve it
    mov eax, dword ptr [ebp+4+ecx*4]    ; Load the next segment from number 1
    add eax, dword ptr [ebp+24+ecx*4]   ; Add the next corresponding segment from number 2

    cmp eax, 9999                       ; Check for a 4-digit overflow (carry detection)
    jg carry1                           ; Jump if carry is generated (result is 5 digits)
    jmp carry0                          ; Jump if no carry

carry1:
    add ebx, 1                          ; Propagate the carry to the previously calculated segment
carry0:
    mov dword ptr [ebp+40+ecx*4], ebx   ; Store the validated result chunk back onto the stack
    inc ecx                             ; Increment loop index
    cmp ecx, 5                          ; Check if all 5 chunks (20 digits total) are processed
    jne mimateba                        ; Repeat loop if processing is incomplete

    mov dword ptr [ebp+40+ecx*4], eax   ; Save the final processed chunk
    
    ; Reset registers for formatting phase
    xor eax, eax  
    mov ecx, 1    
    mov esi, 1                          ; Stack index tracker for ASCII conversion
    mov edi, 10                         ; Divisor for base-10 extraction
    mov eax, dword ptr [ebp+44+ecx*4]   ; Load the first grouped sum chunk
    mov edx, 10                         ; Loop limit for stack clearing

ganuleba:                               ; Stack cleanup loop before output formatting
    xor ebx, ebx  
    mov dword ptr [ebp+edx], ebx  
    dec edx  
    cmp edx, 0    
    jne ganuleba  
    xor ebx, ebx  

; =========================================================================
; CHUNK 1: Convert to ASCII and Print
; =========================================================================
ascii:
    xor edx, edx                        ; Clear EDX for division
    div edi                             ; Divide EAX by 10 (EAX = quotient, EDX = remainder)
    add edx, 30h                        ; Convert remainder numeric value to ASCII character
    mov dword ptr [ebp+esi], edx        ; Store ASCII character on the stack temporary buffer
    inc esi                             ; Move buffer index forward
    cmp eax, 0                          ; Check if chunk is fully disassembled
    jne ascii     

dabechde:
    xor eax, eax  
    mov al, byte ptr [ebp+esi]          ; Load ASCII char from temporary stack buffer
    push eax                            ; Pass character to putchar via stack
    call putchar                        ; Print character to console
    add esp, 4                          ; Clean up stack parameter
    dec esi                             ; Move buffer index backward
    cmp esi, 0                          ; Check if all characters in this chunk are printed
    jne dabechde  

    mov ecx, 2                          ; Load index for the second chunk
    mov eax, dword ptr [ebp+40+ecx*4]   ; Fetch chunk 2 sum from local stack
    mov esi, 1    

; =========================================================================
; CHUNK 2: Convert to ASCII and Print
; =========================================================================
ascii2:
    xor edx, edx  
    div edi       
    add edx, 30h  
    mov dword ptr [ebp+esi], edx  
    inc esi       
    cmp eax, 0    
    jne ascii2    

dabechde2:
    xor eax, eax  
    mov al, byte ptr [ebp+esi]  
    push eax      
    call putchar  
    add esp, 4    
    dec esi       
    cmp esi, 0    
    jne dabechde2 

    mov ecx, 3                          ; Load index for the third chunk
    mov eax, dword ptr [ebp+40+ecx*4]   ; Fetch chunk 3 sum from local stack
    mov esi, 1    

; =========================================================================
; CHUNK 3: Convert to ASCII and Print
; =========================================================================
ascii3:
    xor edx, edx  
    div edi       
    add edx, 30h  
    mov dword ptr [ebp+esi], edx  
    inc esi       
    cmp eax, 0    
    jne ascii3    

dabechde3:
    xor eax, eax  
    mov al, byte ptr [ebp+esi]  
    push eax      
    call putchar  
    add esp, 4    
    dec esi       
    cmp esi, 0    
    jne dabechde3 

    mov ecx, 4                          ; Load index for the fourth chunk
    mov eax, dword ptr [ebp+40+ecx*4]   ; Fetch chunk 4 sum from local stack
    mov esi, 1    

; =========================================================================
; CHUNK 4: Convert to ASCII and Print
; =========================================================================
ascii4:
    xor edx, edx  
    div edi       
    add edx, 30h  
    mov dword ptr [ebp+esi], edx  
    inc esi       
    cmp eax, 0    
    jne ascii4    

dabechde4:
    xor eax, eax  
    mov al, byte ptr [ebp+esi]  
    push eax      
    call putchar  
    add esp, 4    
    dec esi       
    cmp esi, 0    
    jne dabechde4 

    mov ecx, 5                          ; Load index for the fifth chunk
    mov eax, dword ptr [ebp+40+ecx*4]   ; Fetch chunk 5 sum from local stack
    mov esi, 1    

; =========================================================================
; CHUNK 5: Convert to ASCII and Print
; =========================================================================
ascii5:
    xor edx, edx  
    div edi       
    add edx, 30h  
    mov dword ptr [ebp+esi], edx  
    inc esi       
    cmp eax, 0    
    jne ascii5    

dabechde5:
    xor eax, eax  
    mov al, byte ptr [ebp+esi]  
    push eax      
    call putchar  
    add esp, 4    
    dec esi       
    cmp esi, 0    
    jne dabechde5 

dasasruli:
    mov esp, ebp                        ; Epilogue: Restore stack pointer
    pop ebp                             ; Restore base pointer
    ret
oceuli endp
