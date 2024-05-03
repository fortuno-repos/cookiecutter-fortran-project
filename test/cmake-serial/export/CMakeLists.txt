cmake_minimum_required(VERSION 3.22...3.29)

project(export_test LANGUAGES Fortran)

option(FIND_BY_CMAKE "Use find_package() to find installed project (otherwise pkg-config)" ON)

if (FIND_BY_CMAKE)
  find_package(TestCmakeSerial REQUIRED)
else ()
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(testcmakeserial REQUIRED IMPORTED_TARGET testcmakeserial)
  add_library(TestCmakeSerial::testcmakeserial ALIAS PkgConfig::testcmakeserial)
endif ()
add_executable(export_test export_test.f90)
target_link_libraries(export_test PRIVATE TestCmakeSerial::testcmakeserial)
