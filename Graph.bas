a=255
k=0
GR.OPEN a,a,a,a,0,1
GR.SCREEN w,h
m0:
lg=10
REM x=55-k
x=255
GR.COLOR 255/3,x*RND(),x*RND(),x*RND(),1
rd=RND()
FOR i=0 TO h STEP 10+k
 GR.LINE n,0,(i+rd*lg),w,h-(i+rd*lg)
 GR.RENDER
NEXT i
rd=RND()
FOR i=0 TO w STEP 10+k
 GR.LINE n,i+rd*lg,h,w-(i+rd*lg),0
 GR.RENDER
NEXT i
k=k+2
IF k=6
 k=0
 REM GR.CLS
 GR.RENDER
ENDIF
GOTO m0
ONBACKKEY:
GOSUB fin 
END

fin: 
PRINT"Graph (c) 2013/2017 by Dietmar Schrausser"
RETURN
