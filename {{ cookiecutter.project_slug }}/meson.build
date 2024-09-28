project(
  '{{cookiecutter.project_name}}',
  'fortran',
  version: '{{cookiecutter.version}}'
)

# Meson (as of version 1.3.2) requires installed module files to be below the include folder to be
# able to create functional pkg-config files. An installation below 'libdir' would be probably more
# appropriate (as module files are compiler-specific binary files), but other Meson or pkg-config
# based projects would not be able to find the installed module files then.
module_dir_name = get_option('install_module_dir')
install_modules_dir = join_paths(get_option('includedir'), module_dir_name)
install_modules_script = find_program(files(join_paths('meson', 'install-modules.py')))

{% if cookiecutter.__coarray_code == "True" -%}
fflags_coarray = get_option('fflags_coarray')
ldflags_coarray = get_option('ldflags_coarray')
{% endif %}

{% if cookiecutter.__serial_code == "True" -%}
fortuno_serial_dep = dependency('fortuno-serial', fallback: ['fortuno', 'fortuno_serial_dep'])
{%- elif cookiecutter.__mpi_code == "True" -%}
mpi_fortran_dep = dependency('mpi', language: 'fortran', required: true)
fortuno_mpi_dep = dependency(
  'fortuno-mpi',
  fallback: ['fortuno', 'fortuno_mpi_dep'],
  default_options: {'with_mpi': true}
)
{%- elif cookiecutter.__coarray_code == "True" -%}
fortuno_coarray_dep = dependency(
  'fortuno-coarray',
  fallback: ['fortuno', 'fortuno_coarray_dep'],
  default_options: {
    'with_coarray': true,
    'fflags_coarray': fflags_coarray,
    'ldflags_coarray': ldflags_coarray,
  },
)
{%- endif %}

pkg = import('pkgconfig')

subdir('src')
{% if cookiecutter.with_app -%}
if get_option('build_apps')
  subdir('app')
endif
{% endif %}

{% if cookiecutter.with_example -%}
if get_option('build_examples')
subdir('example')
endif
{% endif %}

if get_option('build_tests')
  subdir('test')
endif
