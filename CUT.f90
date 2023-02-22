! ********************************************************
! *         CUT (c)1996 by Dietmar Schrausser            *
! ********************************************************

character*80 :: zeile, ozeile
character :: eingabe*12
ozeile = '                                                            '
write(6,*) 'CUT (c)1996 by Dietmar Schrausser'
read(5,*) eingabe

open(7, file=eingabe)
open(8, file="aus.txt")
lp: do 
     read(7,110, err=11) zeile
     if (zeile(1:60).ne.ozeile(1:60)) then
         write(8,110) zeile
     end if
end do lp
11 close(7)
close(8)

110 format(A80)
end
