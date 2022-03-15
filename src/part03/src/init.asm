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
        mov di, 2 * 4
        mov ax, NMI_handler
        stosw
        mov ax, cs
        stosw
    
start:
        nop
        jmp start

        nop
        nop
        nop
        nop

NMI_handler:
        nop
        iret
