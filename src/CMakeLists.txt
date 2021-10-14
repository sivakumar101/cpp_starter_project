cmake_minimum_required (VERSION 2.8)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_MODULE_PATH ../cmake)
project (dds-tutorial)

include (MacroOpenSplice)
include (osmacros)

include_directories(
  ${PROJECT_SOURCE_DIR}
  ${OpenSplice_INCLUDE_DIRS}
)

SET(outsources
    ${CMAKE_CURRENT_SOURCE_DIR}/HelloWorldData.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/HelloWorldData.h
    ${CMAKE_CURRENT_SOURCE_DIR}/HelloWorldDataSplDcps.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/HelloWorldData_DCPS.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/HelloWorldDataSplDcps.h
)

ADD_CUSTOM_COMMAND(
    OUTPUT ${outsources}
    COMMAND ${OpenSplice_IDLGEN_BINARY} 
    ARGS -l isocpp2 ${CMAKE_CURRENT_SOURCE_DIR}/idl/HelloWorldData.idl
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

set (PUB_SOURCES
	publisher.cpp
	implementation.cpp
)
set (SUB_SOURCES
	subscriber.cpp
	implementation.cpp
)

set (PUB_EXE ttpub)
set (SUB_EXE ttsub)
set (DATAMODEL datamodel)

add_executable (${PUB_EXE} ${PUB_SOURCES})
add_executable (${SUB_EXE} ${SUB_SOURCES})

add_library (${DATAMODEL} SHARED ${outsources})

add_definitions (
 ${OpenSplice_DEFINITIONS}
 ${DEFINITIONS}
)

target_link_libraries (
  ${DATAMODEL} 
  ${OpenSplice_LIBRARIES}
  ${Boost_LIBRARIES}
)

target_link_libraries (${PUB_EXE}
 ${OpenSplice_LIBRARIES}
 ${DATAMODEL} 
)

target_link_libraries (${SUB_EXE}
 ${OpenSplice_LIBRARIES}
 ${DATAMODEL}
)
