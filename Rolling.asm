assume cs:code,ds:data
data segment
    pa equ 20a0h
    pb equ 20a1h
    pc equ 20a2h
    cr equ 20a3h
    
    fire db 071h,09fh,0f5h,061h
    
    data ends
code segment
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,cr
    mov al,80h
    out dx,al
    
    rpt:
    mov cx,4d
    lea si,fire
    
    next:
    mov al,[si]
    call disp
    call delay
    inc si
    loop next
    
    mov ah,06h
    mov dl,0ffh
    int 21h
    
    mov ah,4ch
    int 21h
    
    disp proc
        push cx
        mov cx,008
        nextbit:
        mov dx,pb
        out dx,al
        push ax
        mov dx,pc
        mov al,0ffh
        out dx,al
        mov al,00h
        out dx,al
        pop ax
        ror al,1
        loop nextbit
        pop cx
        ret
        disp endp
    delay proc
        mov si,02ffh
        l2:mov di,0ffffh
        l1:dec di
        jnz l1
        dec si
        jnz l2
        ret
        delay endp
    code ends
end start
        
    
