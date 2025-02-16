REM // Halb-Kugel bei d(K)=1
REM // Volumen Integral ∬f(xy)dxdy
REM // von Dietmar Schrausser (c) 2017/2024

INCLUDE strg.txt
CONSOLE.TITLE"Halb-Kugel Volumen Integral "+jj$

REM ////////////////
pi= PI()
d= 1/200
REM ////////////////
z1=0:z0=0

FOR x=-1 TO 1+d STEP d
 FOR y=-1 TO 1+d STEP d
  z=((1-x^2-y^2))
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
 PRINT "      - 1"
NEXT x

PAUSE 200
CLS

PRINT "d: 1/" 1/d
PRINT "        1"
PRINT "V(HK) = "+jj$+"f(xy)dxdy = " z0
PRINT "      - 1"

PRINT "V(K) = 2"+jj$+"f(xy) = " z0*2
PRINT "wobei"
PRINT "f(xy) = "+v$+"(1-x"+h2$+"-y"+h2$+")"
vk=4/3*pi
PRINT "mit V(K) = 4/3"+pi$+" = " vk 
PRINT "bei d(K) = 1 und O(K) = 4"pi$
PRINT""
CONSOLE.SAVE "vII_hk_d1.txt"
ONBACKKEY:
PRINT "Halb-Kugel Volumen Integral "+jj$+_lf$+_cr$+" 2024 by Dietmar Schrausser"
END
