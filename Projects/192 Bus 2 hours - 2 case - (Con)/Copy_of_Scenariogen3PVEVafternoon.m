clc
clear
close all
Initiate
%define_constants;
%% loading case study
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Test Cases\Main 342 bus case')
load('MPC.mat')
%% loading libraries
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Library Case Modification')
pmain=cd;
load('Scenario.mat')
%% time input
T=2;
%% number of scenarios
MPC=scalingunbalacep(MPC,1,1,1);
MPC=scalingunbalaceq(MPC,1,1,1);
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Adding scenario %%%%%%%%%%%%%%%%%%%%%
% name must not start with numbers
N=dbstack
N=N.name
N=erase(N,'Scenariogen')
name=N;
[st,msg]=mkdir(name)
if msg~="Directory already exists."
   Scenario{end+1,1}=name;
   index=length(Scenario);
else
   for i=1:size(Scenario,1)
       if Scenario{i, 1}==convertCharsToStrings(name)
       index=i;
       end
   end
end
save([cd '\Scenario.mat'],'Scenario')
%% PV EV noon
SN1=MPC;
% Adding 1 phase PVs
SN1.a=openPV([10 30 60 90 120 140],50,100,SN1.a); % in KW
SN1.b=openPV([15 25 65 85 105 143 40],50,100,SN1.b); % in KW
SN1.c=openPV([19 28 69 5  3   130 100],50,100,SN1.c); % in KW
% Adding 3 phase PVs
SN1=open3PV([7 17 27 33 55 82 94 126],150,300,SN1); % in KW
% Adding EVs
SN1.a=openEV([8 19 39 61 99 139],20,40,SN1.a); % in KW
SN1.b=openEV([10 21 42 52 78 95],20,40,SN1.b); % in KW
SN1.c=openEV([2 12 31 84 111 119],20,40,SN1.c); % in KW
% Adding 3 phase EVs
SN1=open3EV([10 15 20 25 66 88 122],60,120,SN1); % in KW
for i=1:T
SN1=scalingunbalacep(SN1,1,1+i/10,1-i/10);
SN1=scalingunbalaceq(SN1,1,1+i/10,1-i/10);
SN{1,i}=SN1;
end
Scenario{end,2}=[pmain '\' Scenario{index, 1}];
save([pmain '\' Scenario{index, 1} '\' 'SN.mat'],'SN')
cd([pmain '\' Scenario{index, 1}])
xlswrite('3PV',SN1.Device3PV)
xlswrite('PVa',SN1.a.DevicePV)
xlswrite('PVb',SN1.b.DevicePV)
xlswrite('PVc',SN1.c.DevicePV)
xlswrite('3EV',SN1.Device3EV)
xlswrite('EVa',SN1.a.DeviceEV)
xlswrite('EVb',SN1.b.DeviceEV)
xlswrite('EVc',SN1.c.DeviceEV)
cd([pmain])
%% Scenario folders
save([cd '\Scenario.mat'],'Scenario')

%% Remove Path
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Test Cases\Main 342 bus case')
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Library Case Modification')