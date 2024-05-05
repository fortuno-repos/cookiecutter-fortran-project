cmake_minimum_required(VERSION 3.22...3.29)

project(export_test LANGUAGES Fortran)

option(FIND_BY_CMAKE "Use find_package() to find installed project (otherwise pkg-config)" ON)

set(COARRAY_COMPILE_FLAGS "" CACHE STRING "Extra flags to use for compiling coarray source files")

set(COARRAY_LINK_FLAGS "" CACHE STRING "Extra flags to use for linking coarray object files")

if (COARRAY_COMPILE_FLAGS)
  set(_coarray_compile_flags "${COARRAY_COMPILE_FLAGS}")
elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  set(_coarray_compile_flags "-coarray")
endif ()
if (COARRAY_LINK_FLAGS)
  set(_coarray_link_flags "${COARRAY_LINK_FLAGS}")
elseif (CMAKE_Fortran_COMPILER_ID STREQUAL "IntelLLVM")
  set(_coarray_link_flags "-coarray")
endif ()

if (FIND_BY_CMAKE)
  find_package(TestProject REQUIRED)
else ()
  find_package(PkgConfig REQUIRED)
  pkg_check_modules(testproject REQUIRED IMPORTED_TARGET testproject)
  add_library(TestProject::testproject ALIAS PkgConfig::testproject)
endif ()
add_subdirectory(app)