!!
               Mondphasen_02c
  
       © 2020 by Dietmar Schrausser
!!

c=255

GR.OPEN c,0,0,0,0,1
GR.SCREEN sx,sy
mx=sx/2:my=sy/2

sc2=29.53
sc3=27.3217
corr=3
corr1=3

eg=17 *corr                           %Erdgrösse

mpos=0 %Mondposition
mrpos=0 %Mondrotationsposition

mi=0


zlr=0
zlr1=0

v=0.5
sw=1
vsim=1

st:                                    %Start
GR.CLS

GR.COLOR c/8,c,c,0,0
GR.CIRCLE cl,mx,my,150*corr            %Sonnenbahn
arc3= (-mi/24)/365.25*360
GR.ROTATE.START arc3-180,mx,my
GR.COLOR c,c,c,0,1 
GR.CIRCLE cl,mx-150*corr,my,6*corr          %Sonne
GR.COLOR c,c,c-50,0,0 
GR.CIRCLE cl,mx-150*corr,my,6*corr          %
GR.COLOR c/8,c,c,0,0
GR.LINE ln,mx-eg,my,mx-145*corr,my
GR.LINE ln,mx,my-eg,mx,my+eg
GR.COLOR c,0,0,90,1
GR.ARC arc,mx-eg,my-eg,mx+eg,my+eg,90,-180,1
GR.COLOR c,210,210,c,1
GR.ARC arc,mx-eg,my-eg,mx+eg,my+eg,90,180,1
GR.COLOR c,0,0,0,0
GR.ROTATE.END
! %%%%%%%%%%%%%%%%% Tag %%%%%%%%%%%%%%%%

atj=mi/24

!!
    h
t = --
    24
!!
! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

GR.CIRCLE cl,mx,my,eg             %Erde
arc1=(-mi/24)*360
GR.ROTATE.START arc1+arc3,mx,my

GR.COLOR c,0,0,c,0
GR.LINE ln,mx,my,mx-eg-5,my
GR.ROTATE.END
! %%%%%%%%%%%%%%% Stunde %%%%%%%%%%%%%%

atx= mi-INT(atj)*24

!!
                 h
h(t) = h - ( int -- 24 )
                 24
!!
! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

GR.COLOR c/8,c,c,c,0
GR.CIRCLE cl,mx,my,80 *corr1             %Mondbahn
arc2=  -((mi/24)/sc2)*360
arc21= -((mi/24)/365.25)*360
GR.ROTATE.START arc2+arc21+mpos, mx,my

GR.COLOR c/8,c,c,c,0
GR.LINE ln,mx+15,my,mx+77,my

GR.COLOR c/8,0,0,0,0

! %%%%%%%%%%%%%%% Mondphase %%%%%%%%%%%%%%

atm= (mi/24)/sc2 + (mi/24)/365.25 -(mi/(24*27))*(2/(27+1/18))

!!
      h         h           h       2
m = ----- +  --------- - ( ----- -------- )
    24 sc2   24 365.25     24 27      1
                                 27 + --
                                      18
!!
! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
GR.ROTATE.START atm*360-90-180-mpos,mx+80*corr1,my

GR.COLOR c,c,c,c,1
GR.ARC arc,mx+80*corr1-10*corr,my-10*corr,mx+80*corr1+10*corr,my+10*corr,0,-180,0

GR.COLOR c,0,0,0,0
GR.ARC arc,mx+80*corr1-10*corr,my-10*corr,mx+80*corr1+10*corr,my+10*corr,0,-180,0

GR.COLOR c,0,0,0,1
GR.ARC arc,mx+80*corr1-10*corr,my-10*corr,mx+80*corr1+10*corr,my+10*corr,0,180,0

GR.COLOR c-50,c,c,c,1
GR.ROTATE.START -atm*360-90+mpos,mx+80*corr1,my
GR.LINE ln,mx+80*corr1,my+13*corr,mx+80*corr1,my-13*corr

GR.COLOR c/2,0,0,0,1

GR.ARC arc,mx+80*corr1-13*corr,my-13*corr,mx+80*corr1+13*corr,my+13*corr,-90,180,1

GR.ROTATE.END
GR.ROTATE.END
GR.ROTATE.END

! %%%%%%% Mondphase %%%%%%%
m=(atm-zlr1)*sc2+sc2*(mpos/360)

b=60
e=-269
d=800

IF m<=sc2/2
 sw=1
 r=180-180*(m/(sc2/2))
 r=r-90
ELSE
 sw=-1
 r=180-180*((m-(sc2/2))/(sc2/2))
 r=r-90
ENDIF

a=SIN(TORADIANS(r))
GR.ROTATE.START 180,mx-e,my-d
IF sw=1                                 %Zunehmend
 GR.COLOR c,c,c,c,1
 GR.CIRCLE cl,mx-e,my-d,b
 GR.COLOR c,0,0,0,0
 GR.CIRCLE cl,mx-e,my-d,b
 GR.COLOR c,0,0,0,1
 GR.ARC ar,mx-e-b,my-d-b,mx-e+b,my-d+b,-90,180,1
 GR.COLOR c,0,0,0,1
 GR.ARC ar,mx-e-b*a,my-d-b,mx-e+b*a,my-d+b,90,180,1
 IF r< 0
  GR.COLOR c,c,c,c,1
  GR.ARC ar,mx-e-b*(-a),my-d-b,mx-e+b*(-a),my-d+b,-90,180,1
 ENDIF
 GR.LINE ln, mx-e-0,my-d-b,mx-e-0,my-d+b
ENDIF

IF sw=-1                                %Abnehmend
 GR.COLOR c,0,0,0,1
 GR.CIRCLE cl,mx-e,my-d,b
 GR.COLOR c,c,c,c,1
 GR.ARC ar,mx-e-b,my-d-b,mx-e+b,my-d+b,-90,180,1
 GR.COLOR c,c,c,c,1
 GR.ARC ar,mx-e-b*a,my-d-b,mx-e+b*a,my-d+b,90,180,1
 IF r<0
  GR.COLOR c,0,0,0,1
  GR.ARC ar,mx-e-b*(-a),my-d-b,mx-e+b*(-a),my-d+b,-90,180,1
 ENDIF
 GR.LINE ln, mx-e-0,my-d-b,mx-e-0,my-d+b
 GR.LINE ln, mx-e+0,my-d-b,mx-e+0,my-d+b
 GR.LINE ln, mx-e+0,my-d-b,mx-e+0,my-d+b
ENDIF
GR.COLOR c,0,0,0,0
GR.CIRCLE cl,mx-e,my-d,b
GR.ROTATE.END

! %%% Mondphase

GR.COLOR 200,150,150,150
GR.TEXT.ALIGN 2
GR.TEXT.SIZE sx/20
GR.TEXT.DRAW tx,mx,sy-35,INT$(atj)+"t, "+INT$(atx)+"h"

GR.TEXT.ALIGN 3
GR.TEXT.SIZE sx/30

arcw=(atm-INT(atm))*360
IF arcw>180 THEN arcw=arcw-180
GR.TEXT.DRAW tx,sx,30,FORMAT$("##.##",atm)+"ph, "+INT$(arcw)+"°"

GR.TEXT.DRAW tx,sx-65,70,FORMAT$("##.##",atj/sc3)+"rt, "+INT$(-arc3-INT(atj/sc3)*360)+"°"

GR.TEXT.ALIGN 1
GR.TEXT.SIZE sx/25
GR.TEXT.DRAW tx,20,30,CHR$(8560)+" Mondrotation:"
GR.LINE ln, 2,37,sx-2,37

GR.COLOR c,c/2,c/2,c/2,0

GR.RENDER

IF vsim=0
 DO
  GR.TOUCH tc,tx,ty
 UNTIL tc
ENDIF

mi=mi+v
!!
IF atj>=sc2
 DO
 UNTIL0
ENDIF
!!
zlr=zlr+v
IF zlr>=sc2*24
 zlr=0
 zlr1=zlr1+1
ENDIF
GOTO st

ONBACKKEY:
GOSUB fin

END

fin:
PRINT"Mondphasen_02c © 2020 by Dietmar Schrausser"
RETURN 
