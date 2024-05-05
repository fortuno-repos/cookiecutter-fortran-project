!> Example
!!
!! Program demonstrating capabilities of the {{cookiecutter.project_slug}} library.
!! By default built only, if the project is the top-level project, and never installed.
!!
{% if cookiecutter.__serial_code == "True" -%}
{% include "example-serial.f90" %}
{%- elif cookiecutter.__mpi_code == "True" -%}
{% include "example-mpi.f90" %}
{%- elif cookiecutter.__coarray_code == "True" -%}
{% include "example-coarray.f90" %}
{%- endif %}
