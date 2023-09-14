function createbar3r(Ymatrix1,Ymatrix2,Ymatrix3,Ymatrix4,Ymatrix5,Ymatrix6,str1,str2)
%CREATEFIGURE1(ymatrix1, ymatrix2, ymatrix3)
%  YMATRIX1:  bar matrix data
%  YMATRIX2:  bar matrix data
%  YMATRIX3:  bar matrix data
str1a(1)=str1;
str1a(2)="(a)";
str1a=join(str1a);
str1b(1)=str1;
str1b(2)="(b)";
str1b=join(str1b);
str1c(1)=str1;
str1c(2)="(c)";
str1c=join(str1c);

str2a(1)=str2;
str2a(2)="(a)";
str2a=join(str2a);
str2b(1)=str2;
str2b(2)="(b)";
str2b=join(str2b);
str2c(1)=str2;
str2c(2)="(c)";
str2c=join(str2c);

g=[0 0.5 0];
% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.11 0.13 3.4/4 3.4/6],...
    'Units','inches');
hold(axes1,'on');

% Create multiple lines using matrix input to bar
bar1 = bar(Ymatrix1,'Parent',axes1,'BarWidth',1,'LineWidth',1);
set(bar1(1),'DisplayName',str1a,'FaceColor','none','EdgeColor','b');
set(bar1(2),'DisplayName',str1b,'FaceColor','none','EdgeColor','r');
set(bar1(3),'DisplayName',str1c,'FaceColor','none','EdgeColor',g);
bar2 = bar(Ymatrix2,'Parent',axes1,'BarWidth',1,'LineWidth',1);
set(bar2(1),'DisplayName',str2a,'FaceColor',[0 0 1],'EdgeColor','black');
set(bar2(2),'DisplayName',str2b,'FaceColor',[1 0 0],'EdgeColor','black');
set(bar2(3),'DisplayName',str2c,'FaceColor',[0 0.5 0],'EdgeColor','black');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[-3.3333336750883 20]);
box(axes1,'on');
% Set the remaining axes properties
set(axes1,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on',...
    'YGrid','on');
% Create xlabel
xlabel('Bus Numbers','FontWeight','bold','FontName','Times New Roman');
ylabel('P(kW)')
% Create legend
legend1 = legend(axes1,'show');
set(legend1,'NumColumns',2);
title('Active Power of the Photolovtaic Systems')
% Create figure
figure2 = figure;
% Create axes
axes2 = axes('Parent',figure2,...
    'Position',[0.11 0.13 3.4/4 3.4/6],...
    'Units','inches');
hold(axes2,'on');

% Create multiple lines using matrix input to bar
bar1 = bar(Ymatrix3,'Parent',axes2,'BarWidth',1,'LineWidth',1);
set(bar1(1),'DisplayName',str1a,'FaceColor','none','EdgeColor','b');
set(bar1(2),'DisplayName',str1b,'FaceColor','none','EdgeColor','r');
set(bar1(3),'DisplayName',str1c,'FaceColor','none','EdgeColor',g);
bar2 = bar(Ymatrix4,'Parent',axes2,'BarWidth',1,'LineWidth',1);
set(bar2(1),'DisplayName',str2a,'FaceColor',[0 0 1],'EdgeColor','black');
set(bar2(2),'DisplayName',str2b,'FaceColor',[1 0 0],'EdgeColor','black');
set(bar2(3),'DisplayName',str2c,'FaceColor',[0 0.5 0],'EdgeColor','black');

% Create xlabel
xlabel('Bus Numbers','FontWeight','bold','FontName','Times New Roman');

% Create ylabel
ylabel('Q (kVAr)','FontWeight','bold','FontName','Times New Roman');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes2,[-1.72585988115386 8]);
box(axes2,'on');
% Set the remaining axes properties
set(axes2,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on',...
    'YGrid','on');
% Create legend
legend2 = legend(axes2,'show');
set(legend2,'NumColumns',2);
title('Reactive Power of the Photolovtaic Systems')
% Create figure
figure3 = figure;
% Create axes
axes3 = axes('Parent',figure3,...
    'Position',[0.11 0.13 3.4/4 3.4/6],...
    'Units','inches');
hold(axes3,'on');

% Create multiple lines using matrix input to bar
bar1 = bar(Ymatrix5,'Parent',axes3,'BarWidth',1,'LineWidth',1);
bar2 = bar(Ymatrix6,'Parent',axes3,'BarWidth',1,'LineWidth',1);
set(bar2(1),'DisplayName',str2a,'FaceColor',[0 0 1],'EdgeColor','black');
set(bar2(2),'DisplayName',str2b,'FaceColor',[1 0 0],'EdgeColor','black');
set(bar2(3),'DisplayName',str2c,'FaceColor',[0 0.5 0],'EdgeColor','black');

set(bar1(1),'DisplayName',str1a,'FaceColor','none','EdgeColor','b');
set(bar1(2),'DisplayName',str1b,'FaceColor','none','EdgeColor','r');
set(bar1(3),'DisplayName',str1c,'FaceColor','none','EdgeColor',g);


% Create ylabel
ylabel('S (kVA)','FontWeight','bold','FontName','Times New Roman');

% Create xlabel
xlabel('Bus Numbers','FontWeight','bold','FontName','Times New Roman');

% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes3,[0 11]);
box(axes3,'on');
% Set the remaining axes properties
set(axes3,'FontName','Times New Roman','FontSize',12,'FontWeight','bold',...
    'GridAlpha',1,'GridColor',...
    [0.941176470588235 0.941176470588235 0.941176470588235],'XGrid','on',...
    'YGrid','on');
% Create legend
legend3 = legend(axes3,'show');
set(legend3,'NumColumns',2);
title('Apparent Power of the Photolovtaic Systems')