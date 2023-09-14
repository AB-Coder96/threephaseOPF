clc
clear
close all
%% loading libraries
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Operators')
%% lod scenario
load('Scenario.mat')
%% %%%%%%%%%%%%%%%%%% Create plots %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:size(Scenario,1)
Plotgen(Scenario{i,2},cd)
end
%% Remove Path
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Operators')