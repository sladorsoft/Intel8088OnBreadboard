        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL init_int_vectors
        GLOBAL set_int_vector

        EXTERN debug_int_handler

init_int_vectors:
        xor cx, cx
        mov si, int_vectors
        mov dx, cs
        mov ds, dx
        xor di, di
        mov es, di

.1:
        movsw
        mov [es:di], dx
        add di, 2

        inc cx
        cmp cx, (int_vectors_end - int_vectors) / 2
        jb .1

        mov ax, default_handler
.2:
        stosw
        mov [es:di], dx
        add di, 2

        inc cx
        cmp cx, 0x0100
        jb .2

        ret
    
;--------------------------------------
; void set_int_vector(uint8_t intNo, void* ptr)
;--------------------------------------
set_int_vector:
        mov bx, sp

        push di
        push es
        xor ax, ax
        mov es, ax

        mov al, [bx + 2] ; intNo
        shl ax, 1
        shl ax, 1
        mov di, ax
        mov ax, [bx + 4] ; ptr

        pushf
        cli
        stosw
        mov ax, SYSTEM_BOOT_SEG
        stosw
        popf

        pop es
        pop di
        ret

default_handler:
        iret

int_vectors:
; divide by 0
        DW default_handler
; single step
        DW debug_int_handler
; NMI
        DW default_handler
; breakpoint
        DW debug_int_handler
; overflow
        DW default_handler
; array bounds
        DW default_handler
; unused opcode
        DW default_handler
; escape opcode
        DW default_handler
int_vectors_end:
