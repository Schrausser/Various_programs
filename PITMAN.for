C        
C                                 PC-PITMAN
C                            Randomization Tests
C                                Version 2.0
C                             December 12, 1985
C
C
C                              Gerard E. Dallal
C
C               USDA Human Nutrition Research Center on Aging
C                            at Tufts University
C                           711 Washington Street
C                             Boston, MA  02111
C
C                                    and
C
C                    Tufts University School of Nutrition
C                             132 Curtis Street
C                             Medford, MA 02155
C        
C
C
C                                  NOTICE
C
C       Documentation and original code copyright 1985 by  Gerard  E.  
C       Dallal.  Reproduction of material for non-commercial purposes 
C       is   permitted,   without  charge,   provided  that  suitable 
C       reference is made to PC-PITMAN and its author.  
C
C       Neither PC-PITMAN nor its documentation should be modified in 
C       any way without permission from the author,  except for those 
C       changes  that are  essential  to move  PC-PITMAN  to  another 
C       computer.  
C
C       Please acknowledge  PC-PITMAN in any manuscript that uses its 
C       calculations.  
C
C
      DIMENSION H(36000), DATA(100), DATAI(100), DCOPY(100), 
     *   DATAG(100)
      CHARACTER*1 QUERY
      DATA MAXTOT /36000/, MAXOBS /100/
      DATA IIN /5/, IOUT /6/, IFIN/10/
C
      WRITE(IOUT,1)
    1 FORMAT ( 'PC-PITMAN')
C
   10 CALL READ(IIN,IOUT,IFIN,DATA,DATAG,MAXOBS,NOBS,M,N,NGRP)
      XNOBS = NOBS
C
  110 WRITE(IOUT,120)
  120 FORMAT (' Multiply data by what integer power of 10?  ')
      READ(IIN,*,ERR=110) DEC
      NDEC = DEC
      IF(FLOAT(NDEC).NE.DEC) GOTO 110
C
C        1.2 ADDITION... ROUND RATHER THAN TRUNCATE
C
      DO 130 I = 1, NOBS
  130 DCOPY(I) = AINT(DATA(I) * 10.0**NDEC + SIGN(0.5,DATA(I)))
C
      IF (NGRP.EQ.2) GOTO 200
C
      CALL PITMN1(DATAI,DCOPY,NOBS,H,MAXTOT,IOUT)
C
C        T-TEST
C
      IF (NOBS.LE.1) STOP 'Fewer than 2 observations.'
      AVG = 0.0
      DO 140 I = 1, NOBS
  140 AVG = AVG + DATA(I)
      AVG = AVG / XNOBS
      SSQ = 0.0
      DO 150 I = 1, NOBS
  150 SSQ = SSQ + (DATA(I) - AVG)**2
      IF (SSQ.GT.0.0) GOTO 180
C
      WRITE(IOUT,170)
  170 FORMAT (' All data values equal.  No t-test.')
      GOTO 300
C
  180 T = AVG / SQRT(SSQ / ((XNOBS - 1) * XNOBS))
      NDF = NOBS - 1
      PVALT = 2.0 * PROBST(SIGN(T,-1.0),NDF)
      WRITE(IOUT,190) T, NDF, PVALT
  190 FORMAT(' Student''s t-statistic = ',G11.4,' with',
     *   I3,' d.f.  (P-value =',F7.4,')')
      GOTO 300
C
  200 CALL PITMN2(DATAI,DCOPY,M,N,NOBS,H,MAXTOT,IOUT)
C
C        T-TEST
C
      IF (NOBS.LE.2 .OR. M.EQ.0 .OR. N.EQ.0) 
     *   STOP 'Degenerate data set.'
      AVG1 = 0.0
      DO 230 I = 1, M
  230 AVG1 = AVG1 + DATA(I)
      AVG1 = AVG1 / FLOAT(M)
      AVG2 = 0.0
      DO 240 I = 1, N
  240 AVG2 = AVG2 + DATA(M+I)
      AVG2 = AVG2 / FLOAT(N)
      SSQ = 0.0
      DO 250 I = 1, M
  250 SSQ = SSQ + (DATA(I) - AVG1)**2
      DO 260 I = 1, N
  260 SSQ = SSQ + (DATA(M+I) - AVG2)**2
      IF (SSQ.GT.0.0) GOTO 280
C
      WRITE(IOUT,270)
  270 FORMAT (' Within group variance zero.  No t-test.')
      GOTO 300
C
  280 T = (AVG1 - AVG2) / SQRT((SSQ / FLOAT(NOBS-2)) *
     *   (1.0 / FLOAT(M) + 1.0 / FLOAT(N)))
      NDF = NOBS - 2
      PVALT = 2.0 * PROBST(SIGN(T,-1.0),NDF)
      WRITE(IOUT,190) T, NDF, PVALT
C
  300 WRITE (IOUT,310)
  310 FORMAT (//' Do you wish to continue?  (Y or N):  ')
      READ (IIN,320) QUERY
  320 FORMAT (A1)
      IF (QUERY.NE.'Y' .AND. QUERY.NE.'y') STOP ' '
      GOTO 10
      END
C
      FUNCTION ALGAMA(S)
C
C        CACM ALGORITHM 291
C        LOGARITHM OF GAMMA FUNCTION
C        BY PIKE, M.C. AND HILL, I.D.
C
C        TRANSLATED INTO FORTRAN BY
C                   Gerard E. Dallal
C                   USDA-Human Nutrition Research Center on Aging
C                              at Tufts University
C                   711 Washington Street
C                   Boston, MA  02111
C
C
      X = S
      ALGAMA = 0.0
      IF (X .LE. 0.0) RETURN
      F = 0.0
      IF (X .GE. 7.0) GOTO 30
C
      F = 1.0
      Z = X - 1.0
C
   10 Z = Z + 1.0
      IF (Z .GE. 7.0) GOTO 20
      X = Z
      F = F * Z
      GOTO 10
C
   20 X = X + 1
      F = -ALOG(F)
C
   30 Z = 1.0 / X ** 2
      ALGAMA = F + ( X - 0.5) * ALOG(X) - X + 0.918938533204673 +
     1   (((-0.000595238095238 * Z + 0.000793650793651) * Z
     2   - 0.002777777777778) * Z + 0.083333333333333) / X
      RETURN
      END
C
      SUBROUTINE BIGGIE(IOBS, IMAX, ICAUSE, IOUT)
C
      GOTO (100,200), ICAUSE
C
  100 WRITE(IOUT,110) IOBS, IMAX
  110 FORMAT(/' ** Too many observations.'/
     *        '    Your data set contains',I4/
     *        '    The program is configured to handle',I4/)
      RETURN
C
  200 WRITE(IOUT,210) IOBS, IMAX
  210 FORMAT(/
     * ' ** Your data set requires a storage array of',I8,' elements.'/
     * '    At present, the array contains',I7,' elements.'/)
      RETURN
      END
C
      SUBROUTINE PITMN1(DATAI ,DCOPY, NOBSX, H, MAXTOT, 
     *   IOUT)
      DOUBLE PRECISION PLOW, PHIGH
      DIMENSION DATAI(NOBSX), H(MAXTOT), DCOPY(NOBSX)
C
      NOBS = 0
      DO 20 I = 1, NOBSX
      IF (DCOPY(I).EQ.0) GOTO 20
      NOBS = NOBS + 1
      DCOPY(NOBS) = DCOPY(I)
   20 CONTINUE
      IF (NOBS.EQ.0) STOP 'All observations are 0.'
C
C         ITEST = 1 -- Sign test
C                 2 -- Wilcoxon signed-rank test
C                 3 -- Pitman randomization test
C
      DO 1300 ITEST = 1, 3
C
      GOTO (60,50,30), ITEST
C
   30 DO 40 I = 1, NOBS
   40 DATAI(I) = DCOPY(I)
      GOTO 80
C
   50 CALL RANK(DATAI ,DCOPY, NOBS)
      GOTO 80
C
C        SIGN TEST
C
   60 NSTAT = 0
      DO 65 I = 1, NOBS
      IF(DCOPY(I).GT.0) NSTAT = NSTAT + 1
   65 CONTINUE
      NSTAT = MIN0(NSTAT,NOBS - NSTAT)
C
      PVAL = 0.0
      XNOBS = NOBS
      XNOBS1 = NOBS + 1
      DO 70 I = 0, NSTAT
      TERM = ALGAMA(XNOBS1) - ALGAMA(FLOAT(I+1)) - 
     *   ALGAMA(XNOBS1-FLOAT(I)) - XNOBS * ALOG(2.0)
      IF (TERM.GT.-78.0) PVAL = PVAL + EXP(TERM)
   70 CONTINUE
      PVAL = AMIN1(1.0, 2.0 * PVAL)
      GOTO 1205
C
   80 ISUM = 1
      DO 100 I = 1, NOBS
  100 ISUM = ISUM + IFIX(ABS(DATAI(I)))
      IF (ISUM.LE.MAXTOT) GOTO 110
      CALL BIGGIE(ISUM,MAXTOT,2,IOUT)
      GOTO 1300
C
  110 NPDF = 1
      H(1) = 1
C
      DO 200 K = 1, NOBS
C
C
      INC = ABS(DATAI(K))
      DO 150 I = 1, INC
  150 H(NPDF+I) = 0
      DO 160 I = NPDF, 1, -1
  160 H(INC+I) = H(INC+I) + H(I)
      NPDF = NPDF + INC
C
  200 CONTINUE
C
C        CALCULATE P-VALUE (TWO-TAILED)
C
      ISTAT = 0
      DO 1100 I = 1, NOBS
 1100 ISTAT = ISTAT + MAX1(0.0,DATAI(I))

      PLOW = 0.0
      DO 1200 I = 1, ISTAT
 1200 PLOW = PLOW + DBLE(H(I))
      PHIGH = 2.0D0**NOBS - PLOW
      PLOW = PLOW + DBLE(H(ISTAT + 1))
C 
      PVAL = 2.0D0 * DMIN1(PLOW,PHIGH) / 2.0D0**NOBS
      PVAL = AMIN1(PVAL,1.0)
C
 1205 IF (ITEST.EQ.1) WRITE(IOUT,1210) PVAL
 1210 FORMAT(/' Sign test:  P-value =',F7.4)
      IF (ITEST.EQ.2) WRITE(IOUT,1220) PVAL
 1220 FORMAT(' Wilcoxon signed-rank test:  P-value =',F7.4)
      IF (ITEST.EQ.3) WRITE(IOUT,1230) PVAL
 1230 FORMAT(' Pitman randomization test:  P-value =',F7.4)
C
 1300 CONTINUE
      RETURN
      END

      SUBROUTINE PITMN2(DATAI, DCOPY, M, N, NOBS, H, MAXTOT,
     *   IOUT)
      DOUBLE PRECISION PLOW, PHIGH
      DIMENSION DATAI(NOBS), DCOPY(NOBS), H(MAXTOT)
C
C        ADJUST DATA
C
      MIN = DCOPY(1)
      DO 10 I = 1, NOBS
   10 IF (DCOPY(I).LT.MIN) MIN = DCOPY(I)
      DO 20 I = 1, NOBS
   20 DCOPY(I) = DCOPY(I) - MIN
C
C        ITEST = 1 -- Wilcoxon-Mann-Whitney test
C                2 -- Pitman randomization test
C
      DO 2500 ITEST = 1, 2
C
      GOTO (80,110), ITEST
C
   80 CALL RANK(DATAI, DCOPY, NOBS)
C
C        SUBTRACT MINIMUM RANK
C        (MIN RANK CAN BE ANYTHING DEPENDING ON TIES)
C
      MIN = DATAI(1)
      DO 90 I = 1, NOBS
   90 IF (MIN.GT.IFIX(DATAI(I))) MIN = DATAI(I)
      DO 100 I = 1, NOBS
  100 DATAI(I) = DATAI(I) - FLOAT(MIN)
      GOTO 130
C
  110 DO 120 I = 1, NOBS
  120 DATAI(I) = DCOPY(I)

C
C        CALCULATE TEST STATISTIC BEFORE DATA ARE SORTED
C
  130 ISTAT = 0
      DO 140 I = 1, M
  140 ISTAT = ISTAT + IFIX(DATAI(I))
C
C        PP3 -- LINE 1
C
      MOBS = MIN0(M,N)
C
C        PP3 -- LINES 2,3
C      
      CALL SHELL(DATAI, NOBS)
C
C           IQ -- 1 + SUM OF M-LARGEST
C           IU -- SUM OF M-SMALLEST
C
      IQ = 1
      IU = 0
      DO 190 K = 1, M
      IQ = IQ + IFIX(DATAI(NOBS+1-K))
      IU = IU + IFIX(DATAI(K))
  190 CONTINUE
      ISUM = IQ + IFIX(DATAI(NOBS))
      ISUM = ISUM * (MOBS + 3)
      IF (ISUM.LE.MAXTOT) GOTO 200
      CALL BIGGIE(ISUM,MAXTOT,2,IOUT)
      GOTO 2500
C
C           NPDFR(C) -- NUMBER OF ROWS(COLUMNS) IN H, THE PDF
C
  200 NPDFR = 1
      NPDFC = 1
      H(1) = 1
C
C        PP3 -- LINE 4
C
      DO 1000 K = 1, NOBS
C
C        PP3 -- LINE 5
C      
      INCR = DATAI(K)
      INCC = 1
      NPDFR2 = NPDFR + INCR
      NPDFC2 = NPDFC + INCC
C
C        ADD ROWS
C
      INCR = NPDFR2 - NPDFR
      IF (INCR.EQ.0) GOTO 250
      DO 240 J = NPDFC, 1, -1
      INDEX0 = (J-1) * NPDFR2
      DO 220 I = NPDFR, 1, -1
  220 H(INDEX0+I) = H((J-1)*NPDFR+I)
      DO 230 I = INCR, 1, -1
  230 H(INDEX0 + NPDFR + I) = 0
  240 CONTINUE
C
C        ADD COLUMN
C
  250 INDEX0 = NPDFR2 * NPDFC
      DO 260 I = 1, NPDFR2
  260 H(INDEX0 + I) = 0
C
      DO 280 J = NPDFC, 1, -1
      INDEX1 = (J - 1) * NPDFR2
      DO 280 I = NPDFR, 1, -1
      INDEX0 = (J + INCC - 1) * NPDFR2 + I + INCR
      H(INDEX0) = H(INDEX0) + H(INDEX1 + I)
  280 CONTINUE
C
      NPDFR = NPDFR2
      NPDFC = NPDFC2

C
C        PP3 -- LINE 6
C
      NPDFR2 = MIN0(NPDFR,IQ)
      NPDFC2 = MIN0(NPDFC,MOBS+2)
C
      IF (NPDFR.EQ.NPDFR2) GOTO 300
      DO 290 J = 1, NPDFC2
      INDEX0 = (J - 1) * NPDFR2
      INDEX1 = (J - 1) * NPDFR
      DO 290 I = 1, NPDFR2
  290 H(INDEX0 + I) = H(INDEX1 + I)
      NPDFR = NPDFR2
  300 NPDFC = NPDFC2
C
C        PP3 -- LINE 7
C
      IF (K .LE. MOBS) GOTO 1000
C
C        PP3 -- LINE 8
C
      NPDFC = NPDFC - 1

C
C        PP3 -- LINE 9
C
      IF (K .LE. NOBS-MOBS) GOTO 1000
C
C        PP3 -- LINE 10
C
      NPDFC2 = NPDFC - 1
      INCR = DATAI(K+MOBS-NOBS)
      NPDFR2 = NPDFR - INCR
      DO 310 J = 1, NPDFC2
      INDEX0 = (J - 1) * NPDFR2
      INDEX1 = J * NPDFR + INCR
      DO 310 I = 1, NPDFR2
  310 H(INDEX0 + I) = H(INDEX1 + I)
      NPDFR = NPDFR2
      NPDFC = NPDFC2

C
C        PP3 -- LINE 11
C
 1000 CONTINUE
C
C        PP3 -- LINE 12
C
      IF (NPDFC .NE. 1) STOP 12
C
      DO 1100 I = 1, IU
 1100 H(NPDFR + I) = 0
      DO 1110 I = NPDFR, 1, -1
 1110 H(I + IU) = H(I)
      NPDFR = IU + NPDFR
C
      DO 1120 I = 1, IU
 1120 H(I) = 0
C
      INCR = IQ - NPDFR
      IF (INCR .LE. 0) GOTO 1160
      DO 1150 I = 1, INCR
 1150 H(NPDFR + I) = 0
C
 1160 NPDFR = IQ
C
C        PP3 -- LINE 13
C
      IF (M .LE. N) GOTO 2000
C
C        PP3 -- LINE 14
C
C          DROP
C
      NPDFR = NPDFR - IU
      DO 1200 I = 1, NPDFR
 1200 H(I) = H(I + IU)
C
C          ROTATE
C
      NPDFR2 = NPDFR / 2
      DO 1210 I = 1, NPDFR2
      DUM = H(I)
      H(I) = H(NPDFR+1-I)
 1210 H(NPDFR+1-I) = DUM
C
C          TAKE
C
      NPDFR2 = IQ + IFIX(DATAI(MOBS+1))
      INCR = NPDFR2 - NPDFR
      IF (INCR) 1220, 2000, 1250
C
 1220 INCR = -INCR
      NPDFR = NPDFR2
      DO 1230 I = 1, NPDFR
 1230 H(I) = H(I+INCR)
      GOTO 2000
C
 1250 DO 1260 I = NPDFR, 1, -1
 1260 H(INCR+I) = H(I)
      DO 1270 I = 1, INCR
 1270 H(I) = 0
      NPDFR = NPDFR2
C
C        PP3 -- ALL DONE.
C
 2000 ITOT = 0
      DO 2100 I = 1, NOBS
 2100 ITOT = ITOT + IFIX(DATAI(I))
C
C        TACK ZEROS ONTO END OF PDF
C
      INCR = ITOT - IQ + 1
      IF (INCR.EQ.0) GOTO 2200
C
      DO 2120 I = 1, INCR
 2120 H(NPDFR+I) = 0
      NPDFR = NPDFR + INCR
C
C        ADJUST LENGTH
C
 2200 NPDFR2 = ITOT+1
      INCR = NPDFR2 - NPDFR
      IF (INCR) 2210, 2300, 2250
C
 2210 INCR = -INCR
      NPDFR = NPDFR2
      DO 2220 I = 1, NPDFR
 2220 H(I) = H(I+INCR)
      GOTO 2300
C
 2250 DO 2260 I = NPDFR, 1, -1
 2260 H(INCR+I) = H(I)
      DO 2270 I = 1, INCR
 2270 H(I) = 0
      NPDFR = NPDFR2
C
 2300 ISTAT1 = ISTAT+1
      PLOW = 0.0
      DO 2310 I = 1, ISTAT1
 2310 PLOW = PLOW + DBLE(H(I))
C
      PHIGH = 0.0
      DO 2320 I = ISTAT1, NPDFR
 2320 PHIGH = PHIGH + DBLE(H(I))
C
      PVAL = 2.0D0 * DMIN1(PLOW, PHIGH)
      PVAL = AMIN1(1.0, PVAL / EXP(ALGAMA(FLOAT(NOBS + 1)) - 
     *   ALGAMA(FLOAT(M + 1)) - ALGAMA(FLOAT(N + 1))))
C
      IF (ITEST.EQ.1) WRITE(IOUT,2420) PVAL
 2420 FORMAT(/' Wilcoxon-Mann-Whitney test:  P-value =',F7.4)
      IF (ITEST.EQ.2) WRITE(IOUT,2430) PVAL
 2430 FORMAT(' Pitman randomization test:  P-value =',F7.4)
 2500 CONTINUE
      RETURN   
      END
C
      FUNCTION PROBST(T,IDF)
C
C         ALGORITHM AS 3  J.R.S.S. C, (1968) VOL. 17, NO. 2.
C
C         STUDENT T PROBABILITY (LOWER TAIL)
C         USES METHOD DUE TO D.B. OWEN (BIOMETRIKA VOL. 52 1965 DEC. P438)
C
      DATA G1/0.3183098862/
C
      F=IDF
      A=T/SQRT(F)
      B=F/(F+T**2)
      IM2=IDF-2
      IOE=IDF-2*(IDF/2)
      S=1.0
      C=1.0
      KS=2+IOE
      FK=KS
      IF(IM2-2) 6,7,7
    7 DO 8 K=KS,IM2,2
      C=C*B*(FK-1.0)/FK
      S=S+C
    8 FK=FK+2.
    6 IF(IOE) 1,1,2
    1 PROBST=.5+.5*A*SQRT(B)*S
      GO TO 3
    2 IF (IDF-1) 4,4,5
    4 S=0.0
    5 PROBST=.5+(A*B*S+ATAN(A))*G1
    3 RETURN
      END

      SUBROUTINE RANK(DATAI, DCOPY, N)
C
C        DCOPY:  DATA
C        DATA:  INPUT --  SCRATCH
C                 OUTPUT --  RANKS

      DIMENSION DATAI(N), DCOPY(N)
C
      DO 200 I = 1,N
      NTIE = 0
      NRANK = 0
      IDUM = ABS(DCOPY(I))

      DO 100 K = 1,N
      KDUM = ABS(DCOPY(K))
      IF (IDUM.EQ.KDUM) NTIE = NTIE + 1
      IF (IDUM.GT.KDUM) NRANK = NRANK + 1
  100 CONTINUE

      DATAI(I) = 2 * NRANK + 2 + (NTIE - 1)
  200 CONTINUE

      DO 210 I = 1, N
  210 DATAI(I) = SIGN(DATAI(I),DCOPY(I))
C
C        IF ALL RANKS ARE EVEN DIVIDE BY TWO
C
      DO 220 I = 1, N
      IF (MOD(IFIX(DATAI(I)),2).EQ.1) RETURN
  220 CONTINUE
      DO 230 I = 1,N
  230 DATAI(I) = DATAI(I) / 2.0

      RETURN
      END

      SUBROUTINE READ(IIN, IOUT, IFIN, DATA, DATAG, MAXOBS, NOBS, 
     *   M, N, NGRP)
C
      CHARACTER FNAME*50, QUERY*1
      DIMENSION DATA(MAXOBS), DATAG(MAXOBS)
C
  100 WRITE(IOUT,110)
  110 FORMAT(/' Does this problem involve paired data (P)'/
     *        '            or two independent samples (I)?  ')
      READ (IIN,220) QUERY
      NGRP = 0
      IF (QUERY.EQ.'P' .OR. QUERY.EQ.'p') NGRP = 1
      IF (QUERY.EQ.'I' .OR. QUERY.EQ.'i') NGRP = 2
      IF (NGRP.EQ.0) GOTO 100
C
  200 WRITE (IOUT,210)
  210 FORMAT(/' Will data be entered through the keyboard (K)'/
     *        '             or read from an external file (F)?  ')
      READ (IIN,220) QUERY
  220 FORMAT(A1)
      IF (QUERY.EQ.'K' .OR. QUERY.EQ.'k') GOTO 400
      IF (QUERY.NE.'F' .AND. QUERY.NE.'f') GOTO 200
C
  230 WRITE (IOUT,240)
  240 FORMAT (/' Enter filename:  ')
      READ (IIN,'(A)') FNAME
      OPEN (IFIN, FILE = FNAME, STATUS = 'OLD', IOSTAT = IOCHK)
      IF (IOCHK.NE.0) GOTO 230
C
  245 WRITE (IOUT,250)
  250 FORMAT (' Enter the number of variables in the file:  ')
      READ (IIN,*,ERR=245) NVAR
      KVARA = 1
      KVARG = 0
      IF (NVAR.EQ.1) GOTO 280
C
C        1.2 ADDITION...  DIFFERENCES ORIGINAL VARIABLES
C
      IF (NGRP.EQ.2) GOTO 260
  251 WRITE(IOUT,252)
  252 FORMAT (' Does the files contain paired values (P)',
     *   ' or differences (D)?:  ')
      READ (IIN,220) QUERY
      IF (QUERY.EQ.'D' .OR. QUERY.EQ.'d') GOTO 260
      IF (QUERY.NE.'P' .AND. QUERY.NE.'p') GOTO 251
  253 WRITE(IOUT,254)
  254 FORMAT(' Which variables are paired?:  ')
      READ(IIN,*,ERR=253) KVARA,KVARG
      IF(KVARA.LT.1 .OR. KVARA.GT.NVAR .OR. KVARA.EQ.KVARG .OR.
     *   KVARG.LT.1 .OR. KVARG.GT.NVAR) GOTO 253
C
      KVAR1 = MIN0(KVARA,KVARG)
      KVAR2 = MAX0(KVARA,KVARG) 
      NOBS = 0
  255 READ (IFIN,*,END=256) (DUMMY,I=1,KVAR1-1),DATAX,
     *   (DUMMY,I=KVAR1+1,KVAR2-1),DATAY,(DUMMY,I=KVAR2+1,NVAR)
      NOBS = NOBS + 1
      IF (NOBS.GT.MAXOBS) CALL BIGGIE(NOBS, MAXOBS, 1, IOUT)
C
      DATA(NOBS) = DATAX - DATAY
      GOTO 255
C
  256 CLOSE (IFIN, STATUS = 'KEEP')
      RETURN
C
  260 WRITE (IOUT,270)
  270 FORMAT (' Enter the number of the variable to be analyzed:  ')
      READ (IIN,*,ERR=260) KVARA
      IF (KVARA.GT.NVAR) GOTO 260
      IF (NGRP.EQ.1) GOTO 280
  271 WRITE (IOUT,272)
  272 FORMAT (' Enter the number of the grouping variable ',
     *   '(0, if none):  ')
      READ (IIN,*,ERR=271) KVARG
      IF (KVARG.GT.NVAR) GOTO 271
      IF (KVARG.EQ.0) GOTO 280
C
C        GROUPING VARIABLE PRESENT
C
      KVAR1 = MIN0(KVARA,KVARG)
      KVAR2 = MAX0(KVARA,KVARG) 
      NOBS = 0
  273 READ (IFIN,*,END=274) (DUMMY,I=1,KVAR1-1),DATAX,
     *   (DUMMY,I=KVAR1+1,KVAR2-1),DATAY,(DUMMY,I=KVAR2+1,NVAR)
      NOBS = NOBS + 1
      IF (NOBS.GT.MAXOBS) CALL BIGGIE(NOBS, MAXOBS, 1, IOUT)
C
C        BLOCK IF BELOW
C
      IF (KVARA.LT.KVARG) THEN
         DATA(NOBS) = DATAX
         DATAG(NOBS) = DATAY
      ELSE
         DATA(NOBS) = DATAY
         DATAG(NOBS) = DATAX
      ENDIF
C
      GOTO 273
C
  274 CLOSE (IFIN, STATUS = 'KEEP')
      CALL SHELL2(DATAG,DATA,NOBS)
      IF(DATAG(NOBS).EQ.DATAG(1)) STOP ' *** Only one group...'
C
      M = 1
      DO 275 I = 2, NOBS-1
      IF (DATAG(I).EQ.DATAG(1)) M = M + 1
      IF (DATAG(I).NE.DATAG(1) .AND. DATAG(I).NE.DATAG(NOBS))
     *   STOP ' *** More than two groups...'
  275 CONTINUE
      N = NOBS - M
      RETURN
C
  280 NOBS = 0
      IF (NGRP.EQ.1) GOTO 300
  285 WRITE (IOUT,290)
  290 FORMAT (' Enter number of observations in each group:  ') 
      READ(IIN,*,ERR=285) M, N
      NOBSX = M + N
C
C        SORRY ABOUT STATEMENT 300.  IT USES FORTRAN-77
C        CONVENTIONS THAT IF 1>KVAR-1 OR KVAR+1>NVAR THEN
C        THAT LOOP WILL NOT BE EXECUTED.
C
C        THIS CODE IS NEEDED TO INSURE THE THE APPROPRIATE 
C        NUMBER OF RECORDS ARE SKIPPED IF THERE ARE MORE THAN 
C        ONE RECORD PER CASE.
C
  300 READ (IFIN,*,END=350) (DUMMY,I=1,KVARA-1),DATAX,
     *   (DUMMY,I=KVARA+1,NVAR)
      NOBS = NOBS + 1
      IF (NOBS.GT.MAXOBS) CALL BIGGIE(NOBS, MAXOBS, 1, IOUT)
      DATA(NOBS) = DATAX
      GOTO 300
C
  350 CLOSE (IFIN, STATUS = 'KEEP')
      IF (NGRP.EQ.1 .OR. NOBS.EQ.NOBSX) RETURN
      WRITE(IOUT,360) NOBSX, NOBS
  360 FORMAT(/' ** Sum of group sizes is',I4,'.  File contains',I4,
     *   ' observations.')
      STOP ' '
C
  400 IF (NGRP.EQ.2) GOTO 630
C
C        1.2 ADDITION... COMPUTE DIFFERENCES
C
  405 WRITE(IOUT,408)
  408 FORMAT(/' Will you be entering pairs (P) or ',
     *   'differences (D)?:  ')
      READ (IIN,220) QUERY
      IF(QUERY.EQ.'D' .OR. QUERY.EQ.'d') GOTO 500
      IF(QUERY.NE.'P' .AND. QUERY.NE.'p') GOTO 405
C
  410 WRITE(IOUT,420)
  420 FORMAT(/' Enter the number of pairs:  ')
      READ (IIN,*,ERR=410) NOBS
      IF (NOBS.GT.MAXOBS) CALL BIGGIE(NOBS, MAXOBS, 1, IOUT)
      WRITE(IOUT,425)
  425 FORMAT(/' Enter data, one pair at a time:')
C
      DO 460 I = 1, NOBS
      GOTO 450
  430 WRITE (IOUT,440)
  440 FORMAT (' Error... re-enter pair:')
  450 READ (IIN,*,ERR=430) DATAX, DATAY
      DATA(I) = DATAX - DATAY
  460 CONTINUE
      RETURN
C  
  500 WRITE (IOUT,510)
  510 FORMAT (/' Enter the number of observations:  ')
      READ (IIN,*,ERR=500) NOBS
      IF (NOBS.GT.MAXOBS) CALL BIGGIE(NOBS, MAXOBS, 1, IOUT)
      GOTO 650
C
  630 WRITE (IOUT,290)
      READ(IIN,*,ERR=630) M, N
      NOBS = M + N

  650 WRITE (IOUT,660)
  660 FORMAT(/' Enter data:  ')
      READ (IIN,*,ERR=650) (DATA(I),I=1,NOBS)
      RETURN
      END

      SUBROUTINE SHELL(X, N)
C        SHELL SORT WITH DECREMENTS SUGGESTED BY KNUTH
      INTEGER H0(12), HP1, H, S, T
      DIMENSION X(N)
      DATA H0(1), H0(2), H0(3), H0(4), H0(5), H0(6)/
     *         1,     4,    13,    40,   121,   364/
      DATA H0(7), H0(8), H0(9), H0(10), H0(11), H0(12)/
     *      1093,  3280,  9841,  29524,  88573, 265720/
      NN = N
      DO 1 T = 1, 10
      IF (H0(T+2).GE.NN) GOTO 2
    1 CONTINUE
      T = 11
    2 DO 6 S = 1, T
      H = H0(T+1-S)
      HP1 = H + 1
      DO 5 J = HP1, NN
      I = J - H
      XM = X(J)
    3 IF (XM.GE.X(I)) GOTO 4
      X(I+H) = X(I)
      I = I - H
      IF (I.GT.0) GOTO 3
    4 X(I+H) = XM
    5 CONTINUE
    6 CONTINUE
      RETURN
      END
C
      SUBROUTINE SHELL2(X, Y, N)
C        SHELL SORT WITH DECREMENTS SUGGESTED BY KNUTH
C        Y GOES ALONG FOR THE RIDE
      INTEGER H0(12), HP1, H, S, T
      DIMENSION X(N), Y(N)
      DATA H0(1), H0(2), H0(3), H0(4), H0(5), H0(6)/
     *         1,     4,    13,    40,   121,   364/
      DATA H0(7), H0(8), H0(9), H0(10), H0(11), H0(12)/
     *      1093,  3280,  9841,  29524,  88573, 265720/
      NN = N
      DO 1 T = 1, 10
      IF (H0(T+2).GE.NN) GOTO 2
    1 CONTINUE
      T = 11
    2 DO 6 S = 1, T
      H = H0(T+1-S)
      HP1 = H + 1
      DO 5 J = HP1, NN
      I = J - H
      XM = X(J)
      YM = Y(J)
    3 IF (XM.GE.X(I)) GOTO 4
      X(I+H) = X(I)
      Y(I+H) = Y(I)
      I = I - H
      IF (I.GT.0) GOTO 3
    4 X(I+H) = XM
      Y(I+H) = YM
    5 CONTINUE
    6 CONTINUE

      RETURN
      END
 
