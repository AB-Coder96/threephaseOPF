close all
load('results3phaseCrossphaseVUFPareto.mat')
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');
for t=1:8
for i=0:10
eval(['F2(i+1,t)=results3phaseCrossphaseVUFPareto{1, ' num2str(t) '}.w' num2str(i) '.VUFtotal'])
eval(['F1(i+1,t)=results3phaseCrossphaseVUFPareto{1, ' num2str(t) '}.w' num2str(i) '.Costtotal'])
end
plot(F1(:,t),F2(:,t),DisplayName=['Interval' num2str(t)],LineStyle='--',Marker='o',MarkerSize=3)
hold on
end
%box(axes1,'on');
%legend('show',Location='northeast')
axes1.Box="on"

title('Pareto Front of CrossphaseVUF','FontName','Times New Roman')
xlabel('Total Cost','FontName','Times New Roman')
ylabel('VUFapr Sum','FontName','Times New Roman')
legend('show','FontName','Times New Roman')