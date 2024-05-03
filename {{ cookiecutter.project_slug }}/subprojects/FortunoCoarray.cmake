# Variables influencing how subproject is obtained
set(CMAKE_REQUIRE_FIND_PACKAGE_FortunoCoarray ${{'{'}}{{cookiecutter.__project_slug_upper}}_SUBPROJECT_REQUIRE_FIND})
set(CMAKE_DISABLE_FIND_PACKAGE_FortunoCoarray ${{'{'}}{{cookiecutter.__project_slug_upper}}_SUBPROJECT_DISABLE_FIND})
# set FETCHCONTENT_SOURCE_DIR_FORTUNO to use a local source of the subproject

# Subproject related variables
option(
  FORTUNO_COARRAY_BUILD_SHARED_LIBS "Fortuno: Build as shared library" ${{'{'}}{{cookiecutter.__project_slug_upper}}_BUILD_SHARED_LIBS}
)

# Make subproject available
FetchContent_Declare(
  FortunoCoarray
  GIT_REPOSITORY "https://github.com/fortuno-repos/fortuno-coarray.git"
  GIT_TAG "main"
  FIND_PACKAGE_ARGS
)
FetchContent_MakeAvailable(FortunoCoarray)

if (FortunoCoarray_FOUND)
  message(STATUS "Subproject FortunoCoarray: using installed version")
else ()
  message(STATUS "Subproject FortunoCoarray: building from source in ${fortunocoarray_SOURCE_DIR}")
endif ()
