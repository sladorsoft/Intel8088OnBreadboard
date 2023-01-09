        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .reset

        GLOBAL reset
        EXTERN init

reset:
        mov ax, UMCS_UNUSED_BITS | BITSET(UMCS_MEM_SIZE_BITS, 0x80, UMCS_MEM_SIZE_SIZE) | BITSET(CS_RDY_IGNRDY_BIT) | BITSET(CS_RDY_WAIT_BITS, 0, CS_RDY_WAIT_SIZE) ; 128kB flash + 0 wait states (not used)
        mov dx, UMCS_RESET
        out dx, ax

        jmp SYSTEM_BOOT_SEG:init
