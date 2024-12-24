!!
          C O L O R   S C R E E N

            
                 B  l
                  : ..R
                t  :
                   G  g



           Copyright (c) MMXVII

                    by

           Dietmar G. SCHRAUSSER
!!

INCLUDE strg.txt

GR.OPEN 255,0,0,0,0,1
GR.SCREEN sx,sy
GR.TEXT.SIZE 10
INPUT"ColorScreen Size … [5|10|20|40|60|80...]",s,60
m0:
r=0:g=0:b=0
d1=(sy/sx)
c1=(s*d1)/2
m1:
FOR j=0 TO  sy STEP (s*d1)
 FOR i=0 TO sx STEP s
  r=r+255/(sx/s)
  IF r>255:r=0:g=g+255/(sx/s)
   IF g>255:g=0:b=b+255/(sx/s)
    IF b>255:b=0
    ENDIF
   ENDIF
  ENDIF
  GR.COLOR 255,r,g,b,1
  GR.RECT rc,i,j-c1,i+s,(j+s*d1)-c1
!!
  GR.COLOR 255,0,0,0,1
  GR.RECT dl,0,0,20,10
  GR.COLOR 255,255,255,255,1
  GR.TEXT.DRAW tx, 0,10,INT$(b)
!!
 NEXT
NEXT
GR.RENDER
IF b>=255 THEN GOTO m2
GR.CLS
GOTO m1
m2:
!!
DO
 GR.TOUCH tc,tx,ty
UNTIL tc
!!
GOTO m0
ONBACKKEY:
GOSUB fin
END

fin:
PRINT"ColorScreen "+_cr$+" 2017 by Dietmar Schrausser"
RETURN
