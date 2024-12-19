!! Potenzen, D. G. SCHRAUSSER 2024
!!
CONSOLE.TITLE "Potenzen"
INPUT "Basis: ",a,2
y=4
FOR i=1to9
 REM x=a^y
 x1=a
  IFy>0
  FORj=1to y-1
   x1=x1*a
  NEXT j
 ENDIF
 IFy<=0
  FORj=0to ABS(y)
   x1=x1/a %%!!!!!!
  NEXT j
 ENDIF
 PRINT a;"^";y;" = ";a;"/";a;
 FORj=1to ABS(y)
  IFy<0
   PRINT "/";a;
  ELSE
   PRINT "*";a;
  ENDIF
 NEXT
 PRINT " = ";x1
 n:
 y=y-1
NEXT i
PRINT "End."
END
ONERROR:
PRINT "0.0^0.0 = 1.0 = 0.0/0.0!!!"
GOTO n
!! end
