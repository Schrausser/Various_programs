!!
      Tetraederparameterverhältnisse
              bei Höhe O(T)
       © 2018 by Dietmar Schrausser
!!
INCLUDE strg.txt
mn$=CHR$(8722)
CONSOLE.TITLE "Tetraeder Verhältnisse bei O(T)=1"

s=(1/3)^(1/4)
o=1
rem v=(139968)^(-1/4) 
v=(27*72^2)^(-1/4)
h=(4/27)^(1/4)

ht$=FORMAT$("#.#####",1/h)
vt$=FORMAT$("#.#####",1/v^(1/3))
st$=FORMAT$("#.#####",1/s)

IF o=1
 PRINT"Gegeben sei"
 PRINT "O =";FORMAT$("#",o);mn$;h2$
 PRINT "wobei"
 PRINT "    4 4"+_lf$+"h =  "+v$+ms$+ms$;" =    ";FORMAT$("#.#####",h);" =";ht$;mn$;h1$+_lf$;"      27"
 PRINT "    4 1"+_lf$+"s =  "+v$+ms$;" =     ";FORMAT$("#.#####",s);" =";st$;mn$;h1$+_lf$;"      3"
 PRINT "   -4 ______"+_lf$+"V =  "+v$+"27 72";h2$;" =";FORMAT$("#.#####",v);" =";vt$;mn$;h3$

ELSE

 PRINT s,1/s
 PRINT o,1/o
 PRINT v,1/v
 PRINT h,1/h

ENDIF

PRINT
PRINT"TetraO "+_cr$+" 2018 by Dietmar Schrausser"


DO:UNTIL 0
ONBACKKEY:
ONCONSOLETOUCH:
IF ##$="r": RUN ptb$+"tetrav1.bas","r"
 GOTO
ELSE
 END
ENDIF
