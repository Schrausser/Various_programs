real(kind(0.0D0)) :: pro
real :: qw,  zwert
!open(6,file='nvt.plo')
write(6,11)
do zwert= -3, 3, 0.2
qw= abs(zwert)
pro=qw*(0.0000380036+qw*(0.0000488906+qw*0.000005383))
pro=1+qw*(0.049867347+qw*(0.021141006+qw*0.0032776263+pro))
pro=0.5*(pro**(-16))
i= 80*pro
write(6,12) zwert, ('Û', j=1,i)
end do
write(6,15)
11 format (6x,'Ú',44('Ä'),'¿')
12 format (f4.1,'  ³',40a,3x,'³')
15 format (6x,'À',44('Ä'),'Ù')
end


