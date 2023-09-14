function Results=Runlinopf1(SN)
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
%%
for snd=1:size(SN,1)
    for snq=1:size(SN,2)
%%
MPC=SN{snd,snq};
%% creating connection cell
n=size(MPC.bus,1);
bus=MPC.bus(:,1);
bus_con_from=cell(n,1);
bus_con_to=cell(n,1);
bus_con=cell(n,1);
k1=cell(n,1);
k2=cell(n,1);
for i=1:n
   bus_con_from(i,1)={find(MPC.branch(:,1)==i)};
   bus_con_to(i,1)={find(MPC.branch(:,2)==i)};
   bus_con(i,1)={union(MPC.branch(cell2mat(bus_con_from(i,1)),2),MPC.branch(cell2mat(bus_con_to(i,1)),1))}; 
   [mm,nn]=size(bus_con{i,1});
   if nn>1
   bus_con{i,1}=bus_con{i,1}';
   end
end

%% Begin CVX
k=2:size(MPC.bus,1);
kk=2:size(MPC.bus,1);
e=2:size(MPC.bus,1);
ek=2:size(MPC.bus,1);
for i=1:size(MPC.bus,1)
    if MPC.gen(i,8)==1 && MPC.gen(i,22)==0
        k(i)=0;
        kk(i)=i;
        e(i)=0;
        ek(i)=0;
    elseif MPC.gen(i,8)==1 && MPC.gen(i,22)==0
        k(i)=i;
        kk(i)=0;
        e(i)=0;
        ek(i)=0;
    elseif MPC.gen(i,8)==0 && MPC.gen(i,22)==0
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
  
  minimize(p'.^2*MPC.gencost(:,5)*(MPC.baseMVA)^2+p'*MPC.gencost(:,6)*(MPC.baseMVA)+sum(MPC.gencost(:,7)));
  
  subject to 
  
  v(1)==1;
  tet(1)==0;
  %p(2)<=3;
  for i=k 
   0==+MPC.bus(i,3)/MPC.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC)+(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC);
   0==+MPC.bus(i,4)/MPC.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC)-(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC);
   p(i)==0;
   q(i)==0;
  end
  
  for j=kk
   p(j)==+MPC.bus(MPC.gen(j,1),3)/MPC.baseMVA+(v(bus(MPC.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.gen(j,1))))))'*k1find(MPC.gen(j,1),bus_con{MPC.gen(j,1)},MPC)+(tet(bus(MPC.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.gen(j,1))))))'*k2find(MPC.gen(j,1),bus_con{MPC.gen(j,1)},MPC);
   q(j)==+MPC.bus(MPC.gen(j,1),4)/MPC.baseMVA+(v(bus(MPC.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.gen(j,1))))))'*k2find(MPC.gen(j,1),bus_con{MPC.gen(j,1)},MPC)-(tet(bus(MPC.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.gen(j,1))))))'*k1find(MPC.gen(j,1),bus_con{MPC.gen(j,1)},MPC);
   p(j)>=MPC.gen(j,10)
  
   q(j)>=MPC.gen(j,5)
   q(j)<=MPC.gen(j,4)
  end
  v>=.9;v<=1.1;
 for l=1:nn
     for i=1:size(MPC.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.baseMVA*p1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(MPC.branch(i,1)),v(MPC.branch(i,2)),tet(MPC.branch(i,1)),tet(MPC.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.baseMVA*q1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(MPC.branch(i,1)),v(MPC.branch(i,2)),tet(MPC.branch(i,1)),tet(MPC.branch(i,2))))/sind(360/nn);
     end
 end
    cvx_end
%% Results
results1=runopf(MPC);
V=results1.bus(:,8);
TET=results1.bus(:,9);
%results3.branch(:,1:2)=results1.branch(:,1:2);
for i=1:size(results1.branch(:,1),1)
   results3.branch.p(i,1)=results1.branch(i,14);
   results3.branch.q(i,1)=results1.branch(i,15);
   results3.branch.p(i,2)=MPC.baseMVA*p1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.q(i,2)=MPC.baseMVA*q1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.s(i,1)=sqrt(results3.branch.p(i,1)^2+results3.branch.q(i,1)^2);
   results3.branch.s(i,2)=sqrt(results3.branch.p(i,2)^2+results3.branch.q(i,2)^2);
end
results3.bus.p(:,1)=results1.gen(:,2);
results3.bus.p(:,2)=MPC.baseMVA*p(:);
results3.bus.q(:,1)=results1.gen(:,3);
results3.bus.q(:,2)=MPC.baseMVA*q(:);
results3.bus.s(:,1)=sqrt(results1.gen(:,2).^2+results1.gen(:,3).^2);
results3.bus.s(:,2)=sqrt((MPC.baseMVA*p(:)).^2+(MPC.baseMVA*q(:)).^2);
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
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.baseMVA*p1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.baseMVA*q1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s(:,3)=S';
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.baseMVA*p1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.baseMVA*q1find(MPC.branch(i,1),MPC.branch(i,2),MPC,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s(:,4)=S';

Results{snd,snq}=results3;
    end
end
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
end