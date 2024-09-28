{{cookiecutter.project_slug}}_example_sources = files([
  '{{cookiecutter.project_slug}}_example.f90',
])

{% if cookiecutter.__mpi_code == "True" -%}
{{cookiecutter.project_slug}}_example_deps = [{{cookiecutter.project_slug}}_dep, mpi_fortran_dep]
{%- else -%}
{{cookiecutter.project_slug}}_example_deps = [{{cookiecutter.project_slug}}_dep]
{%- endif %}

{{cookiecutter.project_slug}}_example_exe = executable(
  '{{cookiecutter.project_slug}}_example',
  sources: {{cookiecutter.project_slug}}_example_sources,
  dependencies: {{cookiecutter.project_slug}}_example_deps,
{% if cookiecutter.__coarray_code == "True" -%}
  fortran_args: fflags_coarray,
  link_args: ldflags_coarray,
{% endif %}
  install: false,
)
