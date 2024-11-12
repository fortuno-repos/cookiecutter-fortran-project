!> Test app driving Fortuno unit tests.
{% if cookiecutter.__serial_code == "True" -%}
{% if cookiecutter.unit_testing == "fortuno" -%}
{% include "testapp-serial-fortuno.f90" %}
{%- endif %}
{%- elif cookiecutter.__mpi_code == "True" -%}
{% if cookiecutter.unit_testing == "fortuno" -%}
{% include "testapp-mpi-fortuno.f90" %}
{%- endif %}
{%- elif cookiecutter.__coarray_code == "True" -%}
{% if cookiecutter.unit_testing == "fortuno" -%}
{% include "testapp-coarray-fortuno.f90" %}
{%- endif %}
{%- endif %}
