        CPU 8086
        BITS 16

        SECTION .reset

        GLOBAL reset

reset:
        mov ax, 0x0001
.1:
        add ah, al
        xchg ah, al
        out 0, al
        jmp .1
