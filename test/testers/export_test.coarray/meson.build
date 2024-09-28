project(
  'export_test',
  'fortran',
  version: '0.0.0'
)

fflags_coarray = get_option('fflags_coarray')
ldflags_coarray = get_option('ldflags_coarray')

testproject_dep = dependency('testproject', required: true)

subdir('app')
