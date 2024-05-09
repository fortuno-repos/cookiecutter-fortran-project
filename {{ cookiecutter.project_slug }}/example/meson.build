{{cookiecutter.project_slug}}_example_sources = files([
  '{{cookiecutter.project_slug}}_example.f90',
])

{% if cookiecutter.__mpi_code == "True" -%}
{{cookiecutter.project_slug}}_example_deps = [testproject_dep, mpi_fortran_dep]
{%- else -%}
{{cookiecutter.project_slug}}_example_deps = [testproject_dep]
{%- endif %}

{{cookiecutter.project_slug}}_example_exe = executable(
  '{{cookiecutter.project_slug}}_example',
  sources: {{cookiecutter.project_slug}}_example_sources,
  dependencies: {{cookiecutter.project_slug}}_example_deps,
{% if cookiecutter.__coarray_code == "True" -%}
  fortran_args: coarray_flags,
  link_args: coarray_link_flags,
{% endif %}
  install: false,
)
