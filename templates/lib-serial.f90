module {{cookiecutter.project_slug}}
  implicit none

  private
  public :: factorial

contains

  !> Calculates the factorial of a number.
  function factorial(nn) result(fact)

    !> number to calculate the factorial of
    integer, intent(in) :: nn

    !> factorial (note, there is no check made for integer overflow!)
    integer :: fact

    integer :: ii

    fact = 1
    do ii = 2, nn
      fact = fact * ii
    end do

  end function factorial

end module {{cookiecutter.project_slug}}
