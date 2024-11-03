do i=1,20000
call random_number(u)
k=u*100
open(6,file='rnd.dat')
write(6,'(I2)') k
end do
end
