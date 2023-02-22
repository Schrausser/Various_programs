real :: n(100) , m
open(7,file="rnd.dat")
write(6,*) 'seed und m bitte'
read(5,*) n(1), m
do i=1,99
n(i+1)=modulo(4*n(i)+30,m)
n(i)=n(i)/m
write(7,*) n(i)
end do
end
