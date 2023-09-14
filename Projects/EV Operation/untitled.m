clc
close all
clear all
fig1=figure

%title(fig1,"Inverter Power References in Crossphase and OPF Methods")
subplot1=subplot(2,2,1)
set(subplot1,'FontName','Times New Roman')
x= categorical({'S','P','Q'});
y=[19.92428347	18.53777301	21.56344001;
19.92201521	18.51751302	21.56047176;
-0.300635476	-0.866452321	0.357774352;
]
bar1=bar(x,y)
set(bar1(1),'FaceColor',[0 0 1]);
set(bar1(2),'FaceColor',[1 0 0]);
set(bar1(3),'FaceColor',[0 0.501960784313725 0]);
set(subplot1,'XGrid','on','XMinorGrid','on','YGrid','on','YMinorGrid','on');
title('Operational','FontName','Times New Roman','Interpreter','latex')
ylabel('Crossphase','FontWeight','bold','FontName','Times New Roman','Interpreter','latex','Interpreter','latex');
subplot2=subplot(2,2,3)
x= categorical({'S','P','Q'});
y=[20.00169584	20.01730397	20.0043698;
20	20	20;
-0.260454212	-0.83214063	0.418104233;
]
bar2=bar(x,y)
set(bar2(1),'FaceColor',[0 0 1]);
set(bar2(2),'FaceColor',[1 0 0]);
set(bar2(3),'FaceColor',[0 0.501960784313725 0]);
set(subplot2,'XGrid','on','XMinorGrid','on','YGrid','on','YMinorGrid','on');
ylabel('OPF','FontWeight','bold','FontName','Times New Roman','Interpreter','latex');
subplot3=subplot(2,2,2)
x= categorical({'S','P','Q'});
y=[0.158056699	2.545611419	2.812729338;
-0.106473148	-2.401947515	2.508420663;
0.116813478	-0.843081036	1.272506231;]
bar3=bar(x,y)
set(bar3(1),'FaceColor',[0 0 1]);
set(bar3(2),'DisplayName','b','FaceColor',[1 0 0]);
set(bar3(3),'DisplayName','c','FaceColor',[0 0.501960784313725 0]);
set(subplot3,'XGrid','on','XMinorGrid','on','YGrid','on','YMinorGrid','on');
title('Non-Operational','FontName','Times New Roman','Interpreter','latex')

subplot4=subplot(2,2,4)
x= categorical({'S','P','Q'});
y=[0	0	0;
0	0	0;
0	0	0;
]
bar4=bar(x,y)
set(bar4(1),'DisplayName','a','FaceColor',[0 0 1]);
set(bar4(2),'DisplayName','b','FaceColor',[1 0 0]);
set(bar4(3),'DisplayName','c','FaceColor',[0 0.501960784313725 0]);
set(subplot4,'XGrid','on','XMinorGrid','on','YGrid','on','YMinorGrid','on');
legend(subplot4,'show','FontName','Times New Roman');
sgtitle('Inverter Power References (Kw, KVAR, KVA)','FontName','Times New Roman','Interpreter','latex') 