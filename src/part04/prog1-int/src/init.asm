        CPU 8086
        BITS 16

        SECTION .text

        GLOBAL init

init:
        mov ax, 0x7000
        mov ss, ax
        xor sp, sp

        mov ds, sp
        mov es, sp
        mov di, 0x55 * 4
        mov ax, INT_handler
        stosw
        mov ax, cs
        stosw
        sti
    
start:
        nop
        jmp start

        nop
        nop
        nop
        nop

INT_handler:
        nop
        iret
