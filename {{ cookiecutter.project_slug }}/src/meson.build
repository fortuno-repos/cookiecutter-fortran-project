{{cookiecutter.project_slug}}_sources = files(
  '{{cookiecutter.project_slug}}.f90',
)

{% if cookiecutter.__mpi_code == "True" -%}
{{cookiecutter.project_slug}}_deps = [mpi_fortran_dep]
{%- else -%}
{{cookiecutter.project_slug}}_deps = []
{%- endif %}

{{cookiecutter.project_slug}}_lib = library(
  '{{ cookiecutter.project_slug }}',
  version: meson.project_version(),
  sources: {{cookiecutter.project_slug}}_sources,
  dependencies: {{cookiecutter.project_slug}}_deps,
{% if cookiecutter.__coarray_code == "True" -%}
  fortran_args: fflags_coarray,
  link_args: ldflags_coarray,
{% endif %}
  install: true,
)

{{cookiecutter.project_slug}}_dep = declare_dependency(
  link_with: {{cookiecutter.project_slug}}_lib,
  dependencies: {{cookiecutter.project_slug}}_deps,
)

meson.add_install_script(
  install_modules_script,
  meson.current_build_dir(), install_modules_dir,
)

pkg.generate(
  {{cookiecutter.project_slug}}_lib,
  description: '{{cookiecutter.description}}',
  subdirs: ['', module_dir_name]
)
