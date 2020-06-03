set(test_srcs test_sigio.pf)

if(BUILD_STATIC_LIBS)
  set(sigio_lib sigio_4_static)
else()
  set(sigio_lib sigio_4_shared)
endif()

add_pfunit_ctest (sigio_test
  TEST_SOURCES test_sigio_mod.pf
  LINK_LIBRARIES ${sigio_lib}
)
