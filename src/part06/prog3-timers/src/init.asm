        CPU 8086
        BITS 16

        %include "system_def.inc"
        %include "macros.inc"

        SECTION .text

        GLOBAL init

        EXTERN __dataoffset
        EXTERN __ldata
        EXTERN __sbss
        EXTERN __lbss

        EXTERN init_int_vectors
        EXTERN set_int_vector
        EXTERN lcd_init
        EXTERN pic_init
        EXTERN pic_enable_ir
        EXTERN pit_init
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

        call init_int_vectors

        mov ax, ss
        mov ds, ax
        mov es, ax

        call lcd_init
        call pic_init
        call pit_init

        xor ah, ah
; check initial state of the "step" button
        in al, BUTTONS_STATE_REG
        and al, BTN_DEBUG_STEP
        jnz .1

; set the Trap Flag via the stack if the "step" button is pressed
        pushf
        mov bp, sp
        or word [bp], (1 << 8)  ; TF is the 8th bit in FLAGS
        popf
.1:
        sti
        call main
        jmp $
