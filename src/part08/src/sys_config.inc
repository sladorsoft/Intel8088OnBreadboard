%ifndef SYS_CONFIG_INC
%define SYS_CONFIG_INC

;--------------------------------------
; System configuration
;--------------------------------------
SYSTEM_STACK_SEG        EQU     0x7000
SYSTEM_BOOT_SEG         EQU     0xf000

SYSTEM_CPU_CLK          EQU     4000000         ; this is the CPU clk (1/2 of the crystal used)
SYSTEM_PCLK             EQU     SYSTEM_CPU_CLK  ; CLKOUT from 80C188
SYSTEM_TIMER_CLK        EQU     SYSTEM_CPU_CLK / 4
SYSTEM_IO_BASE          EQU     0x0000          ; base I/O address for external devices 
SYSTEM_TICKS_SEC        EQU     100             ; 100 ticks per second = 100Hz

MCS_BLOCK_SIZE          EQU     256 * 1024      ; MCS block size is 256kB (64kB per pin)

;--------------------------------------
; Define this macro if the Text LCD is connected to the ports of 8255
; Comment it out when it is driven directly from the CPU data bus
;--------------------------------------
%define TEXT_LCD_USING_8255
;--------------------------------------

%endif
