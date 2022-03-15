        CPU 8086
        BITS 16

        SECTION .text

        GLOBAL init

LCD_CMD     EQU 0x00
LCD_DATA    EQU 0x01

init:
        mov al, 0x30
        out LCD_CMD, al

        mov al, 0x30
        out LCD_CMD, al

        mov al, 0x30
        out LCD_CMD, al

        mov al, 0x38    ; function set
        out LCD_CMD, al

        mov al, 0x08    ; display off
        out LCD_CMD, al

        mov al, 0x01    ; clear display
        out LCD_CMD, al

        mov al, 0x06    ; entry mode set
        out LCD_CMD, al

        mov al, 0x0c    ; display on, no cursor
        out LCD_CMD, al

        mov al, 'T'
        out LCD_DATA, al

        mov al, 'E'
        out LCD_DATA, al

        mov al, 'S'
        out LCD_DATA, al

        mov al, 'T'
        out LCD_DATA, al

        jmp $
