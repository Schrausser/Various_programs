
CONSOLE.TITLE "ASCII/UNICODE Text Output"
INPUT "Start …",a1,1
INPUT "End …",an,255
TEXT.OPEN w,fl,"ascii.txt"
PRINT "writing to file ascii.txt..."
FOR i=a1 TO an STEP 7 
 tx$= INT$(i)+":"+CHR$(i)+" "+INT$(i+1)+":"+CHR$(i+1)+" "+INT$(i+2)+":"+CHR$(i+2)+" "+INT$(i+3)+":"+CHR$(i+3)+" "+INT$(i+4)+":"+CHR$(i+4)+" "+INT$(i+5)+":"+CHR$(i+5)+" "+INT$(i+6)+":"+CHR$(i+6)
 TEXT.WRITELN fl,tx$
NEXT
TEXT.CLOSE fl
ONBACKKEY:
GOSUB fin 
END
fin:
PRINT"done."
PRINT"ASCIICODE1 (c) 2018 by Dietmar Schrausser"
RETURN
