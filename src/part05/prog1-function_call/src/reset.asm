        CPU 8086
        BITS 16

        SECTION .reset

        GLOBAL reset
        EXTERN init

reset:
        jmp 0xf000:init
