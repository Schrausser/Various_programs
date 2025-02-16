REM // Halb-Kugel bei O(K)=π
REM // Volumen Integral ∬f(xy)dxdy
REM // von Dietmar Schrausser © 2017/2025

INCLUDE strg.txt
CONSOLE.TITLE"Halb-Kugel Volumen Integral "+jj$

REM ////////////////
pi= PI()
d= 1/200
REM ////////////////
z1=0:z0=0

FOR x=-0.207106781186 TO 1+0.207106781186+d STEP d
 FOR y=-0.207106781186 TO 1+0.207106781186+d STEP d
  z=(x-x^2+y-y^2)
  IF z>=0 
   v=(z^0.5)*d
   z1=z1+v 
  ENDIF
 NEXT y
 z0=z0+z1*d
 z1=0
 CLS
 PRINT "d: 1/" 1/d
 PRINT "      ";FORMAT$("%.####",x);_lf$+"V(HK) = "+jj$+"f(xy)dxdy = ";z0;_lf$+"      1-"+v$+"0.5-0.5"
NEXT x

PAUSE 200
CLS

PRINT "d: 1/" 1/d
PRINT "      1+"+v$+"0.5-0.5";_lf$+"V(HK) = "+jj$+"f(xy)dxdy = ";z0;_lf$+"      1-"+v$+"0.5-0.5"

PRINT "V(K) = 2"+jj$+"f(xy) = " z0*2
PRINT "wobei"
PRINT "f(xy) = "+v$+"(x-x"+h2$+"+y-y"+h2$+")"
vk=(2^0.5/3)*pi
PRINT "           "+v$+"2"+_lf$+"mit V(K) = "+ms$+ms$+" ";pi$+" = ";vk;_lf$+"           3"

PRINT "bei d(K) = "+v$+"2 und O(K) = "pi$

PRINT""
!!
r1=((2*z0)/((4/3)*pi))^(1/3)
r2=((2*z0)/((4/3)*(6362/2025)))^(1/3)
PRINT "d1^2(pi[approx]) = " (2*r1)^2
PRINT "d2^2(pi[exact] ) = " (2*r2)^2
O1 = (4*pi*r1^2)
O2 = (4*(6362/2025)*r2^2)
PRINT "O1(HK)/2 = " O1/2
PRINT "O2(HK)/2 = " O2/2
PRINT "O2(HK)-O1(HK) = " O2-O1
!!
CONSOLE.SAVE "vII_hk_opi.txt
PRINT "Halb-Kugel Volumen Integral "+jj$+_lf$+_cr$+" 2025 by Dietmar Schrausser"

DO:UNTIL 0
ONBACKKEY:
ONCONSOLETOUCH:
IF ##$="r": RUN ptb$+"kugelraum_1.bas","r"
 GOTO
ELSE
 END
ENDIF
