function [Results,MPC]=Runlinopf3AC(SN)
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
%% Converting 1 phase Devices to the matpower
MPC=ConvertMatpower(MPC);
%% Run a
results1a=runopf(MPC.a);
%% Results a
for i=1:size(results1a.branch(:,1),1)
    results3.branch.q.a(i,1)=results1a.branch(i,15);
   results3.branch.s.a(i,1)=sqrt(results3.branch.p.a(i,1)^2+results3.branch.q.a(i,1)^2);
end
results3.bus.p.a(:,1)=results1a.gen(:,2);
results3.bus.p.a(:,2)=results1a.gen(:,2);
results3.bus.q.a(:,1)=results1a.gen(:,3);
results3.bus.q.a(:,2)=results1a.gen(:,3);
results3.bus.s.a(:,1)=sqrt(results1a.gen(:,2).^2+results1a.gen(:,3).^2);
results3.bus.s.a(:,2)=sqrt(results1a.gen(:,2).^2+results1a.gen(:,3).^2);
results3.f.a(1,1)=results1a.f;
results3.bus.V.a(:,1)=results1a.bus(:,8);
results3.bus.V.a(:,2)=results1a.bus(:,8);
results3.bus.tet.a(:,1)=results1a.bus(:,9);
results3.bus.tet.a(:,2)=results1a.bus(:,9);
% S-linear a
nn=10;
 for l=1:nn
     for i=1:size(results1a.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*results3.branch.p.a(i,1)...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*results1a.branch(i,15))/sind(360/nn);
     end
 end
for i=1:size(results1a.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.a(:,4)=S';
%% Run b
results1=runopf(MPC.b);
%% Results b
for i=1:size(results1.branch(:,1),1)
   results3.branch.p.b(i,1)=results1.branch(i,14);
   results3.branch.q.b(i,1)=results1.branch(i,15);
   results3.branch.s.b(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
end
results3.bus.p.b(:,1)=results1.gen(:,2);
results3.bus.q.b(:,1)=results1.gen(:,3);
results3.bus.s.b(:,1)=sqrt(results1.gen(:,2).^2+results1.gen(:,3).^2);
results3.f.b(1,1)=results1.f;
results3.bus.V.b(:,1)=results1.bus(:,8);
results3.bus.tet.b(:,1)=results1.bus(:,9);
% S-linear b
nn=10;
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*results3.branch.p.b(i,1)...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*results3.branch.q.b(i,1))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
%% Run c
results3.branch.s.b(:,3)=S';
%% Results c
results1=runopf(MPC.c);
for i=1:size(results1.branch(:,1),1)
   results3.branch.p.c(i,1)=results1.branch(i,14);
   results3.branch.q.c(i,1)=results1.branch(i,15);
   results3.branch.s.c(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
end
results3.bus.p.c(:,1)=results1.gen(:,2);
results3.bus.q.c(:,1)=results1.gen(:,3);
results3.bus.s.c(:,1)=sqrt(results1.gen(:,2).^2+results1.gen(:,3).^2);
results3.f.c(1,1)=results1.f;
results3.bus.V.c(:,1)=results1.bus(:,8);
results3.bus.tet.c(:,1)=results1.bus(:,9);
% S-linear c
nn=10;
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*results3.branch.p.c(i,1)...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*results3.branch.q.c(i,1))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.c(:,3)=S';
%% 3phase Results
results3.VUF(:,1)=VUF(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.VUFlin(:,1)=VUF_lin(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.ftotal(1,1)=results3.f.a(1,1)+results3.f.b(1,1)+results3.f.c(1,1);
results3.mismatch(:,1)=mismatch(results3.branch.p.a(:,1),results3.branch.p.b(:,1),results3.branch.p.c(:,1));
Results{snd,snq}=results3;
    end
end
%% remove library
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
end