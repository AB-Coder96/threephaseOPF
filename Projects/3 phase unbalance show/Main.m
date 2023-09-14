clc
clear
close all
g=[0 .5 0];
figure1 = figure;
leg1='phase a (Balanced)';
leg2='phase b (Balanced)';
leg3='phase c (Balanced)';
leg4='phase a (Unbalanced)';
leg5='phase b (Unbalanced)';
leg6='phase c (Unbalanced)';
% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.11 0.13 3.4/4 3.4/6], 'Units','inches');
set(axes1,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on','GridLineStyle',...
    '-','YGrid','on');
set(0,'DefaultAxesLineWidth',2,'DefaultLineLineWidth',1)

box(axes1,'on');
hold(axes1,'on');

% Create quiver
quiver(0,0,1,0,'DisplayName','on','Color',[1 0 0],'DisplayName',leg1,'LineWidth',2);
quiver(0,0,-0.5,+sqrt(3)/2,'Color',[0 0 1],'DisplayName',leg2,'LineWidth',2);
quiver(0,0,-.5,-sqrt(3)/2,'Color',[0 0.5 0],'DisplayName',leg3,'LineWidth',2);
% Create quiver
quiver(0,0,.9,0.1,'DisplayName','on','Color',[1 0 0],'DisplayName',leg4,'LineWidth',2,'linestyle','-.');
quiver(0,0,-0.55,+sqrt(3)/2,'Color',[0 0 1],'DisplayName',leg5,'LineWidth',2,'linestyle','-.');
quiver(0,0,-.6,-sqrt(3)/2+0.1,'Color',[0 0.5 0],'DisplayName',leg6,'LineWidth',2,'linestyle','-.');
% create title
title('3 Phase Configuration: Balanced vs Unbalanced');
% Create legend
legend1=legend(axes1,'show');
set(legend1,'Location','west');
 xlim(axes1,[-2 2]);
 saveas(figure1,'3phaseunbalance.emf')