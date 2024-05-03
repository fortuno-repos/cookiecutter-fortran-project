!> App
!!
!! Standalone program based on the {{cookiecutter.project_slug}} library.
!! By default built and installed only, if the project is the top-level project.
!!
{% if cookiecutter.parallelization == "serial" -%}
{% include "app-serial.f90" %}
{%- elif cookiecutter.parallelization == "mpi" -%}
{% include "app-mpi.f90" %}
{%- elif cookiecutter.parallelization == "coarray" -%}
{% include "app-coarray.f90" %}
{%- endif %}
