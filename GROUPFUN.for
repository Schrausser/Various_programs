      program groupfun
      parameter(maxnum=160,maxbin=15000)
      implicit double precision (a-h,o-z)
* maxnum is max. sample size
************************************************************************
*                                                                      *
* This program does permutation 2-sample grouped t-test.               *
* date 21/2/94                                                         *
*                                                                      *
************************************************************************
      integer n,firstgroup(0:maxnum),binsreq,x(0:maxnum)
     +,dope(0:maxnum)
      double precision a(0:maxnum),p,cv,ptol ,b(0:maxbin)
* fractional error required on prob.
        character*80 filename
        ptol=0.05
* array to hold filename
        call coua('Enter input file name: ')
        read(*,'(a)')filename
* get file name
        open(5,file=filename,status='old')
        n=0
1       read(5,*,err=4,end=4)a(n),firstgroup(n)
        write(*,2)n,a(n),firstgroup(n)
2       format('number',i5,' is ',f12.4,' group ',i5)
        n=n+1
        if(n.gt.maxnum)then
          write(*,3)maxnum
3         format('sample size too large. Maximum is', i5)
          stop 'failed'
        endif
        goto 1 
4       continue
        write(*,5)n
5       format('read in', i5,' numbers')
 
        p=pitmanprob(a,firstgroup,n,ptol,cv,binsreq,x,b,maxbin,dope)
* find tail probability
        if(p.lt.0.)then
          write(*,6)binsreq
6         format(i5,' array elements requested, which is too many.')
          stop 'failed'
        else
          write(*,7)binsreq,p,cv
7         format(i5,' array elements used'
     +/'1-tailed probability is ',f12.4/
     +'CV of estimated probability is ',f12.4)
        endif
        stop 'done'
        end
      double precision function pitmanprob( a, firstgroup,
     +n, ptol,cv,binsreq,x,b,maxbin,dope)
        implicit double precision (a-h,o-z)
* returns 1-tail probability from Pitman's 2-sample permutation test,
* the distribution-free analogue of the grouped t-test
        integer numberone,numbertwo,binsreq,
     +smallnum,k,j,smallgroup,ntop,kbot,
     +bin,i,isum,s,n0,n0dash,ndash,m, dope(0:*), x(0:*),firstgroup(0:*)
        double precision a(0:*),onesum,twosum,scale,sum,tail,term1,
     +term2,
     +minnum,maxnum,onemean,twomean,mu,sigsq,em,en,factor, b(0:*)
 
          numberone=0
          numbertwo=0
          isum=0
          onesum=0.d+00
          twosum=0.d+00
          binsreq=n
          do 1 i=0,n-1
            if(i .eq. 0)then
              minnum=a(i)
* find max. and min. sample values
              maxnum=a(i)
            else
              minnum=min(a(i),minnum)
              maxnum=max(a(i),maxnum)
            endif
            if(firstgroup(i) .eq.1)then
              numberone=numberone+1
* count numbers of in each group
              onesum=onesum+a(i)
* and their sums
            else
              numbertwo=numbertwo+1
              twosum=twosum+a(i)
            endif
1         continue
          onemean=onesum/numberone
* find means for each group
          twomean=twosum/numbertwo
          if(onemean.gt.twomean)then
            smallgroup=2
          else
            smallgroup=1
          endif
          do 2 i=0,n-1
2           a(i)=a(i)-minnum
* translate sample values to be .gt.= 0
          if(numberone.lt.numbertwo)then
            smallnum=1
          else
            smallnum=2
          endif
          onesum=onesum-numberone*minnum
* and modify sums and maximum value
          twosum=twosum-numbertwo*minnum
          maxnum=maxnum-minnum
 
          if(smallgroup .ne. smallnum)then
* if necessary, reflect values so smaller group has smaller mean
            do 3 i=0,n-1
3             a(i)=maxnum-a(i)
            onesum=numberone*maxnum-onesum
            twosum=numbertwo*maxnum-twosum
          endif
          if(smallnum.eq.1)then
            sum=onesum
          else
            sum=twosum
          endif
      m=min(numberone,numbertwo)
* number in smaller group
 
          em=m
          en=n
          mu=0.d+00
          sigsq=0.d+00
          do 5 i=0,n-1
            mu=mu+a(i)
            sigsq=sigsq+a(i)*a(i)
            do 4 j=i+1,n-1
4             sigsq=sigsq-2.*a(i)*a(j)/(en-1.)
5         continue
          mu=(em/en)*mu
          sigsq=(em/en)*(1.-(em/en))*sigsq
* permutation mean and variance
          factor=sqrt((em/en)*(1.-(em/en))*(en+(mu-sum)*(mu-sum)*
     +(en+1.)/(en*sigsq))/12.)
          term1=mu*(mu-sum)/(ptol*sigsq)
          term2=2./ptol
          bin=factor*max(term1,term2)
* number of histogram bins needed
 
          scale=bin/sum
* scale sample values so that sum of smaller sample
* is in bin number bin
          do 6 i=0,n-1
            x(i)=a(i)*scale+0.5
* rescaling sample values.
* Adding 0.5 rounds to nearest bin rather than truncating
            if(firstgroup(i).eq.smallnum)isum=isum+x(i)
6         continue
          bin=isum 
* find exact histogram bin for start of reject H0 region
 
          binsreq=(bin+2)*m
          if(binsreq.gt.maxbin)then
            write(*,7)maxbin,binsreq
7           format('increase MAXBIN from ',i5,' to',i6,' and recompile')
            stop 'failed'
          endif
      do 666 i=0,binsreq
666   b(i)=0.d+00
          call sort(x,n)
* sort sample
          do 8 i=0,n-1
8           x(i)=min(x(i),bin+1)
* any sample values greater than   the test statistic 'bin'
* will cause b(.gt.bin) to be occupied and are set
* to bin+1, the overflow bin NOW rather than later so as not to cause integer
*  overflow
 
          do 9 i=0,m-1
9           dope(i)=i*(bin+2)
* offsets to mimick 2 dim. array
          b(dope(0)+x(0))=b(dope(0)+x(0))+1
* start histogram off
* for 2 dim. array code would be  ++b(0)(x(0))
 
          n0=x(0)
          do 13 s=1,n-1
            kbot=max(m+s-n,1)
            n0dash=n0+x(s)
* translate each level by x(s)
            do 12 k=min(s,m-1),kbot,-1
* only build up histograms
* as far as mth level, which is the one we want
 
              if(n0dash.gt.bin)then
                do 10 ndash=bin-x(s)+1,bin+1
* translate k-1 th level onto kth level...these terms go into overflow bin
10                b(dope(k)+bin+1)=b(dope(k)+bin+1)+b(dope(k-1)+ndash)
              endif
* for 2 dim. array...    b(k)(bin+1)+=b(k-1)(ndash)
              ntop=min(bin,n0dash)
              do 11 ndash=x(s),ntop
* these terms just translate along, but may go into overflow bin
                b(dope(k)+ndash)=b(dope(k)+ndash)+b(dope(k-1)+ndash-x(s)
     +)
* for 2 dim. array...  b(k)(ndash)+=b(k-1)(ndash-x(s))
11            continue
12          continue
            b(dope(0)+x(s))=b(dope(0)+x(s))+1
* add new term to lowest level
* for 2 dim. array...  ++b(0)(x(s))
            n0=n0dash
13        continue
          tail=0.
* find tail probability
          do 14 i=0,bin
14          tail=tail+b(dope(m-1)+i)
* for 2 dim. array...   tail+=b(m-1)(i)
          cv=100.*b(dope(m-1)+bin)*factor/tail
* find coefficient of variation
* for 2d array...   *cv=100.*b(m-1)(bin)*factor/tail
          pitmanprob=tail/(tail+b(dope(m-1)+bin+1))
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
