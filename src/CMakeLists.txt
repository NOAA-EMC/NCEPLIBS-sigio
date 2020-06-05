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
set(module_dir "${CMAKE_CURRENT_BINARY_DIR}/include_4")

add_library(${lib_name} STATIC ${fortran_src})
set_target_properties(${lib_name} PROPERTIES Fortran_MODULE_DIRECTORY
  ${module_dir})

target_include_directories(${lib_name} INTERFACE
  $<BUILD_INTERFACE:${module_dir}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include_4>)
list(APPEND LIB_TARGETS ${lib_name})
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


      
