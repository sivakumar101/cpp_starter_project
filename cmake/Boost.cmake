if (UNIX)
find_package(Boost 1.71 COMPONENTS REQUIRED)
include_directories(${Boost_INCLUDE_DIR})
link_directories(${Boost_LIBRARY_DIR})
elseif (WIN32)
#Install the boost and the set the include/link directories for the windows.
endif()