#!/bin/bash
set -e -v -x

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

source ${SCRIPT_DIR}/init.sh

cookiecutter \
   --replay-file ${TEST_DIR}/cc-replay/cmake-${parallelization}-${unit_testing}.json\
    ${COOKIECUTTER_ROOT_DIR}

CMAKE_PROJECT_BUILD_OPTIONS=()
CMAKE_EXPORT_TEST_OPTIONS=()
if [[ ${parallelization} == "coarray" ]]; then
  CMAKE_PROJECT_BUILD_OPTIONS+=(
    "-DTESTPROJECT_FFLAGS_COARRAY=${FFLAGS_COARRAY}"
    "-DTESTPROJECT_LDFLAGS_COARRAY=${LDFLAGS_COARRAY}"
  )
  CMAKE_EXPORT_TEST_OPTIONS+=(
    "-DFFLAGS_COARRAY=${FFLAGS_COARRAY}"
    "-DLDFLAGS_COARRAY=${LDFLAGS_COARRAY}"
  )
fi

RUNNER=""
if [[ ${parallelization} == "mpi" ]]; then
  RUNNER="mpirun -n 2"
fi

cmake\
  -GNinja\
  -B _build\
  -DCMAKE_INSTALL_PREFIX=$PWD/_install\
  ${CMAKE_PROJECT_BUILD_OPTIONS[@]}\
  testproject/
cmake --build _build
if [[ ${unit_testing} != "none" ]]; then
  ctest --test-dir _build
fi
cmake --install _build
${RUNNER} ./_install/bin/testproject_app
${RUNNER} ./_build/example/testproject_example


CMAKE_PREFIX_PATH=$PWD/_install\
  cmake\
  -B _build_export_cmake\
  -GNinja\
  -DFIND_BY_CMAKE=ON\
  ${CMAKE_EXPORT_TEST_OPTIONS[@]}\
  ${TEST_DIR}/testers/export_test.${parallelization}
cmake --build _build_export_cmake
${RUNNER} ./_build_export_cmake/app/export_test

PKG_CONFIG_PATH=$PWD/_install/${LIB_DIR}/pkgconfig\
  cmake\
  -B _build_export_pkgconf\
  -GNinja\
  -DFIND_BY_CMAKE=OFF\
  ${CMAKE_EXPORT_TEST_OPTIONS[@]}\
  ${TEST_DIR}/testers/export_test.${parallelization}
cmake --build _build_export_pkgconf
${RUNNER} ./_build_export_pkgconf/app/export_test
