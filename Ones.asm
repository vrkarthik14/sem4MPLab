assume cs:code,ds:data

data segment
    pa equ 20a0h
    pb equ 20a1h
    pc equ 20a2h
    cr equ 20a3h
    
    msg db "No of ones : "
    ones db ?,"$"
    data ends
code segment
    start:
    mov ax,data
    mov ds,ax
    
    mov dx,cr
    mov al,82h
    out dx,al
    
    mov dx pb
    in al,dx
    
    mov cx,0008
    mov ah,00
    
    nxt:
    ror al,1
    jnc next1
    inc ah
    
    next1:
    loop next
    
    mov bl,ah
    add ah,30h
    mov ones,ah
    
    lea dx,msg
    mov ah,9
    int 21h
    
    mov al,bl
    mov dx,pa
    out dx,al
    
    mov ah,4ch
    int 21h
    code ends
end start
    
    
    
    
