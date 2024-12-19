!!
          Gestaltenwandel GSW
                (Neu)

            (c)1992/2017
                  by

         Dietmar G. Schrausser
!!
a=255
DIM x[2]
x[1]=1
x[2]=20
GR.OPEN a,a,a,a,0,1
GR.SCREEN w,h
m0:
x=0
GR.COLOR 115,x,x,x,0
GR.SET.STROKE 4
x1=RND()*w
x0=x1
y1=RND()*h
y0=y1
FOR i=1 TO ROUND(RND()*8)+2
 x2=RND()*w
 y2=RND()*h
 GR.LINE n,x1,y1,x2,y2
 GR.RENDER
 VIBRATE x[],-1
 x1=x2
 y1=y2
NEXT i
GR.LINE n,x1,y1,x0,y0
GR.RENDER
PAUSE 1000
GR.CLS
GOTO m0
ONBACKKEY:
GOSUB fin
END
fin:
PRINT"Gestaltenwandel GSW (Neu)"
PRINT"(c)1992/2017 by Dietmar G. Schrausser"
RETURN
