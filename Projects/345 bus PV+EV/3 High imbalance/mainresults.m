clc
clear
close all
%%
addpath('D:\imbalance aleviation strategies\Simulation\345 bus PV case 2')
%%
load('results3phaseUn.mat')
load('MPC.mat')
load('results3phaseUB.mat')
%% S P Q
% figure1=createbar3([results3phaseUB.bus.p.a(:,1) results3phaseUB.bus.p.b(:,1) results3phaseUB.bus.p.c(:,1)],...
%      [results3phaseUB.bus.p.a(:,2) results3phaseUB.bus.p.b(:,2) results3phaseUB.bus.p.c(:,2)],...
%      [results3phaseUB.bus.q.a(:,1) results3phaseUB.bus.q.b(:,1) results3phaseUB.bus.q.c(:,1)],...
%      [results3phaseUB.bus.q.a(:,2) results3phaseUB.bus.q.b(:,2) results3phaseUB.bus.q.c(:,2)],...
%      [results3phaseUB.bus.s.a(:,1) results3phaseUB.bus.s.b(:,1) results3phaseUB.bus.s.c(:,1)],...
%    [results3phaseUB.bus.s.a(:,2) results3phaseUB.bus.s.b(:,2) results3phaseUB.bus.s.c(:,2)],'P, Q , and S: High Imbalance');
%saveas(figure1,'SPQ.emf')
%% VUF
Ymatrix(:,1)=results3phaseUn.lin_VUF(:,1);
Ymatrix(:,2)=results3phaseUn.lin_VUF(:,2);
Ymatrix(:,3)=0.02;
Ymatrix(:,4)=results3phaseUB.lin_VUF(:,2);
figure2=createfigure_4(abs(Ymatrix),'VUFs comparison: High Imbalance','ACOPF-PV','ILACOPF-PV','VUF Standard','IBLACOPF-PV');
saveas(figure2,'VUFs comparison.emf')
%% Magnitude
YMatrix2(:,1)=results3phaseUn.bus.V.a(:,1);
YMatrix2(:,2)=results3phaseUn.bus.V.b(:,1);
YMatrix2(:,3)=results3phaseUn.bus.V.c(:,1);
YMatrix2(:,4)=results3phaseUn.bus.V.a(:,2);
YMatrix2(:,5)=results3phaseUn.bus.V.b(:,2);
YMatrix2(:,6)=results3phaseUn.bus.V.c(:,2);
YMatrix2(:,7)=results3phaseUB.bus.V.a(:,2);
YMatrix2(:,8)=results3phaseUB.bus.V.b(:,2);
YMatrix2(:,9)=results3phaseUB.bus.V.c(:,2);
%figure3=createfigure_3r(YMatrix2,'3 Phase Voltage Magnitudes: High Imbalance','Magnitude (p.u)','ACOPF-PV (a)','ACOPF-PV (b)','ACOPF-PV (c)','ILACOPF-PV (a)','ILACOPF-PV (b)','ILACOPF-PV (c)','IBLACOPF-PV (a)','IBLACOPF-PV (b)','IBLACOPF-PV (c)');
%saveas(figure3,'3 Phase Voltage Magnitudes.emf')
%% Angle
YMatrix2(:,1)=results3phaseUn.bus.tet.a(:,1);
YMatrix2(:,2)=results3phaseUn.bus.tet.b(:,1);
YMatrix2(:,3)=results3phaseUn.bus.tet.c(:,1);
YMatrix2(:,4)=results3phaseUn.bus.tet.a(:,2);
YMatrix2(:,5)=results3phaseUn.bus.tet.b(:,2);
YMatrix2(:,6)=results3phaseUn.bus.tet.c(:,2);
YMatrix2(:,7)=results3phaseUB.bus.tet.a(:,2);
YMatrix2(:,8)=results3phaseUB.bus.tet.b(:,2);
YMatrix2(:,9)=results3phaseUB.bus.tet.c(:,2);
[figure4,legend4]=createfigure_3r(YMatrix2,'3 Phase Voltage Angles: High Imbalance','angles (Degree)','ACOPF-PV (a)','ACOPF-PV (b)','ACOPF-PV (c)','ILACOPF-PV (a)','ILACOPF-PV (b)','ILACOPF-PV (c)','IBLACOPF-PV (a)','IBLACOPF-PV (b)','IBLACOPF-PV (c)');
set(legend4,'Location','northeast')
saveas(figure4,'3 Phase Voltage Angles.emf')