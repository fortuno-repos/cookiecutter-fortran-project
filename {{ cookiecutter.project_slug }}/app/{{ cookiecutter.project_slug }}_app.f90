!> App
!!
!! Standalone program based on the {{cookiecutter.project_slug}} library.
!! By default built and installed only, if the project is the top-level project.
!!
{% if cookiecutter.__serial_code == "True" -%}
{% include "app-serial.f90" %}
{%- elif cookiecutter.__mpi_code == "True" -%}
{% include "app-mpi.f90" %}
{%- elif cookiecutter.__coarray_code == "True" -%}
{% include "app-coarray.f90" %}
{%- endif %}
