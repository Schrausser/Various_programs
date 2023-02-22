real(kind=selected_real_kind(4,300)) :: x=1
integer :: a=0
write(6,*) 'N'
read(5,*) a
do i=1,a
x=x*i
end do
write(6,*) x
end
