100  write (6,*) "Berechnungen in einem Rechteck", "Bitte die &
                  & Länge der ersten Seite angeben"

read  (5,*, end=200, err=200)  a
write (6,*) "Bitte die Länge der zweiten Seite angeben"
read  (5,*)  b

differenze = a - b , umfang = 2*a + 2*b , flaeche = a*b
diagonale = sqrt(a**2 + b**2)

write (6,*) "Die kantenlängen a und b sind: ", a , b ,
write (6,*) "Differenz Umfang Flaeche und Diagonale:" ,        &
            & differenze , umfang , flaeche , diagonale

go to 100
200  stop
end
