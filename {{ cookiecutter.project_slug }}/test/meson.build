testapp_sources = files(['testapp.f90'])

{% if cookiecutter.__serial_code == "True" -%}
testapp_deps = [{{cookiecutter.project_slug}}_dep, fortuno_serial_dep]
{%- elif cookiecutter.__mpi_code == "True" -%}
testapp_deps = [{{cookiecutter.project_slug}}_dep, fortuno_mpi_dep, mpi_fortran_dep]
{%- elif cookiecutter.__coarray_code == "True" -%}
testapp_deps = [{{cookiecutter.project_slug}}_dep, fortuno_coarray_dep]
{%- endif %}

testapp_exe = executable(
  'testapp',
  sources: testapp_sources,
  dependencies: testapp_deps,
{% if cookiecutter.__coarray_code == "True" -%}
  fortran_args: fflags_coarray,
  link_args: ldflags_coarray,
{% endif %}
)
test('testapp', testapp_exe)