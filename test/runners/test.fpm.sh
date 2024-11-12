#!/bin/bash
set -e -v -x

SCRIPT_DIR="$(readlink -f $(dirname ${BASH_SOURCE[0]}))"

source ${SCRIPT_DIR}/init.sh

RUNNER=""
case ${parallelization} in
  mpi)
    RUNNER="mpirun -n 2"
    ;;
  coarray)
    export FPM_FFLAGS="${FPM_FFLAGS} ${FFLAGS_COARRAY}"
    export FPM_LDFLAGS="${FPM_LDFLAGS} ${LDFLAGS_COARRAY}"
    ;;
esac

cookiecutter \
   --replay-file ${TEST_DIR}/cc-replay/fpm-${parallelization}-${unit_testing}.json\
    ${COOKIECUTTER_ROOT_DIR}

fpm build -C testproject
if [[ ${unit_testing} != "none" ]]; then
  fpm test -C testproject --verbose
fi
fpm run -C testproject --target testproject_app
fpm run -C testproject --example testproject_example
fpm install -C testproject --prefix ${PWD}/_install
${RUNNER} ./_install/bin/testproject_app

cp -a ${TEST_DIR}/testers/export_test.${parallelization} export_test
cp export_test/fpm.toml.in export_test/fpm.toml
echo "testproject = { path = \"../testproject\"}" >> export_test/fpm.toml
fpm build -C export_test
fpm run -C export_test --target export_test
