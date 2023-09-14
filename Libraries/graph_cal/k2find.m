function k2=k2find(i,j,mpc)
[m,n]=size(j);
 if m==1
   A=find(mpc.branch(:,1)==i);
   B=find(mpc.branch(:,2)==j);
   C=find(mpc.branch(:,1)==j);
   D=find(mpc.branch(:,2)==i);
   if intersect(A,B)
     r=mpc.branch(intersect(A,B),3);
     x=mpc.branch(intersect(A,B),4);
     k1=r/(r^2+x^2);
     k2=x/(r^2+x^2);
   elseif intersect(C,D)
     r=mpc.branch(intersect(C,D),3);
     x=mpc.branch(intersect(C,D),4);
     k1=r/(r^2+x^2);
     k2=x/(r^2+x^2);
   else
     r=[];
     x=[];
     k1=[];
     k2=[];
   end
 else
   r=zeros(m,n);
   x=zeros(m,n);
   k1=zeros(m,n);
   k2=zeros(m,n);
     for k=1:m
      A=find(mpc.branch(:,1)==i);
      B=find(mpc.branch(:,2)==j(k,1));
      C=find(mpc.branch(:,1)==j(k,1));
      D=find(mpc.branch(:,2)==i);
        if intersect(A,B)
           r(k,1)=sum(mpc.branch(intersect(A,B),3));
           x(k,1)=sum(mpc.branch(intersect(A,B),4));
           k1(k,1)=r(k,1)/(r(k,1)^2+x(k,1)^2);
           k2(k,1)=x(k,1)/(r(k,1)^2+x(k,1)^2);
        elseif intersect(C,D)
           r(k,1)=sum(mpc.branch(intersect(C,D),3));
           x(k,1)=sum(mpc.branch(intersect(C,D),4));
           k1(k,1)=r(k,1)/(r(k,1)^2+x(k,1)^2);
           k2(k,1)=x(k,1)/(r(k,1)^2+x(k,1)^2);
        else
           r=[];
           x=[];  
           k1=[];
           k2=[];
        end
     end
 end 
end