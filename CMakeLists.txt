cmake_minimum_required(VERSION 2.8)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --bind -O3")

add_definitions(-DDLIB_NO_GUI_SUPPORT)
include_directories(vendor/dlib)

add_executable(cppmain main.cpp vendor/dlib/dlib/all/source.cpp)
