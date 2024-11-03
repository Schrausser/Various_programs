!----------------------------------------------------!
!   Permutation von Elementen durch randomisierte    !
!   Inversion. Anwendbar für k unabhängige Stich-    !
!   proben mit gleicher oder ungleicher Zellenbe-    ! 
!   setzung.                                         !
!----------------------------------------------------!
program rpm

integer :: ngrps, nperm, nn=0, mm, ig, kk, k, x
real :: rnd
integer, allocatable, dimension(:) :: index, n

!  Anzahl der Stichproben [ngrps] und Permutationen [nperm]

1 write(6,*) 'wieviele Gruppen (k) ?'
read(5,*,err=1) ngrps
2 write(6,*) 'wieviele Permutationen ?'
read(5,*,err=2) nperm 
allocate (n(ngrps))

!  Zellenbesetzung pro Stichprobe

write(6,*) 'Zellenbesetzungen ', ngrps, ' mal'
read(5,*) (n(i), i=1,ngrps)

do I=1,ngrps
nn=nn+n(i)
end do

allocate (index(nn))

do I=1,nn
index(i)=i
end do

ig=ngrps-1

L1:do i=2,nperm
mm=0
L2:do j=1,ig
l=mm+1 ; mm=mm+n(j)
L3:do k=l,mm

!  Aufruf einer gleichverteilten Zufallszahl im 
!  Intervall (0,1).                             

call random_number(rnd) 

!  Die Variable kk kann nun jede Zahl im Bereich
!  (MM..NN) annehmen.                           
                   
kk=k+rnd*(nn-k+1)

!  Vertauschung des aktuellen Index (index(k))  
!  mit einem zufälligen Index (index(kk))       

x=index(kk) ; index(kk)=index(k) ; index(k)=x

end do l3
end do l2

!  Ausgabe des permutierten Vektors index

write(6,*) index  

end do l1
end 
