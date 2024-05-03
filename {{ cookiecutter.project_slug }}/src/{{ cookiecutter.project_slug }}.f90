!> Library to be imported/used by consumer applications
!!
!! Built and installed by default.
!!
{% if cookiecutter.__serial_code == "True" -%}
{% include "lib-serial.f90" %}
{%- elif cookiecutter.__mpi_code == "True" -%}
{% include "lib-mpi.f90" %}
{%- elif cookiecutter.__coarray_code == "True" -%}
{% include "lib-coarray.f90" %}
{%- endif %}
