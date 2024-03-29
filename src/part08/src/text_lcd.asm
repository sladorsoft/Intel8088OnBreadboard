        CPU 186
        BITS 16

%include "system_def.inc"

        SECTION .text

        GLOBAL text_lcd_clear_display
        GLOBAL text_lcd_return_home
        GLOBAL text_lcd_entry_mode_set
        GLOBAL text_lcd_display_ctrl
        GLOBAL text_lcd_function_set
        GLOBAL text_lcd_set_char_gen_addr
        GLOBAL text_lcd_set_xy
        GLOBAL text_lcd_send_char
        GLOBAL text_lcd_send_char_at
        GLOBAL text_lcd_send_text
        GLOBAL text_lcd_send_text_at

        EXTERN delay

TEXT_LCD_CHARS_PER_LINE EQU     20
TEXT_LCD_LINES          EQU     4
TEXT_LCD_LINE_1_ADDR    EQU     0x40

SEND_TEXT_DELAY_VALUE   EQU     25


%ifdef TEXT_LCD_USING_8255

%macro TEXT_LCD_WRITE_CMD 0
        xchg ah, al
        mov al, 0b00011111
        out GPIO_PORTC_REG, al

        xchg ah, al
        out GPIO_PORTA_REG, al

        mov al, 0b10011111
        out GPIO_PORTC_REG, al

        mov al, 0b00011111
        out GPIO_PORTC_REG, al
%endmacro

%macro TEXT_LCD_WRITE_CMD 1
        mov al, 0b00011111
        out GPIO_PORTC_REG, al

        mov al, %1
        out GPIO_PORTA_REG, al

        mov al, 0b10011111
        out GPIO_PORTC_REG, al

        mov al, 0b00011111
        out GPIO_PORTC_REG, al
%endmacro

%macro TEXT_LCD_WRITE_DATA 0
        xchg ah, al
        mov al, 0b00111111
        out GPIO_PORTC_REG, al

        xchg ah, al
        out GPIO_PORTA_REG, al

        mov al, 0b10111111
        out GPIO_PORTC_REG, al

        mov al, 0b00111111
        out GPIO_PORTC_REG, al
%endmacro


%else


%macro TEXT_LCD_WRITE_CMD 0
        mov dx, TEXT_LCD_CMD
        out dx, al
%endmacro

%macro TEXT_LCD_WRITE_CMD 1
        mov al, %1
        mov dx, TEXT_LCD_CMD
        out dx, al
%endmacro

%macro TEXT_LCD_WRITE_DATA 0
        mov dx, TEXT_LCD_DATA
        out dx, al
%endmacro

%endif



;--------------------------------------
; void text_lcd_clear_display()
;--------------------------------------
text_lcd_clear_display:
        TEXT_LCD_WRITE_CMD 0b00000001
        ret

;--------------------------------------
; void text_lcd_return_home()
;--------------------------------------
text_lcd_return_home:
        TEXT_LCD_WRITE_CMD 0b00000010
        ret

;--------------------------------------
; void text_lcd_entry_mode_set(bool increment, bool disp_shift)
;--------------------------------------
text_lcd_entry_mode_set:
        mov bx, sp
        mov al, 0b00000100
        mov ah, [bx + 2]
        test ah, ah
        jz .1
        or al, 0b00000010
.1:
        mov ah, [bx + 4]
        test ah, ah
        jz .2
        or al, 0b00000001
.2:
        TEXT_LCD_WRITE_CMD
        ret

;--------------------------------------
; void text_lcd_display_ctrl(bool is_on, bool cursor_visible, bool cursor_blink)
;--------------------------------------
text_lcd_display_ctrl:
        mov bx, sp
        mov al, 0b00001000
        mov ah, [bx + 2]
        test ah, ah
        jz .1
        or al, 0b00000100
.1:
        mov ah, [bx + 4]
        test ah, ah
        jz .2
        or al, 0b00000010
.2:
        mov ah, [bx + 6]
        test ah, ah
        jz .3
        or al, 0b00000001
.3:
        TEXT_LCD_WRITE_CMD
        ret

;--------------------------------------
; void text_lcd_function_set()
;--------------------------------------
text_lcd_function_set:
        TEXT_LCD_WRITE_CMD 0b00111000
        ret

;--------------------------------------
; void text_lcd_set_char_gen_addr(uint8_t addr)
;--------------------------------------
text_lcd_set_char_gen_addr:
        mov bx, sp
        mov al, 0b01000000
        mov ah, [bx + 2]
        and ah, 0b00111111
        or al, ah
        TEXT_LCD_WRITE_CMD
        ret

;--------------------------------------
; void text_lcd_set_disp_addr(uint8_t addr)
;--------------------------------------
text_lcd_set_disp_addr:
        mov bx, sp
        mov al, 0b10000000
        mov ah, [bx + 2]
        and ah, 0b01111111
        or al, ah
        TEXT_LCD_WRITE_CMD
        ret

;--------------------------------------
; void text_lcd_set_xy(uint8_t x, uint8_t y)
;--------------------------------------
text_lcd_set_xy:
        push bp
        mov bp, sp

        xor dx, dx
        mov al, [bp + 6]
        test al, 0b00000001
        jz .1
        mov dl, TEXT_LCD_LINE_1_ADDR
.1:
        test al, 0b00000010
        jz .2
        add dl, TEXT_LCD_CHARS_PER_LINE
.2:
        mov al, [bp + 4]
        add dl, al
        push dx
        call text_lcd_set_disp_addr
        add sp, 2

        mov sp, bp
        pop bp
        ret

;--------------------------------------
; void text_lcd_send_char(char c)
;--------------------------------------
text_lcd_send_char:
        mov bx, sp
        mov al, [bx + 2]
        TEXT_LCD_WRITE_DATA
        ret

;--------------------------------------
; void text_lcd_send_char_at(uint8_t x, uint8_t y, char c)
;--------------------------------------
text_lcd_send_char_at:
        push bp
        mov bp, sp

        mov al, [bp + 6]
        push ax
        mov al, [bp + 4]
        push ax
        call text_lcd_set_xy
        add sp, 4

        mov al, [bp + 8]
        TEXT_LCD_WRITE_DATA

        mov sp, bp
        pop bp
        ret

;--------------------------------------
; void text_lcd_send_text(const char* str)
;--------------------------------------
text_lcd_send_text:
        push bp
        mov bp, sp

        push si
        mov si, [bp + 4]
        test si, si
        jz .2
.1:
        lodsb
        test al, al
        jz .2
        TEXT_LCD_WRITE_DATA
        mov ax, SEND_TEXT_DELAY_VALUE
        push ax
        call delay
        add sp, 2
        jmp .1
.2:
        pop si

        mov sp, bp
        pop bp
        ret

;--------------------------------------
; void text_lcd_send_text_at(uint8_t x, uint8_t y, const char* str)
;--------------------------------------
text_lcd_send_text_at:
        push bp
        mov bp, sp

        mov al, [bp + 6]
        push ax
        mov al, [bp + 4]
        push ax
        call text_lcd_set_xy
        add sp, 4

        mov ax, [bp + 8]
        push ax
        call text_lcd_send_text

        mov sp, bp
        pop bp
        ret
