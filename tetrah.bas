!!
      Tetraederparameterverhältnisse
              bei Höhe h(T)
       © 2018 by Dietmar Schrausser
!!
INCLUDE strg.txt
mn$=CHR$(8722)
CONSOLE.TITLE "Tetraeder Verhältnisse bei h(T)=1"

s=(3/2)^(1/2)
o=(((2^3)^(2^2))/3^2)^(-1/2^2)
!!
o=(8^4/9)^(-1/4)
o=(4096/9)^(-1/4) 
!!
o=(455.1111111111)^(-1/4)
v=(27/4)^(1/2)
h=1

ot$=FORMAT$("#.#####",1/o^(1/2))
vt$=FORMAT$("#.#####",1/v^(1/3))
st$=FORMAT$("#.#####",1/s)

IF h=1
 PRINT"Bei gegebener Tetraederhöhe"
 PRINT "h =";FORMAT$("#",h);mn$;h1$
 PRINT "resultiert"
 PRINT "   -4    _"+_lf$+"O = "+v$+"455.1";" =";FORMAT$("#.#####",o);" =";ot$;mn$;h2$
 PRINT "     27"+_lf$+"V = "+v$+ms$+ms$;" =   ";FORMAT$("#.#####",v);" =";vt$;mn$;h3$+_lf$;"     4"
PRINT "     3"+_lf$+"s = "+v$+ms$+" =    ";FORMAT$("#.#####",s);" =";st$;mn$;h1$+_lf$;"     2"

ELSE

 PRINT s,1/s
 PRINT o,1/o
 PRINT v,1/v
 PRINT h,1/h

ENDIF

PRINT
PRINT"Tetrah "+_cr$+" 2018 by Dietmar Schrausser"
END
