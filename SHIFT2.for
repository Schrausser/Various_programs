      integer n,sp,ifehl,ilen,go
c***      integer cpubeg, cpuend
      real r(100), pgt, plt, peq, ptwo, pvalue
      character*60 nfmt, filein, fileout, title
      integer ir(100)
      character*29 text(0:2)
             
      
      data text / 'ONE-SIDED  H0: MUE1<=MUE2   :',
     -            'ONE-SIDED  H0: MUE1>=MUE2   :',
     -            'TWO-SIDED  H0: MUE1 =MUE2   :'/

C***      call cpu_tim(cpubeg)
    
      in=5
      out=6

 20   write(out,100)
      read(in,101) lentitle, title
      if(lentitle.gt.60) go to 20
 22   write(out,103)
      read(in,101) lenfilein, filein
      open(unit=10,name=filein,readonly,type='old',err=23)
      go to 24
 23   write(out,*) '## ERROR OPENING INPUT-FILE ##'
      go to 22
 24   write(out,104)
      read(in,101) lennfmt, nfmt
      do 25 i=1,lennfmt
      if(nfmt(i:i).eq.'I'.or.nfmt(i:i).eq.'A') then
        write(out,*) '## INPUT FORMAT MUST BE F-FORMATED ##'
        go to 24
      end if
 25   continue
 26   write(out,105)
      read(in,101) lenfileout, fileout
      open(unit=20, name=fileout,type='new',err=27)
      go to 28
 27   write(out,*) '## ERROR OPENING OUTPUT-FILE ##'
      go to 26
 28   write(out,106)
      read(in,*) n
      if(n.gt.50) go to 28
 29   write(out,107)
      read(in,*) itail
      if((itail-1)*(itail+1)*(itail-2).ne.0) go to 29

      do i=1,n
        read(10,nfmt,err=33,end=34) r(i), r(n+i)
      end do
      go to 36
 33   type 108
      stop
 34   type 109
      stop

    
 36   do i=1,n
        ir(i)=0
        ir(n+i)=0
      end do


      call convert(r,ir,n)
 
      call permu1(n,ir,ilen,go,sp,pgt,plt,peq,ptwo,ifehl)

      if(ifehl.eq.1) then
        write(out,*) '*** MORE SPACE REQIRED. INCREASE ARRAY G TO ', sp
        write(out,*) '*** PROGRAM TERMINATED'
        stop
      end if

      if(itail.eq.-1) pvalue=pgt+peq
      if(itail.eq.1) pvalue=plt+peq
      if(itail.eq.2) pvalue=ptwo

      write(20,110) title(1:lentitle)

      call rawout(nfmt,r,ir,n,filein)

      write(20,111) go
      if(itail.eq.-1) itail=0
      write(20,112) plt,pgt,peq,text(itail),pvalue

c***      call cpu_tim(cpuend)
c***      cpu_time=float(cpubeg-cpuend)/100.
c***      write(20,113) cpu_time

      stop
           
 100  format (' *** ENTER TITLE (MAX. 60 CHARACTERS) :',$)
 101  format (q,a60)
 103  format (' *** ENTER NAME OF INPUT FILE :',$)
 104  format (' *** ENTER INPUT FORMAT(MAX. 60 CHARACTERS):',$)  
 105  format (' *** ENTER NAME OF OUTPUT FILE :',$)
 106  format (' *** ENTER SAMPLE SIZE N :',$)
 107  format (' *** ENTER -1:   H0 : MUE1<=MUE2'/
     -       '            1:   H0 : MUE1>=MUE2'/
     -       '            2:   H0 : MUE1 =MUE2 :',$)
 108  format (//' *** ERROR DETECTED WHEN READING IN RAW DATA ***'/)
 109  format (//' *** INSUFFICIENT RAW DATA ***'/)
 110  format (1H1,71(1H*)/1X,1H*,T72,1H*/
     -       1X,1H*,18X,'EXACT TWO SAMPLE PERMUTATION TEST',T72,1H*/
     -       1X,1H*,T72,1H*/1X,1H*,4X,'USING THE STREITBERG-ROEHMEL',
     -       ' ONE-DIMENSIONAL SHIFT ALGORITHM',T72,1H*/1X,1H*,T72,1H*/
     -       1X,1H*,T72,1H*/1X,1H*,<(69-lentitle)/2>X,
     -       A<Lentitle>,T72,1H*/1X,1H*,T72,1H*/1X,71(1H*))
 111  format (/3X,'VALUE OF TEST STATISTIC (SUM OF FIRST SAMPLE',1H,
     -       'S VALUES) :',I8)
 112  format (/20X,33(1H*)/20X,'* RESULT OF THE SHIFT ALGORITHM *'/
     -        20X,33(1H*)//
     -        30X,'P> :',F8.4/30X,'P< :',F8.4/30X,'P= :',F8.4//
     -'   NON RANDOMIZED P-VALUE FOR ',A29,F8.4)
 113  format (/'   REQUIRED CPU-TIME :',F10.2)

      end
      

      subroutine oneshift(n,b,g,ilen,ifehl)

      real*8 g(2*ilen)
      integer b(200)

      ifehl=0
     

      if(ilen*2.gt.400000) then
        ifehl=1
        return
      end if
      
      g(1)=1
      ncol=1

      do 40 i=1,n
        do 10 k=1,b(i)
        g(ncol+k)=0
  10    g(ncol+b(i)+k)=0
        
        do 20 k=1,ncol
  20    g(ncol+2*b(i)+k)=g(k)
        ncol=ncol+b(i)
        do 30 k=1,ncol
  30    g(k)=g(k)+g(ncol+k)
  40    continue


            
        return

      end

      subroutine permu1(n,ir,ilen,go,sp,pgt,plt,peq,ptwo,ifehl)

      real*8 g(400000), fak*8, puu*8, ynoverm*8, pee*8
      integer ir(2*n), b(200), sp, go

      go=0
      puu=0
      ilen=0

      do i=1,n
       mina=min(ir(i),ir(n+i))end do
       go=go+ir(i)-mina
       b(i)=max(ir(i)-mina,ir(n+i)-mina)
       ilen=ilen+b(i)
      end do

      sp=ilen*2

      call oneshift (n,b,g,ilen,ifehl)

      if(ifehl.eq.1) return

      fak=1./2.**float(n)
      
      do 50 i=go+2,ilen
  50  puu=puu+g(i)
      pee=g(go+1)

      plt = fak*puu
      peq = fak*pee
      pgt = 1.-plt-peq
      ptwo= min(plt+peq,pgt+peq)*2. 
      ptwo= min(1.,ptwo)

      return

      end
      
      
      subroutine convert (r,ir,n)

      integer n,ir(2*n)
      real r(2*n)

      do i=1,2*n
        ir(i)=nint(r(i)*1000)
      end do

      ifak=3

   5  k=0
      do i=1,2*n
        if(mod(ir(i),10).eq.0) k=k+1
      end do

      if(k.eq.2*n) then
         do i=1,2*n
           ir(i)=nint(ir(i)/10.)
         end do
         ifak=ifak-1
         go to 5
      end if
      if(k.ne.2*n) return

      end

      subroutine rawout(nfmt,y,iy,nsum,filein)

      integer nsum,iy(100),n(2)
      real y(100)

      character*60 filein,nfmt

      
        n(1)=nsum
        n(2)=nsum

      write(20,100) filein,nfmt

      write(20,104)

      nzaehl=0
      do l=1,2
        do i=1,n(l)
          nzaehl=nzaehl+1
          if(i.ne.(n(l)+1)/2) then
            write(20,102) i,y(nzaehl)
          else
            write(20,103) l,i,y(nzaehl)
          end if
        end do
        write(20,104)
      end do

      write (20,105)

      write (20,104)

      nzaehl=0
      do l=1,2
        do i=1,n(l)
          nzaehl=nzaehl+1
          if(i.ne.(n(l)+1)/2) then
            write(20,106) i,iy(nzaehl)
          else
            write(20,107) l,i,iy(nzaehl)
          end if
        end do
        write(20,104)
      end do

      return

 100  format(/25X,21(1h*)/25x,1h*,' R A W - D A T A ',1h*/25x,
     221(1h*)//12x,'INPUT FILE  : ',a60/12x,'DATA-FORMAT : ',a60/)
 102  format(20x,'I',10x,'I',I3,' I',2x,f10.3,'  I')
 103  format(20x,'I SAMPLE ',I1,' I',I3,' I',2x,f10.3,'  I')
 104  format(20x,'I',18(1h-),(10(1h-)),'--I')
 105  format(/20x,32(1h*)/20x,'* INTEGER TRANSFORMED RAW-DATA *'/
     -        20x,32(1h*)/)
 106  format(20x,'I',10x,'I',I3,' I',2X,I10,'  I')
 107  format(20X,'I SAMPLE ',I1,' I',I3,' I',2x,I10,'  I')

      end 
