cmake_minimum_required(VERSION 3.28)
project(baremetal)

set(GENERATED_FILES boot.s
                    traps.s
                    kernel.s
                    main.c
                    driver_uart.c
)

set(EXECUTABLE ${PROJECT_NAME}.elf)

add_executable(${EXECUTABLE} ${GENERATED_FILES})

target_compile_options(${EXECUTABLE} PRIVATE --target=riscv32
                                             -march=rv32i
                                             -mabi=ilp32
                                             -nostdlib
)

target_link_options(${EXECUTABLE} PRIVATE -T${CMAKE_CURRENT_SOURCE_DIR}/linker.ld
                                          -fuse-ld=lld
                                          -nostdlib
                                          --target=riscv32
                                          -march=rv32i
                                          -O2
)

# Create aux files
add_custom_command(TARGET ${EXECUTABLE}
        POST_BUILD
        COMMAND ${CMAKE_SIZE} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXECUTABLE} # Print executable size
        COMMAND ${CMAKE_OBJDUMP} -D ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXECUTABLE} > ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${PROJECT_NAME}.list
        COMMAND ${CMAKE_OBJCOPY} -O ihex ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXECUTABLE} ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${PROJECT_NAME}.hex
        COMMAND ${CMAKE_OBJCOPY} -O binary ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXECUTABLE} ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${PROJECT_NAME}.bin
        COMMAND ${CMAKE_OBJDUMP} -d ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/${EXECUTABLE} -l > ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/${PROJECT_NAME}.s
)
