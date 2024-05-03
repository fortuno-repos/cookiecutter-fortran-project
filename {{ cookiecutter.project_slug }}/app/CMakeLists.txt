# Folder for generated mod-files
set(moduledir "${CMAKE_CURRENT_BINARY_DIR}/modules")

add_executable({{cookiecutter.project_slug}}_app)
target_sources({{cookiecutter.project_slug}}_app PRIVATE {{cookiecutter.project_slug}}_app.f90)
set_target_properties({{cookiecutter.project_slug}}_app
  PROPERTIES Fortran_MODULE_DIRECTORY "${moduledir}"
  )
target_link_libraries({{cookiecutter.project_slug}}_app PRIVATE {{cookiecutter.project_slug}})
{% if cookiecutter.parallelization == "mpi" -%}
target_link_libraries({{cookiecutter.project_slug}}_app PRIVATE MPI::MPI_Fortran)
{%- elif cookiecutter.parallelization == "coarray" -%}
{{cookiecutter.project_slug}}_add_coarray_build_flags({{cookiecutter.project_slug}}_app)
{%- endif %}

{% if cookiecutter.parallelization == "mpi" -%}
{%- endif %}

if ({{cookiecutter.__project_slug_upper}}_INSTALL)
  install(
    TARGETS {{cookiecutter.project_slug}}_app
    EXPORT {{cookiecutter.project_name}}Targets
    RUNTIME
      DESTINATION "${CMAKE_INSTALL_BINDIR}"
      COMPONENT {{cookiecutter.project_name}}_runtime
  )
endif ()
