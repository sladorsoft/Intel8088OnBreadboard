        CPU 8086
        BITS 16

;--------------------------------------
; System definitions
;--------------------------------------
SYSTEM_STACK_SEG    EQU     0x3000
SYSTEM_BOOT_SEG     EQU     0xf000

%if CPU_TYPE = 186
SYSTEM_CPU_CLK      EQU     4000000     ; this is the CPU clk (1/2 of the used crystal)
SYSTEM_PCLK         EQU     SYSTEM_CPU_CLK ; CLKOUT from 80C188
SYSTEM_DEV_BASE_IO  EQU     0x0000      ; base I/O address for external devices 
%else
SYSTEM_CPU_CLK      EQU     2000000     ; this is the CPU clk (1/3 of the used crystal)
SYSTEM_PCLK         EQU     (SYSTEM_CPU_CLK / 2) ; PCLK from 8284 is half the rate of the CPU clk
%endif

;--------------------------------------
; I/O port numbers
; and constants related to I/O devices
;--------------------------------------
; Text LCD
;--------------------------------------
%if CPU_TYPE = 186
TEXT_LCD_CMD        EQU     (SYSTEM_DEV_BASE_IO + 0x00)
TEXT_LCD_DATA       EQU     (SYSTEM_DEV_BASE_IO + 0x01)
%else
TEXT_LCD_CMD        EQU     0x00
TEXT_LCD_DATA       EQU     0x01
%endif

;--------------------------------------
; Push buttons
;--------------------------------------
%if CPU_TYPE = 186
BUTTONS_STATE_REG   EQU     (SYSTEM_DEV_BASE_IO + 0x80)
%else
BUTTONS_STATE_REG   EQU     0x10
%endif

;--------------------------------------
; Push button definitions
;--------------------------------------
BTN_DEBUG_STEP      EQU     0b00000001
BTN_DEBUG_RUN       EQU     0b00000010
BTN_2_UNUSED        EQU     0b00000100
BTN_3_UNUSED        EQU     0b00001000
BTN_4_UNUSED        EQU     0b00010000
BTN_5_UNUSED        EQU     0b00100000
BTN_6_UNUSED        EQU     0b01000000
BTN_7_UNUSED        EQU     0b10000000


%if CPU_TYPE = 186
;--------------------------------------
; Peripherals in 80C188/6
;--------------------------------------
; Peripheral Control Block (PCB)
;--------------------------------------
PCB_BASE_RESET      EQU     0xff00      ; default location of PCB after reset
UMCS_RESET          EQU     (PCB_BASE_RESET + 0xa0)
RELREG_RESET        EQU     (PCB_BASE_RESET + 0xfe)

PCB_BASE            EQU     PCB_BASE_RESET ;0x0000      ; configured location of PCB
EOI                 EQU     (PCB_BASE + 0x22)
POLL                EQU     (PCB_BASE + 0x24)
POLLSTS             EQU     (PCB_BASE + 0x26)
IMASK               EQU     (PCB_BASE + 0x28)
PRIMSK              EQU     (PCB_BASE + 0x2a)
INSERV              EQU     (PCB_BASE + 0x2c)
REQST               EQU     (PCB_BASE + 0x2e)
INSTS               EQU     (PCB_BASE + 0x30)
TCUCON              EQU     (PCB_BASE + 0x32)
DMA0CON             EQU     (PCB_BASE + 0x34)
DMA1CON             EQU     (PCB_BASE + 0x36)
I0CON               EQU     (PCB_BASE + 0x38)
I1CON               EQU     (PCB_BASE + 0x3a)
I2CON               EQU     (PCB_BASE + 0x3c)
I3CON               EQU     (PCB_BASE + 0x3e)
T0CNT               EQU     (PCB_BASE + 0x50)
T0CMPA              EQU     (PCB_BASE + 0x52)
T0CMPB              EQU     (PCB_BASE + 0x54)
T0CON               EQU     (PCB_BASE + 0x56)
T1CNT               EQU     (PCB_BASE + 0x58)
T1CMPA              EQU     (PCB_BASE + 0x5a)
T1CMPB              EQU     (PCB_BASE + 0x5c)
T1CON               EQU     (PCB_BASE + 0x5e)
T2CNT               EQU     (PCB_BASE + 0x60)
T2CMPA              EQU     (PCB_BASE + 0x62)
T2CON               EQU     (PCB_BASE + 0x66)
UMCS                EQU     (PCB_BASE + 0xa0)
LMCS                EQU     (PCB_BASE + 0xa2)
PACS                EQU     (PCB_BASE + 0xa4)
MMCS                EQU     (PCB_BASE + 0xa6)
MPCS                EQU     (PCB_BASE + 0xa8)
D0SRCL              EQU     (PCB_BASE + 0xc0)
D0SRCH              EQU     (PCB_BASE + 0xc2)
D0DSTL              EQU     (PCB_BASE + 0xc4)
D0DSTH              EQU     (PCB_BASE + 0xc6)
D0TC                EQU     (PCB_BASE + 0xc8)
D0CON               EQU     (PCB_BASE + 0xca)
D1SRCL              EQU     (PCB_BASE + 0xd0)
D1SRCH              EQU     (PCB_BASE + 0xd2)
D1DSTL              EQU     (PCB_BASE + 0xd4)
D1DSTH              EQU     (PCB_BASE + 0xd6)
D1TC                EQU     (PCB_BASE + 0xd8)
D1CON               EQU     (PCB_BASE + 0xda)
RFBASE              EQU     (PCB_BASE + 0xe0)
RFTIME              EQU     (PCB_BASE + 0xe2)
RFCON               EQU     (PCB_BASE + 0xe4)
PWRSAV              EQU     (PCB_BASE + 0xf0)
PWRCON              EQU     (PCB_BASE + 0xf2)
STEPID              EQU     (PCB_BASE + 0xf6)
RELREG              EQU     (PCB_BASE + 0xfe)


TIMER0_INT_VEC      EQU     8
TIMER1_INT_VEC      EQU     18
TIMER2_INT_VEC      EQU     19
DMA0_INT_VEC        EQU     10
DMA1_INT_VEC        EQU     11
INT0_INT_VEC        EQU     12
INT1_INT_VEC        EQU     13
INT2_INT_VEC        EQU     14
INT3_INT_VEC        EQU     15

%else

;--------------------------------------
; PIC (8259)
;--------------------------------------
PIC_REG_0           EQU     0x20
PIC_REG_1           EQU     0x21
PIC_ISR             EQU     0x20
PIC_IRR             EQU     0x20
PIC_IMR             EQU     0x21

PIC_INT_VEC         EQU     0x08

;--------------------------------------
; PIT (8254)
;--------------------------------------
PIT_COUNTER_0       EQU     0x30
PIT_COUNTER_1       EQU     0x31
PIT_COUNTER_2       EQU     0x32
PIT_CTRL_REG        EQU     0x33

PIT_COUNTER0_INT    EQU     (PIC_INT_VEC + 0)

%endif

;--------------------------------------
; Common definitions
;--------------------------------------
SYSTEM_TICKS_SEC    EQU     100         ; 100 ticks per second = 100Hz
