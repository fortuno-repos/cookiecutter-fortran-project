{{cookiecutter.project_slug}}_app_sources = files([
  '{{cookiecutter.project_slug}}_app.f90',
])

{% if cookiecutter.__mpi_code == "True" -%}
{{cookiecutter.project_slug}}_app_deps = [{{cookiecutter.project_slug}}_dep, mpi_fortran_dep]
{%- else -%}
{{cookiecutter.project_slug}}_app_deps = [{{cookiecutter.project_slug}}_dep]
{%- endif %}

{{cookiecutter.project_slug}}_app_exe = executable(
  '{{cookiecutter.project_slug}}_app',
  sources: {{cookiecutter.project_slug}}_app_sources,
  dependencies: {{cookiecutter.project_slug}}_app_deps,
{% if cookiecutter.__coarray_code == "True" -%}
  fortran_args: coarray_compile_flags,
  link_args: coarray_link_flags,
{% endif %}
  install: true,
)
