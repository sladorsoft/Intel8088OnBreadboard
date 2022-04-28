        CPU 8086
        BITS 16

        %include "system_def.inc"

        SECTION .text

        GLOBAL pic_init
        GLOBAL pic_disable_ir
        GLOBAL pic_enable_ir

;--------------------------------------
; void pic_init(void)
;--------------------------------------
pic_init:
        pushf
        cli
        mov al, 0b00010111      ; ICW1
        out PIC_REG_0, al
        mov al, (PIC_INT_VEC & 0b11111000)  ; ICW2
        out PIC_REG_1, al
        mov al, 0b00000001      ; ICW4
        out PIC_REG_1, al

        mov al, 0b11111111      ; mask all interrupts
        out PIC_IMR, al

        mov al, 0b00001000
        out PIC_REG_0, al

        popf
        ret

;--------------------------------------
; void pic_disable_ir(uint8_t irNo)
;--------------------------------------
pic_disable_ir:
        pushf
        cli

        mov bx, sp
        mov cl, [bx + 2]
        and cl, 0b00000111
        mov ah, 1
        shl ah, cl
        in al, PIC_IMR
        or al, ah
        out PIC_IMR, al

        popf
        ret

;--------------------------------------
; void pic_enable_ir(uint8_t irNo)
;--------------------------------------
pic_enable_ir:
        pushf
        cli

        mov bx, sp
        mov cl, [bx + 2]
        and cl, 0b00000111
        mov ah, 1
        shl ah, cl
        neg ah
        in al, PIC_IMR
        and al, ah
        out PIC_IMR, al

        popf
        ret
