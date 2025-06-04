cmake_minimum_required( VERSION 3.21 )

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(CMAKE_BUILD_TYPE Release)

set(CMAKE_CXX_STANDARD 14)

set(CMAKE_CUDA_ARCHITECTURES "80")

project(compare_cuda CUDA CXX)

add_executable(va va.cu)

