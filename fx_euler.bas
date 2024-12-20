REM // Euler e
REM // bei Unendlichkeitsgrenzwert ∞
REM // von Dietmar Schrausser © 2017

INCLUDE strg.txt

REM /////////////
oo = 7 % 7//5//3//4
n1= 7367% 48784//841//27//137
REM /////////////

INPUT oo$+" = [3|4|5|7|…]",oo,oo
INPUT "n = [27|137|841|48784|…]",n1,n1

x=0:m=1
FOR n=1 TO oo
 FOR y=1 TO n :m=m*y:NEXT
 x=x+ 1/m:m=1
NEXT n

PRINT "       "+oo$+" = ";oo;_lf$+"e"+oo$+" = 1+"+e$+"f(X) = ";1+x;_lf$+"       1"

e1=(1-1/n1)^-n1
PRINT"bei e"+oo$+" = f(X) = 1+X"
PRINT "und "
PRINT "e[n="+INT$(n1)+"] = " e1
PRINT "                -n"+_lf$+"bei e"+hn$+" = (1-1/n)"
PRINT""
REM PRINT "Q[en/e"+oo$+"] = " e1/(1+x)
PRINT"Q[e/e"oo$"] = " EXP(1)/(1+x)
PRINT"Q[e"+hn$+"/e] = " e1/EXP(1)
ONBACKKEY:
PRINT ""
PRINT "Euler e Summation bis "+oo$+_lf$+_cr$+" 2017 by Dietmar Schrausser"
END
