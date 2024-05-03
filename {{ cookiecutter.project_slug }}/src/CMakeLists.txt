# Folder for generated mod-files
set(moduledir "${CMAKE_CURRENT_BINARY_DIR}/modules")

add_library({{cookiecutter.project_slug}})
add_library({{cookiecutter.project_name}}::{{cookiecutter.project_slug}} ALIAS {{cookiecutter.project_slug}})

target_sources(
  {{cookiecutter.project_slug}}
  PRIVATE
  {{cookiecutter.project_slug}}.f90
)

target_include_directories(
  {{cookiecutter.project_slug}} PUBLIC
  $<BUILD_INTERFACE:${moduledir}>
  $<INSTALL_INTERFACE:${CMAKE_INSTALL_LIBDIR}/${{'{'}}{{cookiecutter.__project_slug_upper}}_INSTALL_MODULEDIR}>
)

{% if cookiecutter.parallelization == "mpi" -%}
target_link_libraries({{cookiecutter.project_slug}} PRIVATE MPI::MPI_Fortran)
{%- elif cookiecutter.parallelization == "coarray" -%}
{{cookiecutter.project_slug}}_add_coarray_build_flags({{cookiecutter.project_slug}})
{%- endif %}

set_target_properties(
  {{cookiecutter.project_slug}}
  PROPERTIES
    VERSION ${PROJECT_VERSION}
    SOVERSION ${PROJECT_VERSION_MAJOR}
    EXPORT_NAME {{cookiecutter.project_slug}}
    OUTPUT_NAME {{cookiecutter.project_slug}}
    Fortran_MODULE_DIRECTORY "${moduledir}"
)

if ({{cookiecutter.__project_slug_upper}}_INSTALL)
  install(
    TARGETS {{cookiecutter.project_slug}}
    EXPORT {{cookiecutter.project_name}}Targets
    LIBRARY
      DESTINATION "${CMAKE_INSTALL_LIBDIR}"
      COMPONENT {{cookiecutter.project_name}}_runtime
      NAMELINK_COMPONENT {{cookiecutter.project_name}}_development
    PUBLIC_HEADER
      DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
      COMPONENT {{cookiecutter.project_name}}_development
  )
  install(
    DIRECTORY "${moduledir}/"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/${{'{'}}{{cookiecutter.__project_slug_upper}}_INSTALL_MODULEDIR}"
    COMPONENT {{cookiecutter.project_name}}_development
  )
endif ()
