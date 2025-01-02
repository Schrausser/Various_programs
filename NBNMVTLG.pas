#cas
NBNMVTLG(K,P,R,N):=
BEGIN
STARTAPP("Statistiken_1_Var");
STARTVIEW(1)
B=0
FOR I FROM 0 TO R-K DO
 ((K+I-1)!/(I!*(K(I)-1)!))*P^K*(1-P)^I▶L4(I)
 B=B+L4(I)
END
D7=L4;L4={}
FOR I FROM 0 TO N DO
 ((K+I-1)!/(I!*(K-1)!))*P^K*(1-P)^I▶L5(I)
END
D8=L5;L5={}
RETURN(B);
END;
#end 
