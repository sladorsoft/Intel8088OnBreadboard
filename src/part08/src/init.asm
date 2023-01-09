        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL init

        EXTERN __dataoffset
        EXTERN __ldata
        EXTERN __sbss
        EXTERN __lbss

        EXTERN init_int_vectors
        EXTERN set_int_vector
        EXTERN lcd_init
        EXTERN int_ctrl_init
        EXTERN timers_init
        EXTERN main

init:
; We don't relocate the Peripheral Control Block
;        mov ax, BITSET(RELREG_ADDR_BITS, PCB_BASE >> 8, RELREG_ADDR_SIZE)
;        mov dx, RELREG_RESET
;        out dx, al

        mov ax, MMCS_UNUSED_BITS | BITSET(MMCS_MEM_SIZE_BITS, 0x40, MMCS_MEM_SIZE_SIZE) | BITSET(CS_RDY_WAIT_BITS, 0, CS_RDY_WAIT_SIZE) ; MCS starts at 0x80000 + READY active
        mov dx, MMCS
        out dx, ax

        mov ax, MPCS_UNUSED_BITS | BITSET(MPCS_MEM_SIZE_BITS, (MCS_BLOCK_SIZE >> 13), MPCS_MEM_SIZE_SIZE) | BITSET(MPCS_EX_BIT) | BITSET(CS_RDY_WAIT_BITS, 0, CS_RDY_WAIT_SIZE) ; MCS block size, activate PCS5-6 pins + READY active for PCS4-6
        mov dx, MPCS
        out dx, ax

        mov ax, PACS_UNUSED_BITS | BITSET(PACS_MEM_SIZE_BITS, (SYSTEM_IO_BASE >> 10), PACS_MEM_SIZE_SIZE) | BITSET(CS_RDY_WAIT_BITS, 0, CS_RDY_WAIT_SIZE) ; I/O base address for PCS = 0x0000 + READY active for PCS0-3
        mov dx, PACS
        out dx, ax

; We don't use the LCS signal, so no need to initialise LMCS
;        mov ax, LMCS_UNUSED_BITS | BITSET(LMCS_MEM_SIZE_BITS, 0xff, LMCS_MEM_SIZE_SIZE) | BITSET(CS_RDY_IGNRDY_BIT) | BITSET(CS_RDY_WAIT_BITS, 0, CS_RDY_WAIT_SIZE) ; 256kB RAM (max) + 0 wait states (not used)
;        mov dx, LMCS
;        out dx, ax

        mov ax, SYSTEM_STACK_SEG
        mov ss, ax
        xor sp, sp
        mov es, ax

        mov ax, cs
        mov ds, ax

        mov si, __dataoffset
        xor di, di
        mov cx, __ldata
        rep movsw

        xor ax, ax
        mov di, __sbss
        mov cx, __lbss
        rep stosw

        call init_int_vectors

        mov ax, ss
        mov ds, ax
        mov es, ax

; configure the 8255:
; - Port A: OUT (LCD data)
; - Port C upper half: OUT (bit 7: E, bit 6: RW and bit 5: RS)
; - Port B and lower half pof Port C: IN
        mov al, 0b10000011
        out GPIO_CTRL_REG, al
        mov al, 0b00011111
        out GPIO_PORTC_REG, al

        call lcd_init
        call timers_init

        xor ah, ah
; check initial state of the "step" button
        mov dx, BUTTONS_STATE_REG
        in al, dx
        and al, BTN_DEBUG_STEP
        jnz .1

; set the Trap Flag via the stack if the "step" button is pressed
        pushf
        mov bp, sp
        or word [bp], (1 << 8)  ; TF is the 8th bit in FLAGS
        popf
.1:
        sti
        call main
        jmp $
