a=255
GR.OPEN a,a,a,a,0,1
GR.SCREEN h,w
m0:
GR.TOUCH flag, x , y
IF flag
 n=ROUND(RND()*1000)
 GR.COLOR 255,0,0,0,0
 GR.TEXT.DRAW p,x,y,FORMAT$("###",n)
 GR.RENDER
ENDIF
GOTO m0
onbackkey:
gosub fin
END

fin: 
PRINT"RND2 (c) 2013 by Dietmar Schrausser"
RETURN
