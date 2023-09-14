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
results3phaseUB=Runlinopf3UB(MPC,0.0005);
%% 3 phase plots
%createbar2(results3phaseUn.f.total)
 createfigure_2(abs(results3phaseUn.VUF(:,1:2)),'VUFs in OPF','VUF','linear VUF')
createfigure_2(abs(results3phaseUn.lin_VUF(:,1:2)),'VUFs in LOPF','VUF','linear VUF')
%% 3 phase comparison
Ymatrix(:,1)=results3phaseUn.lin_VUF(:,1);
Ymatrix(:,2)=results3phaseUn.lin_VUF(:,2);
Ymatrix(:,3)=results3phaseUB.lin_VUF(:,2);
Ymatrix(:,4)=results3phaseUn.VUF(:,3);
createfigure_4(abs(Ymatrix),'VUFs comparison','Matpower','Un','UB','Un-Exact')
%% 3 phase plots Combined (Un-Ub)
YMatrix2(:,1)=results3phaseUn.bus.V.a(:,1);
YMatrix2(:,2)=results3phaseUn.bus.V.b(:,1);
YMatrix2(:,3)=results3phaseUn.bus.V.c(:,1);
YMatrix2(:,4)=results3phaseUn.bus.V.a(:,2);
YMatrix2(:,5)=results3phaseUn.bus.V.b(:,2);
YMatrix2(:,6)=results3phaseUn.bus.V.c(:,2);
YMatrix2(:,7)=results3phaseUB.bus.V.a(:,2);
YMatrix2(:,8)=results3phaseUB.bus.V.b(:,2);
YMatrix2(:,9)=results3phaseUB.bus.V.c(:,2);
createfigure_3r(YMatrix2,'3 Phase Voltage Magnitudes')
YMatrix2(:,1)=results3phaseUn.bus.tet.a(:,1);
YMatrix2(:,2)=results3phaseUn.bus.tet.b(:,1);
YMatrix2(:,3)=results3phaseUn.bus.tet.c(:,1);
YMatrix2(:,4)=results3phaseUn.bus.tet.a(:,2);
YMatrix2(:,5)=results3phaseUn.bus.tet.b(:,2);
YMatrix2(:,6)=results3phaseUn.bus.tet.c(:,2);
YMatrix2(:,7)=results3phaseUB.bus.tet.a(:,2);
YMatrix2(:,8)=results3phaseUB.bus.tet.b(:,2);
YMatrix2(:,9)=results3phaseUB.bus.tet.c(:,2);
createfigure_3r(YMatrix2,'3 Phase Voltage Angles')