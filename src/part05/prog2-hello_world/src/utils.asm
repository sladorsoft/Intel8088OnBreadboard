        CPU 8086
        BITS 16

        %include "system_def.inc"

        SECTION .text

        GLOBAL delay

;--------------------------------------
; void delay(uint16_t steps)
;--------------------------------------
delay:
        push bp
        mov bp, sp

        mov cx, [bp + 4]
.1:     dec cx
        jnz .1

        mov sp, bp
        pop bp
        ret

