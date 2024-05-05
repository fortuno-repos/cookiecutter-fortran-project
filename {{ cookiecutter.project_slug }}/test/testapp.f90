!> Test app driving Fortuno unit tests.
{% if cookiecutter.__serial_code == "True" -%}
{% include "testapp-serial.f90" %}
{%- elif cookiecutter.__mpi_code == "True" -%}
{% include "testapp-mpi.f90" %}
{%- elif cookiecutter.__coarray_code == "True" -%}
{% include "testapp-coarray.f90" %}
{%- endif %}
