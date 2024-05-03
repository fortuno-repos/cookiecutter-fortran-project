program testapp
  use {{cookiecutter.project_slug}}, only : factorial
  use fortuno_serial, only : execute_serial_cmd_app, is_equal, test => serial_case_item,&
      & check => serial_check
  implicit none

  call execute_serial_cmd_app(&
      testitems=[&
          test("factorial_0", test_factorial_0),&
          test("factorial_1", test_factorial_1),&
          test("factorial_2", test_factorial_2)&
      ]&
  )

contains

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

end program testapp
