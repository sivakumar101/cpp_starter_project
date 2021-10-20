cmake_minimum_required(VERSION 3.16)

project(ETGVA)

if (WIN32)
message(FATAL_ERROR "This CMAKE doesn't support windows platform at the moment.")
endif()

# Set the default build type if nothing has been specified
include(cmake/StandardProjectSettings.cmake)

# Prevent an insource build of the cmake.
include(cmake/PreventInSourceBuilds.cmake)

# Link this 'library' to set the c++ standard / compile-time options requested
add_library(project_options INTERFACE)
target_compile_features(project_options INTERFACE cxx_std_17)

# Link this 'library' to use the warnings specified in CompilerWarnings.cmake
add_library(project_warnings INTERFACE)

# Add linker configuration
include(cmake/Linker.cmake)
configure_linker(project_options)

# standard compiler warnings
include(cmake/CompilerWarnings.cmake)
set_project_warnings(project_warnings)

# allow for static analysis options
include(cmake/StaticAnalyzers.cmake)

# Set up the Opensplice
include(cmake/Opensplice.cmake)

# Set up the Opensplice
include(cmake/Boost.cmake)

# Very basic PCH added. Has to be changed as per project needs.
option(ENABLE_PCH "Enable Precompiled Headers" OFF)
if(ENABLE_PCH)
  target_precompile_headers(
    project_options
    INTERFACE
    <vector>
    <string>
    <map>
    <utility>)
endif()

option(ENABLE_GOOGLETEST "Enable Test Builds" OFF)
if(ENABLE_GOOGLETEST)
  message("GoogleTest is enabled..")

  # Set up the google test unit framework
  include(cmake/Googletest.cmake)

  add_subdirectory(test)
endif()

add_subdirectory(src)

