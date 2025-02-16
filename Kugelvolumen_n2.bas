REM // Halb-Kugel bei d(K)=2√2
REM // Volumen Integral ∬f(xy)dxdy
REM // von Dietmar Schrausser (c) 2025

INCLUDE strg.txt
CONSOLE.TITLE"Halb-Kugel Volumen Integral "+jj$

REM ////////////////
pi= PI()
d= 1/200
REM ////////////////
z1=0:z0=0
a=SQR(2)

FOR x=-a TO a+d STEP d
 FOR y=-a TO a+d STEP d
  z=((1-x^2)+(1-y^2))
  IF z>=0 
   v=(z^0.5)*d
   z1=z1+v 
  ENDIF
 NEXT y
 z0=z0+z1*d
 z1=0
 CLS
 PRINT "d: 1/" 1/d
 PRINT "      ";:PRINT FORMAT$("%.####",x)
 PRINT "V(HK) = "+jj$+"f(xy)dxdy = " z0
 PRINT "      - "+v$+"2"
NEXT x

PAUSE 200
CLS

PRINT "d: 1/" 1/d
PRINT "        "+v$+"2"
PRINT "V(HK) = "+jj$+"f(xy)dxdy = " z0
PRINT "      - "+v$+"2"

PRINT "V(K) = 2"+jj$+"f(xy) = " z0*2
PRINT "wobei"
PRINT "f(xy) = "+v$+"(1-x"+h2$+")+(1-y"+h2$+")"
vk=8/3*pi*SQR(2)
PRINT "mit V(K) = 8/3"+pi$+v$"2 = " vk 
PRINT "bei d(K) = 2"+v$+"2 und O(K) = 8"pi$
PRINT""
CONSOLE.SAVE "vII_hk_d1.txt"
ONBACKKEY:
PRINT "Halb-Kugel Volumen Integral "+jj$+_lf$+_cr$+" 2025 by Dietmar Schrausser"
END
