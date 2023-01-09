        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL debug_int_handler

        EXTERN display_state
        EXTERN btn_wait_for_press

debug_int_handler:
        push bp 
        mov bp, sp 
        sub sp, CPUState_size

        push ax
        push bx
        push cx
        push dx
        push si
        push di
    
        mov [bp - CPUState_size + CPUState.regAX], ax
        mov [bp - CPUState_size + CPUState.regBX], bx
        mov [bp - CPUState_size + CPUState.regCX], cx
        mov [bp - CPUState_size + CPUState.regDX], dx
        mov [bp - CPUState_size + CPUState.regSI], si
        mov [bp - CPUState_size + CPUState.regDI], di

        mov ax, ds
        mov [bp - CPUState_size + CPUState.regDS], ax
        mov ax, es
        mov [bp - CPUState_size + CPUState.regES], ax
        mov ax, ss
        mov [bp - CPUState_size + CPUState.regSS], ax

        mov ax, [bp]
        mov [bp - CPUState_size + CPUState.regBP], ax
        lea ax, [bp + 8]
        mov [bp - CPUState_size + CPUState.regSP], ax
        mov ax, [bp + 2]
        mov [bp - CPUState_size + CPUState.regIP], ax
        mov ax, [bp + 4]
        mov [bp - CPUState_size + CPUState.regCS], ax
        mov ax, [bp + 6]
        mov [bp - CPUState_size + CPUState.flags], ax

        lea ax, [bp - CPUState_size]
        push ax
        call display_state
        add sp, 2

        mov al, BTN_DEBUG_STEP | BTN_DEBUG_RUN
        push ax
        call btn_wait_for_press
        add sp, 2

        and al, BTN_DEBUG_STEP

; [re-]set the Trap Flag on the stack depending on the "step" button state (in AL)
        pushf
        test al, al
        jnz .1
        and word [bp + 6], ~(1 << 8)    ; TF is the 8th bit in FLAGS
        jmp .2
.1:
        or word [bp + 6], (1 << 8)      ; TF is the 8th bit in FLAGS
.2:
        popf

        pop di
        pop si
        pop dx
        pop cx
        pop bx
        pop ax

        mov sp, bp
        pop bp

        iret

STRUC   CPUState
        .regCS: resw 1
        .regDS: resw 1
        .regES: resw 1
        .regSS: resw 1
        .regAX: resw 1
        .regBX: resw 1
        .regCX: resw 1
        .regDX: resw 1
        .regSI: resw 1
        .regDI: resw 1
        .regSP: resw 1
        .regBP: resw 1
        .regIP: resw 1
        .flags: resw 1
ENDSTRUC
