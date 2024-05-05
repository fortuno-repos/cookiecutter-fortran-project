add_executable(export_test export_test.f90)
target_link_libraries(export_test PRIVATE TestProject::testproject MPI::MPI_Fortran)
