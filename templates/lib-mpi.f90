module {{cookiecutter.project_slug}}
  use mpi_f08, only : MPI_Bcast, MPI_Comm, MPI_COMM_WORLD, MPI_INTEGER
  implicit none

  private
  public :: broadcast

contains


  !> Broadcasts a scalar integer
  subroutine broadcast(comm, buffer, source)

    !> MPI communicator to use
    type(MPI_Comm), intent(in) :: comm

    !> Item to broadcast
    integer, intent(inout) :: buffer

    !> Source rank (default = 0)
    integer, optional, intent(in) :: source

    integer :: source_

    if (present(source)) then
      source_ = source
    else
      source_ = 0
    end if
    call MPI_Bcast(buffer, 1, MPI_INTEGER, source_, comm)

  end subroutine broadcast

end module {{cookiecutter.project_slug}}
