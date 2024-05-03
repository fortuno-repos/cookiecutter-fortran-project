# Folder for generated mod-files
set(moduledir "${CMAKE_CURRENT_BINARY_DIR}/modules")

add_executable(testapp)
target_sources(testapp PRIVATE testapp.f90)
set_target_properties(
  testapp PROPERTIES Fortran_MODULE_DIRECTORY "${moduledir}"
)
target_link_libraries(testapp PRIVATE {{cookiecutter.project_slug}})
{% if cookiecutter.parallelization == "serial" -%}
target_link_libraries(testapp PRIVATE Fortuno::fortuno_serial)
{%- elif cookiecutter.parallelization == "mpi" -%}
target_link_libraries(testapp PRIVATE Fortuno::fortuno_mpi MPI::MPI_Fortran)
{%- elif cookiecutter.parallelization == "coarray" -%}
{{cookiecutter.project_name}}_add_coarray_build_flags(testapp)
target_link_libraries(testapp PRIVATE Fortuno::fortuno_coarray)
{%- endif %}

add_test(
  NAME testapp
  COMMAND testapp
)
