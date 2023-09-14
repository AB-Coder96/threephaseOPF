clc
clear
close all
%define_constants;
%% loading case study
MPC=case33bww3ph;
%MPC=case345bww3ph
%% Grid-Connected/Microgrid 
MPC.a.gen(1,8)=1;
MPC.b.gen(1,8)=1;
MPC.c.gen(1,8)=1;
%% Adding PVs
MPC.a=openPV([],MPC.a);
MPC.b=openPV([],MPC.b);
MPC.c=openPV([],MPC.c);
%% Adding EVs
MPC.a=openEV([4],MPC.a);
MPC.b=openEV([],MPC.b);
MPC.c=openEV([],MPC.c);
%% modyfing Grid limits
 % phase a
 MPC.a.gen(1,9)=10;
 MPC.a.gen(1,10)=-10;
 MPC.a.gen(1,4)=10;
 MPC.a.gen(1,5)=-10;
 % phase b
 MPC.b.gen(1,9)=10;
 MPC.b.gen(1,10)=-10;
 MPC.b.gen(1,4)=10;
 MPC.b.gen(1,5)=-10;
 % phase c
 MPC.c.gen(1,9)=10;
 MPC.c.gen(1,10)=-10;
 MPC.c.gen(1,4)=10;
 MPC.c.gen(1,5)=-10;
%% modyfing PV limits
%phase a
%MPC.a.gen(2:end,9)=3;
%MPC.a.gen(2:end,10)=-3;
%MPC.a.gen(2:end,4)=3;
%MPC.a.gen(2:end,5)=-3;
%phase b
%MPC.b.gen(2:end,9)=3;
%MPC.b.gen(2:end,10)=-3;
%MPC.b.gen(2:end,4)=3;
%MPC.b.gen(2:end,5)=-3;
%phase c
%MPC.c.gen(2:end,9)=3;
%MPC.c.gen(2:end,10)=-3;
%MPC.c.gen(2:end,4)=3;
%MPC.c.gen(2:end,5)=-3;
%% modifying cost
MPC.a.gencost(1,5)=6;
MPC.b.gencost(1,5)=6;
MPC.c.gencost(1,5)=6;
MPC.a.gencost(2:end,5:7)=0;
MPC.b.gencost(2:end,5:7)=0;
MPC.c.gencost(2:end,5:7)=0;
%% scaling unbalance
MPC.b.bus(:,3)=1*MPC.a.bus(:,3);
MPC.b.bus(:,4)=1*MPC.a.bus(:,4);
MPC.c.bus(:,3)=1*MPC.a.bus(:,3);
MPC.c.bus(:,4)=1*MPC.a.bus(:,4);
MPC.a.bus(:,3)=1*MPC.a.bus(:,3);
MPC.a.bus(:,4)=1*MPC.a.bus(:,4);
%% Pick phase a for comparison
mpc=MPC.a;
%% 1 phase OPF
results=Runlinopf(mpc);
%% 1 phase plots 
createfigure_2(results.bus.V,'Voltage Magnitudes','matpower','linear')
createfigure_2(results.bus.tet,'Voltage Angles','matpower','linear')
createfigure_sub(results.branch.p(:,1:2),results.branch.q(:,1:2),results.branch.s(:,1:2))
createbar(results.bus.p,results.bus.q,results.bus.s)
createbar2(results.f)