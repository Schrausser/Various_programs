real :: x, y
a=2.0
4 do
write(6,'("ld von ")')
read(5,*,err=4) x
2 y=2**a
if (x.eq.0) go to 3
if (anint(x*100).eq.anint(y*100)) go to 1
if (y.lt.x) a=a+0.5
if (y.gt.x) a=a-0.3
go to 2
1 write(6,*)  a
end do
3 end 
