for i=1:8
A(i)=1
B(i)=1+i/10
C(i)=1-i/10
end
Ymatrix=[A',B',C']
createfigure(Ymatrix,2)
