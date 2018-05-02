assume cs:code,ds:data
data segment
    pa equ 20a0h
    pb equ 20a1h
    pc equ 20a2h
    cr equ 20a3h
    colval db ?
    rowval db ?
    scode  db ?
    data ends
code segment
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,cr
    mov al,90h
    out dx,al
    
    try:
    mov bl,01
    mov ah,01
    mov cl,00
    mov bh,03
    
    nextrow:
    mov dx,pc
    mov al,bl
    out dx,al
    
    mov dx,pa
    in al,dx
    
    cmp al,00h
    jne cal
    add cl,08
    inc ah
    shl bl,01
    dec bh
    jnz next_row
    jmp try
    
    cal:
    mov rowval,ah
    mov ah,00h
    
    rot:
    ror al,1
    jc next
    inc ah
    inc cl
    jmp rot
    
    next:
    mov scode,cl
    mov colval,ah
    mov al,cl
    call disp
    
    
    mov ah,4ch
    int 21h
    
    disp proc
        mov al,bl
        mov cl,04
        shr al,cl
        cmp al,09
        jle add_30
        add al,07
        
        add_30:
        add al,30h
        mov dl,al
        mov ah,02
        int 21h
        
        mov al,bl
        and al,0fh
        cmp al,09
        jle add_301
        add al,07
        
        add_301:   
        add al,30h
        mov dl,al
        mov ah,02
        int 21h
        ret
        disp endp
    code ends
end start

        
        
        
        
        
    
