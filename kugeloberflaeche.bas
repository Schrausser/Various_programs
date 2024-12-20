REM // Kugel Oberflaechen Integral
REM //     ∫∮∫f(xyz)dxdydz=π
REM // 
REM // von Dietmar Schrausser 
REM //     © 2016/2018/2024

INCLUDE strg.txt

CONSOLE.TITLE"Kugel Oberflächen Integral "+j$+f$+j$ 

REM ////////////
d=(1/((6362/2025)-PI()))^(1/2)
d=d*1
d=100
REM ////////////

c=1/d
c1=1/d^2 %% Oberflächen d
z=0
z1=0
sw=0

GOSUB inf

FOR x=-0.25 TO 1.3 STEP 1/d
 FOR y=-0.25 TO 1.3 STEP 1/d
  a=(x-x^2+y-y^2)
  IF a>0 THEN a=a^0.5
  b=(x-x^2+(y+c1)-(y+c1)^2) 
  IF b>0 THEN b=b^0.5

  a1=((x+c1)-(x+c1)^2+y-y^2)
  IF a1>0 THEN a1=a1^0.5
  b1=(x-x^2+y-y^2) 
  IF b1>0 THEN b1=b1^0.5

  IF a>0 | b>0 THEN 
   z=z+((a-b)^2+c^2)^0.5 * ((a1-b1)^2+c^2)^0.5
   sw=1
  ENDIF
 NEXT y
 IF sw=1
  z1=z1+z
  z=0
  sw=0
 ENDIF
 GOSUB inf
NEXT x  

PAUSE 50
GOSUB inf

PRINT "wobei"
PRINT j$+f$+j$+"dxdydz = 2 "+f$+f$+v$+"(x-x"+h2$+"+y-y"+h2$+")"

ONBACKKEY:
PRINT
PRINT "Kugel Oberflächen Integral " +j$+f$+j$+" zu "+pi$_lf$+_cr$+" 2024 by Dietmar Schrausser" 
END

inf:
CLS
IF d=(1/((6362/2025)-PI()))^(1/2)
 PRINT "d: "+v$+oo$
ELSE 
 PRINT "d: 1/"d
ENDIF
PRINT "   ";FORMAT$("%.####",x);_lf$+pi$+" = "+j$+f$+j$"f(xyz)dxdydz = "; 2*z1;_lf$+"   - 0.25"
RETURN

%% END
%%
