!> Example
!!
!! Program demonstrating capabilities of the {{cookiecutter.project_slug}} library.
!! By default built only, if the project is the top-level project, and never installed.
!!
{% if cookiecutter.parallelization == "serial" -%}
{% include "example-serial.f90" %}
{%- elif cookiecutter.parallelization == "mpi" -%}
{% include "example-mpi.f90" %}
{%- elif cookiecutter.parallelization == "coarray" -%}
{% include "example-coarray.f90" %}
{%- endif %}
