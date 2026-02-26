# This is the main CMake file for NCEPLIBS-sigio.
#
# Mark Potts, Kyle Gerheiser, Ed Hartnett
cmake_minimum_required(VERSION 3.15)

# Get the version from the VERSION file.
file(STRINGS "VERSION" pVersion)

project(
  sigio
  VERSION ${pVersion}
  LANGUAGES Fortran)

include(GNUInstallDirs)

# Handle user options.
option(ENABLE_TESTS "Build pfunit tests?" OFF)
OPTION(ENABLE_DOCS "Enable generation of doxygen-based documentation." OFF)
OPTION(BUILD_UTILS "Build historical utilities to manipulate GFS Spectral files." OFF)

if(NOT CMAKE_BUILD_TYPE MATCHES "^(Debug|Release|RelWithDebInfo|MinSizeRel)$")
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE
    "Release"
    CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

add_subdirectory(src)

include(CTest)
if(BUILD_TESTING)
  add_subdirectory(tests)
endif()

if(BUILD_UTILS)
  add_subdirectory(utils)
endif()

# Generate docs if desired.
if(ENABLE_DOCS)
  find_package(Doxygen REQUIRED)
  add_subdirectory(docs)  
endif()
