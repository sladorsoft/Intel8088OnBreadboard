        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL timers_init

        EXTERN set_int_vector
        EXTERN system_timer_int_handler

;--------------------------------------
; void timers_init(void)
;--------------------------------------
timers_init:
        call timer0_init

        mov ax, BITSET(INT_CON_PRI_BITS, 0, INT_CON_PRI_SIZE)   ; Priority 0 for Timers' INT and enable (mask = 0)
        mov dx, TCUCON
        out dx, ax

        ret

;--------------------------------------
; void timer0_init(void)
;--------------------------------------
timer0_init:
        mov ax, system_timer_int_handler
        push ax
        mov al, TIMER0_INT_VEC
        push ax
        call set_int_vector
        add sp, 4

        xor ax, ax                      ; Initialise Timer0 counter
        mov dx, T0CNT
        out dx, ax

        mov ax, ((SYSTEM_TIMER_CLK + (SYSTEM_TICKS_SEC / 2)) / SYSTEM_TICKS_SEC) ; set system tick counter
        mov dx, T0CMPA
        out dx, ax

        mov ax, BITSET(TCON_EN_BIT) | BITSET(TCON_INH_BIT) | BITSET(TCON_INT_BIT) | BITSET(TCON_CONT_BIT)
        mov dx, T0CON
        out dx, ax

        ret
