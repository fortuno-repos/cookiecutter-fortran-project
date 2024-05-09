#!/bin/bash
set -e -v -x

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

source ${SCRIPT_DIR}/init.sh

cookiecutter \
   --replay-file ${TEST_DIR}/cc-replay/cmake-coarray.json\
    ${COOKIECUTTER_ROOT_DIR}

cmake\
  -GNinja\
  -B _build\
  -DCMAKE_INSTALL_PREFIX=$PWD/_install\
  testproject/
cmake --build _build
ctest --test-dir _build
cmake --install _build
./_install/bin/testproject_app
./_build/example/testproject_example

CMAKE_PREFIX_PATH=$PWD/_install\
  cmake\
  -B _build_export_cmake\
  -GNinja\
  -DFIND_BY_CMAKE=ON\
  ${TEST_DIR}/testers/export_test.coarray
cmake --build _build_export_cmake
./_build_export_cmake/app/export_test

PKG_CONFIG_PATH=$PWD/_install/lib/pkgconfig\
  cmake\
  -B _build_export_pkgconf\
  -GNinja\
  -DFIND_BY_CMAKE=OFF\
  ${TEST_DIR}/testers/export_test.coarray
cmake --build _build_export_pkgconf
./_build_export_pkgconf/app/export_test