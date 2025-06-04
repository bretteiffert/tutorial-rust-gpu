cmake_minimum_required( VERSION 3.21 )

if (NOT CMAKE_INSTALL_PREFIX)
    set (CMAKE_INSTALL_PREFIX ~/tmp CACHE STRING)
endif ()

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_CUDA_ARCHITECTURES "80")

project(libva CUDA CXX)

#add_executable(bfs bfs.cu)

add_library(va STATIC va.cu)
install(TARGETS va
    DESTINATION ${CMAKE_INSTALL_PREFIX}
    )

