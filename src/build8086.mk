########################################
# To be defined in user's Makefile:
########################################
# Required:
########################################
# PROJECT
# LDSCRIPT
# SRCFILES
#
########################################
# Optional:
########################################
# SRC_DIR
# INC_DIRS
# LIB_DIRS
# LIBS
#
# ASFLAGS
# CFLAGS
# CXXFLAGS
# NASMFLAGS
#
# LDFLAGS
########################################

ifeq (,$(PROJECT))
    $(error PROJECT not specified)
endif

ifeq (,$(LDSCRIPT))
    $(error LDSCRIPT not specified)
endif

ifeq (,$(SRCFILES))
    $(error SRCFILES not specified)
endif

PREFIX ?= ia16-elf-
CC	= $(PREFIX)gcc
CXX = $(PREFIX)g++
AS  = $(PREFIX)as
LD	= $(PREFIX)g++
OBJCOPY	= $(PREFIX)objcopy
OBJDUMP	= $(PREFIX)objdump
NASM = nasm

SRC_DIR ?= src
OBJ_DIR = obj
BIN_DIR = bin

INC_DIRS += $(SRC_DIR)
OBJS = $(foreach FILE,$(SRCFILES),$(OBJ_DIR)/$(basename $(FILE)).o)
DEPS = $(OBJS:%.o=%.d)
BIN_NAME = $(BIN_DIR)/$(PROJECT)

LIBS += nosys c
GCCFLAGS += -march=i8088 -mtune=i8088 -mcmodel=small -Os $(patsubst %,-D%,$(DEFINES)) $(patsubst %,-I%,$(INC_DIRS))

ASFLAGS += -march=i386 -mtune=i8086
ASFLAGS += -mmnemonic=intel -msyntax=intel

CFLAGS += -std=c11

CXXFLAGS += -fno-use-cxa-atexit -std=c++14

NASMFLAGS += -f elf $(patsubst %,-I%,$(INC_DIRS))

LDFLAGS += -T"$(realpath $(LDSCRIPT))"
LDFLAGS += -Wl,-Map=$(BIN_NAME).map
LDFLAGS += -nostartfiles -fno-use-cxa-atexit
LDFLAGS += -Wl,--oformat=elf32-i386
LDFLAGS += -Wl,--gc-sections

ifeq ($(OS),Windows_NT)
MAKEDIR_CMD = @if not exist "$(realpath $(@D))\" mkdir "$(realpath $(@D))"
REMOVEDIR_CMD = rmdir /S /Q
else
MAKEDIR_CMD = @mkdir -p "$(abspath $(@D))/"
REMOVEDIR_CMD = rm -r
endif

.PHONY: all clean

all: $(BIN_NAME).bin $(BIN_NAME).elf $(BIN_NAME).lst

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	$(MAKEDIR_CMD)
	$(NASM) $(NASMFLAGS) -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	$(MAKEDIR_CMD)
	$(AS) $(ASFLAGS) -o $@ $<

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	$(MAKEDIR_CMD)
	$(CC) $(GCCFLAGS) $(CFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(MAKEDIR_CMD)
	$(CXX) $(GCCFLAGS) $(CXXFLAGS) -c $< -o $@

$(BIN_NAME).bin: $(BIN_NAME).elf
	$(OBJCOPY) -I elf32-little -O binary $< $@

$(BIN_NAME).elf: $(OBJS)
	$(MAKEDIR_CMD)
	$(CXX) $(LDFLAGS) $^ $(patsubst %,-L"$(realpath %)",$(LIB_DIRS)) $(patsubst %,-l%,$(LIBS)) -o $@

$(BIN_NAME).lst: $(BIN_NAME).elf
	$(OBJDUMP) -d -S -m i8086 -M i8086,intel,intel-mnemonic $< > $@

clean:
	$(REMOVEDIR_CMD) $(OBJ_DIR) $(BIN_DIR)

-include $(DEPS)
