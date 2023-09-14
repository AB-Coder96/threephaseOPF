function [Results,MPC]=Runlinopf3UN(SN)
%% approximation input
H=5;
%% add library
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
%% time
for snd=1:size(SN,1)
    for snq=1:size(SN,2)
%% Extract MPC
MPC=SN{snd,snq};
%% Converting 3 phase Devices to one phase
MPC=Convert3Device(MPC);
%% initiate connection cells
bus_con=ConCell(MPC);
%% variable
n=size(MPC.a.bus,1);
bus=MPC.a.bus(:,1);
%% Bus seperation a
[Kall,Kslack,K3EV,K3PV,KPVa,KPVb,KPVc,KEVa,KEVb,KEVc]=BusSep1(MPC);
%% Begin CVX a
cvx_begin
  variable pa(n) 
  variable qa(n)
  variable teta(n)
  variable va(n) 
  
  minimize(pa'.^2*MPC.a.gencost(:,5)*(MPC.a.baseMVA)^2+pa'*MPC.a.gencost(:,6)*(MPC.a.baseMVA)+sum(MPC.a.gencost(:,7)));
  
  subject to 
  
  for i=MPC.Slack
  va(i)==1;
  teta(i)==0;
  end
  
  for i=k1 
   0==+MPC.a.bus(i,3)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a)+(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a);
   0==+MPC.a.bus(i,4)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a)-(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a);
   pa(i)==0;
   qa(i)==0;
  end
   for j=k2
   pa(j)==+MPC.a.bus(MPC.a.gen(j,1),3)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)+(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
   qa(j)==+MPC.a.bus(MPC.a.gen(j,1),4)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)-(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
   pa(j)*MPC.a.baseMVA>=MPC.a.gen(j,10)
   pa(j)*MPC.a.baseMVA<=MPC.a.gen(j,9)
   qa(j)*MPC.a.baseMVA>=MPC.a.gen(j,5)
   qa(j)*MPC.a.baseMVA<=MPC.a.gen(j,4)
  end

  va>=.9;va<=1.1;

 for h=1:H
     for i=1:size(MPC.a.branch(:,1),1)   
     6>=((sind(360*h/H)-sind(360*(h-1)/H))*MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)))...
         -(cosd(360*h/H)-cosd(360*(h-1)/H))*MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2))))/sind(360/H);
     end
 end
    cvx_end
%% Results a
for i=1:size(MPC.a.branch(:,1),1)
   results3.branch.p.a(i,1)=MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)));
   results3.branch.q.a(i,1)=MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)));
   results3.branch.s.a(i,1)=sqrt(results3.branch.p.a(i,1)^2+results3.branch.q.a(i,1)^2);
end
results3.bus.p.a(:,1)=MPC.a.baseMVA*pa(:);
results3.bus.q.a(:,1)=MPC.a.baseMVA*qa(:);
results3.bus.s.a(:,1)=sqrt((MPC.a.baseMVA*pa(:)).^2+(MPC.a.baseMVA*qa(:)).^2);
results3.f.a(1,1)=cvx_optval;
results3.bus.V.a(:,1)=va(:,1);
results3.bus.tet.a(:,1)=teta(:,1)*180/pi;
% S-linear a
H=10;
 for h=1:H
     for i=1:size(MPC.a.branch(:,1),1)   
     SS(i,h)=((sind(360*h/H)-sind(360*(h-1)/H))*MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)))...
         -(cosd(360*h/H)-cosd(360*(h-1)/H))*MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2))))/sind(360/H);
     end
 end
for i=1:size(MPC.a.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.a(:,2)=S';
%% Bus seperation b
[k,kk]=BusSep1(MPC.b);
%% Begin CVX b
cvx_begin
  variable p(n) 
  variable q(n)
  variable tet(n)
  variable v(n) 
  
  minimize(p'.^2*MPC.b.gencost(:,5)*(MPC.b.baseMVA)^2+p'*MPC.b.gencost(:,6)*(MPC.b.baseMVA)+sum(MPC.b.gencost(:,7)));
  
  subject to 
  
  v(1)==1;
  tet(1)==0;
  
  for i=k 
   0==+MPC.b.bus(i,3)/MPC.b.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b)+(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b);
   0==+MPC.b.bus(i,4)/MPC.b.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b)-(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b);
   p(i)==0;
   q(i)==0;
  end
  
  for j=kk
   p(j)==+MPC.b.bus(MPC.b.gen(j,1),3)/MPC.b.baseMVA+(v(bus(MPC.b.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)+(tet(bus(MPC.b.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   q(j)==+MPC.b.bus(MPC.b.gen(j,1),4)/MPC.b.baseMVA+(v(bus(MPC.b.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)-(tet(bus(MPC.b.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   p(j)*MPC.a.baseMVA>=MPC.b.gen(j,10)
   p(j)*MPC.a.baseMVA<=MPC.b.gen(j,9)
   q(j)*MPC.a.baseMVA>=MPC.b.gen(j,5)
   q(j)*MPC.a.baseMVA<=MPC.b.gen(j,4)
  end

  v>=.9;v<=1.1;

 for h=1:H
     for i=1:size(MPC.b.branch(:,1),1)   
     6>=((sind(360*h/H)-sind(360*(h-1)/H))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2)))...
         -(cosd(360*h/H)-cosd(360*(h-1)/H))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2))))/sind(360/H);
     end
 end
    cvx_end
%% Results b
for i=1:size(MPC.b.branch(:,1),1)
   results3.branch.p.b(i,1)=MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2)));
   results3.branch.q.b(i,1)=MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2)));
   results3.branch.s.b(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
end
results3.bus.p.b(:,1)=MPC.b.baseMVA*p(:);
results3.bus.q.b(:,1)=MPC.b.baseMVA*q(:);
results3.bus.s.b(:,1)=sqrt((MPC.b.baseMVA*p(:)).^2+(MPC.b.baseMVA*q(:)).^2);
results3.f.b(1,1)=cvx_optval;
results3.bus.V.b(:,1)=v(:,1);
results3.bus.tet.b(:,1)=tet(:,1)*180/pi;
% S-linear b
H=10;
 for h=1:H
     for i=1:size(MPC.b.branch(:,1),1)   
     SS(i,h)=((sind(360*h/H)-sind(360*(h-1)/H))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2)))...
         -(cosd(360*h/H)-cosd(360*(h-1)/H))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2))))/sind(360/H);
     end
 end
for i=1:size(MPC.b.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.b(:,2)=S';
%% Bus seperation c
[k,kk]=BusSep1(MPC.c);
%% Begin CVX c
cvx_begin
  variable p(n) 
  variable q(n)
  variable tet(n)
  variable v(n) 
  
  minimize(p'.^2*MPC.c.gencost(:,5)*(MPC.c.baseMVA)^2+p'*MPC.c.gencost(:,6)*(MPC.c.baseMVA)+sum(MPC.c.gencost(:,7)));
  
  subject to 
  
  v(1)==1;
  tet(1)==0;
  
  for i=k 
   0==+MPC.c.bus(i,3)/MPC.c.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c)+(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c);
   0==+MPC.c.bus(i,4)/MPC.c.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c)-(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c);
   p(i)==0;
   q(i)==0;
  end
  
  for j=kk
   p(j)==+MPC.c.bus(MPC.c.gen(j,1),3)/MPC.c.baseMVA+(v(bus(MPC.c.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)+(tet(bus(MPC.c.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   q(j)==+MPC.c.bus(MPC.c.gen(j,1),4)/MPC.c.baseMVA+(v(bus(MPC.c.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)-(tet(bus(MPC.c.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   p(j)*MPC.a.baseMVA>=MPC.c.gen(j,10)
   p(j)*MPC.a.baseMVA<=MPC.c.gen(j,9)
   q(j)*MPC.a.baseMVA>=MPC.c.gen(j,5)
   q(j)*MPC.a.baseMVA<=MPC.c.gen(j,4)
  end

  v>=.9;v<=1.1;

 for h=1:H
     for i=1:size(MPC.c.branch(:,1),1)   
     6>=((sind(360*h/H)-sind(360*(h-1)/H))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2)))...
         -(cosd(360*h/H)-cosd(360*(h-1)/H))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2))))/sind(360/H);
     end
 end
    cvx_end
%% Results c
for i=1:size(MPC.c.branch(:,1),1)
   results3.branch.p.c(i,1)=MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2)));
   results3.branch.q.c(i,1)=MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2)));
   results3.branch.s.c(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
end
results3.bus.p.c(:,1)=MPC.c.baseMVA*p(:);
results3.bus.q.c(:,1)=MPC.c.baseMVA*q(:);
results3.bus.s.c(:,1)=sqrt((MPC.c.baseMVA*p(:)).^2+(MPC.c.baseMVA*q(:)).^2);
results3.f.c(1,1)=cvx_optval;
results3.bus.V.c(:,1)=v(:,1);
results3.bus.tet.c(:,1)=tet(:,1)*180/pi;
% S-linear c
H=10;
 for h=1:H
     for i=1:size(MPC.c.branch(:,1),1)   
     SS(i,h)=((sind(360*h/H)-sind(360*(h-1)/H))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2)))...
         -(cosd(360*h/H)-cosd(360*(h-1)/H))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2))))/sind(360/H);
     end
 end
for i=1:size(MPC.c.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.c(:,2)=S';
%% 3phase Results
results3.VUF(:,1)=VUF(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.VUFlin(:,1)=VUF_lin(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.ftotal(1,1)=results3.f.a(1,1)+results3.f.b(1,1)+results3.f.c(1,1);
%
results3.mismatch(:,1)=mismatch(results3.branch.p.a(:,1),results3.branch.p.b(:,1),results3.branch.p.c(:,1));
%%
Results{snd,snq}=results3;
    end
end
%% remove library
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
end