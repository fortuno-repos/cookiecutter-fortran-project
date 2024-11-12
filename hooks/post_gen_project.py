"""Post-processes the generated template."""

import os
import re
import shutil

PROJECT_SLUG = "{{ cookiecutter.project_slug }}"

CMAKE_BUILD = {{ cookiecutter.__cmake_build }}
FPM_BUILD = {{ cookiecutter.__fpm_build }}
MESON_BUILD = {{ cookiecutter.__meson_build }}

SERIAL_CODE = {{ cookiecutter.__serial_code }}
MPI_CODE = {{ cookiecutter.__mpi_code }}
COARRAY_CODE = {{ cookiecutter.__coarray_code }}

WITH_APP = {{cookiecutter.with_app}}
WITH_EXAMPLE = {{cookiecutter.with_example}}

WITH_TEST = "{{cookiecutter.unit_testing}}" != "none"
WITH_FORTUNO = "{{cookiecutter.unit_testing}}" == "fortuno"

# List of optional paths to keep or to remove
# Each tuple contains a regular expression pattern and a boolean value. If the regular expression
# matches a path and the corresponding boolean value is False, the path is removed.
OPTIONAL_PATHS = [
    (r"./app$", WITH_APP),
    (r"./cmake$", CMAKE_BUILD),
    (r"./meson$", MESON_BUILD),
    (r"./example$", WITH_EXAMPLE),
    (r"./subprojects$", (CMAKE_BUILD or MESON_BUILD) and WITH_TEST),
    (r"./subprojects/Fortuno.cmake$", CMAKE_BUILD and WITH_FORTUNO),
    (r"./subprojects/fortuno.wrap$", MESON_BUILD and WITH_FORTUNO),
    (r"./test", WITH_TEST),
    (r".*/CMakeLists.txt$", CMAKE_BUILD),
    (r".*/fpm.toml$", FPM_BUILD),
    (r".*/meson.build$", MESON_BUILD),
    (r".*/meson.options$", MESON_BUILD),
]


def main():
    """Main script."""
    _remove_superfluous_paths()


def _remove_superfluous_paths():
    """Removes superfluous files and directories."""
    optional_paths = [(re.compile(path), keep) for path, keep in OPTIONAL_PATHS]
    rootdir = "."
    for dirpath, dirnames, filenames in os.walk(rootdir):
        for pathname in dirnames + filenames:
            fullpath = os.path.join(dirpath, pathname)
            for pattern, keep in optional_paths:
                if pattern.match(fullpath):
                    if not keep:
                        if os.path.isfile(fullpath):
                            os.unlink(fullpath)
                        else:
                            shutil.rmtree(fullpath)
                    break


if __name__ == "__main__":
    main()
