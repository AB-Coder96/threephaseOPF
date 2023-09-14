clc
clear
close all
Initiate
%define_constants;
%% time input
T=8;
%% loading case study
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Test Cases\Main 33 bus case')
load('MPC.mat')
%% loading libraries
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Library Case Modification')
pmain=cd;
load('Scenario.mat')
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
SN1.a=openPV([10 20],5,10,SN1.a); % in KW
SN1.b=openPV([18 33],5,10,SN1.b); % in KW
SN1.c=openPV([3 13 23],5,10,SN1.c); % in KW
% Adding 3 phase PVs
SN1=open3PV([7 17 27 33],9,15,SN1); % in KW
% Adding EVs
SN1.a=openEV([],1,3,SN1.a); % in KW
SN1.b=openEV([],1,3,SN1.b); % in KW
SN1.c=openEV([],1,3,SN1.c); % in KW
% Adding 3 phase EVs
SN1=open3EV([],3,9,SN1); % in KW
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