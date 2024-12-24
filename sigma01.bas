seed1=RND()*1000
CONSOLE.TITLE "Random Numbers"
INPUT "Number of cycles n=...",n,50000
DIM sigv[n]
DIM sysv[n]
dsig=0
dsys=0
dsiga=0
dsysa=0
!!
PRINT "writing...
TEXT.OPEN w, rnd1, "r_sig.txt"
TEXT.OPEN w, rnd2, "r_sys.txt"
TEXT.OPEN w, reg,   "reg.txt"
!!
PRINT "generating random vectors over n=";int$(n);"..."
FOR i=1 TO n
 _rn_=10000
 rn=seed1^(34/45)
 nx=_rn_*(rn-FLOOR(rn))-FLOOR(_rn_*(rn-FLOOR(rn)))
 seed1=nx
 sigv[i]=nx
 nrnd=RND()
 sysv[i]=nrnd
!!
 regr=i/n
 TEXT.WRITELN rnd1, nx   % // writing F(n) SIGMA  //
 TEXT.WRITELN rnd2, nrnd % // writing F(n) System //
 TEXT.WRITELN reg, regr  % // writing reg line 1 //
!!
NEXT
!!
TEXT.CLOSE rnd1
TEXT.CLOSE rnd2
TEXT.CLOSE reg
PRINT "file stream done."
!!
PRINT "calculating differences..."
ARRAY.SORT sigv[]
ARRAY.SORT sysv[]
FOR i=1 TO n
 dsig=dsig+(sigv[i]-i/n)
 dsys=dsys+(sysv[i]-i/n)
 dsiga=dsiga+ABS(sigv[i]-i/n)
 dsysa=dsysa+ABS(sysv[i]-i/n)
NEXT
dsig=dsig/n
dsys=dsys/n
dsiga=dsiga/n
dsysa=dsysa/n
PRINT"AM of Differences d=F(n)-F(reg):"
PRINT "SIGMA d= "+FORMAT$("%.########",dsig)
PRINT "System d="+FORMAT$("%.########",dsys)
PRINT"AM of Absolute Differences |d|:"
PRINT "SIGMA |d|= "+FORMAT$("%.########",dsiga)
PRINT "System |d|="+FORMAT$("%.########",dsysa)
PRINT "done."
END
