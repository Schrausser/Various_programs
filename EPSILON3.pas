#cas
EPSILON3(M,N,S,D,K):=
BEGIN
F=STUDENT_ICDF(D,K)
M+S*F▶L7(1)
N-S*F▶L7(2)
"X>E-F AND X≤E-F AND Y>0 AND Y<(G*(K*π)^(-1/2)*(1+((E-X)^2/K))^(-(K+1)/2))"▶V4
"X>F AND X≤F AND Y>0 AND Y<(G*(K*π)^(-1/2)*(1+((X)^2/K))^(-(K+1)/2))"▶V5
RETURN(L7);
END;
#end 
