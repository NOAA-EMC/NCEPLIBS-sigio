find_package(bacio REQUIRED)
find_package(w3nco REQUIRED)
find_package(sp REQUIRED)

add_library(utils_obj OBJECT machine.f90 physcons.f90)
add_executable(ss2gg.x ss2gg.f90)
target_link_libraries(ss2gg.x utils_obj)
target_link_libraries(ss2gg.x bacio::bacio_4 w3nco::w3nco_d sp::sp_4 sigio)
add_executable(ss2lv.x ss2lv.f90)
target_link_libraries(ss2lv.x utils_obj)
target_link_libraries(ss2lv.x bacio::bacio_4 w3nco::w3nco_d sp::sp_4 sigio)
add_executable(sigdif.x sigdif.f90)
target_link_libraries(sigdif.x bacio::bacio_4 w3nco::w3nco_d sp::sp_4 sigio)

install(TARGETS ss2gg.x ss2lv.x sigdif.x
        RUNTIME
        DESTINATION bin
        COMPONENT utilities)

