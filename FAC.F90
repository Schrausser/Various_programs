real(kind=selected_real_kind(4,300)) :: x=1,y=1,z=1,v=0
integer :: a=0,b=0
write(6,*) 'N gesamt'
read(5,*) a
write(6,*) 'n Subraum 1'
read(5,*) b
do i=1,a
x=x*i
end do
do j=1,b
y=y*j
end do
do k=1,a-b
z=z*k
end do
v=x/(y*z)
write(6,*) v
end
