module test_{{cookiecutter.project_slug}}
  use {{cookiecutter.project_slug}}, only : factorial
  use fortuno_serial, only : is_equal, test => serial_case_item, check => serial_check, test_list
  implicit none

contains

  function tests()
    type(test_list) :: tests

    tests = test_list([&
      test("factorial_0", test_factorial_0),&
      test("factorial_1", test_factorial_1),&
      test("factorial_2", test_factorial_2)&
    ])

  end function tests

  ! Test: 0! = 1
  subroutine test_factorial_0()
    call check(factorial(0) == 1)
  end subroutine test_factorial_0

  ! Test: 1! = 1
  subroutine test_factorial_1()
    call check(is_equal(factorial(1), 1))
  end subroutine test_factorial_1

  ! Test: 2! = 2
  subroutine test_factorial_2()
    ! Failing check, you should obtain detailed info about the failure.
    call check(is_equal(factorial(2), 2))
  end subroutine test_factorial_2

end module test_{{cookiecutter.project_slug}}


program testapp
  use fortuno_serial, only : execute_serial_cmd_app
  use test_{{cookiecutter.project_slug}}, only : tests
  implicit none

  call execute_serial_cmd_app(tests())

end program testapp
