        CPU 8086
        BITS 16

        %include "system_def.inc"
        %include "macros.inc"

        SECTION .text

        GLOBAL pic_init
        GLOBAL pit_init

        EXTERN set_int_vector
        EXTERN system_timer_int_handler

;--------------------------------------
; void pic_init(void)
;--------------------------------------
pic_init:
        xor ax, ax                      ; Set priority of the timers interrupt
        mov dx, TCUCON
        out dx, ax

        mov ax, ~0 & ~(1 << 0)          ; Enable timers interrupt
        mov dx, IMASK
        out dx, ax

        ret

;--------------------------------------
; void pit_init(void)
;--------------------------------------
pit_init:
        mov ax, system_timer_int_handler
        push ax
        mov al, TIMER2_INT_VEC
        push ax
        call set_int_vector     ; => set_int_vector(PIT_COUNTER0_INT, &counter0_int_handler);
        add sp, 4

        xor ax, ax                      ; Initialise Timer2 counter
        mov dx, T2CNT
        out dx, ax

        mov ax, ((SYSTEM_CPU_CLK / 4 + (SYSTEM_TICKS_SEC / 2)) / SYSTEM_TICKS_SEC) ; set system tick counter
        mov dx, T2CMPA
        out dx, ax

        mov ax, 0b1110000000000001      ; Timer2 setup
        mov dx, T2CON
        out dx, ax

        ret
