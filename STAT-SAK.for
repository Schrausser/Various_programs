C        
C                                 STAT-SAK
C                            The Statistician's
C                             Swiss Army Knife   
C                                Version 1.0
C                             February 16, 1985
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
C       reference is made to STAT-SAK and its author.  
C
C       Neither  STAT-SAK nor its documentation should be modified in 
C       any way without permission from the author,  except for those 
C       changes  that  are  essential  to move   STAT-SAK to  another 
C       computer.  
C
      DATA IIN /0/, IOUT /0/, NOPT /7/
C
      WRITE(IOUT,1)
    1 FORMAT (//35X,'STAT-SAK'/
     *   30X,'The Statistician''s'/
     *   31X,'Swiss Army Knife'/
     *   34X,'Version 1.0'/31X,'February 16, 1985'//
     *   32X,'Gerard E. Dallal'/
     *   17X,'USDA Human Nutrition Research Center on Aging'/
     *   30X,'at Tufts University'/29X,'711 Washington Street'/
     *   31X,'Boston, MA  02111'//)
C
   90 WRITE(IOUT,100)
  100 FORMAT(/' Your options are:'//
     *        '   1 -- EXIT'/
     *        '   2 -- distribution functions'/
     *        '   3 -- independence in ',
     *        'two-dimensional contingency tables'/
     *        '   4 -- Mantel-Haenszel test / odds ratios'/
     *        '   5 -- McNemar''s test'/
     *        '   6 -- correlation coefficients'/
     *        '   7 -- Bartholomew''s test for increasing proportions'/)
  110 WRITE(IOUT,120)
  120 FORMAT(' Pick one:  ' )
      READ(IIN,*,ERR=90) NPICK
      IF (NPICK.LT.1 .OR. NPICK.GT.NOPT) GOTO 110
C
      GOTO (10000,200,300,400,500,600,700), NPICK
C
  200 CALL PROB(IIN,IOUT)
      GOTO 90
C
  300 CALL GOF(IIN,IOUT)
      GOTO 90
C
  400 CALL MANTEL(IIN,IOUT)
      GOTO 90
C
  500 CALL MCNEMR(IIN,IOUT)
      GOTO 90 
C
  600 CALL CORR(IIN,IOUT)
      GOTO 90
C
  700 CALL BART(IIN,IOUT)
      GOTO 90
C
10000 STOP ' '
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
      FUNCTION ALNORM(X,UPPER)
C
C        ALGORITHM AS 66 APPL. STATIST. (1973) VOL.22, NO.3
C
C        EVALUATES THE TAIL AREA OF THE STANDARD NORMAL CURVE
C        FROM X TO INFINITY IF UPPER IS .TRUE. OR
C        FROM MINUS INFINITY TO X IF UPPER IS .FALSE.
C
      REAL LTONE, UTZERO, ZERO, HALF, ONE, CON, Z, Y, X
      LOGICAL UPPER, UP
C
C        LTONE AND UTZERO MUST BE SET TO SUIT THE PARTICULAR
C        COMPUTER (SEE INTRODUCTORY TEXT)
C
      DATA LTONE, UTZERO/7.0, 18.66/
      DATA ZERO, HALF, ONE, CON/0.0, 0.5, 1.0, 1.28/
      UP = UPPER
      Z = X
      IF (Z .GE. ZERO) GOTO 10
      UP = .NOT. UP
      Z = -Z
   10 IF (Z .LE. LTONE .OR. UP .AND. Z .LE. UTZERO) GOTO 20
      ALNORM = ZERO
      GOTO 40
   20 Y = HALF * Z * Z
      IF (Z .GT. CON) GOTO 30
C
      ALNORM = HALF - Z * (0.398942280444 - 0.399903438504 * Y /
     1   (Y + 5.75885480458 - 29.8213557808 /
     2   (Y + 2.62433121679 + 48.6959930692 /
     3   (Y + 5.92885724438))))
      GOTO 40
C
   30 ALNORM = .398942280385 * EXP(-Y) /
     1   (Z - 3.8052E-8 + 1.00000615302 /
     2   (Z + 3.98064794E-4 + 1.98615381364 /
     3   (Z - 0.151679116635 + 5.29330324926 /
     4   (Z + 4.8385912808 - 15.1508972451 /
     5   (Z + 0.742380924027 + 30.789933034 / (Z + 3.99019417011))))))
C
   40 IF (.NOT. UP) ALNORM = ONE - ALNORM
      RETURN
      END
C
      SUBROUTINE BART(IIN,IOUT)
C
C              BARTHOLOMEW'S TEST FOR ORDERED SAMPLES (INCREASING)
C
      DIMENSION CT(10),X(2,10),P(10)
      CHARACTER*1 QUERY
C
      WRITE(IOUT,2)
    2 FORMAT(//' Limitation:  No more than 10 columns'/)


    3 WRITE(IOUT,4)
    4 FORMAT(' Enter the number of columns:  ', )
      READ(IIN,*,ERR=3) NCOL
      IF(NCOL.LT.2 .OR. NCOL.GT.10) GOTO 3
C
    8 WRITE (IOUT,9)
    9 FORMAT(/' Do you wish to enter both rows (R) or '/
     *        '      one row and column totals (T)?:  ' )
      READ (IIN,10) QUERY
   10 FORMAT(A1)
      IF (QUERY.NE.'R' .AND. QUERY.NE.'r' .AND. 
     *   QUERY.NE.'T' .AND. QUERY.NE.'t') GO TO 8
C
      WRITE (IOUT,5)
    5 FORMAT(' ')
    6 WRITE(IOUT,7) 
    7 FORMAT('         Enter row 1:  ', )
      READ(IIN,*,ERR=6) (X(1,J), J = 1, NCOL)
      IF (QUERY.EQ.'2') GOTO 16
C
      IF (QUERY.EQ.'R' .OR. QUERY.EQ.'r') GOTO 16
   11 WRITE (IOUT,12)
   12 FORMAT(' Enter column totals:  ', )
      READ(IIN,*,ERR=11) (CT(J), J = 1, NCOL)
      GOTO 18
C
   16 WRITE(IOUT,17) 
   17 FORMAT('         Enter row 2:  ', )
      READ(IIN,*,ERR=16) (X(2,J), J = 1, NCOL)
C
C              GET COL TOTALS AND P'S
C
   18 PNUM=0.
      PDEN=0.
      DO 19 J=1,NCOL
      IF (QUERY.EQ.'R' .OR. QUERY.EQ.'r') CT(J)=X(1,J)+X(2,J)
      P(J)=X(1,J)/CT(J)
      PNUM=PNUM+X(1,J)
      PDEN=PDEN+CT(J)
   19 CONTINUE
      PBAR=PNUM/PDEN
C
C              BARTHOLOMEW'S TEST
C              FIRST MASSAGE TABLE
C
      DO 50 J=2,NCOL
      IF (P(J-1).LE.P(J)) GO TO 50
C
C              P DECREASES...DETERMINE VALUE BY 'COLLAPSING'
C              SO THAT SEQUENCE IS MONOTONE
C
      PNUM=P(J-1)*CT(J-1)+P(J)*CT(J)
      PDEN=CT(J-1)+CT(J)
      PX=PNUM/PDEN
C
C              IS IT NECESSARY TO GO FURTHER BACK?
C
      JS=J-1
      IF (JS.EQ.1) GO TO 30
      JM2=J-2
      DO 20 I=1,JM2
      IF (P(JS-1).LE.PX) GO TO 30
      JS=JS-1
      PNUM=PNUM+P(JS)*CT(JS)
      PDEN=PDEN+CT(JS)
      PX=PNUM/PDEN
   20 CONTINUE
   30 DO 40 J1=JS,J
   40 P(J1)=PX
   50 CONTINUE
C
C              CALCULATE STATISTIC
C
      CHISQ=0.
      DO 70 J=1,NCOL
   70 CHISQ=CHISQ+CT(J)*(P(J)-PBAR)**2
      CHISQ=CHISQ/(PBAR*(1.-PBAR))
C
      WRITE (IOUT,80)CHISQ
   80 FORMAT(/' Chi-square statistic for order restriction =', F8.3)
C
C              INDICES FOR USE WITH TABLES
C
      IF (NCOL.NE.3) GOTO 100
      C = SQRT(CT(1) * CT(3) / 
     *   ((CT(1) + CT(2)) * (CT(2) + CT(3))))
      WRITE(IOUT,90) C
   90 FORMAT(' Index for use with the distribution table = ',F5.3)
C
  100 IF (NCOL.NE.4) RETURN
      C1 = SQRT(CT(1) * CT(3) / 
     *   ((CT(1) + CT(2)) * (CT(2) + CT(3))))
      C2 = SQRT(CT(2) * CT(4) / 
     *   ((CT(2) + CT(3)) * (CT(3) + CT(4))))
      WRITE(IOUT,110) C1, C2
  110 FORMAT(' Indices for use with the distribution table:',
     *   5X, 'C1 = ',F5.3,',     C2 = ',F5.3)
C
      RETURN
      END
C
      FUNCTION BETAIN(X,P,Q)
C
C        ALGORITHM AS 63  APPL.STATIST. (1973), VOL.22, NO.3
C        MODIFIED AS PER REMARK ASR 19  (1977), VOL.26, NO. 1
C        ***[FAULT INDICATOR REMOVED BY G.E.D.]***
C
C        COMPUTES INCOMPLETE BETA FUNCTION RATIO FOR ARGUMENTS
C        X BETWEEN ZERO AND ONE, P AND Q POSITIVE.
C        LOG OF COMPLETE BETA FUNCTION, BETA, ASSUMED TO BE KNOWN.
C        ***[CALCULATION OF BETA ADDED BY G.E.D]***
C
      LOGICAL INDEX
C
C        DEFINE ACCURACY AND INITIALIZE
C
      DATA ACU /0.1E-7/
      BETAIN = X 
C
C        TEST FOR ADMISIBILITY OF AGRUMENTS
C
      IF (P .LE. 0.0 .OR. Q .LE. 0.0) STOP 40
      IF (X .LT. 0.0 .OR .X .GT. 1.0) STOP 41
      IF (X .EQ .0.0 .OR .X .EQ. 1.0) RETURN
C
C     CHANGE TAIL IF NECESSARY AND DETERMINE S
C
      PSQ = P + Q
      CX = 1.0 - X
      IF (P .GE .PSQ * X) GOTO 1
      XX = CX
      CX = X
      PP = Q
      QQ = P
      INDEX = .TRUE.
      GOTO 2
    1 XX = X
      PP = P
      QQ = Q
      INDEX = .FALSE.
    2 TERM = 1.0
      AI = 1.0
      BETAIN = 1.0
      NS = QQ + CX * PSQ
C
C        USE SOPER'S REDUCTION FORMULAE
C
      RX = XX / CX
    3 TEMP = QQ - AI
      IF (NS .EQ. 0) RX = XX
    4 TERM = TERM * TEMP * RX / (PP + AI)
      BETAIN = BETAIN + TERM
      TEMP = ABS(TERM)
      IF (TEMP .LE. ACU .AND. TEMP .LE. ACU * BETAIN) GOTO 5
      AI = AI + 1.0
      NS = NS - 1
      IF (NS .GE. 0) GOTO 3
      TEMP = PSQ
      PSQ = PSQ + 1.0
      GOTO 4
C
C        CALCULATE RESULT
C
    5 BETA = ALGAMA(P) + ALGAMA(Q) - ALGAMA(P+Q)
      BETAIN = BETAIN * 
     *     EXP(PP * ALOG(XX) + (QQ - 1.0) * ALOG(CX) - BETA) / PP
      IF (INDEX) BETAIN = 1.0 - BETAIN
      RETURN
      END
C
      FUNCTION CHIDFC(X,NDF)
C
C        RETURNS P(CHISQ(NDF).GT.X), WHERE CHISQ(NDF) IS A CHI-SQUARE
C        RANDOM VARIABLE WITH 'NDF' DEGREES OF FREEDOM.
C
C        IF  X.LE.0, RETURNS THE VALUE 1.0
C
C        UPPER TAIL RECURRENCE FORMULA...
C           Q(X/NDF)=Q(X/NDF-2)+X**(NDF/2-1)*EXP(-X/2)/GAMMA(NDF/2),
C              WHERE Q(X/NDF) IS THE UPPER TAIL, (X, INFINITY), OF THE
C              CHI-SQUARE DISTRIBUTION WITH 'NDF' DEGREES OF FREEDOM.
C        SEE HANDBOOK OF MATHEMATICAL FUNCTIONS,
C        NBS,55(1964),26.4.8
C
C        USES WILSON-HILFERTY APPROXIMATION FOR NDF.GT.NDFBIG
C        NBS HANDBOOK, 24.4.17
C           (X/NDF)**(1./3.) IS APPROXIMATLEY NORMALLY DISTRIBUTED
C           WITH MEAN 1.-2./(9.*NDF) AND VARIANCE 2./(9.*NDF)
C
C        REQUIRES FUNCTIONS ALNORM, ALGAMA
C
C        WRITTEN BY  Gerard E. Dallal
C                    USDA-Human Nutrition Research Center on Aging
C                               at Tufts University
C                    711 Washington Street
C                    Boston, MA  02111
C
C
C        EXPBIG IS A NUMBER GREATER THAN THE MOST NEGATIVE VALID
C           ARGUMENT TO THE EXP() FUNCTION.
C
      DATA NDFBIG /60/, EXPBIG /-80.0/
C
      CHIDFC = 1.0
      IF (X .LE. 0.0 .OR. NDF .LT. 1) RETURN
      CHIDFC = 0.
      DF = NDF
      IF (NDF .GT. NDFBIG) GOTO 50
      HX = X / 2.0
      IF ((NDF / 2) * 2 .EQ. NDF) GOTO 30
C
C        ODD NUMBER OF DEGREES OF FREEDOM
C
      IF (NDF .EQ. 1) GOTO 20
C
      INDEX = (NDF - 1) / 2
      DO 10 I = 1, INDEX
      C = FLOAT(I) + 0.5
      D = (C - 1.0) * ALOG(HX) - HX - ALGAMA(C)
      IF (D .GT. EXPBIG) CHIDFC = CHIDFC + EXP(D)
   10 CONTINUE
   20 CHIDFC = CHIDFC + 2.0 * ALNORM (SQRT(X), .TRUE.)
      RETURN
C
C        EVEN NUMBER OF DEGREES OF FREEDOM
C
   30 INDEX = NDF / 2
      DO 40 I = 1, INDEX
      C = I
      D =(C - 1.0) * ALOG(HX) - HX - ALGAMA(C)
      IF (D .GT. EXPBIG) CHIDFC = CHIDFC + EXP(D)
   40 CONTINUE
      RETURN
C
   50 D = 2.0 / (9.0 * DF)
      D = ((X / DF) ** (1.0 / 3.0) + D - 1.0) / SQRT(D)
      CHIDFC = ALNORM(D, .TRUE.)
      RETURN
      END
C
      SUBROUTINE CORR(IIN,IOUT)
C
      CHARACTER*1 QUERY
C
   10 WRITE (IOUT,20)
   20 FORMAT (/'   1 -- confidence interval for a single '
     *   'correlation coefficient'/
     *         '   2 -- compare two independent correlation '
     *   'coefficients'//' Pick one:  ', )
      READ (IIN,30) QUERY
   30 FORMAT (A1)
      IF (QUERY.NE.'1' .AND. QUERY.NE.'2') GOTO 10
C
      IF (QUERY.EQ.'1') CALL CORR1(IIN,IOUT)
      IF (QUERY.EQ.'2') CALL CORR2(IIN,IOUT)
      RETURN
      END
C
      SUBROUTINE CORR1(IIN,IOUT)
C
C        TWO-SIDED CONFIDENCE LIMITS FOR A POPULATION CORRELATION
C        COEFFICIENT.  TRANSLATED FROM THE BASIC PROGRAM ON P.300 OF
C          MAINDONALD, J.H.(1984)  STATISTICAL COMPUTATION.
C          NEW YORK:  JOHN WILEY & SONS, INC.
C
C        USES APPROXIMATION FROM 
C          WINTERBOTTOM, ALAN (1980).  ESTIMATION FOR THE BIVARIATE
C          NORMAL CORRELATION COEFFICIENT USING ASYMPTOTIC EXPANSIONS 
C
C        THREE DIGIT ACCURACY FOR SAMPLES OF 10
C        NEARLY FOUR DIGIT ACCURACY FOR SAMPLES OF 25 OR MORE     
C
      FNA(X,R,V,Z) = Z + X / SQRT(V) - R / (2.0 * V) + X * (X**2 +
     *   3.0 * (1.0 + R**2)) / (12.0 * V * SQRT(V))
      FNB(X,R,V) = R * (4.0 * (R * X)**2 + 5.0 * R**2 + 9.0) /
     *   (24.0 * V**2)
      FNC(X,R3,R4,V) = X * (X**4 + R3 * X**2 + R4) / 
     *   (480.0 * V**2 * SQRT(V))
      FNT(X,R,R3,R4,V,Z) = FNA(X,R,V,Z) - FNB(X,R,V) + FNC(X,R3,R4,V)
      FNR(Z) = (EXP(2.0 * Z) - 1.0) / (EXP(2.0 * Z) + 1.0)

C
   90 WRITE (IOUT,100)
  100 FORMAT(/' Enter confidence level:  ' )
      READ(IIN,*,ERR=90) CONF
      IF (CONF.LE.0.0 .OR. CONF.GE.1.0) GOTO 90
      Z0 = -GAUINV((1.0 - CONF)/ 2.0,IFAULT)
C
  110 WRITE(IOUT,120)
  120 FORMAT(' Enter sample correlation coefficient:  ' )
      READ(IIN,*,ERR=110) R
      IF(ABS(R).GT.1) GOTO 110
  130 WRITE(IOUT,140)
  140 FORMAT(' Enter number of observations:  ' )
      READ(IIN,*,ERR=130) N2
      IF (N2.LT.2) GOTO 130
C
      V = N2 - 1
      Z = 0.5 * ALOG((1.0 + R) / (1.0 - R))
      R3 = 60.0 * R**4 - 30.0 * R**2 + 20.0
      R4 = 165.0 * R**4 + 30.0 * R**2 + 15.0
      X = -Z0
      Z1 = FNT(X,R,R3,R4,V,Z)
      X = Z0
      Z2 = FNT(X,R,R3,R4,V,Z)
      R1 = FNR(Z1)
      R2 = FNR(Z2)
      WRITE(IOUT,150) 100.0*CONF,R1,R2
  150 FORMAT (' The ',F4.1,'-% confidence interval is (',
     *   F7.4,', ',F7.4,')')
      RETURN
      END
C
      SUBROUTINE CORR2(IIN,IOUT)
C
C             USES FISHER'S Z TO COMPARE TO CORRELATION COEFFICENTS
C
   10 WRITE (IOUT,20) 
   20 FORMAT(/' Enter first correlation coefficient:  ' )
   30 READ (IIN,*,ERR=10) CC1
      IF(ABS(CC1).GT.1.0) GOTO 10
   40 WRITE (IOUT,50)
   50 FORMAT (' Enter first sample size:  ' )
      READ (IIN,*,ERR=40) N1
C
  110 WRITE (IOUT,120) 
  120 FORMAT(' Enter second correlation coefficient:  ' )
  130 READ (IIN,*,ERR=110) CC2
      IF(ABS(CC2).GT.1.0) GOTO 110
  140 WRITE (IOUT,150)
  150 FORMAT (' Enter second sample size:  ' )
      READ (IIN,*,ERR=140) N2
C
      Z = 0.0
      P = 0.0
      IF (N1.LE.3 .OR. N2.LE.3) GOTO 400
C
      CC1 = 0.5 * ALOG((1.0 + CC1) / (1.0 - CC1))
      CC2 = 0.5 * ALOG((1.0 + CC2) / (1.0 - CC2))
      Z = ABS(CC1 - CC2)/ SQRT(1.0 / FLOAT(N1 - 3) + 
     *   1.0 / FLOAT(N2 - 3))
      P = 2.0 * ALNORM(Z,.TRUE.)
C
  400 WRITE(IOUT,410) Z, P
  410 FORMAT (/' Test statistic = ',G12.5,'      P-value = ',F5.3)
      RETURN
      END
C
      FUNCTION FDFC(FQUAN, DFN, DFD)
C
C        THE COMPLEMENT OF CDF OF THE F DISTRIBUTION
C        WITH DFN NUMERATOR DEGREES OF FREEDOM AND DFD DENOMINATOR 
C        DEGREES OF FREEDOM EVALUATED AT FQUAN.
C
C
      ESQ = (DFN * FQUAN) / (DFD + DFN * FQUAN)
      FDFC = BETAIN (ESQ, DFN/2.0, DFD / 2.0)
      RETURN
      END
C
      SUBROUTINE FDFC0(IIN, IOUT)
C
C        GET INFO FOR F-DISTRIBUTION CALCULATION
C
   10 WRITE (IOUT,20)
   20 FORMAT(/' Enter numerator degrees of freedom:  ' )
      READ (IIN,*,ERR=10) DFN
   30 WRITE (IOUT,40)
   40 FORMAT(' Enter denominator degrees of freedom:  ' )
      READ (IIN,*,ERR=30) DFD
   50 WRITE (IOUT,60)
   60 FORMAT(' Enter F-statistic:  ' )
      READ (IIN,*,ERR=50) FQUAN
      PVAL = 1.0 - FDFC(FQUAN,DFN,DFD)
      WRITE (IOUT,80) PVAL
   80 FORMAT (/' P-value (upper tail) =',F8.5)
      RETURN
      END
C
      FUNCTION GAMAIN(X,P)
C
C        ALGORITHM AS 32 J.R.STATIST.SOC. C. (1970) VOL.19 NO.3
C
C        COMPUTES INCOMPLETE GAMMA RATIO FOR POSITIVE VALUES OF
C        ARGUMENTS X AND P.  G MUST BE SUPPLIED AND SHOULD BE EQUAL TO
C        LN(GAMMA(P)).
C        IFAULT = 1 IF P.LE.0 ELSE 2 IF X.LT.0 ELSE 0
C        USES SERIES EXPANSION IF P.GT.X OR X.LE.1, OTHERWISE A 
C        CONTINUED FRACTION APPROXIMATION.C
C
C        [FAULT INDICATOR REMOVED BY G.E.D
C        CALCULATION OF G INSERTED BY G.E.D.]
C
      DIMENSION PN(6)
C
C        DEFINE ACCURACY AND INITIALIZE
C
      ACU = 1.0E-8
      OFLO = 1.0E30
      GIN = 0.0
C
C        TEST FOR ADMISSIBILITY OF ARGUMENTS
C
      IF (P .LE. 0.0) STOP 21
      IF (X .LT. 0.0) STOP 22
      IF (X .EQ. 0.0) GOTO 50
      G = ALGAMA(P)
      FACTOR = EXP(P * ALOG(X) - X - G)
      IF (X .GT. 1.0 .AND. X .GE. P) GOTO 30
C
C        CALCULATION BY SERIES EXPANSION
C
      GIN = 1.0
      TERM = 1.0
      RN = P
   20 RN = RN + 1.0
      TERM = TERM * X / RN
      GIN = GIN + TERM
      IF (TERM .GT. ACU) GOTO 20
      GIN = GIN * FACTOR / P
      GOTO 50
C
C        CALCULATION BY CONTINUED FRACTION
C
   30 A = 1.0 - P
      B = A + X + 1.0
      TERM = 0.0
      PN(1) = 1.0
      PN(2) = X
      PN(3) = X + 1.0
      PN(4) = X * B
      GIN = PN(3) / PN(4)
   32 A = A + 1.0
      B = B + 2.0
      TERM = TERM + 1.0
      AN = A * TERM
      DO 33 I = 1, 2
   33 PN(I+4) = B * PN(I+2) - AN * PN(I)
      IF (PN(6) .EQ. 0.0) GOTO 35
      RN = PN(5) / PN(6)
      DIF = ABS(GIN - RN)
      IF (DIF .GT. ACU) GOTO 34
      IF (DIF .LE. ACU * RN) GOTO 42
   34 GIN = RN
   35 DO 36 I = 1, 4
   36 PN(I) = PN(I+2)
      IF (ABS(PN(5)).LT.OFLO) GOTO 32
      DO 41 I = 1, 4
   41 PN(I) = PN(I) / OFLO
      GOTO 32
   42 GIN = 1.0 - FACTOR * GIN
C
   50 GAMAIN = GIN
      RETURN
      END
C
      FUNCTION GAUINV(P,IFAULT)
C
C              ALGORITHM AS 70 APPL. STATIST. (1974) VOL. 23, NO.1
C              GAUINV FINDS PERCENTAGE POINTS OF THE NORMAL DISTRIBUTION
C
      DATA ZERO,ONE,HALF,ALIMIT/0.0, 1.0, 0.5, 1.0E-20/
C
      DATA             P0,  P1,             P2,                P3
     1   / -.322232431088, -1., -.342242088547, -.204231210245E-1/
C
      DATA                P4,               Q0,            Q1
     1   / -.453642210148E-4, .993484626060E-1, .588581570495/
C
      DATA            Q2,            Q3,              Q4
     1   / .531103462366, .103537752850, .38560700634E-2/
C
      IFAULT=1
      GAUINV=ZERO
      PS=P
      IF (PS.GT.HALF) PS=ONE-PS
      IF (PS.LT.ALIMIT) RETURN
      IFAULT=0
      IF (PS.EQ.HALF) RETURN
      YI=SQRT(ALOG(ONE/(PS*PS)))
      GAUINV=YI+((((YI*P4+P3)*YI+P2)*YI+P1)*YI+P0)
     1         /((((YI*Q4+Q3)*YI+Q2)*YI+Q1)*YI+Q0)
      IF (P.LT.HALF) GAUINV=-GAUINV
      RETURN
      END
C
      SUBROUTINE GOF(IIN,IOUT)
C
C        TEST OF INDEPENDENCE AND HOMOGENEITY OF VARIANCE
C        FOR TWO-DIMENSIONAL CONTINGENCY TABLES
C
C        LIMITATIONS:  NO MORE THAN FIVE ROWS OR COLUMNS.
C
      INTEGER ITABLE(5,10), IR(5), IC(10)
      CHARACTER*1 QUERY
      DATA NROW /5/, NCOL /10/

C-----WRITE OUT WARNING ON LIMITATIONS OF METHOD

      WRITE(IOUT,20)
   20 FORMAT(//2X,'Limitation:  No more than 5 rows or 10 columns'/)


   30 WRITE(IOUT,70)
   70 FORMAT(/2X,'Enter the number of rows:  ', )
      READ(IIN,*,ERR=30)LROW
   75 WRITE(IOUT,80)
   80 FORMAT(2X,'Enter the number of columns:  ', )
      READ(IIN,*,ERR=75)LCOL
      IF(LROW.LE.NROW.AND.LCOL.LE.NCOL)GO TO 100
      WRITE(IOUT,90)
   90 FORMAT(2X,'*** Permissible table dimensions exceeded')
      GO TO 30
C
  100 WRITE (IOUT,110)
  110 FORMAT(' ')
      DO 130 I = 1, LROW
  125 WRITE(IOUT,120) I
  120 FORMAT(2X,'Enter row #',I1,':  ', )
      READ(IIN,*,ERR=125)(ITABLE(I,J), J = 1, LCOL)
  130 CONTINUE

      DO 140 J = 1, LCOL
      IC(J) = 0
      DO 140 I = 1, LROW
      IC(J) = IC(J) + ITABLE(I,J)
  140 CONTINUE
C
C        COMPUTE ROW SUMS AND GRAND TOTAL
C
      GRAND = 0.0
      DO 160 I = 1, LROW
      IR(I) = 0
      DO 150 J = 1, LCOL
      IR(I) = IR(I) + ITABLE(I,J)
  150 CONTINUE
      GRAND = GRAND + FLOAT(IR(I))
  160 CONTINUE
C
C        COMPUTE CHI-SQUARE P-VALUES
C
  180 CHISQ = 0.0
      DO 190 I = 1, LROW
      DO 190 J = 1, LCOL
      EXPECT = FLOAT(IR(I)) * FLOAT(IC(J)) / GRAND
      CHISQ = CHISQ + (FLOAT(ITABLE(I,J)) - EXPECT)**2 / EXPECT
  190 CONTINUE
      NDF = (LROW - 1) * (LCOL - 1)
      PCHI = CHIDFC(CHISQ,NDF)
      WRITE(IOUT,200) CHISQ,NDF,PCHI
  200 FORMAT(/'  Pearson chi-square equals ',G11.4,' with',I3,
     *   ' d.f.  (P-value = ',F7.5,')')
C
      IF (LROW.GT.2 .OR. LCOL.GT.2) GOTO 290
C
C        YATES'S CONTINUITY CORRECTED CHI-SQUARE STATISTIC
C
      YCHISQ = 0.0
      DO 201 I = 1, 2
      DO 201 J = 1, 2
      EXPECT = FLOAT(IR(I)) * FLOAT(IC(J)) / GRAND
      YCHISQ = YCHISQ + (ABS(FLOAT(ITABLE(I,J)) - EXPECT) - 0.5)**2 
     *   / EXPECT
  201 CONTINUE
      YPCHI = CHIDFC(YCHISQ,1)
      WRITE(IOUT,202) YCHISQ,YPCHI
  202 FORMAT ('  Yates''s corrected chi-square equals ',G11.4,
     *   '     (P-value = ',F7.5,')')

  290 WRITE(IOUT,300)
  300 FORMAT(/2X,'Entering another table?  (Y or N):  ' )
      READ(IIN,310) QUERY
  310 FORMAT (A1)
      IF (QUERY.EQ.'Y' .OR. QUERY.EQ.'y') GOTO 30
      RETURN
      END
C
      SUBROUTINE MANTEL(IIN,IOUT)
C
C        MANTEL-HAENSZEL ESTIMATE OF COMMON ODDS RATIO
C        MANTEL-HAENSZEL STATISTIC TESTING SIGNIFICANCE OF 
C          COMMON ODDS RATIO
C        APPROXIMATE C.I. FOR COMMON ODDS RATION BASED ON 
C          FLEISS(1981, EQ. 10.22).  THIS FORMULA CAN ALSO
C          BE USED TO CONSTRUCT AN APPROXIMATE C.I. FOR A 
C          SINGLE 2*2 TABLE.
C
   90 WRITE(IOUT,100)
  100 FORMAT(/' Enter the number of 2 * 2 tables:  ' )
      READ(IIN,*,ERR=90) NTAB
      IF (NTAB.LT.1 .OR. NTAB.GT.6) GOTO 90
C
      SN = 0.0
      SD = 0.0
      SNMH = 0.0
      SDMH = 0.0
      ODDSN = 0.0
      ODDSD = 0.0
C
      DO 300 K = 1, NTAB
  110 WRITE (IOUT,120) K
  120 FORMAT(/' Enter row 1 of table',I2,':  ' )
      READ(IIN,*,ERR=110) TAB11, TAB12
  130 WRITE (IOUT,140) K
  140 FORMAT(' Enter row 2 of table',I2,':  ' )
      READ(IIN,*,ERR=130) TAB21, TAB22
      IF (TAB11 * TAB12 * TAB21 * TAB22 .GT. 0.0) GOTO 160
      WRITE(IOUT,150)
  150 FORMAT(/' Can''t evaluate odds ratio with counts of 0',
     *   ' in the data.')
      RETURN
C
  160 SUM = TAB11 + TAB12 + TAB21 + TAB22
C
C        MANTEL-HAENSZEL CHI-SQUARE STATISTIC
C
      SN = SN + TAB11 - (TAB11 + TAB12) *
     *   (TAB11 + TAB21) / SUM
      SD = SD + (TAB11 + TAB12) * (TAB11 + TAB21)
     *   * (TAB21 + TAB22) * (TAB12 + TAB22) /
     *   (SUM * SUM * (SUM-1.0))
C
C        MANTEL-HAENSZEL ESTIMATE OF COMMON ODDS RATIO
C
      SNMH = SNMH + TAB11 * TAB22 / SUM
      SDMH = SDMH + TAB12 * TAB21 / SUM
C
C        C.I. FOR ODDS RATIO BASED ON COMBINING LOG ODDS (FLIESS, 10.22)
C
      WEIGHT = 1.0 / TAB11 + 1.0 / TAB12 + 1.0 / TAB21 + 1.0 / TAB22
      WEIGHT = 1.0 / WEIGHT
      ODDSD = ODDSD + WEIGHT
      ODDSN = ODDSN + WEIGHT * ALOG(TAB11 * TAB22 / (TAB12 * TAB21))
C
  300 CONTINUE
C
C        MANTEL-HAENSZEL CHI-SQUARE
C
      CHISQ = (ABS(SN) - 0.5)**2 / SD
      PVAL = ALNORM(SQRT(CHISQ),.TRUE.)
C
C        MANTEL-HAENSZEL ESTIMATE
C
      ODDS = SNMH / SDMH
C
C        C.I. FOR ODDS RATIO
C
  310 WRITE(IOUT,320)
  320 FORMAT(/' Enter desired level of confidence:  ' )
      READ(IIN,*,ERR=310) CONF
      COEF = -GAUINV((1.0 - CONF) / 2.0, IFAULT)
      CONF = 100.0 * CONF
      ODDSC = ODDSN / ODDSD
      ODDSSE = 1.0 / SQRT(ODDSD)
      CL = EXP(ODDSC - COEF * ODDSSE)
      CU = EXP(ODDSC + COEF * ODDSSE)
C
      WRITE(IOUT,400) ODDS,CHISQ, PVAL,CONF,CL,CU
  400 FORMAT(/' Common odds ratio = ',G12.5/
     *   ' Mantel-Haenszel chi-square statistic = ',G11.4/
     *   ' P-value = ',F6.4//
     *   ' Approximate ',F4.1,'-% confidence interval for the odds',
     *   ' ratio:'/'      (',F7.3,',',F7.3,')')
C
      RETURN
      END
C
      SUBROUTINE MCNEMR(IIN,IOUT)
C
C        MCNEMAR'S TEST
C
   90 WRITE(IOUT,100)
  100 FORMAT (/' Enter two discordant cells:  ' )
      READ(IIN,*,ERR=90) B, C
C
      XMIN = AMIN1(B,C)
      SUM = B + C
      CHISQ = (2.0 * XMIN - SUM + 1.0)**2 / SUM
      PVAL = 2.0 * ALNORM(SQRT(CHISQ),.TRUE.)
C
      WRITE(IOUT,120) CHISQ, PVAL
  120 FORMAT(' Chi-square statistic = ',G11.4,' with 1 d.f.  P-value'
     *   ' = ',F6.4)
      RETURN
      END
C
      FUNCTION PPCHI2(P,V)
C
C        ALGORITHM AS 91  APPL. STATIST. (1975) VOL.24, NO.3
C
C        TO EVALUATE THE PECENTAGE POINTS OF THE CHI-SQUARED
C        PROBABILITY DISTRIBUTION FUNCTION.
C        P MUST LIE IN THE RANGE 0.000002 TO 0.999998, V MUST BE POSITIVE,
C        G MUST BE SUPPLIED AND SHOULD BE EQUAL TO LN(GAMMA(V/2.0))
C
C        [FAULT INDICATOR REMOVED BY G.E.D.  
C        CALCULATION OF G ADDED BY G.E.D.
C
      DATA E, AA /0.5E-6, 0.6931471805/
C
C        AFTER DEFINING THE ACCURACY AND LN(2), TEST ARGUMENTS AND INITIALIZE
C
      PPCHI2 = -1.0
      IF (P .LT. 0.000002 .OR. P .GT. 0.999998) STOP 31
      IF (V .LE. 0.0) STOP 32
      G = ALGAMA(V / 2.0)
      XX = 0.5 * V
      C = XX - 1.0
C
C        STARTING APPROXIMATION FOR SMALL CHI-SQUARED
C
      IF (V .GE. -1.24 * ALOG(P)) GOTO 1
      CH = (P * XX * EXP(G + XX * AA)) ** (1.0 / XX)
      IF (CH - E) 6, 4, 4
C
C        STARTING APPROXIMATION FOR V LESS THAN OR EQUAL TO 0.32
C
    1 IF (V .GT. 0.32) GOTO 3
      CH = 0.4
      A = ALOG(1.0 - P)
    2 Q = CH
      P1 = 1.0 + CH * (4.67 + CH)
      P2 = CH * (6.73 + CH * (6.66 + CH))
      T = -0.5 + (4.67 + 2.0 * CH) / P1 -
     *   (6.73 + CH * (13.32 + 3.0 * CH)) / P2
      CH = CH - (1.0 - EXP(A + G + 0.5 * CH + C * AA) * P2 / P1) / T
      IF (ABS(Q / CH - 1.0) - 0.01) 4, 4, 2
C
C        CALL TO ALGORITHM AS 70 - NOTE THAT P HAS BEEN TESTED ABOVE
C
    3 X = GAUINV(P,IF1)
C
C        STARTING APPROXIMATION USING WILSON AND HILFERTY ESTIMATE
C
      P1 = 0.222222 / V
      CH = V * (X * SQRT(P1) + 1.0 - P1) ** 3
C
C        STARTING APPROXIMATION FOR P TENDING TO 1
C
      IF (CH .GT. 2.2 * V + 6.0)
     *   CH = -2.0 * (ALOG(1.0 - P) - C * ALOG(0.5 * CH) + G)
C
C        CALL TO ALGORITHM AS 32 AND CALCULATION OF SEVEN TERM
C        TAYLOR SERIES
C
    4 Q = CH
      P1 = 0.5 * CH
      P2 = P - GAMAIN(P1, XX)
      T = P2 * EXP(XX * AA + G + P1 - C * ALOG(CH))
      B = T / CH
      A = 0.5 * T - B * C
      S1 = (210.0+A*(140.0+A*(105.0+A*(84.0+A*(70.0+60.0*A))))) / 420.0
      S2 = (420.0+A*(735.0+A*(966.0+A*(1141.0+1278.0*A)))) / 2520.0
      S3 = (210.0 + A * (426.0 + A * (707.0 + 932.0 * A))) / 2520.0
      S4 =(252.0+A*(672.0+1182.0*A)+C*(294.0+A*(889.0+1740.0*A)))/5040.0
      S5 = (84.0 + 264.0 * A + C * (175.0 + 606.0 * A)) / 2520.0
      S6 = (120.0 + C * (346.0 + 127.0 * C)) / 5040.0
      CH = CH+T*(1.0+0.5*T*S1-B*C*(S1-B*(S2-B*(S3-B*(S4-B*(S5-B*S6))))))
      IF (ABS(Q / CH - 1.0) .GT. E) GOTO 4
C
    6 PPCHI2 = CH
      RETURN
      END
C
      SUBROUTINE PROB(IIN, IOUT)
C
C        PROBABILITY CALCULATION
C
      DATA MAXDIST /5/
C
      NDIST = 2
   10 WRITE (IOUT,30)
   30 FORMAT (/' Which distribution ?:'//
     *   '        1 -- RETURN to main menu'/
     *   '        2 -- standard normal'/
     *   '        3 -- Student''s t'/
     *   '        4 -- chi-square'/
     *   '        5 -- F'//)
   40 WRITE (IOUT,50) NDIST
   50 FORMAT (' Pick one [',I1,']:  ' )
      READ (IIN,60,ERR=40) XNDIST
   60 FORMAT (BN,F18.0)
      IF (XNDIST.EQ.1.0) RETURN
      IF (XNDIST.EQ.0.0) GOTO 70
      IF (XNDIST.LT.2.0 .OR. XNDIST.GT.MAXDIST) GOTO 40
      NDIST = XNDIST
C
   70 GOTO (40,100,200,300,400), NDIST
C
  100 CALL N01(IIN,IOUT)
      GOTO 10
C
  200 CALL STUDNT(IIN,IOUT)
      GOTO 10
C
  300 CALL X2DFC0(IIN,IOUT)
      GOTO 10
C
  400 CALL FDFC0(IIN,IOUT)
      GOTO 10
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
      F = IDF
      A = T / SQRT(F)
      B = F / (F + T ** 2)
      IM2 = IDF - 2
      IOE = IDF - 2 * (IDF / 2)
      S = 1.0
      C = 1.0
      KS = 2 + IOE
      FK = KS
      IF (IM2 - 2) 6, 7, 7
    7 DO 8 K = KS, IM2, 2
      C = C * B * (FK - 1.0) / FK
      S = S + C
    8 FK = FK + 2.0
    6 IF (IOE) 1, 1, 2
    1 PROBST = 0.5 + 0.5 * A * SQRT(B) * S
      GOTO 3
    2 IF (IDF - 1 ) 4, 4, 5
    4 S = 0.0
    5 PROBST = 0.5 + (A * B * S + ATAN(A)) * G1
    3 RETURN
      END
C
      SUBROUTINE X2DFC0(IIN, IOUT)
C
C        GET INFO FOR CHI-SQUARE DISTRIBUTION CALCULATION
C
      WRITE(IOUT,10)
   10 FORMAT(/' 1 -- from statistic to percentile'/
     *        ' 2 -- from percentile to statistic'/)
   20 WRITE(IOUT,30)
   30 FORMAT('                          Pick one:  ' )
      READ (IIN,*,ERR=20) NPICK
      IF (NPICK.NE.1 .AND. NPICK.NE.2) GOTO 20
      IF(NPICK.EQ.2) GOTO 200
C
  110 WRITE (IOUT,120)
  120 FORMAT(/' Enter degrees of freedom:  ' )
      READ (IIN,*,ERR=110) DF
      IF (DF.NE.FLOAT(IFIX(DF))) GOTO 110
      NDF = DF
  130 WRITE (IOUT,140)
  140 FORMAT(' Enter chi-square statistic:  ' )
      READ (IIN,*,ERR=130) CHISQ
      PVAL = CHIDFC(CHISQ,NDF)
      WRITE (IOUT,150) PVAL
  150 FORMAT (/' P-value (upper tail) =',F8.5)
      RETURN
C
  200 WRITE (IOUT,210)
  210 FORMAT(/' Enter P-value (upper tail):  ' )
      READ(IIN,*,ERR=200) PVAL
      IF(PVAL.LT.0.0 .OR. PVAL.GT.1.0) GOTO 200
  220 WRITE (IOUT,230)
  230 FORMAT(' Enter degrees of freedom:  ' )
      READ (IIN,*,ERR=220) DF
      WRITE(IOUT,250) PPCHI2(1.0 - PVAL,DF)
  250 FORMAT (/' Percentile = ',G12.5)
      RETURN
      END
C
      SUBROUTINE STUDNT(IIN, IOUT)
C
C        INFORMATION FOR STUDENT'S T-DISTRIBUTION
C
  110 WRITE (IOUT,120)
  120 FORMAT(/' Enter degrees of freedom:  ' )
      READ (IIN,*,ERR=110) DF
      IF (DF.NE.FLOAT(IFIX(DF))) GOTO 110
      NDF = DF
  130 WRITE (IOUT,140)
  140 FORMAT(' Enter t-statistic:  ' )
      READ (IIN,*,ERR=130) T
      PVAL = PROBST(T,NDF)
C
      WRITE(IOUT,170) 1.0 - PVAL, PVAL, 
     *   2.0 * AMIN1(1.0 - PVAL, PVAL)
  170 FORMAT(/25X,'Upper tail = ',F7.4,
     *       /25X,'Lower tail = ',F7.4,
     *       /25X,'Two-tailed = ',F7.4)
      RETURN
      END
C
      SUBROUTINE N01(IIN, IOUT)
C
C        INFORMATION FOR STANDARD NORMAL DISTRIBUTION
C
      WRITE(IOUT,10)
   10 FORMAT(/' 1 -- from statistic to probability'/
     *        ' 2 -- from probability to statistic'/)
   20 WRITE(IOUT,30)
   30 FORMAT('                          Pick one:  ' )
      READ (IIN,*,ERR=20) NPICK
      IF (NPICK.NE.1 .AND. NPICK.NE.2) GOTO 20
      IF(NPICK.EQ.2) GOTO 200
C
  130 WRITE (IOUT,140)
  140 FORMAT(/' Enter statistic:  ' )
      READ (IIN,*,ERR=130) Z
      PVAL = ALNORM(Z,.TRUE.)
C
      WRITE(IOUT,170) PVAL, 1.0 - PVAL, 
     *   2.0 * AMIN1(1.0 - PVAL, PVAL)
  170 FORMAT(/25X,'Upper tail = ',F7.4,
     *       /25X,'Lower tail = ',F7.4,
     *       /25X,'Two-tailed = ',F7.4)
      RETURN
C
  200 WRITE (IOUT,210)
  210 FORMAT(/' Enter upper tail probability:  ' )
      READ(IIN,*,ERR=200) PVAL
      IF(PVAL.LT.0.0 .OR. PVAL.GT.1.0) GOTO 200
      WRITE(IOUT,250) ABS(GAUINV(PVAL,IFAULT))
  250 FORMAT (/' Quantile = ',G12.5)
      RETURN
      END 
