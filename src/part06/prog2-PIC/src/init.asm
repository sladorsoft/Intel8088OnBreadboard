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

        call pic_init
        call lcd_init


; set the address of the test handler in the interrupt vector table
        mov ax, ir0_int_handler
        push ax
        mov al, (PIC_INT_VEC + 0)
        push ax
        call set_int_vector     ; => set_int_vector(8, &ir0_int_handler);
        add sp, 4

; enable pin IR0 in the PIC
        xor ax, ax
        push ax
        call pic_enable_ir      ; => pic_enable_ir(0);
        add sp, 2

        xor ah, ah
; check initial state of the "step" button
        in al, BUTTONS_STATE_REG
        and al, BTN_DEBUG_STEP
; temporary comparison to turn on single-step by default (when the button is NOT pressed)
        cmp al, BTN_DEBUG_STEP
        jnz .1

; set the Trap Flag via the stack
        pushf
        mov bp, sp
        or word [bp], (1 << 8)  ; TF is the 8th bit in FLAGS
        popf
.1:
        sti
;        call main


; test programme calculating consecutive numbers of the Fibonacci sequence in AX
        mov ax, 0x0001
        xor bx, bx
.2:
        add bx, ax
        xchg bx, ax
        jmp .2

        jmp $

; test interrupt handler
ir0_int_handler:
        nop
        pic_eoi_cmd
        iret
