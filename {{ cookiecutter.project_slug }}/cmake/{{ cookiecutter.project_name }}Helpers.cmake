# Sets up the build type.
function ({{cookiecutter.project_slug}}_setup_build_type default_build_type)

  get_property(_multiConfig GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
  if (_multiConfig)
    message(STATUS "Build type multi-config (build type selected at the build step)")
  else ()
    if (NOT CMAKE_BUILD_TYPE)
      message(STATUS "Build type ${default_build_type} (default single-config)")
      set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE STRING "Build type" FORCE)
      set_property(CACHE CMAKE_BUILD_TYPE PROPERTY HELPSTRING "Choose the type of build")
      set_property(
        CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "RelWithDebInfo"
      )
    else ()
      message(STATUS "{{cookiecutter.project_name}}: build type: ${CMAKE_BUILD_TYPE} (manually selected single-config)")
    endif ()
  endif ()

endfunction ()


{% if cookiecutter.__coarray_code == "True" -%}
# Creates the target CoarrayBuildInterface with coarray build options
function ({{cookiecutter.project_slug}}_create_coarray_build_target)

  if (NOT TARGET CoarrayBuildInterface)
    add_library(CoarrayBuildInterface INTERFACE)
    target_compile_options(
      CoarrayBuildInterface INTERFACE
      ${{'{'}}{{cookiecutter.__project_slug_upper}}_COARRAY_COMPILE_FLAGS}
    )
    target_link_options(
      CoarrayBuildInterface INTERFACE
      ${{'{'}}{{cookiecutter.__project_slug_upper}}_COARRAY_LINK_FLAGS}
    )
  endif ()

endfunction ()


# Applies coarray build flags to a target
function ({{cookiecutter.project_slug}}_add_coarray_build_flags target)

  {{cookiecutter.project_slug}}_create_coarray_build_target()

  # TODO: Delete first branch once cmake minimum version is 3.26 or above
  # Older CMake versions have problems during installation if the CoarrayBuildInterface target is
  # linked directly with any target, therefore applying a workaround.
  if (CMAKE_VERSION VERSION_LESS 3.26)
    get_target_property(_compile_flags CoarrayBuildInterface INTERFACE_COMPILE_OPTIONS)
    if (_compile_flags)
      target_compile_options(${target} PRIVATE ${_compile_flags})
    endif ()
    get_target_property(_link_flags CoarrayBuildInterface INTERFACE_LINK_OPTIONS)
    if (_link_flags)
      target_link_options(${target} PRIVATE ${_link_flags})
    endif ()
  else ()
    target_link_libraries(${target} PRIVATE $<BUILD_LOCAL_INTERFACE:CoarrayBuildInterface>)
  endif ()

endfunction ()
{%- endif %}
