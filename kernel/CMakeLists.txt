cmake_minimum_required(VERSION 3.28)

PROJECT(kernel)

set(GENERATED_FILES entry.s
                    kernel.c )

set(EXECUTABLE ${PROJECT_NAME}.elf)

add_executable(${EXECUTABLE} ${GENERATED_FILES})

#set (SfsInclude ${CMAKE_SOURCE_DIR}/include) # Raiz do projeto
#target_include_directories (${EXECUTABLE} PUBLIC ${SfsInclude})

target_compile_options(${EXECUTABLE} PRIVATE
                        #--target=riscv64
                        #-march=rv64gc
                        --target=riscv32
                        -march=rv32i
                        -nostdlib
                        -static
                        -Wall
                        -Wextra
                        -c
                        -mcmodel=medany
)

target_link_options(${EXECUTABLE} PRIVATE
        -T${CMAKE_CURRENT_SOURCE_DIR}/linker.ld
        #--target=riscv64
        #-march=rv64gc
        --target=riscv32
        -march=rv32i
        -nostdlib
        -L.
        -Wl
        #-Map=${PROJECT_NAME}.map
        # --cref
        #--gc-sections
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
