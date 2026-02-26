find_package(bacio REQUIRED)
message(STATUS bacio_VERSION)
if(bacio_VERSION VERSION_LESS 2.5)
  set(u4 "_4")
endif()
find_package(w3emc)
if(w3emc_FOUND)
  set(w3 "w3emc")
else()
  find_package(w3nco REQUIRED)
  set(w3 "w3nco")
endif()
find_package(sp REQUIRED)

add_library(utils_obj OBJECT machine.f90 physcons.f90)
add_executable(ss2gg.x ss2gg.f90)
target_link_libraries(ss2gg.x utils_obj)
target_link_libraries(ss2gg.x bacio::bacio${u4} ${w3}::${w3}_d sp::sp_4 sigio)
add_executable(ss2lv.x ss2lv.f90)
target_link_libraries(ss2lv.x utils_obj)
target_link_libraries(ss2lv.x bacio::bacio${u4} ${w3}::${w3}_d sp::sp_4 sigio)
add_executable(sigdif.x sigdif.f90)
target_link_libraries(sigdif.x bacio::bacio${u4} ${w3}::${w3}_d sp::sp_4 sigio)

install(TARGETS ss2gg.x ss2lv.x sigdif.x
        RUNTIME
        DESTINATION bin
        COMPONENT utilities)

