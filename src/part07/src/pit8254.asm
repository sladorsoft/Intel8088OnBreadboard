        CPU 8086
        BITS 16

        %include "system_def.inc"
        %include "macros.inc"

        SECTION .text

        GLOBAL pit_init

        EXTERN set_int_vector
        EXTERN pic_enable_ir
        EXTERN system_timer_int_handler

;--------------------------------------
; void pit_init(void)
;--------------------------------------
pit_init:
        pushf
        cli
        mov al, 0b00110110      ; Counter 0, binary, mode 3, write both bytes
        out PIT_CTRL_REG, al

        mov ax, ((SYSTEM_PCLK + (SYSTEM_TICKS_SEC / 2)) / SYSTEM_TICKS_SEC) ; set system tick counter
        out PIT_COUNTER_0, al
        xchg ah, al
        out PIT_COUNTER_0, al

        mov ax, system_timer_int_handler
        push ax
        mov al, PIT_COUNTER0_INT
        push ax
        call set_int_vector     ; => set_int_vector(PIT_COUNTER0_INT, &counter0_int_handler);
        add sp, 4

; enable pin IR0 in the PIC
        xor ax, ax
        push ax
        call pic_enable_ir      ; => pic_enable_ir(0);
        add sp, 2

        popf
        ret
