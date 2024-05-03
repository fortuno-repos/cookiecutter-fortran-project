program export_test
  use testcmakeserial, only : factorial
  implicit none

  write(*, "(a, i0)") "Factorial of 10 = ", factorial(10)

end program export_test
