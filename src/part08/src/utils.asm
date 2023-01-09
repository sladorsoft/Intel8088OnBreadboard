        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL delay
        GLOBAL byte_to_hex_str
        GLOBAL word_to_hex_str

;--------------------------------------
; void delay(uint16_t steps)
;--------------------------------------
delay:
        mov bx, sp

        mov cx, [bx + 2]
.1:     dec cx              ; clocks: 3
        jnz .1              ; clocks: 13 if taken, or 4

        ret


;--------------------------------------
; uint16_t byte_to_hex_str(char* str, uint8_t val)
;--------------------------------------
byte_to_hex_str:
        push bp
        mov bp, sp

        xor ax, ax
        mov bx, [bp + 4]
        test bx, bx
        jz .ret

        mov al, [bp + 6]
        mov ah, al
        mov cl, 4
        shr al, cl
        and ax, 0x0f0f
        cmp al, 0x09
        jbe .1
        add al, 'A' - '0' - 10
.1:
        cmp ah, 0x09
        jbe .2
        add ah, 'A' - '0' - 10
.2:
        add ax, "00"
        mov [bx], ax
        mov [bx + 2], byte 0
        mov ax, 2
.ret:
        mov sp, bp
        pop bp
        ret

;--------------------------------------
; uint16_t word_to_hex_str(char* str, uint16_t val)
;--------------------------------------
word_to_hex_str:
        push bp
        mov bp, sp
        push si

        mov si, [bp + 4]
        mov ax, [bp + 6]
        push ax
        xchg ah, al
        push ax
        push si
        call byte_to_hex_str
        add sp, 4
        test ax, ax
        jnz .1
        pop dx
        jmp .ret
.1:
        add si, ax
        push si
        call byte_to_hex_str
        add sp, 4

        add si, ax
        mov [si], byte 0
        mov ax, 4
.ret:
        pop si
        mov sp, bp
        pop bp
        ret
