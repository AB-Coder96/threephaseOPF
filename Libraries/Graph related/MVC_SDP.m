function [Xopt]=MVC_SDP(Ad,c)
n=size(Ad,1);
C=diag(c);
A=eye(n,n);
I=adj2inc(Ad);
cvx_begin SDP
    variable X(n,n) diagonal
    minimize(sum(dot(C,X)))
    subject to 
    1<=sum(I*X,2)
    dot(A,X)<=1
    0<=X;  
cvx_end
Xopt=X;
end