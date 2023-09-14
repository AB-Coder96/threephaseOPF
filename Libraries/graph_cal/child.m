function childs=child(X)
childs=zeros(1,length(X));
for i=1:length(X)
    if X(:, 1) == X(i, 2)
    childs(i)=a;
    end    
end  