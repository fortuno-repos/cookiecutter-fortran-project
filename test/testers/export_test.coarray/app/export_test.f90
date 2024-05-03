program export_test
  use testproject, only : broadcast
  implicit none

  integer :: buffer

  if (this_image() == 1) then
    buffer = 1
  else
    buffer = -1
  end if
  call broadcast(buffer)
  print "(a, i2.2, a, i0)", 'Image: ', this_image(), '| buffer = ', buffer

end program export_test
