"""Deletes unnecessary files after the project had been generated."""

import os
import re
import shutil

CMAKE_BUILD = "{{ cookiecutter.build_system }}" == "cmake"
FPM_BUILD = "{{ cookiecutter.build_system }}" == "fpm"
MESON_BUILD = "{{ cookiecutter.build_system }}" == "meson"

SERIAL_CODE = "{{ cookiecutter.parallelization }}" == "serial"
MPI_CODE = "{{ cookiecutter.parallelization }}" == "mpi"
COARRAY_CODE = "{{ cookiecutter.parallelization }}" == "coarray"

WITH_APP = {{cookiecutter.with_app}}
WITH_EXAMPLE = {{cookiecutter.with_example}}

# List of optional paths to keep or to remove
# Each tuple contains a regular expression pattern and a boolean value. If the regular expression
# matches a path and the corresponding boolean value is False, the path is removed.
OPTIONAL_PATHS = [
    (r"./app$", WITH_APP),
    (r"./cmake$", CMAKE_BUILD),
    (r"./example$", WITH_EXAMPLE),
    (r"./subprojects$", CMAKE_BUILD or MESON_BUILD),
    (r"./subprojects/Fortuno.cmake$", CMAKE_BUILD and SERIAL_CODE),
    (r"./subprojects/FortunoMpi.cmake$", CMAKE_BUILD and MPI_CODE),
    (r"./subprojects/FortunoCoarray.cmake$", CMAKE_BUILD and COARRAY_CODE),
    (r".*/CMakeLists.txt$", CMAKE_BUILD),
    (r"fpm.toml$", FPM_BUILD),
]


def main():
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
