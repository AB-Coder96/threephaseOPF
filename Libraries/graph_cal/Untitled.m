clc
clear
close
dbstop if error
%dbclear all
va=linspace(.9,1.1,100);
vb=linspace(.9,1.1,100);
vc=linspace(.9,1.1,100);
ta=linspace(-3,+3,100);
tb=linspace(-3,+3,100);
tc=linspace(-3,+3,100);
figure1=figure
subplot(3,2,1)
%plot(va,V1adjust(va,0,1,120,1,-120))
hold on
plot(va,V1(va,0,1,120,1,-120))
subplot(3,2,2)
%plot(ta,V1adjust(1,ta,1,120,1,-120))
hold on
plot(ta,V1(1,ta,1,120,1,-120))
subplot(3,2,3)
%plot(vb,V1adjust(1,0,vb,120,1,-120))
hold on
plot(vb,V1(1,0,vb,120,1,-120))
subplot(3,2,4)
%plot(tb,V1adjust(1,0,1,120+tb,1,-120))
hold on
plot(tb,V1(1,0,1,120+tb,1,-120))
subplot(3,2,5)
%plot(vc,V1adjust(1,0,1,120,vc,-120))
hold on
plot(vc,V1(1,0,1,120,vc,-120))
subplot(3,2,6)
%plot(tc,V1adjust(1,0,1,120,1,tc-120))
hold on
plot(tc,V1(1,0,1,120,1,tc-120))
title('V1')
figure2=figure
subplot(3,2,1)
plot(va,50*V2(va,0,1,120,1,-120))
subplot(3,2,2)
plot(ta,50*V2(1,ta,1,120,1,-120))
subplot(3,2,3)
plot(vb,50*V2(1,0,vb,120,1,-120))
subplot(3,2,4)
plot(tb,50*V2(1,0,1,120+tb,1,-120))
subplot(3,2,5)
plot(vc,50*V2(1,0,1,120,vc,-120))
subplot(3,2,6)
plot(tc,50*V2(1,0,1,120,1,tc-120))
title('V2')

[va ta]=meshgrid(va,ta);
[vb tb]=meshgrid(vb,tb);
[vc tc]=meshgrid(vc,tc);
% [taa vaa]=meshgrid(ta,va);
% [tbb vbb]=meshgrid(tb,vb);
% [tcc vcc]=meshgrid(tc,vc);
%figure
figure3=figure
subplot(3,5,1)
surf(va,ta,50*V2(va,ta,1,120,1,-120),'DisplayName','V1','LineWidth',2)
title('va ta')
subplot(3,5,2)
surf(va,vb,50*V2(va,0,vb,120,1,-120),'DisplayName','V1','LineWidth',2)
title('va vb')
subplot(3,5,3)
surf(va,tb,50*V2(va,0,1,tb+120,1,-120),'DisplayName','V1','LineWidth',2)
title('va tb')
subplot(3,5,4)
surf(va,vc,50*V2(va,0,1,+120,vc,-120),'DisplayName','V1','LineWidth',2)
title('va vc')
subplot(3,5,5)
surf(va,tc,50*V2(va,0,1,+120,1,tc-120),'DisplayName','V1','LineWidth',2)
title('va tc')
subplot(3,5,6)
surf(ta,vb,50*V2(va,0,1,tb+120,1,-120),'DisplayName','V1','LineWidth',2)
title('ta vb')
subplot(3,5,7)
surf(ta,tb,50*V2(va,0,1,tb+120,1,-120),'DisplayName','V1','LineWidth',2)
title('ta tb')
subplot(3,5,8)
surf(ta,vc,50*V2(1,ta,1,+120,vc,-120),'DisplayName','V1','LineWidth',2)
title('ta vc')
subplot(3,5,9)
surf(ta,tc,50*V2(1,ta,1,+120,1,tc-120),'DisplayName','V1','LineWidth',2)
title('ta tc')
subplot(3,5,10)
surf(vb,tb,50*V2(1,0,vb,tb+120,1,-120),'DisplayName','V1','LineWidth',2)
subplot(3,5,11)
title('vb tb')
surf(vb,vc,50*V2(1,0,vb,+120,vc,-120),'DisplayName','V1','LineWidth',2)
title('vb vc')
subplot(3,5,12)
surf(vb,tc,50*V2(1,0,vb,+120,1,tc-120),'DisplayName','V1','LineWidth',2)
title('vb tc')
%
subplot(3,5,13)
surf(tb,vc,50*V2(1,0,1,tb+120,vc,-120),'DisplayName','V1','LineWidth',2)
hold on
contourf(tb,vc,50*V2(1,0,1,tb+120,vc,-120),[0 1])
title('tb vc')
%
subplot(3,5,14)
surf(tb,tc,50*V2(1,0,1,tb+120,1,tc-120),'DisplayName','V1','LineWidth',2)
hold on
contourf(tb,tc,50*V2(1,0,1,tb+120,1,tc-120),[0 1])
title('tb tc')
%
subplot(3,5,15)
surf(vc,tc,50*V2(1,0,1,+120,vc,tc-120),'DisplayName','V1','LineWidth',2)
hold on
contourf(vc,tc,50*V2(1,0,1,+120,vc,tc-120),[0 1])
title('vc tc')