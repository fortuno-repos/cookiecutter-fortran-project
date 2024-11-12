module test_{{cookiecutter.project_slug}}
  use {{cookiecutter.project_slug}}, only : broadcast
  use fortuno_coarray, only : test => coa_pure_case_item, context => coa_context,&
      & is_equal, test_list
  implicit none

contains

  function tests()
    type(test_list) :: tests

    tests = test_list([&
       test("broadcast", test_broadcast)&
    ])

  end function tests


  subroutine test_broadcast(ctx)
    class(context), intent(inout) :: ctx

    integer, parameter :: sourceimg = 1, sourceval = 1, otherval = -1
    integer :: buffer

    ! GIVEN source rank contains a different integer value as all other ranks
    if (this_image() == sourceimg) then
      buffer = sourceval
    else
      buffer = otherval
    end if

    ! WHEN source rank broadcasts its value
    call broadcast(buffer, sourceimg)

    ! THEN each rank must contain source rank's value
    call ctx%check(is_equal(buffer, sourceval))

  end subroutine test_broadcast

end module test_{{cookiecutter.project_slug}}


program testapp
  use fortuno_coarray, only : execute_coa_cmd_app
  use test_{{cookiecutter.project_slug}}, only : tests
  implicit none

  call execute_coa_cmd_app(tests())

end program testapp
