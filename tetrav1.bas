!!
      Tetraederparameterverhältnisse 
              bei Volumen V(T) 
       © 2018 by Dietmar Schrausser
!!
INCLUDE strg.txt
mn$=CHR$(8722)
CONSOLE.TITLE "Tetraeder Verhältnisse bei V(T)"

s=72^(1/6)
rem o=139968^(1/6)
o=(27*72^2)^(1/6)
v=1
!!
h=455.1111111111111111^(1/12)
!!
h=(64/3)^(1/6)

ot$=FORMAT$("#.#####",1/o^(1/2))
st$=FORMAT$("#.#####",1/s)
ht$=FORMAT$("#.#####",1/h) 

IF v=1

 PRINT"Bei gegebenem Volumen"
 PRINT "V =";FORMAT$("#",v);mn$;h3$
 PRINT "errechnet sich"
 PRINT "    6 ______"+_lf$+"O =  "v$+"27 72";h2$;" =";FORMAT$("#.#####",o);" =";ot$;mn$;h2$ 
 PRINT "    6    _"+_lf$+"h =  ";v$+"21.3 =  ";FORMAT$("#.#####",h);" =";ht$;mn$;h1$  
 PRINT "    6"+_lf$+"s =  "v$+"72 =    ";FORMAT$("#.#####",s);" =";st$;mn$;h1$   

ELSE

 PRINT s,1/s
 PRINT o,1/o
 PRINT v,1/v
 PRINT h,1/h

ENDIF

PRINT
PRINT"TetraV "+_cr$+" 2018 by Dietmar Schrausser"
END
