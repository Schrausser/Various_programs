REM              RND N
REM 
REM
REM (c) 2017 by Dietmar Schrausser

GR.OPEN 255,0,0,0,0,1
GR.SCREEN sx,sy
GR.TEXT.SIZE 11
GR.TEXT.BOLD 1
n=0
loop:
FOR j=0 TO sy STEP 10
 FOR i=-sx TO sx STEP 5*5.4
  GR.COLOR 255,255*RND(),255*RND(),255*RND(),1
  GR.TEXT.DRAW tx,i+n,j,INT$(RND()*10000)
  REM GR.RENDER
 NEXT
 n=n+5
NEXT
GR.RENDER
GR.CLS
n=0
GOTO loop
ONBACKKEY:
GOSUB fin
END

fin:
PRINT "RND N (c) by Dietmar Schrausser"
RETURN 
