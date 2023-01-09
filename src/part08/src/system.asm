        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL get_sys_ticks
        GLOBAL system_timer_int_handler

        EXTERN set_int_vector
        EXTERN pic_enable_ir

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
system_timer_int_handler:
        inc word [sys_tick_count]
        jnz .1
        inc word [sys_tick_count + 2]
.1:
        PIC_EOI_CMD
        iret

        SECTION .data

sys_tick_count: dd 0
