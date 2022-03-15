        CPU 8086
        BITS 16

        SECTION .text

        GLOBAL init

init:
        mov ax, 0x7000
        mov ss, ax
        xor sp, sp

        push cs
        pop es

; push the length of the string on stack ("len")
        mov ax, hello_str_end - hello_str
        push ax
; push the string address of the string on stack ("str")
        mov ax, hello_str
        push ax

; call find_space() in the C-style
        call find_space
; tidy up the parameters (2 * 2 bytes)
        add sp, 4

        jmp $


;   C declaration:
;   int16_t find_space(const char* str, uint16_t len);
find_space:
        push bp
        mov bp, sp

        sub sp, 2

        push di
        mov di, [bp + 4]    ; load "str" to DI
        mov cx, [bp + 6]    ; load "len" to CX
        mov [bp - 2], di    ; save "str" to a local variable

        mov al, ' '
        repne scasb
        je .1               ; jump over if found
        mov ax, -1
        jmp .ret
.1:
        mov ax, di
        sub ax, [bp - 2]
        dec ax
.ret:
        pop di

        mov sp, bp
        pop bp
        ret

hello_str:
        DB "Hello World!"
hello_str_end:
