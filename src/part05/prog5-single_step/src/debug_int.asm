        CPU 8086
        BITS 16

        SECTION .text

        GLOBAL debug_int_handler

        EXTERN display_state

debug_int_handler:
        push bp 
        mov bp, sp 
        sub sp, CPUState_size

        push ax
        push bx
        push cx
        push dx
        push si
        push di
    
        mov [bp - CPUState_size + CPUState.regAX], ax
        mov [bp - CPUState_size + CPUState.regBX], bx
        mov [bp - CPUState_size + CPUState.regCX], cx
        mov [bp - CPUState_size + CPUState.regDX], dx
        mov [bp - CPUState_size + CPUState.regSI], si
        mov [bp - CPUState_size + CPUState.regDI], di

        mov ax, ds
        mov [bp - CPUState_size + CPUState.regDS], ax
        mov ax, es
        mov [bp - CPUState_size + CPUState.regES], ax
        mov ax, ss
        mov [bp - CPUState_size + CPUState.regSS], ax

        mov ax, [bp]
        mov [bp - CPUState_size + CPUState.regBP], ax
        lea ax, [bp + 8]
        mov [bp - CPUState_size + CPUState.regSP], ax
        mov ax, [bp + 2]
        mov [bp - CPUState_size + CPUState.regIP], ax
        mov ax, [bp + 4]
        mov [bp - CPUState_size + CPUState.regCS], ax
        mov ax, [bp + 6]
        mov [bp - CPUState_size + CPUState.flags], ax

        lea ax, [bp - CPUState_size]
        push ax
        call display_state
        add sp, 2

        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax

        mov sp, bp
        pop bp

; infinite loop to allow the user to read the LCD
; it is here temporarily only
        jmp $

        iret

STRUC   CPUState
        .regCS: resw 1
        .regDS: resw 1
        .regES: resw 1
        .regSS: resw 1
        .regAX: resw 1
        .regBX: resw 1
        .regCX: resw 1
        .regDX: resw 1
        .regSI: resw 1
        .regDI: resw 1
        .regSP: resw 1
        .regBP: resw 1
        .regIP: resw 1
        .flags: resw 1
ENDSTRUC
