character*30 :: dummy
character*80 :: data(32)
character :: eingabe*15, ausgabe*15, weiter

10 write(6,*) '**** Eingabedatei:'
read(5,*) eingabe
write(6,*) '**** Ausgabedatei:'
read(5,*) ausgabe
open(7, file=eingabe)
open(8, file=ausgabe)
read(7,100) dummy

loop: do k=1,270
      read(7,110) (data(j),j=1,32)
      write(8,120) data(22)(74:78)
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
