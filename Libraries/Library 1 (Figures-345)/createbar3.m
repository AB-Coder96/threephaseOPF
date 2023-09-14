function figure1=createbar3(Ymatrix1,Ymatrix2,Ymatrix3,Ymatrix4,Ymatrix5,Ymatrix6,ttl)
figure1 = figure;
g=[0 .5 0];
%%
axes1=subplot(3,1,1);
%subplot('position',[0.11 0.13 3.4/4 3.4/6])
set(axes1,...
 'Units','inches')
hold(axes1,'on');
set(axes1,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on','GridLineStyle',...
    '-','YGrid','on');
set(0,'DefaultAxesLineWidth',2,'DefaultLineLineWidth',1)
box(axes1,'on');
bar1=bar(Ymatrix5);
set(bar1,'barwidth',1)
set(bar1(1),'DisplayName','Matpower (a)','FaceColor','b')
set(bar1(2),'DisplayName','Matpower (b)','FaceColor','r')
set(bar1(3),'DisplayName','Matpower (c)','FaceColor',g)
hold on
plot2=plot(Ymatrix6);
set(plot2,'linewidth',1)
set(plot2(1),'DisplayName','a','Color','b')
set(plot2(2),'DisplayName','b','Color','r')
set(plot2(3),'DisplayName','c','Color',g)
ylabel('P (kw)')
xlabel('Bus Numbers')
title(ttl)
%%
axes2=subplot(3,1,2);
%subplot('position',[0.11 0.13 3.4/4 3.4/6])
set(axes2,...
 'Units','inches')
hold(axes2,'on');
set(axes2,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on','GridLineStyle',...
    '-','YGrid','on');
set(0,'DefaultAxesLineWidth',2,'DefaultLineLineWidth',1)
box(axes2,'on');
bar1=bar(Ymatrix3,'Parent',axes2);
set(bar1,'barwidth',1)
set(bar1(1),'DisplayName','Matpower (a)','FaceColor','b')
set(bar1(2),'DisplayName','Matpower (b)','FaceColor','r')
set(bar1(3),'DisplayName','Matpower (c)','FaceColor',g)
hold on
plot2=plot(Ymatrix4);
set(plot2,'linewidth',1)
set(plot2(1),'DisplayName','a','Color','b')
set(plot2(2),'DisplayName','b','Color','r')
set(plot2(3),'DisplayName','c','Color',g)
ylabel('Q (kVAr)')
%%
axes3=subplot(3,1,3);
%subplot('position',[0.11 0.13 3.4/4 3.4/6])
set(axes3,...
 'Units','inches')
hold(axes3,'on');
set(axes3,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on','GridLineStyle',...
    '-','YGrid','on');
set(0,'DefaultAxesLineWidth',2,'DefaultLineLineWidth',1)
box(axes3,'on');
bar1=bar(Ymatrix5);
set(bar1,'barwidth',1)
set(bar1(1),'DisplayName','Matpower (a)','FaceColor','b')
set(bar1(2),'DisplayName','Matpower (b)','FaceColor','r')
set(bar1(3),'DisplayName','Matpower (c)','FaceColor',g)
hold on
plot2=plot(Ymatrix6);
set(plot2,'linewidth',1)
set(plot2(1),'DisplayName','a','Color','b')
set(plot2(2),'DisplayName','b','Color','r')
set(plot2(3),'DisplayName','c','Color',g)
ylabel('S (kVA)')
xlabel('Bus Numbers')
end