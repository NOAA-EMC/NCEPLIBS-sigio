add_executable(test_sigio_module test_sigio_module.F90)
target_link_libraries(test_sigio_module PUBLIC ${PROJECT_NAME})
add_test(test_sigio_module test_sigio_module)
