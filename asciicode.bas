CONSOLE.TITLE "ASCII/UNICODE"
INPUT "Start …",a1,0
INPUT "End …",an,255
FOR i=a1 TO an STEP 7
 PRINT INT$(i)+":"+CHR$(i)+" ";
 PRINT INT$(i+1)+":"+CHR$(i+1)+" ";
 PRINT INT$(i+2)+":"+CHR$(i+2)+" ";
 PRINT INT$(i+3)+":"+CHR$(i+3)+" ";
 PRINT INT$(i+4)+":"+CHR$(i+4)+" ";
 PRINT INT$(i+5)+":"+CHR$(i+5)+" ";
 PRINT INT$(i+6)+":"+CHR$(i+6)
NEXT
ONBACKKEY:
GOSUB fin 
END
fin:
PRINT"ASCIICODE (c) 2017 by Dietmar Schrausser"
RETURN
