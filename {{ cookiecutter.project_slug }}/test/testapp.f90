!> Test app driving Fortuno unit tests.
{% if cookiecutter.parallelization == "serial" -%}
{% include "testapp-serial.f90" %}
{%- elif cookiecutter.parallelization == "mpi" -%}
{% include "testapp-mpi.f90" %}
{%- elif cookiecutter.parallelization == "coarray" -%}
{% include "testapp-coarray.f90" %}
{%- endif %}
