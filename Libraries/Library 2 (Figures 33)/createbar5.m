function figure1=createbar5(Ymatrix1,Ymatrix2,ttl)
figure1 = figure;
g=[0 .5 0];
% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.11 0.13 3.4/4 3.4/6], 'Units','inches')

hold(axes1,'on');

set(axes1,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on','GridLineStyle',...
    '-','YGrid','on');
set(0,'DefaultAxesLineWidth',2,'DefaultLineLineWidth',1)

box(axes1,'on');

bar1=bar(Ymatrix1,'LineWidth',1,'Parent',axes1);

set(bar1,'barwidth',1,'FaceColor','none')
set(bar1(1),'DisplayName','ACOPF-PV (a)','EdgeColor','b')
set(bar1(2),'DisplayName','ACOPF-PV (b)','EdgeColor','r')
set(bar1(3),'DisplayName','ACOPF-PV (c)','EdgeColor',g)
hold on
bar2=bar(Ymatrix2);
set(bar2,'barwidth',1)
set(bar2(1),'DisplayName','ILACOPF-PVEV (a)','FaceColor','b')
set(bar2(2),'DisplayName','ILACOPF-PVEV (b)','FaceColor','r')
set(bar2(3),'DisplayName','ILACOPF-PVEV (c)','FaceColor',g)
ylabel('P(kW)')
xlabel('Bus numbers')

title(ttl)

legend1 = legend('show');
set(legend1,'NumColumns',2,'FontSize',9,'location','southeast');