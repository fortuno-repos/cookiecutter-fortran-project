#!/bin/bash
set -e -v -x

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"
COOKIECUTTER_ROOT_DIR="$(readlink -f $SCRIPT_DIR/../..)"

build_dir=$1
if [[ -z ${build_dir} ]]; then
    echo "Usage: $0 <build_dir>" >&2
    exit 1
fi
if [[ -e ${build_dir} ]]; then
    echo "Error: ${build_dir} already exists" >&2
    exit 1
fi
mkdir -p ${build_dir}
cd ${build_dir}

cookiecutter \
   --replay-file ${SCRIPT_DIR}/cc-replay.json\
    ${COOKIECUTTER_ROOT_DIR}

cmake\
  -GNinja\
  -B _build\
  -DCMAKE_INSTALL_PREFIX=$PWD/_install\
  testcmakempi/
cmake --build _build --verbose -j1
ctest --test-dir _build
cmake --install _build
mpirun -n 2 ./_install/bin/testcmakempi_app
mpirun -n 2 ./_build/example/testcmakempi_example

CMAKE_PREFIX_PATH=$PWD/_install\
  cmake\
  -B _build_export_cmake\
  -GNinja\
  -DFIND_BY_CMAKE=ON\
  ${SCRIPT_DIR}/export
cmake --build _build_export_cmake --verbose -j1
mpirun -n 2 ./_build_export_cmake/export_test

PKG_CONFIG_PATH=$PWD/_install/lib/pkgconfig\
  cmake\
  -B _build_export_pkgconf\
  -GNinja\
  -DFIND_BY_CMAKE=OFF\
  ${SCRIPT_DIR}/export
cmake --build _build_export_pkgconf --verbose -j1
mpirun -n 2 ./_build_export_pkgconf/export_test