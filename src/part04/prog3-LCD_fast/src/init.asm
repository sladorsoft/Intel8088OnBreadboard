        CPU 8086
        BITS 16

        SECTION .text

        GLOBAL init

LCD_CMD     EQU 0x00
LCD_DATA    EQU 0x01

init:
        mov cx, 0x0600
.1:     dec cx
        jnz .1

        mov al, 0x30
        out LCD_CMD, al

        mov cx, 0x0100
.2:     dec cx
        jnz .2

        mov al, 0x30
        out LCD_CMD, al

        mov cx, 0x0020
.3:     dec cx
        jnz .3

        mov al, 0x38    ; function set
        out LCD_CMD, al

        mov cx, 0x0010
.4:     dec cx
        jnz .4

        mov al, 0x08    ; display off
        out LCD_CMD, al

        mov cx, 0x0010
.5:     dec cx
        jnz .5

        mov al, 0x01    ; clear display
        out LCD_CMD, al

        mov cx, 0x0200
.6:     dec cx
        jnz .6

        mov al, 0x02    ; return home
        out LCD_CMD, al

        mov cx, 0x0200
.7:     dec cx
        jnz .7

        mov al, 0x06    ; entry mode set
        out LCD_CMD, al

        mov cx, 0x0010
.8:     dec cx
        jnz .8

        mov al, 0x0c    ; display on, no cursor
        out LCD_CMD, al

        mov cx, 0x0010
.9:     dec cx
        jnz .9

        mov al, 'T'
        out LCD_DATA, al

        mov cx, 0x0010
.10:    dec cx
        jnz .10

        mov al, 'E'
        out LCD_DATA, al

        mov cx, 0x0010
.11:    dec cx
        jnz .11

        mov al, 'S'
        out LCD_DATA, al

        mov cx, 0x0010
.12:    dec cx
        jnz .12

        mov al, 'T'
        out LCD_DATA, al

        jmp $
