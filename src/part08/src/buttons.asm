        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL btn_wait_for_press

        EXTERN delay

BUTTON_DELAY    EQU 5000

;--------------------------------------
; uint8_t btn_wait_for_press(uint8_t btn_mask)
;--------------------------------------
btn_wait_for_press:
        mov bx, sp
        mov ah, [bx + 2]
.1:
        mov dx, BUTTONS_STATE_REG
        in al, dx
        push ax

        mov ax, BUTTON_DELAY
        push ax
        call delay
        add sp, 2

        pop ax
        and al, ah
        cmp al, ah
        jne .1
.2:
        mov dx, BUTTONS_STATE_REG
        in al, dx
        push ax

        mov ax, BUTTON_DELAY
        push ax
        call delay
        add sp, 2

        pop ax
        and al, ah
        cmp al, ah
        je .2

        xor al, ah
        ret
