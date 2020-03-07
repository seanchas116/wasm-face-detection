cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -s ALLOW_MEMORY_GROWTH=1 --bind -O3")

add_definitions(-DDLIB_NO_GUI_SUPPORT)
include_directories(vendor/dlib)

set(OpenCV_DIR ${CMAKE_CURRENT_SOURCE_DIR}/vendor/opencv/lib/cmake/opencv4)
find_package(OpenCV REQUIRED PATHS ${OpenCV_DIR})

add_executable(cppmain main.cpp vendor/dlib/dlib/all/source.cpp)
