clc
clear
close all
%define_constants;
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Library Case Modification')
%% loading case study
MPC=case345bww3ph;
%% SLACK
MPC.Slack=144:192;
%% voltage limits
MPC.a.bus(:,13)=.9;
MPC.b.bus(:,13)=.9;
MPC.c.bus(:,13)=.9;
MPC.a.bus(:,12)=1.1;
MPC.b.bus(:,12)=1.1;
MPC.c.bus(:,12)=1.1;
MPC.a.bus(MPC.Slack,12:13)=1;
MPC.b.bus(MPC.Slack,12:13)=1;
MPC.c.bus(MPC.Slack,12:13)=1;
%% Grid-Connected/Microgrid 
MPC.a.gen(1:end,8)=0;
MPC.b.gen(1:end,8)=0;
MPC.c.gen(1:end,8)=0;
MPC.a.gen(MPC.Slack,8)=1;
MPC.b.gen(MPC.Slack,8)=1;
MPC.c.gen(MPC.Slack,8)=1;
%% slack
MPC.a.bus(1:end,2)=1;
MPC.b.bus(1:end,2)=1;
MPC.c.bus(1:end,2)=1;
MPC.a.bus(MPC.Slack,2)=3;
MPC.b.bus(MPC.Slack,2)=3;
MPC.c.bus(MPC.Slack,2)=3;
%% modyfing Grid limits
MPC=pvlimitp(MPC,0,0);
MPC=pvlimitq(MPC,0,0);
MPC=gridlimitp(MPC,-10,+10,MPC.Slack);
MPC=gridlimitq(MPC,-10,+10,MPC.Slack);
%% modifying cost
MPC.a.gencost(1,5)=3;
MPC.b.gencost(1,5)=3;
MPC.c.gencost(1,5)=3;
MPC.a.gencost(2:end,5:7)=0;
MPC.b.gencost(2:end,5:7)=0;
MPC.c.gencost(2:end,5:7)=0;
%%
MPC.vuf=0.0005;
save('MPC.mat','MPC')