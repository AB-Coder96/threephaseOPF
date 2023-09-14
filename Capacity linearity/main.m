clc
clear
close
%% loading case study
%define_constants;
mpc=loadcase('case33bww');
%% modifying generators
mpc.gen(2,8)=0;
mpc.gen(3,8)=0;
%% extention
%mpc.bus(34:40,2:end)=mpc.bus(25:31,2:end);
%mpc.bus(34:40,1)=34:40;
%mpc.branch(33:39,3:end)=mpc.bus(26:32,3:end);
%mpc.branch(33,1)=33;
%mpc.branch(34:39,1)=34:39;
%mpc.branch(33:39,2)=34:40;

%% creating connection cell
bus=mpc.bus(:,1);
gen=mpc.gen(:,1);
[n,m]=size(bus);
[g,h]=size(gen);
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
%% Newton-Rofson OPF
results1=runopf(mpc);
V=results1.bus(:,8);
%% SDP OPF
clear settings;
%results2=OPF_Solver(mpc);
results2=rundcopf(mpc);
%V2_sdp=sqrt(diag(results2.sdp.W));
V2_sdp=results2.bus(:,8);
%% Linear OPF
k=2:size(mpc.bus,1);
%k(1)=[];
%k(25-1)=[];
%k(33-2)=[];
cvx_begin
  variable p(g) 
  variable q(g)
  variable tet(n)
  variable v(n) 
  %minimize(p'.^2*mpc.gencost(:,5)*(mpc.baseMVA)^2+p'*mpc.gencost(:,6)*(mpc.baseMVA)+sum(mpc.gencost(:,7)));
  maximize(sum(v))
  subject to 
  v(1)==1;
  tet(1)==0;
  for i=k 
   0==+mpc.bus(i,3)/mpc.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},mpc)+(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},mpc);
   0==+mpc.bus(i,4)/mpc.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},mpc)-(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},mpc);
  end
  for j=[1]
   p(j)==+mpc.bus(mpc.gen(j,1),3)/mpc.baseMVA+(v(bus(mpc.gen(j,1)))-v(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k1find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc)+(tet(bus(mpc.gen(j,1)))-tet(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k2find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc);
   q(j)==+mpc.bus(mpc.gen(j,1),4)/mpc.baseMVA+(v(bus(mpc.gen(j,1)))-v(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k2find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc)-(tet(bus(mpc.gen(j,1)))-tet(cell2mat(bus_con(bus(mpc.gen(j,1))))))'*k1find(mpc.gen(j,1),bus_con{mpc.gen(j,1)},mpc);
  end
%   for i=1:size(results1.branch(:,1),1)   
%    3>=mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
%    3>=mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
%    -4<=mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
%    -4<=mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
%   end
%linear flows
% nn=20;
% for l=1:nn
%     for i=1:size(results1.branch(:,1),1)   
%     2.5*sind(360/nn)>=(sind(360*l/nn)-sind(360*(l-1)/nn))*mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
%         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
%     end
% end
  p(2)==0;
  q(2)==0;
  p(3)==0;
  q(3)==0;
  
  
  v>=.9;
  v<=1.1;
    cvx_end
    %% Results
results3.branch(:,1:2)=results1.branch(:,1:2);
for i=1:size(results1.branch(:,1),1)
   results3.branch(i,3)=results1.branch(i,14);
   results3.branch(i,5)=results1.branch(i,15);
   results3.branch(i,4)=mpc.baseMVA*p1find(mpc.branch(i,1),mpc.branch(i,2),mpc,V(results1.branch(i,1)),V(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch(i,6)=mpc.baseMVA*q1find(mpc.branch(i,1),mpc.branch(i,2),mpc,V(results1.branch(i,1)),V(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.s(i,1)=sqrt(results3.branch(i,3)^2+results3.branch(i,5)^2);
   results3.s(i,2)=sqrt(results3.branch(i,4)^2+results3.branch(i,6)^2);
end
results3.p(:,1)=results1.gen(:,2);
results3.p(:,2)=mpc.baseMVA*p(:);
results3.q(:,1)=results1.gen(:,3);
results3.q(:,2)=mpc.baseMVA*q(:);
results3.f(1,1)=results1.f;
results3.f(1,2)=cvx_optval;
%% plots
figure1=figure;
from=mpc.branch(:,1);
to=mpc.branch(:,2);
Weight=results3.branch(:,4)';
name=char(mpc.bus(:,1))';
G=digraph(from,to,Weight);
plot(G,'Layout','force','EdgeLabel',G.Edges.Weight)
Ymatrix(:,1)=V;
%Ymatrix(:,2)=V2_sdp;
Ymatrix(:,2)=v;
createfigure_2(Ymatrix,'Voltage Magnitudes','PF','Linear PF')
Ymatrix1(:,1)=tet*180/pi;
Ymatrix1(:,2)=results1.bus(:,9);
createfigure_2(Ymatrix1,'Voltage Angles','PF','Linear PF')
figure
subplot(2,2,1)
plot(results3.branch(:,3:4),'LineWidth',5)
title('active power flow')
legend('matpower','linear')
subplot(2,2,2)
plot(results3.branch(:,5:6),'LineWidth',5)
title('reactive power flow')
legend('matpower','linear')
subplot(2,2,3)
plot(results3.s(:,1:2),'LineWidth',5)
title('apparent power flow')
legend('matpower','linear')