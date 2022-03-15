        CPU 8086
        BITS 16

        %include "system_def.inc"

        SECTION .text

        GLOBAL init

        EXTERN __dataoffset
        EXTERN __ldata
        EXTERN __sbss
        EXTERN __lbss

        EXTERN lcd_init
        EXTERN set_int_vectors
        EXTERN main

init:
        mov ax, SYSTEM_STACK_SEG
        mov ss, ax
        xor sp, sp
        mov es, ax

        mov ax, cs
        mov ds, ax

        mov si, __dataoffset
        xor di, di
        mov cx, __ldata
        rep movsw

        xor ax, ax
        mov di, __sbss
        mov cx, __lbss
        rep stosw

        call set_int_vectors

        mov ax, ss
        mov ds, ax
        mov es, ax

        call lcd_init

        sti

; main() in this programme is empty, so we don't need to call it
;        call main

; set the registers to known values, push AX to move the stack pointer in SP
        push ax
        mov ax, 0xa11a
        mov bx, 0xb22b
        mov cx, 0xc33c
        mov dx, 0xd44d
        mov si, 0x5151
        mov di, 0xd1d1
        mov bp, 0xbbbb

; raise the debug interrupt
        int3

        jmp $
