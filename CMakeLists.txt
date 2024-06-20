cmake_minimum_required(VERSION 3.5)
project(my_project
  VERSION 1.0.0
  LANGUAGES CXX
)
set( CMAKE_CXX_COMPILER /usr/bin/clang++ )
set( CMAKE_C_COMPILER /usr/bin/clang )
set( CMAKE_EXPORT_COMPILE_COMMANDS ON ) # for clangd compile_commands.json

add_library(prj1 SHARED
  TimeIt/timeit.cpp
)
set_target_properties(prj2 PROPERTIES VERSION ${PROJECT_VERSION})
set_target_properties(prj2 PROPERTIES SOVERSION 1)
set_target_properties(prj2 PROPERTIES CXX_STANDARD 17 )
target_compile_options(prj2 PUBLIC 
  -std=c++17 
  -O2
)


add_executable(prj3
  Main/main.cpp
  Main/DLHandler.cpp
  Main/Project2.cpp
  Main/Project2_AVX.cpp
  Main/Project2_OpenMP.cpp
  Main/Project2_cuda.cu
)
set_target_properties(prj3 PROPERTIES VERSION ${PROJECT_VERSION})
set_target_properties(prj3 PROPERTIES CUDA_ARCHITECTURES "50;72")
target_compile_options(prj3 PUBLIC 
  -std=c++17
  -O2
  -DUSE_CUDA
  # -mavx2
  # -DUSE_AVX
  # -fopenmp
  # -DUSE_MP
)
set_target_properties(
  prj1 prj2 prj2
  PROPERTIES
  LANGUAGE CXX
  CXX_STANDARD 17
)

target_include_directories(prj3 PUBLIC
  /usr/local/cuda/include
)
target_link_libraries(prj3 PUBLIC omp)
target_link_directories(prj3 PUBLIC
  /usr/local/cuda/lib64
)
