character*30 :: dummy(3)
character*80 :: data(26)
character :: eingabe*12, ausgabe*12, weiter

10 write(6,*) '**** Eingabedatei:'
read(5,*) eingabe
write(6,*) '**** Ausgabedatei:'
read(5,*) ausgabe
open(7, file=eingabe)
open(8, file=ausgabe)
read(7,100) (dummy(i),i=1,3)

loop: do k=1,30
      read(7,110) (data(j),j=1,26)
      write(8,120) data(16)(68:73), data(17)(68:73), data(20)(68:73), data(23)(68:73)
end do loop
write(6,*) '**** OK'
write(6,*) '**** weiter(j/n) ?'
read(5,*) weiter
close(7)
close(8)
if (weiter.eq.'j') go to 10

100 format(A30)
110 format(A80)
120 format(A6,1X,A6,1X,A6,1X,A6)
end
