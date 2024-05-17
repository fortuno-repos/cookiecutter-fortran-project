*************************
Fortran project templates
*************************

*Cookiecutter-Fortran-project* provides templates for setting up new Fortran
projects, allowing you to choose from various build systems (CMake, Fpm, and
Meson) and different parallelization models such as serial, MPI, and coarray.
The generated projects are designed to embody best practices for new Fortran
projects. They include a library, unit tests (currently utilizing the `Fortuno
unit test framework <https://github.com/fortuno-repos/fortuno>`_), and
optionally, a standalone application and an example. The generated projects
contain the essential configuration files and source code needed to be fully
functional and ready to build, test, and install.


Generating a Fortran project
============================

Prerequisites
-------------

You must have cookiecutter and Python installed on your system in order to
generate Fortran projects with *Cookiecutter-Fortran-project*. If cookiecutter
is not installed yet, you can obtain and install it using the pip installation
tool distributed with Python. For Linux users, this can be easily accomplished
with the command

.. code-block::

    pip install --user cookiecutter

For other operating systems and further ways of installing cookiecutter, consult
the `cookiecutter installation instructions
<https://cookiecutter.readthedocs.io/en/latest/installation.html>`_.


Generating the project
----------------------

To generate a new Fortran project, run:

.. code-block::

    cookiecutter gh:fortuno-repos/cookiecutter-fortran-project

You will be asked to choose the build system and parallelization model for your
project, along with additional details about it. The project will be generated
in a new folder named according to the project's slug you provided. This folder
will contain a complete, ready-to-build, run, test, and install project.


Using the generated Fortran project
===================================

The generated project can be configured, built, tested and installed using the
usual workflow specific to each build system. Below is concise summary for each
supported build system. For more details, please refer to the documentation of
the individual build systems.

All commands listed below should be executed in the root directory of the
generated project.


CMake
-----

Configuration
.............

Create the build directory ``build`` and configure the project by issuing

.. code-block::

    mkdir build
    FC=gfortran cmake -B build

To ensure that CMake selects the correct compiler, specify your Fortran compiler
explicitly using the ``FC`` environment variable.

The generated project offers several custom configuration variables in
additional to the standard CMake options for fine-tuning the setup, as shown
below. You can modify these configuration variables using the ``-D`` option
during the configuration step. (Replace ``<PROJECTSLUG>`` in the variable names
with the uppercase version of your project's slug.)

``<PROJECTSLUG>_BUILD_SHARED_LIBS``
  Whether to build shared libraries. Default: ``OFF`` (static libraries are
  built).

``<PROJECTSLUG>_BUILD_APPS``
  Whether to build the executable app(s). Default: ``ON`` if the project is
  top-level, ``OFF`` if the project was invoked from another project.

``<PROJECTSLUG>_BUILD_EXAMPLES``
  Whether to build the executable examples. Default: ``ON`` if the project is
  top-level, ``OFF`` if the project was invoked from another project.

``<PROJECTSLUG>_BUILD_TESTS``
  Whether to build the tests. Default: ``ON`` if the project is top-level,
  ``OFF`` if the project was invoked from another project.

``<PROJECTSLUG>_INSTALL``
  Whether to register various targets for installation. Default: ``ON`` if the
  project is top-level, ``OFF`` if the project was invoked from an other
  project.

``<PROJECTSLUG>_INSTALL_MODULEDIR``
  Name of the subdirectory to put the installed module files into. Default:
  ``modules``.

``<PROJECTSLUG>_COARRAY_COMPILE_FLAGS``
  Compiler flags to use when compiling coarray source code (only available if
  the coarray template was chosen). Default: ``-coarray``.

``<PROJECTSLUG>_COARRAY_LINK_FLAGS``
  Linker flags to use when linking coarray object files (only available if
  the coarray template was chosen). Default: ``-coarray``.

``<PROJECTSLUG>_SUBPROJECT_REQUIRE_FIND``
  Whether subprojects (e.g. Fortuno) should be exclusively looked up on the
  system without the fallback to downloading. Default: ``OFF``.

``<PROJECTSLUG>_SUBPROJECT_DISABLE_FIND``
  Whether subprojects (e.g. Fortuno) should never be looked up on the
  system but always downloaded. Default: ``OFF``.


Build
.....

Compile the source files and link the library and the executables with

.. code-block::

    cmake --build build


Testing
.......

Execute the tests using

.. code-block::

  ctest --test-dir build --verbose

The option ``--verbose`` will show the unit test driver app's output, which
might be helpful to obtain more details about the testing process.


Installation
............

Install the project including CMake and pkg-config export files with the command

.. code-block::

  cmake --install build

Note: Make sure to choose the proper installation prefix already **during the
configuration step** (using the option
``-DCMAKE_INSTALL_PREFIX=YOUR_INSTALLATION_PREFIX``). Overriding it in the
installation step via the ``--prefix`` option will result in an incorrect
pkg-config file.


Fpm
---

Configuration
.............

Fpm has no explicit configuration step. You might want to change settings in the
``fpm.toml`` file to adapt the project to your needs.


Build
.....

Create the ``build`` folder and build the project by issuing

.. code-block::

  FPM_FC=gfortran fpm build

To ensure that Fpm picks the right compiler, pass your Fortran compiler
explicitly via the ``FPM_FC`` environment variable. If you compile coarray
source, you additionally have to pass the appropriate compiler and linker flags
as well, e.g.

.. code-block::

  FPM_FC=ifx FPM_FFLAGS="-coarray" FPM_LDFLAGS="-coarray" fpm build


Testing
.......

Execute the tests with

.. code-block::

  FPM_FC=gfortran fpm test


Installation
............

You can install the built project with the

.. code-block::

  fpm install

command. You might choose the installation prefix via the ``--prefix`` option.


Meson
-----

Configuration
.............

Create the build directory ``build`` and configure the project with

.. code-block::

  FC=gfortran meson setup build

To ensure that Meson picks the right compiler, pass your Fortran compiler
explicitly via the ``FC`` environment variable.

The generated project offers several custom configuration variables in
additional to the standard Meson options for fine-tuning the setup, as shown
below. You can modify these configuration variables using the ``-D`` option
during the configuration step.

``build_apps``
  Whether to build the executable app(s). Default: ``true``.

``build_examples``
  Whether to build the executable examples. Default: ``true``.

``build_tests``
  Whether to build the tests. Default: ``true``.

``install_module_dir``
  Directory containing the installed module files. The pkg-config files
  generated by Meson are only correct when the module files are located below
  the include folder. Therefore, the specified directory will be relative to
  that folder. Default: ``modules``.

``coarray_compile_flags``
  Compiler flags to use when compiling coarray source code (only available if
  the coarray template was chosen). Default: ``-coarray``.

``coarray_link_flags``
  Linker flags to use when linking coarray object files (only available if
  the coarray template was chosen). Default: ``-coarray``.


Build
.....

Compile and link the code with

.. code-block::

  meson compile -C build


Testing
.......


Execute the tests using

.. code-block::

  meson test -C build --verbose

The option ``--verbose`` will show the unit test driver app's output, which
might be helpful to obtain more details about the testing process.


Installation
............

You can install the project including a pkg-config export file with the command

.. code-block::

  meson install -C build

Make sure to choose the proper installation prefix already **during the
configuration step** (using the ``--prefix`` flag). Overriding it in the
installation step via the ``--destdir`` option might not result in the paths you
actually want.


Credits
=======

The templates provided by the *Cookiecutter-Fortran-project* are based on the
experiences gained by the attempts to provide support for those build systems
within the `Fortuno project <https://github.com/fortuno-repos/fortuno>`_.
Various excellent publicly available templates and examples served as starting
point.

The initial CMake template was based on the  `CMake template created by Cristian
Le <https://github.com/LecrisUT/CMake-Template>`_. Valuable in-depth discussions
with the author have also significantly shaped its subsequent evolution.

For the initial Meson template, inspiration was drawn from various Fortran
projects created by `Sebastian Ehlert <https://github.com/awvwgk/>`_ and his
`mod-file installer
<https://github.com/mesonbuild/meson/issues/5374#issuecomment-830662831>`_.

The template for Fpm was adapted from the `Fortran package manager
<https://fpm.fortran-lang.org>`_'s own template.


Contributing
============

Contributions to *Cookiecutter-Fortran-project* are welcome. If you have
suggestions for improvements, or would like to report bugs, please open a pull
request or an issue.


License
=======

Cookiecutter-Fortran-Project is licensed under the `BSD-2-Clause Plus Patent
License <LICENSE>`_. This `OSI-approved
<https://opensource.org/licenses/BSDplusPatent>`_ license combines the 2-clause
BSD license with an explicit patent grant from contributors. The SPDX license
identifier for this project is `BSD-2-Clause-Patent
<https://spdx.org/licenses/BSD-2-Clause-Patent.html>`_.

**Important**: The license applied to the generated Fortran project is
independent of this license. You are free to choose any license you prefer for
your project.
