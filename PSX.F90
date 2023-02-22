program psx

character :: dmy
character*3 :: com_inp
character*15 :: com_file, data_file
integer :: n_var, n_cases, av, uv
integer, allocatable :: data_matrix(:,:)

read(5,*) com_file
open(7,file=com_file,err=1)

do
 read (7,"(A3)",end=10,err=1) com_inp

 select case (com_inp)
  
  case("inp"," inp")
    backspace 7
    read(7,"(A5,1X,A)",err=11) dmy, data_file
    open(8, file=data_file, err=10)
    read(7,"(7X,2I)",err=11) n_var
    do
      read(8,*,end=12) dmy
      n_cases=n_cases+1
    end do
    12 allocate(data_matrix(n_cases,n_var))
    rewind 8
    read(8,*,end=22) data
  
  case("tab", " tab")
   call data_definition
   call data_table
  
  case("rem","   ")
   go to 2
  
 end select

2 end do
end

subroutine data_definition
    integer :: dmy, av_loc, uv_loc, dat_len=0, k(5), di, gk
    integer, allocatable :: data(:), data_perm(:,:), index(:), n_k(:)
    character*10 :: dmy, vb
    
    read(7,"(6X,A)") vb
    
    select case (vb)
     
     case("by ")
      backspace 7
      read(7,"(9X,2I,1X,2I)") av_loc, uv_loc
      rewind 8
      kl=1
      l1: do i=1,n_cases
        l2: do j=1,kl
            if(data_matrix(i,uv_loc).ne.k(j)) dmy=dmy+1
        end do l2
        if(dmy.eq.kl) then
          k(kl)=data_matrix(i,uv_loc)
          kl=kl+1
        end if
        dmy=0;di=0
      end do l1
      allocate (n_k(kl))
      l1: do j=1, kl
        l2: do i=1, n_cases
          if(data_matrix(i,uv_loc)=j) then
            data(di)=data_matrix(i,av_loc)
            n_k(j)=n_k(j)+1
            di=di+1
          end if
        end do l2
      end do l1
            case("wit")
      go to 22
    end select
    go to 23
    
    22
    23
end subroutine data_definition      

subroutine data_table
      g_k=0
      do i=1,kl
        if(n_k(kl).gt.g_k) g_k=n_k(kl)
      end do
      allocate (data_perm(g_k,kl)
      id=0
      do i=1,kl
        do j=1,n_k(kl)
          data_perm(j,i)=data(id+j)
        end do
        id=id+n_k(kl)
      end do
      write(6,*) data_perm
end subroutine data_table
