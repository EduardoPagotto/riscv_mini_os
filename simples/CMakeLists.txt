PROJECT(app_test)

set(GENERATED_FILES app01.s)
set(EXECUTABLE ${PROJECT_NAME}.elf)

add_executable(${EXECUTABLE} ${GENERATED_FILES})

#set (SfsInclude ${CMAKE_SOURCE_DIR}/include) # Raiz do projeto
#target_include_directories (${EXECUTABLE} PUBLIC ${SfsInclude})

target_compile_options(${EXECUTABLE} PRIVATE    
                        --target=riscv32
                        -march=rv32ia
                        -nostdlib
                        -mabi=ilp32
                        -static
                        -c
)

target_link_options(${EXECUTABLE} PRIVATE
        -T${CMAKE_SOURCE_DIR}/simples/mem_cfg.ld
        --target=riscv32
        -march=rv32ia
        -nostdlib
        -mabi=ilp32
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
