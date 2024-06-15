cmake_minimum_required(VERSION 3.28)

PROJECT(RiscvMiniOS VERSION 0.0.1 LANGUAGES C ASM)

enable_language(ASM)
enable_language(C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS OFF)     # Force the usage of _ISOC11_SOURCE

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/bin)

add_subdirectory(kernel)
add_subdirectory(irq)
add_subdirectory(simples)

# clean
add_custom_target (clean-all COMMAND rm -rf ${CMAKE_BINARY_DIR}/*
                             COMMAND rm -rf ${CMAKE_SOURCE_DIR}/bin/*)