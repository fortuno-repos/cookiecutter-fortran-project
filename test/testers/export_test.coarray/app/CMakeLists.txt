add_executable(export_test export_test.f90)
target_link_libraries(export_test PRIVATE TestProject::testproject)
target_compile_options(export_test PRIVATE ${_fflags_coarray})
target_link_options(export_test PRIVATE ${_ldflags_coarray})
