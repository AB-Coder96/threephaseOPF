clc
clear
close all
%define_constants;
%% loading case study
MPC=case33bww3ph;
%MPC=case345bww3ph%% Pick phase  for comparison
mpc=MPC.a;
%% 1 phase plots
figure1 = figure
axes1 = axes('Parent',figure1);
hold(axes1,'on');
plot(digraph(mpc.branch(:,1),mpc.branch(:,2)),'Parent',axes1)
title('IEEE 33 Bus Test System','FontName','Times New Roman');
set(axes1,'XTick',zeros(1,0),'YTick',zeros(1,0));
box(axes1,'on');
saveas(figure1,'33busschematic.emf')