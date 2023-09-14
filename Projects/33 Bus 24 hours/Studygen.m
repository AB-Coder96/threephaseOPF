clc
clear
close all
%dbstop if error
dbclear all
Initiate
%% loading libraries
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Operators')
%% study
studyparent(["UBEVtest1"])
%% Remove Path
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Operators')