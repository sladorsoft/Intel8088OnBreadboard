cmake_minimum_required(VERSION 3.15)

set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_LIST_DIR}/../../ia16-elf.cmake)

project(part05_1 C CXX ASM_NASM)
set(TARGET_NAME ${PROJECT_NAME})

set(LINKER_SCRIPT ${CMAKE_CURRENT_LIST_DIR}/../../bare8086.ld)

include_directories(src)
link_libraries(nosys c gcc)
add_link_options(LINKER:-Map=${TARGET_NAME}.map LINKER:--oformat=elf32-i386 LINKER:--gc-sections -march=i8086 -ffreestanding -nostdlib -nodefaultlibs -nostartfiles -fno-use-cxa-atexit)
add_link_options(-T "${LINKER_SCRIPT}")

add_executable(${TARGET_NAME})
target_sources(${TARGET_NAME} PRIVATE
    src/reset.asm
    src/init.asm
)

set_target_properties(${TARGET_NAME} PROPERTIES LINKER_LANGUAGE C)

target_compile_options(${TARGET_NAME} PRIVATE
    $<$<COMPILE_LANGUAGE:ASM_NASM>:-f elf>
    $<$<COMPILE_LANGUAGE:C,CXX>:-march=i8086 -mtune=i8086 -mcmodel=small>
)

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
