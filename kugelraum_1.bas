REM // Kugel bei d(K)=2
REM // Raum Integral ∫∫∫f(xyz)dxdydz
REM // von Dietmar Schrausser © 2017/2024

INCLUDE strg.txt
CONSOLE.TITLE" Kugel Raum Integral "+j$+j$+j$

REM ////////////////
pi= PI()
d= 1/50
REM ////////////////
z1=0:z0=0

FOR x=-1 TO 1+d STEP d
 FOR y=-1 TO 1+d STEP d
  z= (1-x^2-y^2)
  w= (1-x^2-y^2)
  IF z>=0 
   v=(z^0.5)*d
   z1=z1+v 
  ENDIF
  IF w>=0 
   u=-(w^0.5)*d
   z1=z1-u
  ENDIF
 NEXT y
 z0=z0+z1*d
 z1=0
 z0$=FORMAT$("%.#############",z0)
 CLS
 PRINT "d: 1/" ;1/d
 PRINT "      ";FORMAT$("%.####",x);_lf$+"V(K) = "+j$+j$+j$+"f(xyz)dxdydz ="; z0$;_lf$+"      - 1"
NEXT x

PAUSE 50

PRINT "d: 1/" ;1/d
PRINT "      ";FORMAT$("%.####",x);_lf$+"V(K) = "+j$+j$+j$+"f(xyz)dxdydz ="; z0$;_lf$+"      - 1"

PRINT "wobei"
PRINT j$+j$+j$+"dxdydz = "+jj$+v$+"(1-x"+h2$+"-y"+h2$+") - "+jj$+"-"+v$+"(1-x"+h2$+"-y"+h2$+")"
vk=4/3*pi
PRINT "           4"+_lf$+"mit V(K) = "+ms$+ms$+" = " ;vk;_lf$+"           3"+pi$
PRINT "bei d(K) = 2 und O(K) = 4"pi$
PRINT""
CONSOLE.SAVE "rIII_k_d1.txt"
ONBACKKEY:
PRINT "Kugel Raum Integral "+j$+j$+j$+_lf$+_cr$+" 2024 by Dietmar Schrausser"
END 
