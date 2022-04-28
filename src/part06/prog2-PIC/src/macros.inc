        CPU 8086
        BITS 16

%macro pic_eoi_cmd 0
        push ax
        mov al, 0b00100000
        out PIC_REG_0, al
        pop ax
%endmacro