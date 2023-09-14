function createbar2(yvector1)
%CREATEFIGURE(yvector1)
%  YVECTOR1:  bar yvector

%  Auto-generated by MATLAB on 23-Mar-2020 16:54:15

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.13 0.115384615384615 0.775 0.809615384615385]);
hold(axes1,'on');

% Create bar
bar1 = bar(yvector1,'DisplayName','data1',...
    'FaceColor',[0.30588236451149 0.396078437566757 0.580392181873322],...
    'EdgeColor',[0 0.749019622802734 0.749019622802734],...
    'BarLayout','stacked');
baseline1 = get(bar1,'BaseLine');
set(baseline1,'Visible','on');

% Create ylabel
ylabel('Cost($)');

% Create title
title('Objective Function');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[-210 0]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'Color',[0.972549021244049 0.972549021244049 0.972549021244049],...
    'FontName','Georgia','FontSize',12,'XColor',[0 0 0],'XTick',[1 2],...
    'XTickLabel',{'Matpower','Linear'},'YColor',[0 0 0],'YGrid','on','ZColor',...
    [0 0 0]);
