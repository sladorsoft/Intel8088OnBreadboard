%ifndef REGS_186_INC
%define REGS_186_INC

%include "sys_config.inc"

;--------------------------------------
; Peripherals in 80C188/6
;--------------------------------------
; Peripheral Control Block (PCB)
;--------------------------------------
PCB_BASE_RESET          EQU     0xff00              ; default location of PCB after reset
UMCS_RESET              EQU     (PCB_BASE_RESET + 0xa0)
RELREG_RESET            EQU     (PCB_BASE_RESET + 0xfe)

PCB_BASE                EQU     PCB_BASE_RESET      ; configured location of PCB
EOI                     EQU     (PCB_BASE + 0x22)
POLL                    EQU     (PCB_BASE + 0x24)
POLLSTS                 EQU     (PCB_BASE + 0x26)
IMASK                   EQU     (PCB_BASE + 0x28)
PRIMSK                  EQU     (PCB_BASE + 0x2a)
INSERV                  EQU     (PCB_BASE + 0x2c)
REQST                   EQU     (PCB_BASE + 0x2e)
INSTS                   EQU     (PCB_BASE + 0x30)
TCUCON                  EQU     (PCB_BASE + 0x32)
DMA0CON                 EQU     (PCB_BASE + 0x34)
DMA1CON                 EQU     (PCB_BASE + 0x36)
I0CON                   EQU     (PCB_BASE + 0x38)
I1CON                   EQU     (PCB_BASE + 0x3a)
I2CON                   EQU     (PCB_BASE + 0x3c)
I3CON                   EQU     (PCB_BASE + 0x3e)
T0CNT                   EQU     (PCB_BASE + 0x50)
T0CMPA                  EQU     (PCB_BASE + 0x52)
T0CMPB                  EQU     (PCB_BASE + 0x54)
T0CON                   EQU     (PCB_BASE + 0x56)
T1CNT                   EQU     (PCB_BASE + 0x58)
T1CMPA                  EQU     (PCB_BASE + 0x5a)
T1CMPB                  EQU     (PCB_BASE + 0x5c)
T1CON                   EQU     (PCB_BASE + 0x5e)
T2CNT                   EQU     (PCB_BASE + 0x60)
T2CMPA                  EQU     (PCB_BASE + 0x62)
T2CON                   EQU     (PCB_BASE + 0x66)
UMCS                    EQU     (PCB_BASE + 0xa0)
LMCS                    EQU     (PCB_BASE + 0xa2)
PACS                    EQU     (PCB_BASE + 0xa4)
MMCS                    EQU     (PCB_BASE + 0xa6)
MPCS                    EQU     (PCB_BASE + 0xa8)
D0SRCL                  EQU     (PCB_BASE + 0xc0)
D0SRCH                  EQU     (PCB_BASE + 0xc2)
D0DSTL                  EQU     (PCB_BASE + 0xc4)
D0DSTH                  EQU     (PCB_BASE + 0xc6)
D0TC                    EQU     (PCB_BASE + 0xc8)
D0CON                   EQU     (PCB_BASE + 0xca)
D1SRCL                  EQU     (PCB_BASE + 0xd0)
D1SRCH                  EQU     (PCB_BASE + 0xd2)
D1DSTL                  EQU     (PCB_BASE + 0xd4)
D1DSTH                  EQU     (PCB_BASE + 0xd6)
D1TC                    EQU     (PCB_BASE + 0xd8)
D1CON                   EQU     (PCB_BASE + 0xda)
RFBASE                  EQU     (PCB_BASE + 0xe0)
RFTIME                  EQU     (PCB_BASE + 0xe2)
RFCON                   EQU     (PCB_BASE + 0xe4)
PWRSAV                  EQU     (PCB_BASE + 0xf0)
PWRCON                  EQU     (PCB_BASE + 0xf2)
STEPID                  EQU     (PCB_BASE + 0xf6)
RELREG                  EQU     (PCB_BASE + 0xfe)

TIMER0_INT_VEC          EQU     8
TIMER1_INT_VEC          EQU     18
TIMER2_INT_VEC          EQU     19
DMA0_INT_VEC            EQU     10
DMA1_INT_VEC            EQU     11
INT0_INT_VEC            EQU     12
INT1_INT_VEC            EQU     13
INT2_INT_VEC            EQU     14
INT3_INT_VEC            EQU     15

TIMER_INT_MASK          EQU     (1 << 0)
DMA0_INT_MASK           EQU     (1 << 2)
DMA1_INT_MASK           EQU     (1 << 3)
INT0_INT_MASK           EQU     (1 << 4)
INT1_INT_MASK           EQU     (1 << 5)
INT2_INT_MASK           EQU     (1 << 6)
INT3_INT_MASK           EQU     (1 << 7)

;--------------------------------------
; Base I/O addresses for pins PCS0-6
;--------------------------------------
IO_PCS0_BASE            EQU     SYSTEM_IO_BASE + 0x0000
IO_PCS1_BASE            EQU     SYSTEM_IO_BASE + 0x0080
IO_PCS2_BASE            EQU     SYSTEM_IO_BASE + 0x0100
IO_PCS3_BASE            EQU     SYSTEM_IO_BASE + 0x0180
IO_PCS4_BASE            EQU     SYSTEM_IO_BASE + 0x0200
IO_PCS5_BASE            EQU     SYSTEM_IO_BASE + 0x0280
IO_PCS6_BASE            EQU     SYSTEM_IO_BASE + 0x0300



;--------------------------------------
; Timer control registers bits
;--------------------------------------
TCON_CONT_BIT           EQU     0
TCON_ALT_BIT            EQU     1
TCON_EXT_BIT            EQU     2
TCON_P_BIT              EQU     3
TCON_RTG_BIT            EQU     4
TCON_MC_BIT             EQU     5
TCON_RIU_BIT            EQU     12
TCON_INT_BIT            EQU     13
TCON_INH_BIT            EQU     14
TCON_EN_BIT             EQU     15

;--------------------------------------
; Relocation register bits
;--------------------------------------
RELREG_ADDR_BITS        EQU     0
RELREG_ADDR_SIZE        EQU     12
RELREG_MIO_BIT          EQU     12
RELREG_SM_BIT           EQU     14
RELREG_ET_BIT           EQU     15

;--------------------------------------
; Chip Select register bits
;--------------------------------------
CS_RDY_WAIT_BITS        EQU     0
CS_RDY_WAIT_SIZE        EQU     2
CS_RDY_IGNRDY_BIT       EQU     2
UMCS_MEM_SIZE_BITS      EQU     6
UMCS_MEM_SIZE_SIZE      EQU     8
UMCS_UNUSED_BITS        EQU     0b1100000000111000
LMCS_MEM_SIZE_BITS      EQU     6
LMCS_MEM_SIZE_SIZE      EQU     8
LMCS_UNUSED_BITS        EQU     0b0000000000111000
MMCS_MEM_SIZE_BITS      EQU     9
MMCS_MEM_SIZE_SIZE      EQU     7
MMCS_UNUSED_BITS        EQU     0b0000000111111000
MPCS_MEM_SIZE_BITS      EQU     8
MPCS_MEM_SIZE_SIZE      EQU     7
MPCS_MS_BIT             EQU     6
MPCS_EX_BIT             EQU     7
MPCS_UNUSED_BITS        EQU     0b1000000000111000
PACS_MEM_SIZE_BITS      EQU     6
PACS_MEM_SIZE_SIZE      EQU     10
PACS_UNUSED_BITS        EQU     0b0000000000111000

;--------------------------------------
; Interrupt control register bits
;--------------------------------------
INT_CON_PRI_BITS        EQU     0
INT_CON_PRI_SIZE        EQU     3
INT_CON_MSK_BIT         EQU     3
INT_CON_LTM_BIT         EQU     4
INT_CON_C_BIT           EQU     5
INT_CON_SFNM_BIT        EQU     6

;--------------------------------------
; Interrupt status/request/mask register bits
;--------------------------------------
INT_TMR_BIT             EQU     0
INT_D0_BIT              EQU     2
INT_D1_BIT              EQU     3
INT_I0_BIT              EQU     4
INT_I1_BIT              EQU     5
INT_I2_BIT              EQU     6
INT_I3_BIT              EQU     7


%endif