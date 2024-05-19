#!/usr/bin/env python3
# Original CC0-1.0 licensed template by awvwgk obtained from:
# https://github.com/mesonbuild/meson/issues/5374#issuecomment-830662831

from os import environ, makedirs, walk
from os.path import join, exists
from sys import argv
from shutil import copy

build_dir = argv[1]
module_dir = argv[2]

if "MESON_INSTALL_DESTDIR_PREFIX" in environ:
    install_dir = environ["MESON_INSTALL_DESTDIR_PREFIX"]
else:
    install_dir = environ["MESON_INSTALL_PREFIX"]
module_install_dir = join(install_dir, module_dir)

# Find recursively all .mod files within the provided build directory
modules = [
    join(root, filename)
    for root, _, filenames in walk(build_dir)
    for filename in filenames
    if filename.endswith(".mod")
]

if modules and not exists(module_install_dir):
    makedirs(module_install_dir)

for mod in modules:
    print("Installing", mod, "to", module_install_dir)
    copy(mod, module_install_dir)
