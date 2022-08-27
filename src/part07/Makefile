PROJECT = part07

SRCFILES = reset.asm init.asm text_lcd.asm utils.asm int_vect.asm debug_int.asm buttons.asm system.asm
SRCFILES += main.c cpu_state.c

ifeq ($(CPU_TYPE),186)
SRCFILES += periph186.asm
else
SRCFILES += pic8259.asm pit8254.asm
endif


LDSCRIPT = ../bare8086.ld

include ../build8086.mk
