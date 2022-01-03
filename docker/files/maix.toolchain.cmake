set(GCC_COMPILER_VERSION "" CACHE STRING "GCC Compiler version")
#set(GNU_MACHINE "arm-linux-gnueabi" CACHE STRING "GNU compiler triple")
set(GNU_MACHINE "arm-openwrt-linux-muslgnueabi" CACHE STRING "GNU compiler triple")

set(CMAKE_SYSROOT $ENV{env})

set(CMAKE_C_COMPILER $ENV{CC})
set(CMAKE_C_FLAGS $ENV{CFLAGS})
set(CMAKE_CXX_COMPILER $ENV{CXX})
set(CMAKE_CXX_FLAGS $ENV{CPPFLAGS})
#set(CMAKE_CXX_FLAGS "-I$env/usr/include -I$header/usr/include -I$header/include -I$header/include/fortify -I$env/usr/include/python3.8")
set(CMAKE_LINKER $ENV{LD})
#set(ARM_LINUX_SYSROOT $ENV{header})
set(ARM_LINUX_SYSROOT $ENV{env})

set(CMAKE_SHARED_LINKER_FLAGS $ENV{LDFLAGS})
#set(ENV{CMAKE_EXE_LINKER_FLAGS} "$CC")
#set(ENV{CMAKE_CXX_FLAGS} "$CC")

set(PKG_CONFIG_LIBDIR, $ENV{env}/usr/lib/pkgconfig/)

set(LD_LIBRARY_PATH $ENV{header}/usr/lib)
set(C_INCLUDE_PATH $ENV{header}/usr/include)
set(CPLUS_INCLUDE_PATH $ENV{header}/usr/include)

#set(PYTHON3_INCLUDE_PATH $ENV{PYTHONPATH})
#set(PYTHON3_LIBRARIES $ENV{PYTHONPATH})
#set(PYTHON_LIBRARIES $ENV{PYTHONPATH})
#set(PYTHON_INCLUDE_DIRS $ENV{PYTHONPATH})

#set(PYTHON_DEFAULT_AVAILABLE "/home/irfan/Code/contentwise/maix/cross/toolchain_v83x_linux_x86/host/bin/python3")
#set(PYTHON_DEFAULT_EXECUTABLE "/home/irfan/Code/contentwise/maix/cross/toolchain_v83x_linux_x86/host/bin/python3")
#set(PYTHON3_INCLUDE_PATH "/home/irfan/Code/contentwise/maix/cross/toolchain_v83x_linux_x86/usr/include/python3.8")
#set(PYTHON3_LIBRARIES "/home/irfan/Code/contentwise/maix/cross/toolchain_v83x_linux_x86/usr/lib/libpython3.8.so.1.0")
#set(PYTHON3_NUMPY_INCLUDE_DIRS "/home/irfan/Code/contentwise/maix/cross/toolchain_v83x_linux_x86/usr/lib/python3.8/site-packages/numpy/core/include")

include("${CMAKE_CURRENT_LIST_DIR}/arm.toolchain.cmake")
