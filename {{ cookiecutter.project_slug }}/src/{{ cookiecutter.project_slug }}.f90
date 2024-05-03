!> Library to be imported/used by consumer applications
!!
!! Built and installed by default.
!!
{% if cookiecutter.parallelization == "serial" -%}
{% include "lib-serial.f90" %}
{%- elif cookiecutter.parallelization == "mpi" -%}
{% include "lib-mpi.f90" %}
{%- elif cookiecutter.parallelization == "coarray" -%}
{% include "lib-coarray.f90" %}
{%- endif %}
