export_test_sources = files([
  'export_test.f90',
])

export_test_deps = [testproject_dep]

export_test_exe = executable(
  'export_test_app',
  sources: export_test_sources,
  dependencies: export_test_deps,
  fortran_args: coarray_compile_flags,
  link_args: coarray_link_flags,
)
