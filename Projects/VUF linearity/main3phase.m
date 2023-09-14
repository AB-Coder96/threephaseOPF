clc
clear
close all
%% loading case study
MPC=case33bww3ph;
%% Grid-Connected/Microgrid 
MPC.a.gen(1,8)=1;
MPC.b.gen(1,8)=1;
MPC.c.gen(1,8)=1;
%% Adding 1 phase PVs
MPC.a=openPV([],MPC.a);
MPC.b=openPV([],MPC.b);
MPC.c=openPV([],MPC.c);
%% Adding 3 phase PVs
MPC=open3pv([],MPC);
%% Adding EVs
MPC.a=openEV([],MPC.a);
MPC.b=openEV([],MPC.b);
MPC.c=openEV([],MPC.c);
%% modyfing Grid limits
MPC=gridlimitp(MPC,-10,+10);
MPC=gridlimitq(MPC,-10,+10);
%% modyfing PV limits
%MPC=pvlimitp(MPC,-3,3);
MPC=pvlimitq(MPC,-4,+4);
%% modifying cost
MPC.a.gencost(1,5)=3;
MPC.b.gencost(1,5)=3;
MPC.c.gencost(1,5)=3;
MPC.a.gencost(2:end,5:7)=0;
MPC.b.gencost(2:end,5:7)=0;
MPC.c.gencost(2:end,5:7)=0;
%% scaling unbalance
MPC=scalingunbalacep(MPC,1,1.1,.9);
MPC=scalingunbalaceq(MPC,1,1.1,.9);
%% Solvers
%cvx_solver sedumi
%cvx_solver SDPT3
%cvx_precision best
%% 3 phase OPF
results3phaseUn=Runlinopf3(MPC);
%% 3 phase plots
figure1=createfigure1(abs(results3phaseUn.lin_VUF(:,1:2)),'Linear Aproximation of VUF constraint')
saveas(figure1,'Linear Aproximation of VUF constraint.emf')