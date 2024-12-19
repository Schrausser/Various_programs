!!
                GR_0041
  
       © 2020 by Dietmar Schrausser
!!

c=255

GR.OPEN c,c,c,c,0,1
GR.SCREEN sx,sy
mx=sx/2:my=sy/2

r=0

st: %Start

GR.COLOR c,0,0,0,0

GR.CLS

GR.TEXT.ALIGN 1
GR.TEXT.SIZE 12
GR.TEXT.DRAW tx,2,10,"GR_0041"

GR.COLOR c/2,0,0,0,1
GR.ROTATE.START -4,mx,my
GR.CIRCLE cl,mx,my,6

GR.COLOR c/2,0,0,0,0
GR.LINE ln, mx,my-120,mx,my+120

GR.ROTATE.START 0,mx,my
!FOR a=0 TO 100 STEP 0
GR.OVAL ov, mx-100+a,my-100*SIN(TORADIANS(5))+a,mx+100-a,my+100*SIN(TORADIANS(5))+a
GR.COLOR c/2,0,0,0,0
GR.ROTATE.START -3,mx,my
GR.OVAL ov, mx-35+a,my-35*SIN(TORADIANS(5))+a,mx+35-a,my+35*SIN(TORADIANS(5))+a
GR.ROTATE.END
!NEXT

GR.ROTATE.END

GR.COLOR c/8,0,0,0,0

rr=TORADIANS(90)
GR.OVAL ov, mx-100*SIN(rr),my-100,mx+100*SIN(rr),my+100

rr=TORADIANS(70)
GR.OVAL ov, mx-100*SIN(rr),my-100,mx+100*SIN(rr),my+100

rr=TORADIANS(50)
GR.OVAL ov, mx-100*SIN(rr),my-100,mx+100*SIN(rr),my+100

rr=TORADIANS(30)
GR.OVAL ov, mx-100*SIN(rr),my-100,mx+100*SIN(rr),my+100

rr=TORADIANS(10)
GR.OVAL ov, mx-100*SIN(rr),my-100,mx+100*SIN(rr),my+100

GR.COLOR c/2,0,0,0,0

rr=TORADIANS(r-90)
GR.OVAL ov, mx-100*SIN(rr),my-100,mx+100*SIN(rr),my+100

GR.ROTATE.END

GR.RENDER

!!
DO
UNTIL 0
!!

r=r+1

GOTO st

ONBACKKEY:
GOSUB fin

END

fin:
PRINT"GR_0041 © 2020 by Dietmar Schrausser"
RETURN 
