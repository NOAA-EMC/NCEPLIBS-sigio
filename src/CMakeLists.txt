if(CMAKE_Fortran_COMPILER_ID MATCHES "^(Intel)$")
  set(CMAKE_Fortran_FLAGS
      "-g -xHOST -traceback -free -convert big_endian -assume byterecl")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O2")
elseif(CMAKE_Fortran_COMPILER_ID MATCHES "^(GNU|Clang|AppleClang)$")
  set(CMAKE_Fortran_FLAGS
      "-g -fbacktrace -ffree-form -fconvert=big-endian -funroll-loops")
  set(CMAKE_Fortran_FLAGS_RELEASE "-O2")
  set(CMAKE_Fortran_FLAGS_DEBUG "-ggdb -Wall")
endif()

set(fortran_src sigio_module.f sigio_r_module.f)

set(lib_name ${PROJECT_NAME}_4)
set(versioned_lib_name ${PROJECT_NAME}_v${PROJECT_VERSION}_4)
set(module_dir "${CMAKE_CURRENT_BINARY_DIR}/include_4")

add_library(${lib_name}_f OBJECT ${fortran_src})
set_target_properties(${lib_name}_f PROPERTIES COMPILE_FLAGS
  "${fortran_${kind}_flags}")
set_target_properties(${lib_name}_f PROPERTIES Fortran_MODULE_DIRECTORY
  ${module_dir})

if(BUILD_STATIC_LIBS)
  add_library(${lib_name}_static STATIC $<TARGET_OBJECTS:${lib_name}_f>)
  set_target_properties(${lib_name}_static PROPERTIES OUTPUT_NAME
    ${versioned_lib_name})
  target_include_directories(${lib_name}_static INTERFACE
    $<BUILD_INTERFACE:${module_dir}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include_${kind}>)
  target_link_libraries(${lib_name}_static bacio::bacio_4_static)
  list(APPEND LIB_TARGETS ${lib_name}_static)
endif()

if(BUILD_SHARED_LIBS)
  add_library(${lib_name}_shared SHARED $<TARGET_OBJECTS:${lib_name}_f>)
  set_target_properties(${lib_name}_shared PROPERTIES OUTPUT_NAME
    ${versioned_lib_name})
  target_include_directories(${lib_name}_shared INTERFACE
    $<BUILD_INTERFACE:${module_dir}>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include_${kind}>)
  target_link_libraries(${lib_name}_shared bacio::bacio_4_shared)
  list(APPEND LIB_TARGETS ${lib_name}_shared)
endif()

install(DIRECTORY ${module_dir} DESTINATION ${CMAKE_INSTALL_PREFIX})

install(
  TARGETS ${LIB_TARGETS}
  EXPORT ${PROJECT_NAME}Exports
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib)

### Package config
include(CMakePackageConfigHelpers)
set(CONFIG_INSTALL_DESTINATION lib/cmake/${PROJECT_NAME})

export(EXPORT ${PROJECT_NAME}Exports
  NAMESPACE ${PROJECT_NAME}::
  FILE ${PROJECT_NAME}-targets.cmake)

# sigio-config.cmake
configure_package_config_file(
  ${CMAKE_SOURCE_DIR}/cmake/PackageConfig.cmake.in ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  INSTALL_DESTINATION ${CONFIG_INSTALL_DESTINATION})
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config.cmake
  DESTINATION ${CONFIG_INSTALL_DESTINATION})

# sigio-config-version.cmake
write_basic_package_version_file(
  ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY AnyNewerVersion)
install(FILES ${CMAKE_BINARY_DIR}/${PROJECT_NAME}-config-version.cmake
  DESTINATION ${CONFIG_INSTALL_DESTINATION})

# *-targets.cmake and *-targets-<build-type>.cmake
install(EXPORT ${PROJECT_NAME}Exports
  NAMESPACE ${PROJECT_NAME}::
  FILE ${PROJECT_NAME}-targets.cmake
  DESTINATION ${CONFIG_INSTALL_DESTINATION})


      
