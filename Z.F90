real(kind(0.0D0) :: qw, zwert, prozent
do
1 write(6,*) "z?"
read(5,*,err=1) zwert
if(zwert.eq.0) go to 2
qw=abs(zwert)
prozent=qw*(0.0000380036+qw*(0.0000488906+qw*0.000005383))
prozent=1+qw*(0.049867347+qw*(0.021141006+qw*0.0032776263+prozent)))
prozent=0.5*(prozent**(-16))
if(zwert.lt.0) prozent=1-prozent
write(6,*) "p= ", prozent
2 end do
end

