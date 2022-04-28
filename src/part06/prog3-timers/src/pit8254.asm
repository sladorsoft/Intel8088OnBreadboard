        CPU 8086
        BITS 16

        %include "system_def.inc"
        %include "macros.inc"

        SECTION .text

        GLOBAL pit_init
        GLOBAL get_sys_ticks

        EXTERN set_int_vector
        EXTERN pic_enable_ir

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

        mov ax, counter0_int_handler
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

;--------------------------------------
; uint32_t get_sys_ticks(void)
;--------------------------------------
get_sys_ticks:
        pushf
        cli
        mov ax, word [sys_tick_count]
        mov dx, word [sys_tick_count + 2]
        popf
        ret

;--------------------------------------
counter0_int_handler:
        inc word [sys_tick_count]
        jnz .1
        inc word [sys_tick_count + 2]
.1:
        pic_eoi_cmd
        iret

;--------------------------------------

        SECTION .data

sys_tick_count: dd 0
