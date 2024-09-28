#!/bin/bash
set -e -v -x

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

source ${SCRIPT_DIR}/init.sh

cookiecutter \
   --replay-file ${TEST_DIR}/cc-replay/meson-coarray.json\
    ${COOKIECUTTER_ROOT_DIR}

meson setup\
 --prefix $PWD/_install\
 --libdir $PWD/_install/lib\
 -Dfflags_coarray=${FFLAGS_COARRAY}\
 -Dldflags_coarray=${LDFLAGS_COARRAY}\
 _build testproject
meson compile -C _build
meson test -C _build --verbose
meson install -C _build
LD_LIBRARY_PATH="${PWD}/_install/lib:${LD_LIBRARY_PATH}"\
  ./_install/bin/testproject_app
./_build/example/testproject_example

PKG_CONFIG_PATH=$PWD/_install/lib/pkgconfig\
  meson setup\
  -Dfflags_coarray=${FFLAGS_COARRAY}\
  -Dldflags_coarray=${LDFLAGS_COARRAY}\
  _build_export\
  ${TEST_DIR}/testers/export_test.coarray
meson compile -C _build_export
./_build_export/app/export_test_app
