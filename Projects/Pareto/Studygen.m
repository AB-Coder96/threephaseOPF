clc
clear
close all
dbstop if error
%dbclear all
%Initiate
%% loading libraries
addpath('C:\Users\arazb\OneDrive - Georgia Institute of Technology\OPF\Simulation\Libraries\Operators')
%% study

studyparent(["CrossphaseVUFPareto"])

%% Remove Path
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Operators')