function results3=Runlinopf(mpc)
%% creating connection cell
n=size(mpc.bus,1);
bus=mpc.bus(:,1);
bus_con_from=cell(n,1);
bus_con_to=cell(n,1);
bus_con=cell(n,1);
k1=cell(n,1);
k2=cell(n,1);
for i=1:n
   bus_con_from(i,1)={find(mpc.branch(:,1)==i)};
   bus_con_to(i,1)={find(mpc.branch(:,2)==i)};
   bus_con(i,1)={union(mpc.branch(cell2mat(bus_con_from(i,1)),2),mpc.branch(cell2mat(bus_con_to(i,1)),1))}; 
   [mm,nn]=size(bus_con{i,1});
   if nn>1
   bus_con{i,1}=bus_con{i,1}';
   end
end

%% Begin CVX
k=2:size(mpc.bus,1);
kk=2:size(mpc.bus,1);
e=2:size(mpc.bus,1);
ek=2:size(mpc.bus,1);
for i=1:size(mpc.bus,1)
    if mpc.gen(i,8)==1 && mpc.gen(i,22)==0
        k(i)=0;
        kk(i)=i;
        e(i)=0;
        ek(i)=0;
    elseif mpc.gen(i,8)==1 && mpc.gen(i,22)==0
        k(i)=i;
        kk(i)=0;
        e(i)=0;
        ek(i)=0;
    elseif mpc.gen(i,8)==0 && mpc.gen(i,22)==0
        k(i)=0;
        kk(i)=0;
        e(i)=i;
        ek(i)=0;
    else
        k(i)=0;
        kk(i)=0;
        e(i)=0;
        ek(i)=i; 
    end
end
k=nonzeros(k)';
kk=nonzeros(kk)';
e=nonzeros(e)';
ek=nonzeros(ek)';

nn=5;

cvx_begin
  variable p(n)
  variable q(n)
  variable tet(n)
  variable v(n) 
  
  minimize(p'.^2*mpc.gencost(:,5)*(mpc.baseMVA)^2+p'*mpc.gencost(:,6)*(mpc.baseMVA)+sum(mpc.gencost(:,7)));
  
  subject to 
  
  v(1)==1;
  tet(1)==0;
  
  for i=k 
   0==+mpc.bus(i,3)/mpc.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},mpc)+(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},mpc);
   0==+mpc.bus(i,4)/mpc.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},mpc)-(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},mpc);
   p(i)==0;
   q(i)==0;
  end
  
  for j=kk
   p(j)==+mpc.bus(mpc.gen(j,1),3)/mpc.baseMVA+(v(bus(mpc.gen(j,1)))-v(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k1find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc)+(tet(bus(mpc.gen(j,1)))-tet(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k2find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc);
   q(j)==+mpc.bus(mpc.gen(j,1),4)/mpc.baseMVA+(v(bus(mpc.gen(j,1)))-v(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k2find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc)-(tet(bus(mpc.gen(j,1)))-tet(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k1find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc);
   p(j)>=mpc.gen(j,10)
  
   q(j)>=mpc.gen(j,5)
   q(j)<=mpc.gen(j,4)
  end
v<=1.1
.9<=v

 for l=1:nn
     for i=1:size(mpc.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(mpc.branch(i,1)),v(mpc.branch(i,2)),tet(mpc.branch(i,1)),tet(mpc.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(mpc.branch(i,1)),v(mpc.branch(i,2)),tet(mpc.branch(i,1)),tet(mpc.branch(i,2))))/sind(360/nn);
     end
 end
    cvx_end
%% Results
results1=runopf(mpc);
V=results1.bus(:,8);
TET=results1.bus(:,9);
%results3.branch(:,1:2)=results1.branch(:,1:2);
for i=1:size(results1.branch(:,1),1)
   results3.branch.p(i,1)=results1.branch(i,14);
   results3.branch.q(i,1)=results1.branch(i,15);
   results3.branch.p(i,2)=mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.q(i,2)=mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.s(i,1)=sqrt(results3.branch.p(i,1)^2+results3.branch.q(i,1)^2);
   results3.branch.s(i,2)=sqrt(results3.branch.p(i,2)^2+results3.branch.q(i,2)^2);
end
results3.bus.p(:,1)=results1.gen(:,2);
results3.bus.p(:,2)=mpc.baseMVA*p(:);
results3.bus.q(:,1)=results1.gen(:,3);
results3.bus.q(:,2)=mpc.baseMVA*q(:);
results3.bus.s(:,1)=sqrt(results1.gen(:,2).^2+results1.gen(:,3).^2);
results3.bus.s(:,2)=sqrt((mpc.baseMVA*p(:)).^2+(mpc.baseMVA*q(:)).^2);
results3.f(1,1)=results1.f;
results3.f(1,2)=cvx_optval;
results3.bus.V(:,1)=results1.bus(:,8);
results3.bus.V(:,2)=v(:,1);
results3.bus.tet(:,1)=results1.bus(:,9);
results3.bus.tet(:,2)=tet(:,1)*180/pi;
%% S-linear
nn=10;
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s(:,3)=S';
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s(:,4)=S';
end