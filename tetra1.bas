!!
      Tetraederparameterverhältnisse
       © 2018 by Dietmar Schrausser
!!
INCLUDE strg.txt
mn$=CHR$(8722)
CONSOLE.TITLE "Tetraeder Verhältnisse"

s=1
o=( 3^(1/2) )* s^2
v=( 2^(1/2)/(2^2*3) )* s^3
h=( (2*3)^(1/2)/3 )* s
REM h=(1.5)^-(1/2)

ot$=FORMAT$("#.#####",1/o^(1/2))
vt$=FORMAT$("#.#####",1/v^(1/3))
ht$=FORMAT$("#.#####",1/h)

IF s=1
 PRINT"Bei gegebener Seitenlänge"
 PRINT "s =";FORMAT$("#",s);mn$;h1$
 PRINT "errechnet man"
 PRINT "     ___     _"+_lf$+"    "+v$+"2 3    "+v$+"6     2       _" +_lf$+"h = "+ms$+ms$+ms$+ms$+ " = "+ms$+ms$+ms$+ms$+" = ";v$+"";ms$;" =  ";v$;"0.6 =   ";ht$;mn$+h1$;_lf$+"      3      3     3"
 PRINT "                         _"+_lf$+"O =                     "+v$+"3 =     ";ot$;mn$;h2$ 
 PRINT "      _      _ "+_lf$+ "     "+v$+"2     "+v$+"2     1          _"+_lf$+"V = "+ms$+ms$+ms$+ms$+" = "+ms$+ms$+ms$+ms$+" = ";v$;ms$;ms$;" = ";v$;"0.0138 =";vt$;mn$+ h3$+_lf$+"    2"+h2$+" 3    12     72"

ELSE

 PRINT s,1/s
 PRINT o,1/o
 PRINT v,1/v
 PRINT h,1/h

ENDIF

PRINT
PRINT"Tetra1 "+_cr$+" 2018 by Dietmar Schrausser"
END
