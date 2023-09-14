clc
clear
close all
%define_constants;
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
%% loading case study
MPC=case33bww3ph;
%% All
MPC.All=1:length(MPC.a.gen);
MPC.a.All=MPC.All;
MPC.b.All=MPC.All;
MPC.c.All=MPC.All;
%% Base MVA
MPC.baseMVA=MPC.a.baseMVA;
MPC.a.baseMVA=MPC.baseMVA;
MPC.b.baseMVA=MPC.baseMVA;
MPC.c.baseMVA=MPC.baseMVA;
MPC.baseKVA=MPC.baseMVA*1000; 
MPC.a.baseKVA=MPC.baseKVA;
MPC.b.baseKVA=MPC.baseKVA;
MPC.c.baseKVA=MPC.baseKVA;
%% Base Voltage
MPC.a.bus(:,13)=12.6;
MPC.b.bus(:,13)=12.6;
MPC.c.bus(:,13)=12.6;
%% preprocessing
MPC.a.gen(:,11:end)=[];
MPC.b.gen(:,11:end)=[];
MPC.c.gen(:,11:end)=[];
%% Voltage limits
MPC.a.bus(:,13)=.9;
MPC.b.bus(:,13)=.9;
MPC.c.bus(:,13)=.9;
MPC.a.bus(:,12)=1.1;
MPC.b.bus(:,12)=1.1;
MPC.c.bus(:,12)=1.1;
%% Grid-Connected/Microgrid 
MPC.a.gen(1:end,8)=0;
MPC.b.gen(1:end,8)=0;
MPC.c.gen(1:end,8)=0;
%% Bus type
MPC.a.bus(1:end,2)=1;
MPC.b.bus(1:end,2)=1;
MPC.c.bus(1:end,2)=1;
%% modyfing Grid limits
MPC=gridlimitp(MPC,0,0,MPC.All);
MPC=gridlimitq(MPC,0,0,MPC.All);
%% modifying cost
MPC.a.gencost(1,5)=3;
MPC.b.gencost(1,5)=3;
MPC.c.gencost(1,5)=3;
MPC.a.gencost(2:end,5:7)=0;
MPC.b.gencost(2:end,5:7)=0;
MPC.c.gencost(2:end,5:7)=0;
%%
MPC.vuf=0.0005;
%% add slack
MPC=openSlack([1],10,-10,MPC);
%% save
save('MPC.mat','MPC')