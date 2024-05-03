#[=============================================================================[
#                       Basic project definition                              #
]=============================================================================]

cmake_minimum_required(VERSION 3.22...3.29)

list(APPEND CMAKE_MESSAGE_CONTEXT {{cookiecutter.project_name}})

project(
  {{cookiecutter.project_name}}
  VERSION {{cookiecutter.version}}
  DESCRIPTION "{{cookiecutter.description}}"
  LANGUAGES Fortran
)

#[=============================================================================[
#                       Options                                               #
]=============================================================================]

option(
  {{cookiecutter.__project_slug_upper}}_BUILD_SHARED_LIBS
  "{{cookiecutter.project_name}}: Build as shared library"
  OFF
)
{% if cookiecutter.with_app -%}
option(
  {{cookiecutter.__project_slug_upper}}_BUILD_APPS
  "{{cookiecutter.project_name}}: Whether to build the app"
  ${PROJECT_IS_TOP_LEVEL}
)
{%- endif %}
{% if cookiecutter.with_example -%}
option(
  {{cookiecutter.__project_slug_upper}}_BUILD_EXAMPLES
  "{{cookiecutter.project_name}}: Whether to build the examples"
  ${PROJECT_IS_TOP_LEVEL}
)
{%- endif %}
option(
  {{cookiecutter.__project_slug_upper}}_BUILD_TESTS
  "{{cookiecutter.project_name}}: Whether to build the tests"
  ${PROJECT_IS_TOP_LEVEL}
)
option(
  {{cookiecutter.__project_slug_upper}}_INSTALL
  "{{cookiecutter.project_name}}: Install project"
  ${PROJECT_IS_TOP_LEVEL}
)
set(
  {{cookiecutter.__project_slug_upper}}_INSTALL_MODULEDIR
  "modules"
  CACHE STRING
  "{{cookiecutter.project_name}}: Sub-directory for installed Fortran module files (relative to CMAKE_INSTALL_LIBDIR)"
)
{% if cookiecutter.parallelization == "coarray" -%}
set(
  {{cookiecutter.__project_slug_upper}}_COARRAY_COMPILE_FLAGS
  ""
  CACHE STRING
  "{{cookiecutter.project_name}}: Extra flags to use for compiling coarray source files"
)
set(
  {{cookiecutter.__project_slug_upper}}_COARRAY_LINK_FLAGS
  ""
  CACHE STRING
  "{{cookiecutter.project_name}}: Extra flags to use for linking coarray object files"
)
{%- endif %}
option(
  {{cookiecutter.__project_slug_upper}}_SUBPROJECT_REQUIRE_FIND
  "{{cookiecutter.project_name}}: Require find_package for all subprojects"
  FALSE
)
option(
  {{cookiecutter.__project_slug_upper}}_SUBPROJECT_DISABLE_FIND
  "{{cookiecutter.project_name}}: Disable find_package for all subprojects"
)

#[=============================================================================[
#                  Project configuration                                      #
]=============================================================================]

include(FetchContent)
include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include({{cookiecutter.project_name}}Helpers)

set(BUILD_SHARED_LIBS ${{'{'}}{{cookiecutter.__project_slug_upper}}_BUILD_SHARED_LIBS})
{{cookiecutter.project_slug}}_setup_build_type("RelWithDebInfo")

{% if cookiecutter.parallelization == "mpi" -%}
find_package(MPI REQUIRED)
{%- endif %}


#[=============================================================================[
#                       Main definition                                       #
]=============================================================================]

add_subdirectory(src)
{% if cookiecutter.with_app -%}
if ({{cookiecutter.__project_slug_upper}}_BUILD_APPS)
  add_subdirectory(app)
endif ()
{%- endif %}
{% if cookiecutter.with_example -%}
if ({{cookiecutter.__project_slug_upper}}_BUILD_EXAMPLES)
  add_subdirectory(example)
endif ()
{%- endif %}
if ({{cookiecutter.__project_slug_upper}}_BUILD_TESTS)
  {% if cookiecutter.parallelization == "serial" -%}
  include(subprojects/Fortuno.cmake)
  {%- elif cookiecutter.parallelization == "mpi" -%}
  include(subprojects/FortunoMpi.cmake)
  {%- elif cookiecutter.parallelization == "coarray" -%}
  include(subprojects/FortunoCoarray.cmake)
  {%- endif %}
  enable_testing()
  add_subdirectory(test)
endif ()


#[=============================================================================[
#                       Install or Export                                     #
]=============================================================================]

if ({{cookiecutter.__project_slug_upper}}_INSTALL)

  # pkg-config files
  configure_file(cmake/{{cookiecutter.project_slug}}.pc.in {{cookiecutter.project_slug}}.pc @ONLY)
  install(
    FILES ${CMAKE_CURRENT_BINARY_DIR}/{{cookiecutter.project_slug}}.pc
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig
    COMPONENT {{cookiecutter.project_name}}_development
  )

  # cmake export files
  write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/{{cookiecutter.project_name}}ConfigVersion.cmake
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
  )
  configure_package_config_file(
      cmake/{{cookiecutter.project_name}}Config.cmake.in
      ${CMAKE_CURRENT_BINARY_DIR}/{{cookiecutter.project_name}}Config.cmake
      INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/{{cookiecutter.project_name}}
  )
  install(
    FILES
      ${CMAKE_CURRENT_BINARY_DIR}/{{cookiecutter.project_name}}ConfigVersion.cmake
      ${CMAKE_CURRENT_BINARY_DIR}/{{cookiecutter.project_name}}Config.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/{{cookiecutter.project_name}}
    COMPONENT {{cookiecutter.project_name}}_development
  )

  export(
    EXPORT {{cookiecutter.project_name}}Targets
    FILE {{cookiecutter.project_name}}Targets.cmake
    NAMESPACE {{cookiecutter.project_name}}::
  )
  install(
    EXPORT {{cookiecutter.project_name}}Targets
    FILE {{cookiecutter.project_name}}Targets.cmake
    NAMESPACE {{cookiecutter.project_name}}::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/{{cookiecutter.project_name}}
    COMPONENT {{cookiecutter.project_name}}_development
  )
endif ()

# Make project available for FetchContent
if (NOT PROJECT_IS_TOP_LEVEL)
  # Propagate variables
  set({{cookiecutter.project_name}}_VERSION ${{'{'}}{{cookiecutter.project_name}}_VERSION} PARENT_SCOPE)
  set({{cookiecutter.project_name}}_VERSION_MAJOR ${{'{'}}{{cookiecutter.project_name}}_VERSION_MAJOR} PARENT_SCOPE)
  set({{cookiecutter.project_name}}_VERSION_MINOR ${{'{'}}{{cookiecutter.project_name}}_VERSION_MINOR} PARENT_SCOPE)
  set({{cookiecutter.project_name}}_VERSION_PATCH ${{'{'}}{{cookiecutter.project_name}}_VERSION_PATCH} PARENT_SCOPE)
  set({{cookiecutter.project_name}}_VERSION_TWEAK ${{'{'}}{{cookiecutter.project_name}}_VERSION_TWEAK} PARENT_SCOPE)
endif ()
