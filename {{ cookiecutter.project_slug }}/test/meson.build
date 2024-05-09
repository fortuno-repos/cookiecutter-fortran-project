testapp_sources = files(['testapp.f90'])

{% if cookiecutter.__serial_code == "True" -%}
testapp_deps = [testproject_dep, fortuno_serial_dep]
{%- elif cookiecutter.__mpi_code == "True" -%}
testapp_deps = [testproject_dep, fortuno_mpi_dep, mpi_fortran_dep]
{%- elif cookiecutter.__coarray_code == "True" -%}
testapp_deps = [testproject_dep, fortuno_coarray_dep]
{%- endif %}

testapp_exe = executable(
  'testapp',
  sources: testapp_sources,
  dependencies: testapp_deps,
)
test('testapp', testapp_exe)