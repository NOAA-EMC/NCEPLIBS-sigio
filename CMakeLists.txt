cmake_minimum_required(VERSION 2.6)
project(sigio)
set(VERSION v2.1.0)
enable_language (Fortran)
if (NOT CMAKE_BUILD_TYPE)
    set (CMAKE_BUILD_TYPE RELEASE CACHE STRING
        "Choose the type of build, options are: PRODUCTION Debug Release."
        FORCE)
endif()
if(CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  set(IntelComp true )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "GNU*" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang*")
  set(GNUComp true )
elseif(CMAKE_CXX_COMPILER_ID MATCHES "pgc*")
  set(PGIComp true )
endif()

STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "RelWithDebInfo" BUILD_RELEASE)
STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "RELEASE" BUILD_RELEASE)
STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "PRODUCTION" BUILD_PRODUCTION)
STRING(COMPARE EQUAL ${CMAKE_BUILD_TYPE} "DEGUG" BUILD_DEBUG)

if(IntelComp)
  set(CMAKE_Fortran_FLAGS "-free -convert big_endian -assume byterecl" CACHE INTERNAL "" )
elseif(GNUComp)
  set(CMAKE_Fortran_FLAGS "-ffree-form -Wall -Wno-unused-variable -Wno-conversion" CACHE INTERNAL "" )
elseif(PGIComp)
else()
  message("unknown compiler!")
  exit()
endif()

if( (BUILD_RELEASE) OR (BUILD_PRODUCTION) )
  if(IntelComp)
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -g -xHOST -traceback" CACHE INTERNAL "" )
  elseif(GNUComp)
    set(CMAKE_Fortran_FLAGS "-O2 -ggdb -fbacktrace -ffree-form -fconvert=big-endian -funroll-loops -Wall " CACHE INTERNAL "" )
  else()
    message("unknown compiler!")
    exit()
  endif()
endif()

set(LIBNAME ${CMAKE_PROJECT_NAME}_${VERSION})
file(GLOB LIB_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/*.f )
add_library(${LIBNAME} STATIC ${LIB_SRC} )
set(CMAKE_INCLUDE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/include")
set_target_properties(${LIBNAME} PROPERTIES Fortran_MODULE_DIRECTORY ${CMAKE_INCLUDE_OUTPUT_DIRECTORY})
target_include_directories(${LIBNAME} PUBLIC ${CMAKE_INCLUDE_OUTPUT_DIRECTORY})

file(MAKE_DIRECTORY ${CMAKE_INCLUDE_OUTPUT_DIRECTORY})

install(TARGETS ${LIBNAME}
        RUNTIME DESTINATION ${CMAKE_INSTALL_PREFIX}/bin
        LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
        ARCHIVE DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

install(DIRECTORY ${CMAKE_INCLUDE_OUTPUT_DIRECTORY}/ DESTINATION include )
