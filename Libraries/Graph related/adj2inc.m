function I=adj2inc(A)
[U,V]=find(A);
n=size(A,1);
m=size(U,1);
I=zeros(m,n);
for i=1:m
I(i,U(i))=1;
I(i,V(i))=1;
end
end