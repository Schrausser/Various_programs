!!
          Konvertierung von
             Dezimalen  
 
      von Dietmar Schrausser 
              © 2018
!!

INCLUDE strg.txt
CONSOLE.TITLE "Dezimalkonvertierung"

INPUT "Dezimale x. ...",x,6362/2025-3
INPUT"zur Basis S:",s,8
PRINT"x = ";x
PRINT"S:";FORMAT$("#",s);"l."
yi$="0."
z=0
st:
y=s*x
yi=INT(y)
yi$=yi$+_lf$+FORMAT$("%",yi)
IF z=15 THEN yi$=yi$+"_(16)"
x=y-yi
z=z+1
IF x>0 & z<1001 THEN GOTO st
PRINT yi$
PRINT"n = ";z

PRINT "decconv"_lf$+_cr$+" 2018 by Dietmar Schrausser" 
END

%% END
%%
