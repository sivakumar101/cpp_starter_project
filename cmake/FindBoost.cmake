cmake_minimum_required(VERSION 2.8)
find_package(Boost 1.71 COMPONENTS program_options REQUIRED)
include_directories(${Boost_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIR})
