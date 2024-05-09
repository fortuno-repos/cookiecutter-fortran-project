#!/bin/bash
set -e -v -x

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

source ${SCRIPT_DIR}/init.sh

cookiecutter \
   --replay-file ${TEST_DIR}/cc-replay/meson-mpi.json\
    ${COOKIECUTTER_ROOT_DIR}

meson setup --prefix $PWD/_install --libdir $PWD/_install/lib _build testproject
meson compile -C _build
meson test -C _build --wrapper "mpirun -n 2" --verbose
meson install -C _build
LD_LIBRARY_PATH="${PWD}/_install/lib:${LD_LIBRARY_PATH}"\
  mpirun -n 2 ./_install/bin/testproject_app
mpirun -n 2 ./_build/example/testproject_example

PKG_CONFIG_PATH=$PWD/_install/lib/pkgconfig\
  meson\
  setup\
  _build_export\
  ${TEST_DIR}/testers/export_test.mpi
meson compile -C _build_export
mpirun -n 2 ./_build_export/app/export_test_app
