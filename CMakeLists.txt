cmake_minimum_required(VERSION 3.28)

PROJECT(RiscvMiniOS VERSION 0.0.1 LANGUAGES C ASM)

enable_language(ASM)
enable_language(C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS OFF)     # Force the usage of _ISOC11_SOURCE
set(RISK_ARCH_SET_32 on)

if (RISK_ARCH_SET_32)
    set(CMAKE_SYSTEM_PROCESSOR "RISCV32")
    set(CMAKE_C_COMPILER_ABI "ilp32")
else(RISK_ARCH_SET_32)
    set(CMAKE_SYSTEM_PROCESSOR "RISCV64")
    set(CMAKE_C_COMPILER_ABI "lp64i")
endif(RISK_ARCH_SET_32)

message(STATUS "Compiler prefix: ${RISCV_COMPLILER_PREFIX}")
message(STATUS "Processor: ${CMAKE_SYSTEM_PROCESSOR}")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

add_subdirectory(kernel)
#add_subdirectory(irq)
#add_subdirectory(simples)

# clean
add_custom_target (clean-all COMMAND rm -rf ${CMAKE_BINARY_DIR}/*
                             COMMAND rm -rf ${CMAKE_SOURCE_DIR}/bin/*)
