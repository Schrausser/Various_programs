integer :: perm, n1, n2, n, x
integer, allocatable, dimension(:) :: index
character*15 :: datei
character, allocatable, dimension(:) :: lin
real :: rn
write(6, *) 'Variablenvektor [n1 n2 Permutationen] ?'
read(5,'(I1,1X,I1,1X,I4)') n1, n2, perm
write(6, *) 'Ausgabedatei'
read(5,*) datei
open(7,file=datei)
n=n1+n2
allocate (index(n))
allocate (lin(n*2))
do i=1,n
   index(i)=i
enddo
do i=1, n*2
   lin(i) ="*"
end do
WRITE(7,*) lin
write(7,*) index
write(7,*) perm ,' zuf�llige Permutationen'
write(7,*) lin
L1: do i=2, perm
 L2: do l=1, n2
  L3: do j=1,n
  call random_number(rn)
  if(anint(rn).eq.1) then
    X=index(n1+l)
    index(n1+l)=index(j)
    index(j)=x
   end if
   end do L3
  end do L2
  write (7,*) index
end do L1
write(7,*) lin
end
