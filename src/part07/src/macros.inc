        CPU 8086
        BITS 16

%if CPU_TYPE = 186

%macro pic_eoi_cmd 0
        push ax
        push dx
        mov ax, 0x8000
        mov dx, EOI
        out dx, ax
        pop dx
        pop ax
%endmacro

%else

%macro pic_eoi_cmd 0
        push ax
        mov al, 0b00100000
        out PIC_REG_0, al
        pop ax
%endmacro

%endif
