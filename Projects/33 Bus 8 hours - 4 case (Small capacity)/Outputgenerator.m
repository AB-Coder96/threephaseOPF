clc
clear
close all
dbclear all
dbstop if error
%dbclear all
Initiate
%% loading libraries
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Operators')
%% %%%%%%%%%%%%%%%%%% Create plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plotparent(["3DVECTOR3branch"])
%% Remove Path
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Operators')