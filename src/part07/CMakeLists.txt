cmake_minimum_required(VERSION 3.15)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_COMPILER ia16-elf-gcc)
set(CMAKE_CXX_COMPILER ia16-elf-g++)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)

project(part07 C CXX ASM_NASM)
set(TARGET_NAME ${PROJECT_NAME})
set(TARGET_NAME_2 ${PROJECT_NAME}_186)

include_directories(src)
link_libraries(nosys c gcc)

set(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/../bare8086.ld)

include_directories(src)
link_libraries(nosys c gcc)
add_link_options(LINKER:-Map=${TARGET_NAME}.map LINKER:--oformat=elf32-i386 LINKER:--gc-sections -ffreestanding -nostdlib -nodefaultlibs -nostartfiles -fno-use-cxa-atexit)
add_link_options(-T "${LINKER_SCRIPT}")

add_executable(${TARGET_NAME})
target_sources(${TARGET_NAME} PRIVATE
    src/reset.asm
    src/init.asm
    src/text_lcd.asm
    src/utils.asm
    src/debug_int.asm
    src/int_vect.asm
    src/buttons.asm
    src/system.asm
    src/pic8259.asm
    src/pit8254.asm
    src/cpu_state.c
    src/main.c
)

target_compile_definitions(${TARGET_NAME} PUBLIC CPU_TYPE=86)
target_compile_options(${TARGET_NAME} PRIVATE
    $<$<COMPILE_LANGUAGE:ASM_NASM>:-f elf>
    $<$<COMPILE_LANGUAGE:C,CXX>:-march=i8086 -mtune=i8086 -mcmodel=small>
)

target_link_options(${TARGET_NAME} PRIVATE -march=i8086)

add_custom_command(
    TARGET ${TARGET_NAME}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -I elf32-little -O binary ${TARGET_NAME} ${TARGET_NAME}.bin
)

add_custom_command(
    TARGET ${TARGET_NAME}
    POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} -d -S -m i8086 -M i8086,intel,intel-mnemonic ${TARGET_NAME} > ${TARGET_NAME}.lst
)

add_executable(${TARGET_NAME_2})

target_sources(${TARGET_NAME_2} PRIVATE
    src/reset.asm
    src/init.asm
    src/text_lcd.asm
    src/utils.asm
    src/debug_int.asm
    src/int_vect.asm
    src/buttons.asm
    src/system.asm
    src/periph186.asm
    src/cpu_state.c
    src/main.c
)

target_compile_definitions(${TARGET_NAME_2} PUBLIC CPU_TYPE=186)
target_compile_options(${TARGET_NAME_2} PRIVATE
    $<$<COMPILE_LANGUAGE:ASM_NASM>:-f elf>
    $<$<COMPILE_LANGUAGE:C,CXX>:-march=i186 -mtune=i186 -mcmodel=small>
)

target_link_options(${TARGET_NAME_2} PRIVATE -march=i186)

add_custom_command(
    TARGET ${TARGET_NAME_2}
    POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -I elf32-little -O binary ${TARGET_NAME_2} ${TARGET_NAME_2}.bin
)

add_custom_command(
    TARGET ${TARGET_NAME_2}
    POST_BUILD
    COMMAND ${CMAKE_OBJDUMP} -d -S -m i8086 -M i8086,intel,intel-mnemonic ${TARGET_NAME_2} > ${TARGET_NAME_2}.lst
)
