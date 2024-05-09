project(
  'export_test',
  'fortran',
  version: '0.0.0'
)

coarray_compile_flags = get_option('coarray_compile_flags')
coarray_link_flags = get_option('coarray_link_flags')

testproject_dep = dependency('testproject', required: true)

subdir('app')
