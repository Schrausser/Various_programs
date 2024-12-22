REM //     T E T R A E D E R -
REM //     P A R A M E T E R
REM //         INTEGRAL
REM //       Jf(x)=64/3
REM //           von
REM //   Dietmar G. Schrausser 
REM //         (c)2018

INCLUDE strg.txt  

CONSOLE.TITLE "Tetraeder Parameter "

REM /////////////
d = 1/((6362/2025)-PI())
REM /////////////

fx=0

PRINT "d = 1/"d
PRINT "1"+_lf$+j$+"f(x) = ..."+_lf$+"0"

FOR x = 0 TO 1 STEP 1/d
 fx=fx+ (126+ 2*x+3*x^2 )/6  /d
NEXT
CLS 

PRINT "d = 1/"d
PRINT "1"+_lf$+j$+"f(x) = ";fx;_lf$+"0"

PRINT "bei"
PRINT "       126+2x+3x"+h2$+_lf$+"f(x) = "+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+_lf$+"           6"

PRINT
PRINT "Tetraeder Parameter Integral "+j$+_lf$+_cr$+" by Dietmar Schrausser"
END
