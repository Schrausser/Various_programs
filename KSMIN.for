      program ks
      include 'ksblks.for'
************************************************************************
*                                                                      *
* This program finds the p-value for a 2-sample Kolmogorov-Smirnov test*
* using an exact algorithm.                                            *
* Data is integer-valued in the form:                                  *
* tail, i.e. 1 to test F1 > F2, 2 to test F2 > F1, 3 for 2-sided test  *
* of F1 ne F2.                                                         *
* < number in 1st group>                                               *
* , data values,                                                       *
* < number in 2nd group>                                               *
* data values.                                                         *
* data values need not be in sorted order.                             *
* Censored values are assumed to be tied lowest and/or  highest values.*
* Uses `inside' algorithm with subtraction from unity.                 *
* date 29/12/93                                                        *
*                                                                      *
************************************************************************
      integer samstat,tail
      integer values(0:maxobs)
      double precision dlow(0:maxm)
        character*80 filnam
 
        debug=.true.
        timflg=.false.
 
        call coua('Type data file name: ')
        read(*,'(a)')filnam
        open(5,file=filnam,status='old')
        if(debug)open(6,file='junk',status='modify')
* read data
        read(5,*)tail
        if(tail.eq.1)then
          write(*,1)
1         format('testing that F1 > F2 (1st sample d.f. larger)')
        elseif(tail.eq.2)then
          write(*,2)
2         format('testing that F2 > F1 (2nd sample d.f. larger)')
        else
          tail=3
          write(*,3)
3         format('doing 2-sided test')
        endif
        read(5,*)n1
        if(n1.gt.maxobs)then
          write(*,4)n1
4         format('*** recompile with MAXOBS parameter set to at least',
     +i5)
          stop 'failed'
        endif
        read(5,*)(values(k),k=1,n1)
        read(5,*)n2
        if(n1+n2.gt.maxobs)then
          write(*,5)n2
5         format('*** recompile with MAXOBS parameter set to at least',
     +i5)
          stop 'failed'
        endif
        read(5,*)(values(k+n1),k=1,n2)
        call timer('doing Smirnov test')
        call getksp(n1,n2,values,dlow,tail,d,samstat,prob)
        call timer('finishing ')
        write(*,6)n1,n2,d
6       format('sample sizes',i5,' and',i5,' Kolmogorov D is',f12.4)
        write(*,7)samstat
7       format('sample test statistic is',i7)
        write(*,8)prob
8       format('Exact Smirnov p-value is',f20.6)
        en1=n1
        en2=n2
        if(tail.eq.1.or.tail.eq.2)then
          z=sqrt(en1*en2/(en1+en2))*d
          probas=exp(-2.d+00*z**2)
          write(*,9)probas
9         format('asymptotic p value',f12.4)
        else
          sqrtne=sqrt(en1*en2/(en1+en2))
          probaj=probks((sqrtne+0.12+0.11/sqrtne)*d)
          probas=probks(sqrtne*d)
          write(*,10)probas,probaj
10        format('asymptotic p value',f12.4,' Stephens corrected',f12.4)
        endif
        stop 'done'
        end
      SUBROUTINE SORT(A,N)
      INTEGER A(N),X,W
      DIMENSION LTT(20),RT(20)
      INTEGER R,RT
************************************************************************
*                                                                      *
* THIS ROUTINE SORTS THE INTEGER ARRAY ~A, WITH N ELEMENTS,            *
* INTO ASCENDING ORDER. THE ~QUICKERSORT ALGORITHM, ALGORITHM 271,     *
* COMM ~ACM 8, OF NOVEMBER 1965, P669, IS USED.                        *
* INPUT-OUTPUT                                                         *
* MODIFY A INTEGER ARRAY OF NUMBERS TO BE SORTED.                      *
* INPUT N, NUMBER OF ELEMENTS.                                         *
* DATE 20/09/83                                                        *
*                                                                      *
************************************************************************
      IF(N.EQ.0)RETURN
      LEVEL=1
      LTT(1)=1
      RT(1)=N
1     L=LTT(LEVEL)
      R=RT(LEVEL)
      LEVEL=LEVEL-1
2     IF(R.LE.L)THEN
        IF(LEVEL)8,8,1
      ENDIF
C
C   SUBDIVIDE THE INTERVAL L,R
C     L : LOWER LIMIT OF THE INTERVAL (INPUT)
C     R : UPPER LIMIT OF THE INTERVAL (INPUT)
C     J : UPPER LIMIT OF LOWER SUB-INTERVAL (OUTPUT)
C     I : LOWER LIMIT OF UPPER SUB-INTERVAL (OUTPUT)
C
      I=L
      J=R
      M=(L+R)/2
      X=A(M)
3     IF(A(I).GE.X)GOTO 4 
      I=I+1
      GOTO 3 
4     IF(A(J).LE.X)GOTO 5 
      J=J-1
      GOTO 4 
C
5     IF(I.GT.J)GOTO 6 
      W=A(I)
      A(I)=A(J)
      A(J)=W
      I=I+1
      J=J-1
      IF(I.LE.J)GOTO 3 
C
6     LEVEL=LEVEL+1
      IF((R-I).GE.(J-L))GOTO 7 
      LTT(LEVEL)=L
      RT(LEVEL)=J
      L=I
      GOTO 2 
7     LTT(LEVEL)=I
      RT(LEVEL)=R
      R=J
      GOTO 2 
8     END
      SUBROUTINE PAIR(X1,N1,X2,N2,TAIL,SAMSTAT)
************************************************************************
*                                                                      *
* Returns samstat as an integer---Kolmogorov-Smirnov D*n1*n2           *
* Adapted from Numerical Recipes software                              *
* Corrected for ties 21/10/92                                          *
* Extended to cope with F1 > F2 (tail=1), F2 > F1 (tail=2) or 2-tailed *
* test 1/1/94                                                          *
* Changed to return samstat instead of D 1/1/94                        *
*                                                                      *
************************************************************************
      IMPLICIT INTEGER (A-Z)
      INTEGER X1(N1),X2(N2),TAIL
      J1=1
      J2=1
      F1=0
      F2=0
      SAMSTAT=0
1     IF(J1.LE.N1.AND.J2.LE.N2)THEN
        IF(J1.LT.N1)THEN
          IF(X1(J1).EQ.X1(J1+1))THEN
* A TIE...
            J1=J1+1
            GOTO 1 
          ENDIF
        ENDIF
        IF(J2.LT.N2)THEN
          IF(X2(J2).EQ.X2(J2+1))THEN
* A TIE...
            J2=J2+1
            GOTO 1 
          ENDIF
        ENDIF
        IF(X1(J1).LT.X2(J2))THEN
          F1=J1*N2
          IF(TAIL.EQ.1)THEN
            DT=F1-F2
          ELSEIF(TAIL.EQ.2)THEN
            DT=F2-F1
          ELSE
            DT=ABS(F1-F2)
          ENDIF
          SAMSTAT=MAX(SAMSTAT,DT)
          J1=J1+1
        ELSEIF(X1(J1).GT.X2(J2))THEN
          F2=J2*N1
          IF(TAIL.EQ.1)THEN
            DT=F1-F2
          ELSEIF(TAIL.EQ.2)THEN
            DT=F2-F1
          ELSE
            DT=ABS(F1-F2)
          ENDIF
          SAMSTAT=MAX(SAMSTAT,DT)
          J2=J2+1
        ELSE
* IE X1 EQ X2
          F1=J1*N2
          F2=J2*N1
          IF(TAIL.EQ.1)THEN
            DT=F1-F2
          ELSEIF(TAIL.EQ.2)THEN
            DT=F2-F1
          ELSE
            DT=ABS(F1-F2)
          ENDIF
          SAMSTAT=MAX(SAMSTAT,DT)
          J1=J1+1
          J2=J2+1
        ENDIF
        GO TO 1 
      ENDIF
      END
      SUBROUTINE TIMER(DESC)
      INCLUDE 'ksblks.for'
      CHARACTER*(*) DESC
************************************************************************
*                                                                      *
* This routine prints out the time DELTAT taken since the last call    *
* to TIMER. It is initialised with TIMFLG set FALSE. DESC is a         *
* string describing the activity that is to be timed next.             *
* Is non-portable as it calls DCLOCK@, which returns a time            *
* in seconds.                                                          *
* Date 3/10/90                                                         *
*                                                                      *
************************************************************************
      CALL DCLOCK@(TIMNOW)
      IF(TIMFLG)THEN
* NOT FIRST CALL...FIND ELAPSED TIME AND PRINT OUT MESSAGE
        ELAPSE=TIMNOW-TTIME
        WRITE(*,1)TIMDES(:LENG(TIMDES)),ELAPSE
        WRITE(6,2)TIMDES(:LENG(TIMDES)),ELAPSE
1       FORMAT(/'Elapsed time taken for ',A,T57,' was',F8.3,' seconds'
     +)
2       FORMAT(' Elapsed time taken for ',A,T58,' was',F8.3,
     +' seconds')
      ENDIF
* SET NOT-FIRST-TIME-FLAG TO TRUE
      TIMFLG=.TRUE.
      TTIME=TIMNOW
      TIMDES=DESC
      WRITE(*,3)DESC
3     FORMAT(/'...Now ',A)
      END
      DOUBLE PRECISION FUNCTION PROBKS(ALAM)
        IMPLICIT DOUBLE PRECISION (A-H,O-Z)
        PARAMETER (EPS1=0.0001, EPS2=1.E-8)
        A2=-2.d+00*ALAM**2
        FAC=2.d+00
        PROBKS=0.d+00
        TERMBF=0.d+00
        DO 1 J=1,100
          TERM=FAC*EXP(A2*J**2)
          PROBKS=PROBKS+TERM
          IF(ABS(TERM).LT.EPS1*TERMBF.OR.ABS(TERM).LT.EPS2*PROBKS)RETURN
          FAC=-FAC
          TERMBF=ABS(TERM)
1       CONTINUE
        PROBKS=1.d+00
        END
 
      subroutine getksp(n1,n2,values,dlow,tail,d,samstat,prob)
      implicit double precision (a-h,o-z)
      integer total,samstat,tail,values(0:*)
      double precision dlow(0:*)
        logical untied
************************************************************************
*                                                                      *
* This routine finds the Kolmogorov-Smirnov 2-sample tail p-value,     *
* using Hodges' updating algorithm.                                    *
* arguments are sample sizes n1 and n2 (min m, max n)                  *
* array of observations values                                         *
* work array dlow                                                      *
* integer tail--- 1 if F1 > F2, 2 if F2 > F1, 3 for 2-sided test.      *
* sample Kolmogorov D (to be calculated),                              *
* and samstat=(nm)*D                                                   *
* p-value returned as prob.                                            *
* date 21/1/94                                                         *
*                                                                      *
************************************************************************
* set up constants
        zero=0.d+00
        one=1.d+00
 
* total number of observations.
        total=n1+n2
 
* get sample Kolmogorov D
        call sort(values(1),n1)
        call sort(values(n1+1),n2)
        call pair(values(1),n1,values(n1+1),n2,tail,samstat)
 
* find list of ties.
        call sort(values(1),total)
        do 1 k=1,total-1
          if(values(k).eq.values(k+1))then
            values(k)=1
          else
            values(k)=0
          endif
1       continue
        values(total)=0
        values(0)=0
 
* find smaller and larger sample sizes m and n.
        m=min(n1,n2)
        n=max(n1,n2)
        klow=1
 
* find D...just for interest
        d=real(samstat)/real(n*m)
 
* zero storage array
        do 2 i=0,m
2         dlow(i)=zero
 
* zero count of no. of consecutive ties
        nties=0
* don't overwrite tail argument.
        ntail=tail
* just find prob for F1 > F2 if 1-sided test; they are equal.
        if(ntail.eq.2)ntail=1
* zero count of no. of consecutive ties
        nties=0
 
* increase `is' until nties=0, n times is ge samstat
        iprod=0
        do 3 is0=1,total
          iprod=iprod+n
          nties=(nties+1)*values(is0-1)
          if(iprod.ge.samstat)goto 4 
3       continue
 
 
* set up dlow(j) array for levels from 1 to is0-1
4       fact=one
* note that is0-1 is guaranteed to not exceed m, dimension of dlow array.
        do 5 k=1,is0-1
          fact=fact*real(is0-k)/real(k)
5         dlow(k)=fact
 
* for each observation in increasing order...
        do 10 is=is0,total
* set no. of consecutive ties at last obs (is-1)th to 0
* if last obs. is not a tie
          nties=(nties+1)*values(is-1)
 
          ir=min(is,m)
          untied=values(is).eq.0
* find highest level to be updated
          if(untied)then
            isup=is
          else
* find next untied value
            do 6 isup=is+1,total
              if(values(isup).eq.0)goto 7 
6           continue
* update khigh
7           continue
          endif
          numfac=m*isup+samstat
          khigh=numfac/total
          if(khigh*total.ge.numfac)khigh=khigh-1
          jhigh=min(ir,khigh)
 
* find lowest level to be updated
          ilow=max(ir+is-total,1)
          if(ntail.eq.3.and.untied)then
            numfac=m*is-samstat
            klow=numfac/total
            if(klow*total.le.numfac)klow=klow+1
          endif
          jlow=max(ilow,klow)
 
          if(n*(total-is).lt.samstat.or.isup.eq.total)then
* use Binomial coefficients to finish quickly
            fact=one
            jmax=min(m,total+1-is)
            do 8 j=1,jmax
              fact=fact*real(total+2-is-j)/real(j)
8             dlow(m)=dlow(m)+dlow(m-j)*fact
            goto 11 
          endif
 
* set level 0 if this level will be used.
          if(jlow.eq.1.and.(ntail.eq.1.or.m*(is-1-nties).lt.samstat))
     +dlow(0)=one
 
* update dlow array
          do 9 j=jhigh,jlow,-1
9           dlow(j)=dlow(j)+dlow(j-1)
* set low element to zero so it wont be picked up next time
          dlow(j)=zero
10      continue
 
* find p-value
11      ways=one
        do 12 k=1,m
          top=total+1-k
          bottom=k
12        ways=ways*top/bottom
        prob=one-dlow(m)/ways
        end
 
