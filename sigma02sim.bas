INCLUDE "strg.inc"
CONSOLE.TITLE "Random Numbers Simulation"
INPUT "Seed=...",seed1,0   % // seed //
IF seed1=0:seed1=INT(RND()*10000):ENDIF % // time seed //
INPUT "Shift parameter b[sig]=...",_rn_,1000
INPUT "Number of cycles n=...",n,10000
INPUT "Number of Simulations M=...",m,500
INPUT "Output File...",fil$,"sim.dat"

DIM sigv[n] % // distribution vector //
DIM sysv[n] % // 

DIM simdsig[m] % // simulation vector //
DIM simdsiga[m] % // simulation vector //
DIM simdsys[m] % // simulation vector //
DIM simdsysa[m] % // simulation vector //
dsig=0
dsys=0
dsiga=0
dsysa=0
!r0=randomize(seed1)
FOR j=1 TO m % // simulations over m //
 CLS
!!
 GOSUB systime
 seed0=SQR(VAL(min$)*VAL(sec$)+VAL(d$))
 seed1=INT(10000*(seed0-INT(seed0))) % // time seed //
!!
seed1=INT(RND()*10000)
 r0=RANDOMIZE(seed1)
 PRINT "Simulation m=";j;" of M=";INT$(m);" with cycles n=";INT$(n);"..."
 FOR i=1 TO n % // cycles over n //
  rn=seed1^(34/45)
  nx=_rn_*(rn-FLOOR(rn))-FLOOR(_rn_*(rn-FLOOR(rn)))
  seed1=nx:sigv[i]=nx % // SIGMA value //
  nrnd=RND():sysv[i]=nrnd % // system value//
 NEXT
 ARRAY.SORT sigv[]
 ARRAY.SORT sysv[]
 FOR i=1 TO n
  dsig=dsig+(sigv[i]-i/n) % // difference //
  dsys=dsys+(sysv[i]-i/n)
  dsiga=dsiga+ABS(sigv[i]-i/n) % // absolute difference //
  dsysa=dsysa+ABS(sysv[i]-i/n)
 NEXT
 simdsig[j]=dsig/n % // mean values //
 simdsys[j]=dsys/n
 simdsiga[j]=dsiga/n
 simdsysa[j]=dsysa/n
NEXT j

ARRAY.SORT simdsig[]
ARRAY.SORT simdsiga[]
ARRAY.SORT simdsys[] 
ARRAY.SORT simdsysa[]

TEXT.OPEN w, sim, fil$

FOR j=1 TO m

 sim$ =    FORMAT$("%.#####",simdsig[j])+_tb$
 sim$=sim$+FORMAT$("%.#####",simdsys[j])+_tb$
 sim$=sim$+FORMAT$("%.#####",simdsiga[j])+_tb$
 sim$=sim$+FORMAT$("%.#####",simdsysa[j])+_tb$
 sim$=sim$+FORMAT$("%.#####",j/m)

 TEXT.WRITELN sim, sim$
NEXT
TEXT.CLOSE sim

ARRAY.AVERAGE m_sig, simdsig[]
ARRAY.AVERAGE m_sys, simdsys[]
ARRAY.STD_DEV s_sig, simdsig[]
ARRAY.STD_DEV s_sys, simdsys[]

ARRAY.AVERAGE m_siga, simdsiga[]
ARRAY.AVERAGE m_sysa, simdsysa[]
ARRAY.STD_DEV s_siga, simdsiga[]
ARRAY.STD_DEV s_sysa, simdsysa[]

PRINT"---------------------------------------
PRINT"AM, SD of AM Differences d=F(n)-F(reg)."
PRINT"---------------------------------------
PRINT "SIGMA  AM[d]=   "+FORMAT$("%.########",m_sig)
PRINT "       SD[d]=   "+FORMAT$("%.########",s_sig)
PRINT "System AM[d]=   "+FORMAT$("%.########",m_sys)
PRINT "       SD[d]=   "+FORMAT$("%.########",s_sys)
PRINT"--------------------------------------
PRINT"AM, SD of AM Absolute Differences |d|."
PRINT"--------------------------------------
PRINT "SIGMA  AM[|d|]= "+FORMAT$("%.########",m_siga)
PRINT "       SD[|d|]= "+FORMAT$("%.########",s_siga)
PRINT "System AM[|d|]= "+FORMAT$("%.########",m_sysa)
PRINT "       SD[|d|]= "+FORMAT$("%.########",s_sysa)
PRINT"--------------------------------------

PRINT "done."

END
systime:
TIME Y$, M$, D$, h$, min$, sec$
RETURN
