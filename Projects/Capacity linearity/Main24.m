%% 24 hour simulation
clc
clear
close all
%%
for i=1:24
    MPC(i)=case33bww3ph;
end
for i=1:24
    MPC.b.bus(i)=1;
end