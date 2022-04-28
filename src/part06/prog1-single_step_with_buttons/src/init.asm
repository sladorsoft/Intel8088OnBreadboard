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

        xor ah, ah
; check initial state of the "step" button
        in al, BUTTONS_STATE_REG
        and al, BTN_DEBUG_STEP

        sti

; temporary comparison to turn on single-step by default (when the button is NOT pressed)
        cmp al, BTN_DEBUG_STEP
        jnz .1

; set the Trap Flag via the stack
        pushf
        mov bp, sp
        or word [bp], (1 << 8)  ; TF is the 8th bit in FLAGS
        popf
.1:
;        call main


; test programme calculating consecutive numbers of the Fibonacci sequence in AX
        mov ax, 0x0001
        xor bx, bx
.2:
        add bx, ax
        xchg bx, ax
        jmp .2

        jmp $
