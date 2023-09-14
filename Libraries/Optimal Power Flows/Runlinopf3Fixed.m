function [Results,MPC]=Runlinopf3Fixed(SN)
%% add library
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Library Case Modification')
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\graph_cal')
%% time
for snd=1:size(SN,1)
    for snq=1:size(SN,2)
%% Extract MPC
MPC=SN{snd,snq};
%% Extracting the configuration in each bus
K=BusSep(MPC); 
Kslack=K{1};
Kpva=K{2}; %PVa
Kpvb=K{3}; %PVb
Kpvc=K{4}; %PVc
Keva=K{5}; %EVa
Kevb=K{6}; %EVb
Kevc=K{7}; %EVc
K3pv=K{8}; %3PV
K3ev=K{9}; %3PV
%% initiate connection cells
bus_con=ConCell(MPC.a);
%% variable
%vuf=MPC.vuf;
n=size(MPC.a.bus,1);
bus=MPC.a.bus(:,1);
%% Begin CVX 3 phase
acc=7;

cvx_begin

  variables Pgena(n) Qgena(n) Pgenb(n) Qgenb(n) Pgenc(n) Qgenc(n)
  variables Peva(n) Qeva(n) Pevb(n) Qevb(n) Pevc(n) Qevc(n)
  variables Ppva(n) Qpva(n) Ppvb(n) Qpvb(n) Ppvc(n) Qpvc(n)
  variables P3pva(n) Q3pva(n) P3pvb(n) Q3pvb(n) P3pvc(n) Q3pvc(n)
  variables P3eva(n) Q3eva(n) P3evb(n) Q3evb(n) P3evc(n) Q3evc(n)
  variables va(n) teta(n) vb(n) tetb(n) vc(n) tetc(n)
   
   minimize(...
 +Pgena'.^2*MPC.a.gencost(:,5)*(MPC.baseMVA)^2+Pgena'*MPC.a.gencost(:,6)*(MPC.baseMVA)+sum(MPC.a.gencost(:,7))...
 +Pgenb'.^2*MPC.b.gencost(:,5)*(MPC.baseMVA)^2+Pgenb'*MPC.b.gencost(:,6)*(MPC.baseMVA)+sum(MPC.b.gencost(:,7))...
 +Pgenc'.^2*MPC.c.gencost(:,5)*(MPC.baseMVA)^2+Pgenc'*MPC.c.gencost(:,6)*(MPC.baseMVA)+sum(MPC.c.gencost(:,7))...
);
%+Ppva'.^2*MPC.a.gencost(:,5)*(MPC.baseMVA)^2+Ppva'*MPC.a.gencost(:,6)*(MPC.baseMVA)...
 %+Ppvb'.^2*MPC.b.gencost(:,5)*(MPC.baseMVA)^2+Ppvb'*MPC.b.gencost(:,6)*(MPC.baseMVA)...
 %+Ppvc'.^2*MPC.c.gencost(:,5)*(MPC.baseMVA)^2+Ppvc'*MPC.c.gencost(:,6)*(MPC.baseMVA)...
 %+P3pva'.^2*MPC.a.gencost(:,5)*(MPC.baseMVA)^2+P3pva'*MPC.a.gencost(:,6)*(MPC.baseMVA)...
 

  %+Ppva'.^2*MPC.a.gencost(:,5)*(MPC.baseMVA)^2+Ppva'*MPC.a.gencost(:,6)*(MPC.baseMVA)...
%
%...
%
%+P3pvb'.^2*MPC.b.gencost(:,5)*(MPC.baseMVA)^2+P3pvb'*MPC.b.gencost(:,6)*(MPC.baseMVA)...
%+P3pvc'.^2*MPC.c.gencost(:,5)*(MPC.baseMVA)^2+P3pvc'*MPC.c.gencost(:,6)*(MPC.baseMVA)...
  subject to 
  % power flow
  for i=MPC.All
  %Pflowa(1,i)=MPC.a.bus(i,3)/MPC.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a)+(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a);
  %Qflowa(1,i)=MPC.a.bus(i,4)/MPC.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a)-(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a);
  %Pflowb(1,i)=MPC.b.bus(i,3)/MPC.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b)+(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b);
  %Qflowb(1,i)=MPC.b.bus(i,4)/MPC.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b)-(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b);
  %Pflowc(1,i)=MPC.c.bus(i,3)/MPC.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c)+(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c);
  %Qflowc(1,i)=MPC.c.bus(i,4)/MPC.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c)-(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c);
 
  Pgena(i)+Ppva(i)+P3pva(i)==P3eva(i)+Peva(i)+MPC.a.bus(i,3)/MPC.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a)+(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a);
  Qgena(i)+Qpva(i)+Q3pva(i)==Q3eva(i)+Qeva(i)+MPC.a.bus(i,4)/MPC.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a)-(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a);
  Pgenb(i)+Ppvb(i)+P3pvb(i)==P3evb(i)+Pevb(i)+MPC.b.bus(i,3)/MPC.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b)+(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b);
  Qgenb(i)+Qpvb(i)+Q3pvb(i)==Q3evb(i)+Qevb(i)+MPC.b.bus(i,4)/MPC.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b)-(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b);
  Pgenc(i)+Ppvc(i)+P3pvc(i)==P3evc(i)+Pevc(i)+MPC.c.bus(i,3)/MPC.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c)+(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c);
  Qgenc(i)+Qpvc(i)+Q3pvc(i)==Q3evc(i)+Qevc(i)+MPC.c.bus(i,4)/MPC.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c)-(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c);
  end
  
%   for j=MPC.All
%   va(j)<=MPC.a.bus(j,12);vb(j)<=MPC.b.bus(j,12);vc(j)<=MPC.c.bus(j,12);
%   va(j)>=MPC.a.bus(j,13);vb(j)>=MPC.b.bus(j,13);vc(j)>=MPC.c.bus(j,13);
%   end
  
    va>=.8;va<=1.1;
    vb>=.8;vb<=1.1;
    vc>=.8;vc<=1.1;
  
  %Line Limit
  for l=1:acc
%      for i=1:size(MPC.b.branch(:,1),1)  
%          
%      6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2)))...
%         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2))))/sind(360/nn);
%   
%      6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)))...
%         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2))))/sind(360/nn);
%    
%      6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2)))...
%         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2))))/sind(360/nn);
%      end
  end
  % Slack & Voltage
  for j=Kslack
     va(j)==1;vb(j)==1;vc(j)==1;
     teta(j)==0;tetb(j)==0;tetc(j)==0;
%      Pgena(j)*MPC.baseMVA>=MPC.a.gen(j,10)
%      Pgena(j)*MPC.baseMVA<=MPC.a.gen(j,9)
%      Qgena(j)*MPC.baseMVA>=MPC.a.gen(j,5)
%      Qgena(j)*MPC.baseMVA<=MPC.a.gen(j,4)
%      Pgenb(j)*MPC.baseMVA>=MPC.b.gen(j,10)
%      Pgenb(j)*MPC.baseMVA<=MPC.b.gen(j,9)
%      Qgenb(j)*MPC.baseMVA>=MPC.b.gen(j,5)
%      Qgenb(j)*MPC.baseMVA<=MPC.b.gen(j,4)
%      Pgenc(j)*MPC.baseMVA>=MPC.c.gen(j,10)
%      Pgenc(j)*MPC.baseMVA<=MPC.c.gen(j,9)
%      Qgenc(j)*MPC.baseMVA>=MPC.c.gen(j,5)
%      Qgenc(j)*MPC.baseMVA<=MPC.c.gen(j,4)
  end
% ~Slack limit
  for j=setdiff(MPC.All,Kslack)
   Pgena(j)==0
   Qgena(j)==0
   Pgenb(j)==0
   Qgenb(j)==0
   Pgenc(j)==0
   Qgenc(j)==0
  end  
%  3ev
  for j=K3ev
      
        P3eva(j)==(1/3)*MPC.Device3EV(j,2)/MPC.baseMVA
        P3evb(j)==(1/3)*MPC.Device3EV(j,2)/MPC.baseMVA
        P3evc(j)==(1/3)*MPC.Device3EV(j,2)/MPC.baseMVA
         
        Q3eva(j)==0;
        Q3evb(j)==0;
        Q3evc(j)==0;

  end
  for j=setdiff(MPC.All,K3ev)
   P3eva(j)==0
   Q3eva(j)==0
   P3evb(j)==0
   Q3evb(j)==0
   P3evc(j)==0
   Q3evc(j)==0
  end
  %  eva
  for j=Keva
        Peva(j)==MPC.a.DeviceEV(j,2)/MPC.baseMVA
        Qeva(j)==0;     
  end
  for j=setdiff(MPC.All,Keva)
   Peva(j)==0
   Qeva(j)==0
  end
    %  evb
   for j=Kevb
        Pevb(j)==MPC.b.DeviceEV(j,2)/MPC.baseMVA
        Qevb(j)==0;
   end
  for j=setdiff(MPC.All,Kevb)
   Pevb(j)==0
   Qevb(j)==0
  end
    %  evc
   for j=Kevc
        Pevc(j)==MPC.c.DeviceEV(j,2)/MPC.baseMVA
        Qevc(j)==0;
   end
  for j=setdiff(MPC.All,Kevc)
      Pevc(j)==0
      Qevc(j)==0
  end
  % 3pv
  for j=K3pv
        P3pva(j)==(1/3)*MPC.Device3PV(j,2)/MPC.baseMVA
        P3pvb(j)==(1/3)*MPC.Device3PV(j,2)/MPC.baseMVA
        P3pvc(j)==(1/3)*MPC.Device3PV(j,2)/MPC.baseMVA
        Q3pva(j)==0;
        Q3pvb(j)==0;
        Q3pvc(j)==0;
  end
  for j=setdiff(MPC.All,K3pv)
        P3pva(j)==0
        Q3pva(j)==0
        P3pvb(j)==0
        Q3pvb(j)==0
        P3pvc(j)==0
        Q3pvc(j)==0
  end
%  pva
  for j=Kpva
        Ppva(j)==MPC.a.DevicePV(j,2)/MPC.baseMVA
        Qpva(j)==0;
  end
  for j=setdiff(MPC.All,Kpva)
      Ppva(j)==0
      Qpva(j)==0
  end
  %  pvb
  for j=Kpvb
        Ppvb(j)==MPC.b.DevicePV(j,2)/MPC.baseMVA
        Qpvb(j)==0;
  end
  for j=setdiff(MPC.All,Kpvb)
      Ppvb(j)==0
      Qpvb(j)==0
  end
  %  pvc
  for j=Kpvc
        Ppvc(j)==MPC.c.DevicePV(j,2)/MPC.baseMVA
        Qpvc(j)==0;  
  end
  for j=setdiff(MPC.All,Kpvc)
      Ppvc(j)==0
      Qpvc(j)==0
  end
% VUF limit           
 for i=MPC.All
%(([0.0032 -0.0058 +0.0026 +0.0154 +0.2897 -0.2877]-vuf*[2.0563e-04 -1.0771e-04 -9.7921e-05 +0.3331 +0.3333 +0.3333])*[tetb(i) teta(i) tetc(i) va(i) vb(i) vc(i)]'-0.0798-vuf*0.0015)<=0
%(0.0032*tetb(i))-(0.0058*teta(i))+(0.0026*tetc(i))+(0.0154*va(i))+(0.2897*vb(i))-(0.2877*vc(i))-0.0798<=vuf*((2.0563e-04*teta(i))-(1.0771e-04*tetb(i))-(9.7921e-05*tetc(i))+(0.3331*va(i))+(0.3333*vb(i))+(0.3333*vc(i))+0.0015)
%(0.0032*tetb)-(0.00158*teta)+(0.0026*tetc)+(0.0154*va)+(0.2897*vb)-(0.2877*vc)-0.0798>=-vuf*((2.0563e-04*teta)-(1.0771e-04*tetb)-(9.7921e-05*tetc)+(0.3331*va)+(0.3333*vb)+(0.3333*vc)+0.0015)
 end
   %(teta-tetb).^2<.001
   %(teta-tetc).^2<.001
  % (tetb-tetc).^2<.001
%    ((teta-tetb)*180/pi).^2<=(.3)^2
%    ((teta-tetc)*180/pi).^2<=(.3)^2
%    ((tetb-tetc)*180/pi).^2<=(.3)^2
%    (va-vb).^2<=(.05)^2
%    (va-vc).^2<=(.05)^2
%    (vb-vc).^2<=(.05)^2
   
 cvx_end
  % loss
 for i=MPC.All
 Va(i)=complex(va(i)*cos(teta(i)),va(i)*sin(teta(i)));
 Vb(i)=complex(vb(i)*cos(tetb(i)),vb(i)*sin(tetb(i)));
 Vc(i)=complex(vc(i)*cos(tetc(i)),vc(i)*sin(tetc(i)));
 end
 for i=MPC.All
 lossa(i)=0;
 lossb(i)=0;
 lossc(i)=0;
 Branch=cell2mat(bus_con(i));
 for j=1:length(Branch)
   lossa(i)=rfind(i,Branch(j),MPC.a).*abs((Va(i)-Va(Branch(j)))./zfind(i,Branch(j),MPC.a)).^2+lossa(i);
   lossb(i)=rfind(i,Branch(j),MPC.b).*abs((Vb(i)-Vb(Branch(j)))./zfind(i,Branch(j),MPC.b)).^2+lossb(i);
   lossc(i)=rfind(i,Branch(j),MPC.c).*abs((Vc(i)-Vc(Branch(j)))./zfind(i,Branch(j),MPC.c)).^2+lossc(i);
 end
 end
 Lossa=sum(lossa)
 Lossb=sum(lossb)
 Lossc=sum(lossc)
 Loss=sum(lossa+lossb+lossc)/2;
%% cvx to matpower 

%% Results a
for i=1:size(MPC.a.branch(:,1),1)
   results3.branch.p.a(i,1)=MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)));
   results3.branch.q.a(i,1)=MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)));
   results3.branch.s.a(i,1)=sqrt(results3.branch.p.a(i,1)^2+results3.branch.q.a(i,1)^2);
end
results3.bus.GENp.a(:,1)=MPC.a.baseMVA*Pgena(:);
results3.bus.GENq.a(:,1)=MPC.a.baseMVA*Qgena(:);
results3.bus.GENs.a(:,1)=sqrt((MPC.a.baseMVA*Pgena(:)).^2+(MPC.a.baseMVA*Qgena(:)).^2);
fa=Pgena'.^2*MPC.a.gencost(:,5)*(MPC.a.baseMVA)^2+Pgena'*MPC.a.gencost(:,6)*(MPC.a.baseMVA)+sum(MPC.a.gencost(:,7));
results3.f.a(1,1)=fa;
results3.loss.a(1,1)=Lossa;
results3.bus.V.a(:,1)=va(:,1);
results3.bus.tet.a(:,1)=teta(:,1)*180/pi;
% S-linear a
nn=10;
 for l=1:nn
     for i=1:size(MPC.a.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(MPC.a.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.a(:,2)=S';
%% Results b
for i=1:size(MPC.b.branch(:,1),1)
   results3.branch.p.b(i,1)=MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2)));
   results3.branch.q.b(i,1)=MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2)));
   results3.branch.s.b(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
end

results3.bus.GENp.b(:,1)=MPC.b.baseMVA*Pgenb(:);
results3.bus.GENq.b(:,1)=MPC.b.baseMVA*Qgenb(:);
results3.bus.GENs.b(:,1)=sqrt((MPC.b.baseMVA*Pgenb(:)).^2+(MPC.b.baseMVA*Qgenb(:)).^2);
fb=Pgenb'.^2*MPC.b.gencost(:,5)*(MPC.b.baseMVA)^2+Pgenb'*MPC.b.gencost(:,6)*(MPC.b.baseMVA)+sum(MPC.b.gencost(:,7));
results3.f.b(1,1)=fb;
results3.loss.b(1,1)=Lossb;
results3.bus.V.b(:,1)=vb(:,1);
results3.bus.tet.b(:,1)=tetb(:,1)*180/pi;
% S-linear b
nn=10;
 for l=1:nn
     for i=1:size(MPC.b.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(MPC.b.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.b(:,2)=S';
%% Results c
for i=1:size(MPC.c.branch(:,1),1)
   results3.branch.p.c(i,1)=MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2)));
   results3.branch.q.c(i,1)=MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2)));
   results3.branch.s.c(i,1)=sqrt(results3.branch.p.c(i,1)^2+results3.branch.q.c(i,1)^2);
end
results3.bus.GENp.c(:,1)=MPC.c.baseMVA*Pgenc(:);
results3.bus.GENq.c(:,1)=MPC.c.baseMVA*Qgenc(:);
results3.bus.GENs.c(:,1)=sqrt((MPC.c.baseMVA*Pgenc(:)).^2+(MPC.c.baseMVA*Qgenc(:)).^2);
fc=Pgenc'.^2*MPC.c.gencost(:,5)*(MPC.c.baseMVA)^2+Pgenc'*MPC.c.gencost(:,6)*(MPC.c.baseMVA)+sum(MPC.c.gencost(:,7));
results3.f.c(1,1)=fc;
results3.bus.V.c(:,1)=vc(:,1);
results3.loss.c(1,1)=Lossc;
results3.bus.tet.c(:,1)=tetc(:,1)*180/pi;
% S-linear c
nn=10;
 for l=1:nn
     for i=1:size(MPC.c.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(MPC.c.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.c(:,2)=S';
%% 3phase Results
results3.VUF(:,1)=VUF(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.VUFlin(:,1)=VUF_lin(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.ftotal(1,1)=cvx_optval;
results3.Costtotal(1,1)=cvx_optval;
results3.losstotal(1,1)=Loss;
% PV
results3.bus.PVp.a(:,1)=MPC.a.baseKVA*Ppva(:);
results3.bus.PVp.b(:,1)=MPC.a.baseKVA*Ppvb(:);
results3.bus.PVp.c(:,1)=MPC.a.baseKVA*Ppvc(:);
results3.bus.PVq.a(:,1)=MPC.a.baseKVA*Qpva(:);
results3.bus.PVq.b(:,1)=MPC.a.baseKVA*Qpvb(:);
results3.bus.PVq.c(:,1)=MPC.a.baseKVA*Qpvc(:);
results3.bus.PVs.a(:,1)=sqrt((MPC.a.baseKVA*Ppva(:)).^2+(MPC.a.baseKVA*Qpva(:)).^2);
results3.bus.PVs.b(:,1)=sqrt((MPC.a.baseKVA*Ppvb(:)).^2+(MPC.a.baseKVA*Qpvb(:)).^2);
results3.bus.PVs.c(:,1)=sqrt((MPC.a.baseKVA*Ppvc(:)).^2+(MPC.a.baseKVA*Qpvc(:)).^2);
% 3PV
results3.bus.PV3p.a(:,1)=MPC.a.baseKVA*P3pva(:);
results3.bus.PV3p.b(:,1)=MPC.a.baseKVA*P3pvb(:);
results3.bus.PV3p.c(:,1)=MPC.a.baseKVA*P3pvc(:);
results3.bus.PV3q.a(:,1)=MPC.a.baseKVA*Q3pva(:);
results3.bus.PV3q.b(:,1)=MPC.a.baseKVA*Q3pvb(:);
results3.bus.PV3q.c(:,1)=MPC.a.baseKVA*Q3pvc(:);
results3.bus.PV3s.a(:,1)=sqrt((MPC.a.baseKVA*P3pva(:)).^2+(MPC.a.baseKVA*Q3pva(:)).^2);
results3.bus.PV3s.b(:,1)=sqrt((MPC.a.baseKVA*P3pvb(:)).^2+(MPC.a.baseKVA*Q3pvb(:)).^2);
results3.bus.PV3s.c(:,1)=sqrt((MPC.a.baseKVA*P3pvc(:)).^2+(MPC.a.baseKVA*Q3pvc(:)).^2);
% EV
results3.bus.EVp.a(:,1)=MPC.a.baseKVA*Peva(:);
results3.bus.EVp.b(:,1)=MPC.a.baseKVA*Pevb(:);
results3.bus.EVp.c(:,1)=MPC.a.baseKVA*Pevc(:);
results3.bus.EVq.a(:,1)=MPC.a.baseKVA*Qeva(:);
results3.bus.EVq.b(:,1)=MPC.a.baseKVA*Qevb(:);
results3.bus.EVq.c(:,1)=MPC.a.baseKVA*Qevc(:);
results3.bus.EVs.a(:,1)=sqrt((MPC.a.baseKVA*Peva(:)).^2+(MPC.a.baseKVA*Qeva(:)).^2);
results3.bus.EVs.b(:,1)=sqrt((MPC.a.baseKVA*Pevb(:)).^2+(MPC.a.baseKVA*Qevb(:)).^2);
results3.bus.EVs.c(:,1)=sqrt((MPC.a.baseKVA*Pevc(:)).^2+(MPC.a.baseKVA*Qevc(:)).^2);
% 3EV
results3.bus.EV3p.a(:,1)=MPC.a.baseKVA*P3eva;
results3.bus.EV3p.b(:,1)=MPC.b.baseKVA*P3evb;
results3.bus.EV3p.c(:,1)=MPC.c.baseKVA*P3evc;
results3.bus.EV3q.a(:,1)=MPC.a.baseKVA*Q3eva;
results3.bus.EV3q.b(:,1)=MPC.b.baseKVA*Q3evb;
results3.bus.EV3q.c(:,1)=MPC.c.baseKVA*Q3evc;
results3.bus.EV3s.a(:,1)=sqrt((MPC.a.baseKVA*P3eva(:)).^2+(MPC.a.baseKVA*Q3eva(:)).^2);
results3.bus.EV3s.b(:,1)=sqrt((MPC.a.baseKVA*P3evb(:)).^2+(MPC.a.baseKVA*Q3evb(:)).^2);
results3.bus.EV3s.c(:,1)=sqrt((MPC.a.baseKVA*P3evc(:)).^2+(MPC.a.baseKVA*Q3evc(:)).^2);
%
results3.mismatch(:,1)=mismatch(results3.branch.p.a(:,1),results3.branch.p.b(:,1),results3.branch.p.c(:,1));

Results{snd,snq}=results3;
end

%% remove library
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Library Case Modification')
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\graph_cal')
end
end