clc
clear
close all
dbstop if error
%dbclear all
Initiate
%% loading libraries
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Operators')
%% study
studyparent(["Fixed"])
%% Remove Path
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Operators')