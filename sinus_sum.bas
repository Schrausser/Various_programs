REM // SINUS Summation
REM // von Dietmar Schrausser © 2017

INCLUDE strg.txt
CONSOLE.TITLE"SINUS Summation "+E$

REM /////////////
oo = 9
x=6362/2025
REM /////////////

y=0
fc=1
FOR k = 0 TO oo
 FOR i=1 TO (2*k+1): fc=fc*i: NEXT
 y=y+ (((-1)^k)/fc)*x^(2*k+1):fc=1
NEXT 
PRINT "x = ";x;"rad"
PRINT "        "+oo$+" = ";oo;_lf$+"sin(x) ="+e$+"f(X) = ";y;_lf$+"        0"

wk= INT(TODEGREES(x)*100)/100
PRINT "Winkel = ";wk;gd$
PRINT "wobei"
PRINT "             k"+_lf$+"         (-1)    2k+1"+_lf$+"f(X) =  "+ms$+ms$+ms$+ms$+ms$+ms$+ms$+" x"+_lf$+"        (2k+1)!"

REM ONBACKKEY:
PRINT ""
PRINT "Sinus Summation"+_lf$+_cr$+" 2017 by Dietmar Schrausser"

DO:UNTIL 0
ONBACKKEY:
ONCONSOLETOUCH:
IF ##$="r": RUN ptb$+"oo.bas","r"
 GOTO
ELSE
 END
ENDIF
