#cas
EPSILON2(E,N,D,K):=
BEGIN
#t opt niv
#V=√(E^2*N)/2▶L6(2)
#P=1-STUDENT_CDF(D,V)▶L6(3)
#e opt eff stke
L=√((2*STUDENT_ICDF(D,K))^2/N)▶L6(1)
"X>0 AND X<L AND Y<0 AND Y>-0.02"▶V1
RETURN(L6);
END;
#end
