REM // Unendlichkeitsschwellenwert z(oo)
REM // der Normalverteilungsfunktion f(z)
REM // von Dietmar Schrausser (c)2016

e= 2.7182539682539684
pi=PI()
piexact=6362/2025
o=piexact-pi

PRINT "Unendlichkeitsschwellenwert z(oo) zu f(z)"
PRINT "bei e = " e
PRINT "und pi[exact]-pi = 1/oo
PRINT "       = " o

FOR i=3.996473880624324 TO 4 STEP 1/1000000000000000000
 x= (1/(2*pi)^0.5)*e^-(i^2/2)
 IF x <= o THEN
  PRINT "z(oo):   " i
  PRINT "dz(oo):  " x
  PRINT "diff =   " o-x
  END
 ENDIF
NEXT i
END
