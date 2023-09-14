clc
clear
close all
%% loading libraries
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Operators')
%% Laod Scenarios
load('Scenario.mat')
%% study 
for i=1:size(Scenario,1)
study(Scenario{i,2},cd,[1 2 3 4])
end
%% Remove Path
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Operators')