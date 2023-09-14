function [Xopt, Z, U]=MVC(A,c)
n=size(A,1);
[U,V]=find(A);
cvx_begin
    variable x(n)
    minimize(sum(c*x))
    subject to 
    x<=1;
    0<=x;
    1<=x(U)+x(V);   
cvx_end
Xopt=x;
Z=Xopt(U)+Xopt(V)
end