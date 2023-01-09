%ifndef DEVICE_REGS_INC
%define DEVICE_REGS_INC

%include "regs_186.inc"

;--------------------------------------
; I/O port numbers
; and constants related to I/O devices
;--------------------------------------
; Multi I/O device
;--------------------------------------
MULTI_IO_BASE_REG       EQU     (IO_PCS0_BASE + 0x00)

;--------------------------------------
; GPIO ports
;--------------------------------------
GPIO_PORTA_REG          EQU     (IO_PCS1_BASE + 0x00)
GPIO_PORTB_REG          EQU     (IO_PCS1_BASE + 0x01)
GPIO_PORTC_REG          EQU     (IO_PCS1_BASE + 0x02)
GPIO_CTRL_REG           EQU     (IO_PCS1_BASE + 0x03)

;--------------------------------------
; Text LCD
;--------------------------------------
TEXT_LCD_CMD            EQU     (IO_PCS2_BASE + 0x00)
TEXT_LCD_DATA           EQU     (IO_PCS2_BASE + 0x01)

;--------------------------------------
; Push buttons
;--------------------------------------
BUTTONS_STATE_REG       EQU     (IO_PCS3_BASE + 0x00)

;--------------------------------------
; External device
;--------------------------------------
EXTERNAL_BASE_REG       EQU     (IO_PCS6_BASE + 0x00)



;--------------------------------------
; Push button definitions
;--------------------------------------
BTN_DEBUG_STEP          EQU     0b00000001
BTN_DEBUG_RUN           EQU     0b00000010
BTN_2_UNUSED            EQU     0b00000100
BTN_3_UNUSED            EQU     0b00001000
BTN_UP                  EQU     0b00010000
BTN_RIGHT               EQU     0b00100000
BTN_DOWN                EQU     0b01000000
BTN_LEFT                EQU     0b10000000

%endif
