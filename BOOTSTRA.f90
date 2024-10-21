integer :: n=0, stpr=0
real :: rnd=0
integer, allocatable, dimension(:) :: index, index1
1 write(6,*) 'N?'
read(5,*,err=1) n
allocate (index(n), index1(n))
init: do i=1,n
index(i)=i
index1(i)=i
end do init
2 write(6,*) 'Wieviele Stichproben?'
read(5,*,err=2) stpr
stichproben: do i=1,stpr
zufall: do j=1,n
3 call random_number(rnd)
k=rnd*(n+1)
if(k.ne.0) then
index1(j)=index(k)
else 
go to 3
end if
end do zufall
write(6,*) index1
end do stichproben
end
