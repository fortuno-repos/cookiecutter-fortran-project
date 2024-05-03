program {{cookiecutter.project_slug}}_example
  use {{cookiecutter.project_slug}}, only: broadcast
  implicit none

  integer :: buffer

  if (this_image() == 1) then
    buffer = 1
  else
    buffer = -1
  end if

  call broadcast(buffer)

  print "(a, i2.2, a, i0)", 'Image: ', this_image(), '| buffer = ', buffer

end program {{cookiecutter.project_slug}}_example
