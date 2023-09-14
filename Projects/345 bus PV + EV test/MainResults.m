clear
clc
close all
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library 1 (Figures-345)')
%% 
load('MPC.mat')
load('results3phaseUn.mat')
load('results3phaseUB.mat')
%% 3 phase plots UB
figure1=createbar3([results3phaseUB.bus.p.a(:,1) results3phaseUB.bus.p.b(:,1) results3phaseUB.bus.p.c(:,1)],...
     [results3phaseUB.bus.p.a(:,2) results3phaseUB.bus.p.b(:,2) results3phaseUB.bus.p.c(:,2)],...
     [results3phaseUB.bus.q.a(:,1) results3phaseUB.bus.q.b(:,1) results3phaseUB.bus.q.c(:,1)],...
     [results3phaseUB.bus.q.a(:,2) results3phaseUB.bus.q.b(:,2) results3phaseUB.bus.q.c(:,2)],...
     [results3phaseUB.bus.s.a(:,1) results3phaseUB.bus.s.b(:,1) results3phaseUB.bus.s.c(:,1)],...
     [results3phaseUB.bus.s.a(:,2) results3phaseUB.bus.s.b(:,2) results3phaseUB.bus.s.c(:,2)],'P Q and S: High Imbalance')
saveas(figure1,'SQP.emf')
%% VUF
Ymatrix(:,1)=results3phaseUn.lin_VUF(:,1);
Ymatrix(:,2)=results3phaseUn.lin_VUF(:,2);
Ymatrix(:,3)=0.02;
Ymatrix(:,4)=results3phaseUB.lin_VUF(:,2);
figure3=createfigure_4(abs(Ymatrix),'VUFs comparison: High Imbalance','ACOPF-PV','ILACOPF-PV','VUF Standard','IBLACOPF-PV');
saveas(figure3,'VUFs comparison.emf')
%% EV SHow
Ymatrix1=[];
Ymatrix1(:,1)=MPC.a.gen(:,12);
Ymatrix1(:,2)=MPC.b.gen(:,12);
Ymatrix1(:,3)=MPC.c.gen(:,12);
Ymatrix2(:,1)=results3phaseUB.bus.pEV(:,1);
Ymatrix2(:,2)=results3phaseUB.bus.pEV(:,2);
Ymatrix2(:,3)=results3phaseUB.bus.pEV(:,3);
figure4=createbar5(100*Ymatrix1,100*Ymatrix2,'Active Power of 3 phases of EV Chargers: High Imbalance');
xlim([91 122])
saveas(figure4,'Active Power of 3 phases of EV Chargers.emf')