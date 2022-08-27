        CPU 8086
        BITS 16

        %include "system_def.inc"

        SECTION .reset

        GLOBAL reset
        EXTERN init

reset:
%if CPU_TYPE = 186
        mov ax, (0x80 << 6) | 0b100     ; 128kB flash + 0 wait states
        mov dx, UMCS_RESET
        out dx, ax
%endif

        jmp SYSTEM_BOOT_SEG:init
