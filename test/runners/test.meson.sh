#!/bin/bash
set -e -v -x

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

source ${SCRIPT_DIR}/init.sh

RUNNER=""
MESON_TEST_WRAPPER_FLAGS=()
MESON_CONFIG_FLAGS=()
case ${parallelization} in
  mpi)
    RUNNER="mpirun -n 2"
    MESON_TEST_WRAPPER_FLAGS=(--wrapper "${RUNNER}")
    ;;
  coarray)
    MESON_CONFIG_FLAGS=(
      "-Dfflags_coarray=${FFLAGS_COARRAY}"
      "-Dldflags_coarray=${LDFLAGS_COARRAY}"
    )
    ;;
esac

cookiecutter \
   --replay-file ${TEST_DIR}/cc-replay/meson-${parallelization}-${unit_testing}.json\
    ${COOKIECUTTER_ROOT_DIR}

meson setup\
  "${MESON_CONFIG_FLAGS[@]}"\
  --prefix $PWD/_install\
  --libdir $PWD/_install/lib\
  _build\
  testproject
meson compile -C _build
if [[ ${unit_testing} != "none" ]]; then
  meson test -C _build --verbose "${MESON_TEST_WRAPPER_FLAGS[@]}"
fi
meson install -C _build
LD_LIBRARY_PATH="$PWD/_install/lib:${LD_LIBRARY_PATH}" ${RUNNER} ./_install/bin/testproject_app
${RUNNER} ./_build/example/testproject_example

PKG_CONFIG_PATH=$PWD/_install/lib/pkgconfig\
  meson setup\
  "${MESON_CONFIG_FLAGS[@]}"\
  _build_export\
  ${TEST_DIR}/testers/export_test.${parallelization}
meson compile -C _build_export
${RUNNER} ./_build_export/app/export_test_app
