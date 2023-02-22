open (10, file="probe.cmd")
do i=1,20
write(10,100) i
end do
100 format('fi n06_24_',I2,'.dat')
end
