clc
clear
close all
%define_constants;
%% loading case study
addpath('D:\imbalance aleviation strategies\Simulation\Test Cases\Main 33 bus case')
load('MPC.mat')
%% loading libraries
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% creating scenario %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pmain=cd;
Scenario{1,1}='low-imbalance';
Scenario{2,1}='Moderate-imbalance';
Scenario{3,1}='High-imbalance';
for i=1:size(Scenario,1)
mkdir(Scenario{i})
Scenario{i,2}=[pmain '\' Scenario{i}];
end
save([cd '\Scenario.mat'],'Scenario')
%% %%%%%% Scenario1 %%%%%%%%%%%%%%%%
SN1=MPC;
%% Adding 1 phase PVs
SN1.plim=[-3 +3];
SN1.qlim=[-3 +3];
plim=[-3 +3];
qlim=[-3 +3];
SN1.a=openPV([10 20],plim,qlim,SN1.a);
SN1.b=openPV([18 33],plim,qlim,SN1.b);
SN1.c=openPV([3 13 23],plim,qlim,SN1.c);
%% Adding 3 phase PVs
SN1=open3pv([5],plim,qlim,SN1);
%% Adding EVs
SN1.a=openEV([],1,SN1.a,3);
SN1.b=openEV([],1,SN1.b,3);
SN1.c=openEV([],1,SN1.c,3);
%% scaling unbalance
SN1=scalingunbalacep(SN1,1,1,1);
SN1=scalingunbalaceq(SN1,1,1,1);
SN=SN1;
save([pmain '\' Scenario{1} '\' 'SN.mat'],'SN')
%% %%%%%%%%%%%% scenario 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SN2=MPC;
SN2.plim=[-3 +3];
SN2.qlim=[-3 +3];
%% Adding 1 phase PVs
SN2.a=openPV([10 20],plim,qlim,SN2.a);
SN2.b=openPV([18 33],plim,qlim,SN2.b);
SN2.c=openPV([3 13 23],plim,qlim,SN2.c);
%% Adding 3 phase PVs
SN2=open3pv([5],plim,qlim,SN2);
%% Adding EVs
SN2.a=openEV([],1,SN2.a,3);
SN2.b=openEV([],1,SN2.b,3);
SN2.c=openEV([],1,SN2.c,3);
%% scaling unbalance
SN2=scalingunbalacep(SN2,1,1.1,.9);
SN2=scalingunbalaceq(SN2,1,1.2,.8);
SN=SN2;
save([pmain '\' Scenario{2} '\' 'SN.mat'],'SN')
%% %%%%%%%%%%%%%%%%% SCENARIO 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SN3=MPC;
SN3.plim=[-3 +3];
SN3.qlim=[-3 +3];
%% Adding 1 phase PVs
SN3.a=openPV([10 20],plim,qlim,SN3.a);
SN3.b=openPV([18 33],plim,qlim,SN3.b);
SN3.c=openPV([3 13 23],plim,qlim,SN3.c);
%% Adding 3 phase PVs
SN3=open3pv([5],plim,qlim,SN3);
%% Adding EVs
SN3.a=openEV([],1,SN3.a,3);
SN3.b=openEV([],1,SN3.b,3);
SN3.c=openEV([],1,SN3.c,3);
%% scaling unbalance
SN3=scalingunbalacep(SN3,1,1.5,.5);
SN3=scalingunbalaceq(SN3,1,1.5,.5);
SN=SN3;
save([pmain '\' Scenario{3} '\' 'SN.mat'],'SN')
%% Remove Path
rmpath('D:\imbalance aleviation strategies\Simulation\Test Cases\Main 33 bus case')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')