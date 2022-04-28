        CPU 8086
        BITS 16

;--------------------------------------
; System definitions
;--------------------------------------
SYSTEM_STACK_SEG    EQU     0x7000
SYSTEM_BOOT_SEG     EQU     0xf000

;--------------------------------------
; I/O port numbers
; and constants related to I/O devices
;--------------------------------------
; Text LCD
;--------------------------------------
TEXT_LCD_CMD        EQU     0x00
TEXT_LCD_DATA       EQU     0x01

;--------------------------------------
; Push buttons
;--------------------------------------
BUTTONS_STATE_REG   EQU     0x10
BTN_DEBUG_STEP      EQU     0b00000001
BTN_DEBUG_RUN       EQU     0b00000010
BTN_2_UNUSED        EQU     0b00000100
BTN_3_UNUSED        EQU     0b00001000
BTN_4_UNUSED        EQU     0b00010000
BTN_5_UNUSED        EQU     0b00100000
BTN_6_UNUSED        EQU     0b01000000
BTN_7_UNUSED        EQU     0b10000000

;--------------------------------------
; PIC (8259)
;--------------------------------------
PIC_REG_0           EQU     0x20
PIC_REG_1           EQU     0x21
PIC_ISR             EQU     0x20
PIC_IRR             EQU     0x20
PIC_IMR             EQU     0x21
PIC_INT_VEC         EQU     0x08
