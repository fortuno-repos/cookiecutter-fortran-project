module {{cookiecutter.project_slug}}
  implicit none

  private
  public :: broadcast

contains


  !> Broadcasts a scalar integer.
  subroutine broadcast(buffer, source)

    !> Buffer to broadcast
    integer, intent(inout) :: buffer

    !> Source image (default 1)
    integer, optional, intent(in) :: source

    integer :: source_

    if (present(source)) then
      source_ = source
    else
      source_ = 1
    end if

    call co_broadcast(buffer, source_)

  end subroutine broadcast

end module {{cookiecutter.project_slug}}
