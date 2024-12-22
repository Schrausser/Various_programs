REM //     T E T R A E D E R -
REM //     P A R A M E T E R
REM //         INTEGRAL
REM //         Jf(x)=72
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
PRINT "         1"+_lf$+"[(3 9/4)";h3$;j$+"f(x)]/(24 9 9) = ..."+_lf$+"         0"

FOR x = 0 TO 1 STEP 1/d
 fx=fx+ (8190+ 2*x+3*x^2 )/18  /d
NEXT
CLS 
  
fx=fx*(27/4)^3
fx=fx/(18*108)

PRINT "d = 1/"d
PRINT "         1"+_lf$+"[(3 9/4)";h3$;j$+"f(x)]/(24 9 9) = ";fx;_lf$+"         0"

PRINT "bei" 
print "           _";_lf$;"       101.1 9 9+2x+3x"+h2$+_lf$+"f(x) = "+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+ms$+_lf$+"             9+9"

PRINT
PRINT "Tetraeder Parameter Integral "+j$+_lf$+_cr$+" by Dietmar Schrausser"
END
