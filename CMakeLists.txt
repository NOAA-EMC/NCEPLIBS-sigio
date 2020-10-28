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

if(NOT CMAKE_BUILD_TYPE MATCHES "^(Debug|Release|RelWithDebInfo|MinSizeRel)$")
  message(STATUS "Setting build type to 'Release' as none was specified.")
  set(CMAKE_BUILD_TYPE
    "Release"
    CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

add_subdirectory(src)

if(ENABLE_TESTS)
  find_package(PFUNIT REQUIRED)
  enable_testing()
  add_subdirectory(tests)
endif()

# Generate docs if desired.
IF(ENABLE_DOCS)
  FIND_PACKAGE(Doxygen REQUIRED)
ENDIF()
ADD_SUBDIRECTORY(docs)  
