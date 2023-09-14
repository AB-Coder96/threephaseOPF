function createfigure_2(YMatrix1,ttl,leg1,leg2)
figure1 = figure;
axes1 = axes('Parent',figure1,...
    'Position',[0.11 0.13 3.4/4 3.4/6], 'Units','inches')
hold(axes1,'on');

% Create multiple lines using matrix input to plot
plot1 = plot(YMatrix1,'LineWidth',5);
set(plot1(1),'DisplayName',leg1);
set(plot1(2),'DisplayName',leg2,'LineStyle',':');

% Create title
title(ttl);

box(axes1,'on');
% Set the remaining axes properties
set(axes1,'XGrid','on','XMinorGrid','on','YGrid','on','YMinorGrid','on');
% Create legend
legend1 = legend(axes1,'show');
set(legend1,...
    'location','southeast');
end
