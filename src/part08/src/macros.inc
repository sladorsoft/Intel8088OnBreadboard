%ifndef MACROS_INC
%define MACROS_INC

%macro PIC_EOI_CMD 0
        push ax
        push dx
        mov ax, 0x8000
        mov dx, EOI
        out dx, ax
        pop dx
        pop ax
%endmacro

%define BITSET(bit) (1 << bit)
%define BITSET(bit, val, size) ((val & ((1 << size) - 1)) << bit)
%define BITCLR(bit) ~(1 << bit)
%define BITCLR(bit, val, size) ~((val & ((1 << size) - 1)) << bit)

%endif
