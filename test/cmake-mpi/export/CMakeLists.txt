cmake_minimum_required(VERSION 3.22...3.29)

project(export_test LANGUAGES Fortran)

option(FIND_BY_CMAKE "Use find_package() to find installed project (otherwise pkg-config)" ON)

find_package(MPI REQUIRED)

if (FIND_BY_CMAKE)
  find_package(TestCmakeMpi REQUIRED)
else ()
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(testcmakempi REQUIRED IMPORTED_TARGET testcmakempi)
  add_library(TestCmakeMpi::testcmakempi ALIAS PkgConfig::testcmakempi)
endif ()
add_executable(export_test export_test.f90)
target_link_libraries(export_test PRIVATE TestCmakeMpi::testcmakempi MPI::MPI_Fortran)
