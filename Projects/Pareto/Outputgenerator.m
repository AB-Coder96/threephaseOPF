clc
clear
close all
dbclear all
dbstop if error
%dbclear all
Initiate
load('root.mat')
%% loading libraries
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Operators')
%% %%%%%%%%%%%%%%%%%% Create plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plotparent(["3DVECTOR3bus"])
%% Remove Path
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Operators')