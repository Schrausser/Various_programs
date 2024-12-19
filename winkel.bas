!! Winkel by D. G. Schrausser 2024
!!
INPUT "x°=...",x,45
a$=INT$(x)+"°="+FORMAT$("#.#################",TORADIANS(x))+"rad"
PRINT a$
x1=x
x=TORADIANS(x)
PRINT "sin(";x1;"°)=";FORMAT$("#.################",SIN(x))
PRINT "cos(";x1;"°)=";FORMAT$("#.################",COS(x))
a=(SIN(x)^2+COS(x)^2)^0.5
PRINT "a=";FORMAT$("#.################",a)
!!
PRINT ATAN(x)
!!

PRINT "|x|=";FORMAT$("#.################",1/SIN(x))
!!end
