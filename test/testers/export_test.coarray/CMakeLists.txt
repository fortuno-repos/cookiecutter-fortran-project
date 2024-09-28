cmake_minimum_required(VERSION 3.22...3.29)

project(export_test LANGUAGES Fortran)

option(FIND_BY_CMAKE "Use find_package() to find installed project (otherwise pkg-config)" ON)

set(FFLAGS_COARRAY "" CACHE STRING "Extra flags to use for compiling coarray source files")

set(LDFFLAGS_COARRAY "" CACHE STRING "Extra flags to use for linking coarray object files")

if (FFLAGS_COARRAY)
  set(_fflags_coarray "${FFLAGS_COARRAY}")
elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  set(_fflags_coarray "-coarray")
endif ()
if (LDFLAGS_COARRAY)
  set(_ldflags_coarray "${LDFLAGS_COARRAY}")
elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  set(_ldflags_coarray "-coarray")
endif ()

if (FIND_BY_CMAKE)
  find_package(TestProject REQUIRED)
else ()
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(testproject REQUIRED IMPORTED_TARGET testproject)
  add_library(TestProject::testproject ALIAS PkgConfig::testproject)
endif ()
add_subdirectory(app)