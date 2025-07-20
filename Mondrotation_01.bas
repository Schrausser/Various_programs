!!
            Erde-Mond Rotation 
      © 2020-25 by Dietmar Schrausser

!!

scr=0
GR.OPEN 255,scr,scr,scr,0,1
GR.SCREEN sx,sy
mx=sx/2:my=sy/2

GR.TEXT.BOLD 1
GR.TEXT.SIZE sx/35

cc=255
ed=sx/1000                  % Vergrößerungsfaktor

v=1                         %Mond Rotationsgeschwindigkeit
w=27.2                        %Erdtage
w2=(27.2/365.25)              %Erdjahre

i=0
i1=0
i2=0
j=0
jx=2020

sw=1                       %Darstellungsschalter
GR.CLS
GR.TEXT.SETFONT "courier","",1

DO
 st:
 i=i+v*((27.2-1)/365.25)+v    %Mondrotation
 i1=i1+w                    %Erdrotation Tag
 i2=i2+w2                   %Jahresrotation

 GR.CLS

!!
ERDE
!!
 GR.COLOR 255, 100, 100, 255, 0
 gr=ed*(6.378)                      %Erdradius
 IF gr<1 THEN gr=1
 GR.CIRCLE sn,mx,my,gr*1.005        %Erde
 GR.ROTATE.START 360-i2,mx,my       %1 Jahr
 GR.COLOR 255,100,100,255,1
 GR.ARC ar, mx-gr,my-gr,mx+gr,my+gr,270,180,1
 IF sw=1
  GR.COLOR 100, 100, 100, 100, 0
  GR.LINE ln,mx,my,mx+384*ed,my
 ENDIF
 GR.ROTATE.END
 GR.ROTATE.START 180-i1,mx,my       %1 Tagrotation
 GR.COLOR 150,255,255,255,1
 gr=ed*1.738
 IF gr<1 THEN gr=1
 GR.CIRCLE cl,mx-5*ed,my,gr         %Erdrotation
 GR.ROTATE.END

!!
UMLAUFBAHN
!!
 IF sw=1
  GR.COLOR 100, 100, 100, 100, 0
  GR.CIRCLE sn,mx,my, ed*384
 ENDIF

!!
MOND
!!
 gr=ed*1.738                        %Mondradius
 GR.COLOR 200,255,255,255,1
 IF gr<1
  grsw=gr
  gr=1
  GR.COLOR 130,255,255,255,1
 ENDIF
 IF grsw < 0.7
  GR.COLOR 100,155,155,155,1
 ENDIF
 grsw=1
 GR.ROTATE.START -180-i,mx,my       %27.2t Rotation
 GR.CIRCLE cl,mx-ed*384,my,gr       %Mond
 GR.COLOR 100, 100, 100, 100, 0
 IF gr>=1 & sw=1
  GR.LINE ln,mx-ed*384,my-30*ed, mx-ed*384,my+30*ed
 ENDIF
 GR.ROTATE.END 

!!
Beschriftung
!!
 jc=i-j*360
 IF jc>=360
  j=j+1
  jx=jx+1
 ENDIF

 IF sw=1
  tg=i1/360+1
  GR.COLOR 155,255,255,255,1
  GR.TEXT.ALIGN 1
  GR.TEXT.DRAW txt,0,sy/100,"T="+INT$(tg)

  jr= (i1/360)/365+1
  GR.COLOR 155,255,255,255,1
  GR.TEXT.ALIGN 3
  GR.TEXT.DRAW txt,sx,sy/100,"J="+INT$(jr)

  GR.COLOR 155,255,255,255,1
  GR.TEXT.ALIGN 1
  GR.TEXT.DRAW txt,0,sy,"M="+INT$(tg/27.2)

  mon=(((tg)/30)*1+1)
  IF mon>13
   DO
    mon=mon-12
   UNTIL mon<13
  ENDIF 

  IF mon<13 THEN mon$="Dez
  IF mon<12 THEN mon$="Nov
  IF mon<11 THEN mon$="Okt"
  IF mon<10 THEN mon$="Sep
  IF mon<9 THEN mon$="Aug"
  IF mon<8 THEN mon$="Jul
  IF mon<7 THEN mon$="Jun"
  IF mon<6 THEN mon$="Mai
  IF mon<5 THEN mon$="Apr"
  IF mon<4 THEN mon$="Mar
  IF mon<3 THEN mon$="Feb"
  IF mon<2 THEN mon$="Jan"

  GR.COLOR 155,255,255,255,1
  GR.TEXT.ALIGN 3
  GR.TEXT.DRAW txt,sx,sy-sy/1000,mon$
 ENDIF

 GR.TOUCH2 t2,tx,ty
 IF t2
  sw=sw*-1
 ENDIF

 GR.TOUCH tc,tx,ty
 IF tc
  IF ty<sy/3 THEN ed=ed/1.05
  IF ty>sy*2/3 THEN ed=ed*1.05
  IF ty<=sy*2/3 & ty>=sy/3
   IF tx<mx 
    v=v+0.1
    w=w+0.1*27.2
    w2=w2+0.1*(27.2/365.25)
   ENDIF
   IF tx>mx & v>=0
    v=v-0.1
    w=w-0.1*27.2
    w2=w2-0.1*(27.2/365.25)
   ENDIF
  ENDIF
 ENDIF

 GR.RENDER
!!
IF tg>28
 DO
 UNTIL 0
ENDIF
!!

UNTIL 0
ONBACKKEY:
GOSUB fin
END

fin:
PRINT "Erde-Mond Rotation © 2020 by Dietmar Schrausser"
RETURN 
