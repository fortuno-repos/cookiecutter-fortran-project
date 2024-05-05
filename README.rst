****************************
Cookiecutter-Fortran-Project
****************************

Cookiecutter-Fortran-Project offers templates for setting up a Fortran project,
allowing you to select from various build systems (currently CMake and Fpm are
implemented, Meson is in progress), as well as different
parallelization models such as serial, MPI, and coarray. The resulting project
will include a library, unit tests (utilizing the `Fortuno
<https://fortuno.readthedocs.io>`_ unit testing framework), and optionally a
standalone application and an example.


Usage
=====

Installing cookiecutter
-----------------------

You must have cookiecutter and Python installed on your system. If cookiecutter
is not already installed, you can add it using pip. For Linux users, the
following commands can be used:

.. code-block:: bash

    mkdir -p ~/opt/venv
    python3 -m venv ~/opt/venv/cookiecutter
    source ~/opt/venv/cookiecutter/bin/activate
    pip install --upgrade pip
    pip install cookiecutter

This will install cookiecutter in a virtual environment under
``~/opt/venv/cookiecutter``. Note that you need to activate the virtual
environment every time you want to use cookiecutter later by running:

.. code-block:: bash

    source ~/opt/venv/cookiecutter/bin/activate

For further details and other ways of installing cookiecutter, consult the
`cookiecutter installation instructions
<https://cookiecutter.readthedocs.io/en/latest/installation.html>`_.


Generating a new Fortran project
--------------------------------

To generate a new Fortran project, run:

.. code-block:: bash

    cookiecutter gh:fortuno-repos/cookiecutter-fortran-project

You will be asked to choose the build system and parallelization model for your
project, along with additional details about it. The project will be generated
in a new folder named according to the ``project_slug`` you provide. This folder
will contain a complete, ready-to-build, run, test, and install project.


Acknowledgements
================

The initial CMake template was inspired by the publicly available `CMake
template by Chris Le <https://github.com/LecrisUT/CMake-Template>`_.
Additionally, valuable discussions with the author have greatly influenced its
development.


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
