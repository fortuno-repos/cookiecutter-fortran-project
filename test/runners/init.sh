TEST_DIR="$(readlink -f $SCRIPT_DIR/..)"
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
