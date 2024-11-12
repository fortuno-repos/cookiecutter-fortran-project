module test_{{cookiecutter.project_slug}}
  use {{cookiecutter.project_slug}}, only : broadcast
  use fortuno_mpi, only : global_comm, is_equal, test => mpi_case_item, check => mpi_check,&
      & test_list, this_rank
  implicit none

contains

  function tests()
    type(test_list) :: tests

    tests = test_list([&
        test("broadcast", test_broadcast)&
    &])

  end function tests


  subroutine test_broadcast()
    integer, parameter :: sourcerank = 0, sourceval = 1, otherval = -1
    integer :: buffer

    ! GIVEN source rank contains a different integer value as all other ranks
    if (this_rank() == sourcerank) then
      buffer = sourceval
    else
      buffer = otherval
    end if

    ! WHEN source rank broadcasts its value
    call broadcast(global_comm(), buffer, sourcerank)

    ! THEN each rank must contain source rank's value
    call check(is_equal(buffer, sourceval))

  end subroutine test_broadcast

end module test_{{cookiecutter.project_slug}}


program testapp
  use fortuno_mpi, only : execute_mpi_cmd_app
  use test_{{cookiecutter.project_slug}}, only : tests
  implicit none

  call execute_mpi_cmd_app(tests())

end program testapp
