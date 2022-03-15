
OUTPUT_FORMAT(binary)
ENTRY(reset)

MEMORY
  {
    csegvma	(rx) : ORIGIN = 0x00000, LENGTH = 0x10000
    dsegvma	(wx) : ORIGIN = 0x00000, LENGTH = 0x10000
    e000vma	(r)  : ORIGIN = 0x00000, LENGTH = 0x10000
    binfile	(wx) : ORIGIN = 0x00000, LENGTH = 0x20000
  }

SECTIONS
  {
    .e000 : {
        FILL(0xff);
		*(.e000) *(.e000.*)
        . = 0xffff;
        BYTE (0xff)
	} >e000vma AT >binfile

    .text : {
        FILL(0x90);
		__stext = .;
		*(.startup)
		KEEP (*(.init))
		*(.text) *(.text.*)
		__etext = .;
		ASSERT(. <= 0xfff0, "Error: too large");
	} >csegvma AT >binfile

    .data : {
		__sdata = .;
        SHORT (0)
		KEEP (*crtbegin*.o(.ctors))
		KEEP (*(EXCLUDE_FILE (*crtend*.o ) .ctors))
		KEEP (*(SORT(.ctors.*)))
		KEEP (*(.ctors))

		KEEP (*crtbegin*.o(.dtors))
		KEEP (*(EXCLUDE_FILE (*crtend*.o ) .dtors))
		KEEP (*(SORT(.dtors.*)))
		KEEP (*(.dtors))

		*(.rodata) *(.rodata.*)
		*(.data) *(.data.*)
		*(.gcc_except_table) *(.gcc_except_table.*)
		. = ALIGN (16);
		__edata = .;
	} >dsegvma AT >binfile

    .bss (NOLOAD) : {
		 __sbss = .;
        *(.bss) *(.bss.*)
        *(COMMON)
		. = ALIGN (16);
        __ebss = .;
	} >dsegvma

    .resetvec : AT(0x1fff0) {
        FILL(0xff);
        KEEP(*(.reset));
        . = 0x000f;
        BYTE (0xff)
	}

    __dataoffset = LOADADDR(.data) - LOADADDR(.text);
    __ldata = __edata - __sdata;
    __lbss = __ebss - __sbss;
    __sheap = __ebss;
    __eheap = 0x10000 - 0x1000;

    /DISCARD/ : { *(.*) }
  }
