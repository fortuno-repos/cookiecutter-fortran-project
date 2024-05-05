cmake_minimum_required(VERSION 3.22...3.29)

project(export_test LANGUAGES Fortran)

option(FIND_BY_CMAKE "Use find_package() to find installed project (otherwise pkg-config)" ON)

find_package(MPI REQUIRED)

if (FIND_BY_CMAKE)
  find_package(TestProject REQUIRED)
else ()
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(testproject REQUIRED IMPORTED_TARGET testproject)
  add_library(TestProject::testproject ALIAS PkgConfig::testproject)
endif ()
add_subdirectory(app)