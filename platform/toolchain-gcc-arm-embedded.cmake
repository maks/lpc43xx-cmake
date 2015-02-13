include(CMakeForceCompiler)

if(NOT TOOLCHAIN_PREFIX)
  message(FATAL_ERROR "No TOOLCHAIN_PREFIX specified.")
endif()

if(CMAKE_HOST_WIN32)
  set(TOOLCHAIN_BIN_SUFFIX ".exe")
  message(STATUS "Toolchain binary suffix set to .exe")
endif()

set(TARGET_TRIPLET "arm-none-eabi")

set(TOOLCHAIN_BIN_DIR ${TOOLCHAIN_PREFIX}/bin)
set(TOOLCHAIN_INC_DIR ${TOOLCHAIN_PREFIX}/${TARGET_TRIPLET}/include)
set(TOOLCHAIN_LIB_DIR ${TOOLCHAIN_PREFIX}/${TARGET_TRIPLET}/lib)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-gcc${TOOLCHAIN_BIN_SUFFIX} CACHE INTERNAL "c compiler")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-g++${TOOLCHAIN_BIN_SUFFIX} CACHE INTERNAL "cxx compiler")
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-as${TOOLCHAIN_BIN_SUFFIX} CACHE INTERNAL "asm compiler")

set(CMAKE_OBJCOPY ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-objcopy${TOOLCHAIN_BIN_SUFFIX} CACHE INTERNAL "objcopy")
set(CMAKE_OBJDUMP ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-objdump${TOOLCHAIN_BIN_SUFFIX} CACHE INTERNAL "objdump")

set(CMAKE_STRIP ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-strip${TOOLCHAIN_BIN_SUFFIX} CACHE INTERNAL "strip")
set(CMAKE_SIZE ${TOOLCHAIN_BIN_DIR}/${TARGET_TRIPLET}-size${TOOLCHAIN_BIN_SUFFIX} CACHE INTERNAL "size")

# Adjust the default behaviour of the FIND_XXX() commands:
# i)    Search headers and libraries in the target environment
# ii)   Search programs in the host environment
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM BOTH)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Compilers like arm-none-eabi-gcc that target bare metal systems don't pass
# CMake's compiler check, so fill in the results manually and mark the test
# as passed:
set(CMAKE_C_COMPILER_ID     GNU)
set(CMAKE_COMPILER_IS_GNUCC 1)
set(CMAKE_C_COMPILER_ID_RUN TRUE)
set(CMAKE_C_COMPILER_FORCED TRUE)