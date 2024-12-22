REM // Unendlichkeitsschwellenwert z∞
REM // der Normalverteilungsfunktion f(z)
REM // von Dietmar Schrausser © 2017

INCLUDE strg.txt
CONSOLE.TITLE"Unendlichkeitsschwellenwert z"+oo$

e= EXP(1) 
pi=PI()
piexact=6362/2025
o=piexact-pi

PRINT "Unendlichkeitsschwellenwert z"+oo$+" zur Standard Normalverteilungs Dichtefunktion f(z),"
PRINT"bei"
PRINT "               1   -(z"+h2$+"/2)"+_lf$+CHR$(977)+"(z) = f(z) = "+ms$+ms$+ms$+" e"+_lf$+"              "+v$+"2"+pi$+"
!!
PRINT "bei e = " e
PRINT "und "+pi$+"[exact]-"+pi$+" = 1/"+oo$+" = " o
!!

FOR i=3.99645340048 TO 4 STEP 1/1000000000000000
 x= (1/(2*pi)^0.5)*e^-(i^2/2)
 IF x <= o THEN
  PRINT "z"+oo$+" = " i
  PRINT"zum Dichtewert"
  PRINT CHR$(977)+"(z"+oo$+") = " x
  PRINT "mit"
  PRINT " 1/"+oo$+_lf$+ms$+ms$+ms$+ms$+ms$+  " = " ;o/x;_lf$+ CHR$(977)+"(z"+oo$+")"
  GOTO m1
 ENDIF
NEXT i
m1:
PRINT""
ONBACKKEY:
PRINT "z"+oo$+" bei f(z)"+_lf$+_cr$+" 2017 by Dietmar Schrausser"
END
