# Variables influencing how subproject is obtained
set(CMAKE_REQUIRE_FIND_PACKAGE_Fortuno ${{'{'}}{{cookiecutter.__project_slug_upper}}_SUBPROJECT_REQUIRE_FIND})
set(CMAKE_DISABLE_FIND_PACKAGE_Fortuno ${{'{'}}{{cookiecutter.__project_slug_upper}}_SUBPROJECT_DISABLE_FIND})
# set FETCHCONTENT_SOURCE_DIR_FORTUNO to use a local source of the subproject

# Subproject related variables
option(
  FORTUNO_BUILD_SHARED_LIBS "Fortuno: Build as shared library" ${{'{'}}{{cookiecutter.__project_slug_upper}}_BUILD_SHARED_LIBS}
)

{% if cookiecutter.__mpi_code == "True" -%}
option(FORTUNO_WITH_MPI "Fortuno: whether to build the MPI interface" ON)
{%- elif cookiecutter.__coarray_code == "True" -%}
option(FORTUNO_WITH_COARRAY "Fortuno: whether to build the coarray interface" ON)
{%- endif %}

# Make subproject available
FetchContent_Declare(
  Fortuno
  GIT_REPOSITORY "https://github.com/fortuno-repos/fortuno.git"
  GIT_TAG "main"
  FIND_PACKAGE_ARGS
)
FetchContent_MakeAvailable(Fortuno)

if (Fortuno_FOUND)
  message(STATUS "Subproject Fortuno: using installed version")
else ()
  message(STATUS "Subproject Fortuno: building from source in ${fortuno_SOURCE_DIR}")
endif ()
