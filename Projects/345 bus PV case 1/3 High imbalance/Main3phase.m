clc
clear
close all
%define_constants;
%% loading case study
%MPC=case33bww3ph;
MPC=case345;
%% voltage limits
MPC.a.bus(:,13)=.9;
MPC.b.bus(:,13)=.9;
MPC.c.bus(:,13)=.9;
MPC.a.bus(:,12)=1.1;
MPC.b.bus(:,12)=1.1;
MPC.c.bus(:,12)=1.1;
MPC.a.bus(144:192,12:13)=1;
MPC.b.bus(144:192,12:13)=1;
MPC.c.bus(144:192,12:13)=1;
%% Grid-Connected/Microgrid 
slack=144:192;
MPC.a.gen(1:end,8)=0;
MPC.b.gen(1:end,8)=0;
MPC.c.gen(1:end,8)=0;
MPC.a.gen(1,8)=1;
MPC.b.gen(1,8)=1;
MPC.c.gen(1,8)=1;
% slack
MPC.a.bus(1:end,2)=1;
MPC.b.bus(1:end,2)=1;
MPC.c.bus(1:end,2)=1;
MPC.a.bus(144:192,2)=3;
MPC.b.bus(144:192,2)=3;
MPC.c.bus(144:192,2)=3;
% modyfing Grid limits
MPC=gridlimitp(MPC,0,0,1:192);
MPC=gridlimitq(MPC,0,0,1:192);
MPC=gridlimitp(MPC,-10,+10,slack);
MPC=gridlimitq(MPC,-10,+10,slack);
%% modyfing PV limits
plimit=[-15,+15];
qlimit=[-15,+15];
%MPC=pvlimitp(MPC,-3,3);
%MPC=pvlimitq(MPC,-4,+4);
%% Adding 1 phase PVs
MPC.a=openPV([1:5:144],plimit,qlimit,MPC.a);
MPC.b=openPV([2:5:144],plimit,qlimit,MPC.b);
MPC.c=openPV([3:5:144],plimit,qlimit,MPC.c);
%% Adding 3 phase PVs
PVBuses=[145:192];
MPC=open3pv(PVBuses,[-5 +5],[   -5 +5],MPC);
%% Adding 3 phase EVs
%Size=10;
%EVBuses=[];
%EVSch=[];
%MPC=open3ev(EVBuses,Size,EVSch,MPC);
%% modifying cost
MPC.a.gencost(145:192,5)=300;
MPC.b.gencost(145:192,5)=300;
MPC.c.gencost(145:192,5)=300;
MPC.a.gencost(1:191,5:7)=0;
MPC.b.gencost(1:191,5:7)=0;
MPC.c.gencost(1:191,5:7)=0;
%% scaling unbalance
MPC=scalingunbalacep(MPC,1,2,1.5);
MPC=scalingunbalaceq(MPC,1,2,1.5);
save('MPC.mat','MPC')
%% Solvers
%cvx_solver sedumi
%cvx_solver SDPT3
%cvx_precision best
%% 3 phase OPF
results3phaseUn=Runlinopf3(MPC);
results3phaseUB=Runlinopf3UB(MPC,2.5,0);
save('results3phaseUn','results3phaseUn')
save('results3phaseUB','results3phaseUB')
%% 3 phase plots Un
YMatrix2(:,1)=results3phaseUn.bus.V.a(:,1);
YMatrix2(:,2)=results3phaseUn.bus.V.b(:,1);
YMatrix2(:,3)=results3phaseUn.bus.V.c(:,1);
YMatrix2(:,4)=results3phaseUn.bus.V.a(:,2);
YMatrix2(:,5)=results3phaseUn.bus.V.b(:,2);
YMatrix2(:,6)=results3phaseUn.bus.V.c(:,2);
YMatrix2(:,7)=results3phaseUn.bus.V.a(:,2);
YMatrix2(:,8)=results3phaseUn.bus.V.b(:,2);
YMatrix2(:,9)=results3phaseUn.bus.V.c(:,2);
createfigure_9(YMatrix2,'Un: 3 Phase Voltage Magnitudes')
YMatrix2(:,1)=results3phaseUn.bus.tet.a(:,1);
YMatrix2(:,2)=results3phaseUn.bus.tet.b(:,1);
YMatrix2(:,3)=results3phaseUn.bus.tet.c(:,1);
YMatrix2(:,4)=results3phaseUn.bus.tet.a(:,2);
YMatrix2(:,5)=results3phaseUn.bus.tet.b(:,2);
YMatrix2(:,6)=results3phaseUn.bus.tet.c(:,2);
YMatrix2(:,7)=results3phaseUn.bus.tet.a(:,3);
YMatrix2(:,8)=results3phaseUn.bus.tet.b(:,3);
YMatrix2(:,9)=results3phaseUn.bus.tet.c(:,3);
createfigure_9(YMatrix2,'Un: 3 Phase Voltage Angles')
createbar3([results3phaseUn.bus.p.a(:,1) results3phaseUn.bus.p.b(:,1) results3phaseUn.bus.p.c(:,1)],...
     [results3phaseUn.bus.p.a(:,2) results3phaseUn.bus.p.b(:,2) results3phaseUn.bus.p.c(:,2)],...
     [results3phaseUn.bus.q.a(:,1) results3phaseUn.bus.q.b(:,1) results3phaseUn.bus.q.c(:,1)],...
     [results3phaseUn.bus.q.a(:,2) results3phaseUn.bus.q.b(:,2) results3phaseUn.bus.q.c(:,2)],...
     [results3phaseUn.bus.s.a(:,1) results3phaseUn.bus.s.b(:,1) results3phaseUn.bus.s.c(:,1)],...
     [results3phaseUn.bus.s.a(:,2) results3phaseUn.bus.s.b(:,2) results3phaseUn.bus.s.c(:,2)])
%createbar2(results3phaseUn.f.total)
% createfigure_2(abs(results3phaseUn.VUF(:,1:2)),'VUFs in OPF','VUF','linear VUF')
% createfigure_2(abs(results3phaseUn.lin_VUF(:,1:2)),'VUFs in LOPF','VUF','linear VUF')
%% 3 phase plots UB
YMatrix3(:,1)=results3phaseUB.bus.V.a(:,1);
YMatrix3(:,2)=results3phaseUB.bus.V.b(:,1);
YMatrix3(:,3)=results3phaseUB.bus.V.c(:,1);
YMatrix3(:,4)=results3phaseUB.bus.V.a(:,2);
YMatrix3(:,5)=results3phaseUB.bus.V.b(:,2);
YMatrix3(:,6)=results3phaseUB.bus.V.c(:,2);
createfigure_6(YMatrix3,'3 Phase Voltage Magnitudes')
YMatrix3(:,1)=results3phaseUB.bus.tet.a(:,1);
YMatrix3(:,2)=results3phaseUB.bus.tet.b(:,1);
YMatrix3(:,3)=results3phaseUB.bus.tet.c(:,1);
YMatrix3(:,4)=results3phaseUB.bus.tet.a(:,2);
YMatrix3(:,5)=results3phaseUB.bus.tet.b(:,2);
YMatrix3(:,6)=results3phaseUB.bus.tet.c(:,2);
createfigure_6(YMatrix3,'3 Phase Voltage Angles')
createbar3([results3phaseUB.bus.p.a(:,1) results3phaseUB.bus.p.b(:,1) results3phaseUB.bus.p.c(:,1)],...
     [results3phaseUB.bus.p.a(:,2) results3phaseUB.bus.p.b(:,2) results3phaseUB.bus.p.c(:,2)],...
     [results3phaseUB.bus.q.a(:,1) results3phaseUB.bus.q.b(:,1) results3phaseUB.bus.q.c(:,1)],...
     [results3phaseUB.bus.q.a(:,2) results3phaseUB.bus.q.b(:,2) results3phaseUB.bus.q.c(:,2)],...
     [results3phaseUB.bus.s.a(:,1) results3phaseUB.bus.s.b(:,1) results3phaseUB.bus.s.c(:,1)],...
     [results3phaseUB.bus.s.a(:,2) results3phaseUB.bus.s.b(:,2) results3phaseUB.bus.s.c(:,2)])
%createbar2(results3phaseUB.f.total)
% createfigure_2(results3phaseUB.VUF(:,1:2),'VUFs in OPF','VUF','linear VUF')
% createfigure_2(results3phaseUB.lin_VUF(:,1:2),'VUFs in LOPF','VUF','linear VUF')
%% 3 phase comparison
Ymatrix1(1)=results3phaseUn.f.total(1);
Ymatrix1(2)=results3phaseUn.f.total(2);
Ymatrix1(3)=results3phaseUB.f.total(2); 
createbar4(Ymatrix1,'Objective Functions')
Ymatrix(:,1)=results3phaseUn.lin_VUF(:,1);
Ymatrix(:,2)=results3phaseUn.lin_VUF(:,2);
Ymatrix(:,3)=results3phaseUn.VUF(:,3);
Ymatrix(:,4)=results3phaseUB.lin_VUF(:,2);
createfigure_4(abs(Ymatrix),'VUFs comparison','Matpower','Un','Un-Exact','UB')
figure
plot(results3phaseUB.bus.tet.a-results3phaseUB.bus.tet.b)
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