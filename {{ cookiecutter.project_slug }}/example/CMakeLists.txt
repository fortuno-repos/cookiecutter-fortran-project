# Folder for generated mod-files
set(moduledir "${CMAKE_CURRENT_BINARY_DIR}/modules")

add_executable({{cookiecutter.project_slug}}_example)

target_sources({{cookiecutter.project_slug}}_example PRIVATE {{cookiecutter.project_slug}}_example.f90)
set_target_properties({{cookiecutter.project_slug}}_example
  PROPERTIES Fortran_MODULE_DIRECTORY "${moduledir}"
)
target_link_libraries({{cookiecutter.project_slug}}_example PRIVATE {{cookiecutter.project_slug}})
{% if cookiecutter.parallelization == "mpi" -%}
target_link_libraries({{cookiecutter.project_slug}}_example PRIVATE MPI::MPI_Fortran)
{%- elif cookiecutter.parallelization == "coarray" -%}
{{cookiecutter.project_slug}}_add_coarray_build_flags({{cookiecutter.project_slug}}_example)
{%- endif %}
