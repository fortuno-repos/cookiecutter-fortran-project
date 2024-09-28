TEST_DIR="$(readlink -f $SCRIPT_DIR/..)"
COOKIECUTTER_ROOT_DIR="$(readlink -f $SCRIPT_DIR/../..)"
DISTRO_ID=$(python3 -c "import platform; print(platform.freedesktop_os_release()['ID'])")
LIB_DIR=$([[ "${DISTRO_ID}" =~ ^(ubuntu|debian)$ ]] && echo "lib" || echo "lib64")

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
