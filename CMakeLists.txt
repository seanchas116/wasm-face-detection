cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s ALLOW_MEMORY_GROWTH=1 -s USE_ZLIB=1 --bind -O3")

add_definitions(-DDLIB_NO_GUI_SUPPORT)
include_directories(vendor/dlib)

include_directories(vendor/opencv/include/opencv4)
file(GLOB opencv_core "vendor/opencv/lib/*.a")

add_executable(cppmain main.cpp vendor/dlib/dlib/all/source.cpp)
target_link_libraries(cppmain ${opencv_core})
