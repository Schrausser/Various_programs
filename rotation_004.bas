!!
       © 2020 by Dietmar Schrausser
!!

c=255

GR.OPEN c,c,c,c,0,1
GR.SCREEN sx,sy
mx=sx/2:my=sy/2
GR.COLOR c,0,0,0,0
i=1
ed=60

st: %Start

GR.CLS

GR.TEXT.ALIGN 1
GR.TEXT.SIZE 12
GR.TEXT.DRAW tx,2,10,"Riesenrad"

GR.CIRCLE cl,mx,my,3
GR.CIRCLE cl,mx,my,70
GR.CIRCLE cl,mx,my,85
GR.LINE ln,mx,my,mx-30,my+130
GR.LINE ln,mx,my,mx+30,my+130

GR.ROTATE.START -i,mx,my
GR.COLOR 255,100,100,255
GR.CIRCLE cl,mx-ed,my-ed,1
GR.COLOR cc-65,cc,0,0,0
GR.ROTATE.START 180+i,mx-ed,my-ed
GR.LINE ln,mx-ed,my-ed,mx-ed,my-35-ed
GR.CIRCLE cl,mx-ed,my-ed-38,5
GR.CIRCLE cl,mx-ed,my-ed,3
GR.ROTATE.END
GR.LINE ln, mx-80,my-80,mx+80,my+80
GR.ROTATE.END

GR.ROTATE.START 180-i,mx,my
GR.COLOR 255,100,100,255
GR.CIRCLE cl,mx-ed,my-ed,1
GR.COLOR cc-65,cc,0,0,0
GR.ROTATE.START 180+i-(180),mx-ed,my-ed
GR.LINE ln,mx-ed,my-ed,mx-ed,my-35-ed
GR.CIRCLE cl,mx-ed,my-ed-38,5
GR.CIRCLE cl,mx-ed,my-ed,3
GR.ROTATE.END
GR.ROTATE.END

GR.ROTATE.START 90-i,mx,my
GR.COLOR 255,100,100,255
GR.CIRCLE cl,mx-ed,my-ed,1
GR.COLOR cc-65,cc,0,0,0
GR.ROTATE.START 180+i-90,mx-ed+10,my-ed+10
GR.LINE ln,mx-ed+10,my-ed+10,mx-ed+10,my-35-ed+10
GR.CIRCLE cl,mx-ed+10,my-ed+10-38,5
GR.CIRCLE cl,mx-ed+10,my-ed+10,3
GR.ROTATE.END
GR.LINE ln, mx-80,my-80,mx+80,my+80
GR.ROTATE.END

GR.ROTATE.START (270)-i,mx,my
GR.COLOR 255,100,100,255
GR.CIRCLE cl,mx-ed,my-ed,1
GR.COLOR cc-65,cc,0,0,0
GR.ROTATE.START 180+i-(270),mx-ed+10,my-ed+10
GR.LINE ln,mx-ed+10,my-ed+10,mx-ed+10,my-35-ed+10
GR.CIRCLE cl,mx-ed+10,my-ed+10-38,5
GR.CIRCLE cl,mx-ed+10,my-ed+10,3
GR.ROTATE.END
GR.ROTATE.END

i=i+5
GR.RENDER
GOTO st

ONBACKKEY:
GOSUB fin

END

fin:
PRINT"© 2020 by Dietmar Schrausser"
RETURN 
