clc
clear
close all
%define_constants;
%% loading case study
addpath('D:\imbalance aleviation strategies\Simulation\Test Cases\Main 342 bus case')
load('MPC.mat')
%% loading libraries
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% creating scenario %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pmain=cd;
Scenario{1,1}='test';
for i=1:size(Scenario,1)
mkdir(Scenario{i})
Scenario{i,2}=[pmain '\' Scenario{i}];
end
save([cd '\Scenario.mat'],'Scenario')
%% %%%%%% Scenario1 %%%%%%%%%%%%%%%%
SN1=MPC;
%% Adding 1 phase PVs
plim=[-5 +5];
qlim=[-4 +4];
SN1.plim=plim;
SN1.qlim=qlim;
SN1.a=openPV([1:5:144],plim,qlim,SN1.a);
SN1.b=openPV([2:5:144],plim,qlim,SN1.b);
SN1.c=openPV([3:5:144],plim,qlim,SN1.c);
%% Adding 3 phase EVs
SN1=open3ev([27 45 83 104 120],[.5],SN1,qlim);
%% scaling unbalance
SN1=scalingunbalacep(SN1,2,1.5,1);
SN1=scalingunbalaceq(SN1,2,1.5,1);
SN=SN1;
save([pmain '\' Scenario{1} '\' 'SN.mat'],'SN')
%% Remove Path
rmpath('D:\imbalance aleviation strategies\Simulation\Test Cases\Main 342 bus case')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')