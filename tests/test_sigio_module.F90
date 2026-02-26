program test_sigio_module
  use sigio_module
  implicit none
  if (sizeof(sigio_intfill) .ne. 4) stop 1
  if (sizeof(sigio_realfill) .ne. 4) stop 2
  if (sizeof(sigio_dblefill) .ne. 8) stop 3
end program test_sigio_module
