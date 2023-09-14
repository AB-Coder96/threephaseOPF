function [Results,MPC]=Runlinopf3UBEV(SN)
%% add library
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
%% time
for snd=1:size(SN,1)
    for snq=1:size(SN,2)
%% Extract MPC
MPC=SN{snd,snq};
%% initiate connection cells
bus_con=ConCell(MPC);
%% variable
plim=MPC.plim;
qlim=MPC.qlim;
vuf=MPC.vuf;
n=size(MPC.a.bus,1);
bus=MPC.a.bus(:,1);
%% Extracting the configuration in each bus
kk=1:n;
k2a=kk;k2b=kk;k2c=kk;k3=kk;
for i=kk
    %a
    if MPC.a.gen(i,8)==1
        k2a(i)=i;
        k3(i)=0;
    end
    if MPC.a.gen(i,8)==0 
        k2a(i)=0;
        k3(i)=0;        
    end
    %b
    if MPC.b.gen(i,8)==1 
        k2b(i)=i;
        k3(i)=0;
    end
    if MPC.b.gen(i,8)==0
        k2b(i)=0;
        k3(i)=0;
    end
    %c
    if MPC.c.gen(i,8)==1
        k2c(i)=i;
        k3(i)=0;
    end
    if MPC.c.gen(i,8)==0
        k2c(i)=0;
        k3(i)=0;
    end 
    if MPC.a.gen(i,13)==1    
        k2a(i)=0;
        k3(i)=i;
    end
end
k2a=nonzeros(k2a)';
k2b=nonzeros(k2b)';
k2c=nonzeros(k2c)';
k3=nonzeros(k3)';     % +EV  
k1a=setdiff(kk,k3);
k1b=setdiff(kk,k3);
k1c=setdiff(kk,k3);
k2a=setdiff(k2a,k3);  % -EV +PV
k2b=setdiff(k2b,k3);  % -EV +PV
k2c=setdiff(k2c,k3);  % -EV +PV
k1a=setdiff(k1a,k2a); % -EV -PV
k1b=setdiff(k1b,k2b); % -EV -PV
k1c=setdiff(k1c,k2c); % -EV -PV
%% Begin CVX 3 phase
nn=5;
cvx_begin

  variable pa(n) 
  variable qa(n)
  variable peva(n)
  variable teta(n)
  variable va(n)
  variable pb(n)
  variable qb(n)
  variable pevb(n)
  variable tetb(n)
  variable vb(n)
  variable pc(n) 
  variable qc(n)
  variable pevc(n)
  variable tetc(n)
  variable vc(n)
  
  minimize(pa'.^2*MPC.a.gencost(:,5)*(MPC.a.baseMVA)^2+pa'*MPC.a.gencost(:,6)*(MPC.a.baseMVA)+sum(MPC.a.gencost(:,7))...
+pb'.^2*MPC.b.gencost(:,5)*(MPC.b.baseMVA)^2+pb'*MPC.b.gencost(:,6)*(MPC.b.baseMVA)+sum(MPC.b.gencost(:,7))...
+...
pc'.^2*MPC.c.gencost(:,5)*(MPC.c.baseMVA)^2+pc'*MPC.c.gencost(:,6)*(MPC.c.baseMVA)+sum(MPC.c.gencost(:,7)));
  
  subject to 
  
  va(1)==1;
  teta(1)==0;
  
  for i=k1a 
   0==+MPC.a.bus(i,3)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a)+(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a);
   0==+MPC.a.bus(i,4)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a)-(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a);
   pa(i)==0;
   qa(i)==0;
  end
  
  for j=k2a
   pa(j)==+MPC.a.bus(MPC.a.gen(j,1),3)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)+(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
   qa(j)==+MPC.a.bus(MPC.a.gen(j,1),4)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)-(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
   pa(j)*MPC.a.baseMVA>=MPC.a.gen(j,10)
   pa(j)*MPC.a.baseMVA<=MPC.a.gen(j,9)
   qa(j)*MPC.a.baseMVA>=MPC.a.gen(j,5)
   qa(j)*MPC.a.baseMVA<=MPC.a.gen(j,4)
  end

  va>=.9;va<=1.1;

 for l=1:nn
     for i=1:size(MPC.a.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2))))/sind(360/nn);
     end
 end
 vb(1)==1;
  tetb(1)==0;
  
  for i=k1b 
   0==+MPC.b.bus(i,3)/MPC.b.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b)+(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b);
   0==+MPC.b.bus(i,4)/MPC.b.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b)-(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b);
   pb(i)==0;
   qb(i)==0;
  end
  
  for j=k2b
   pb(j)==+MPC.b.bus(MPC.b.gen(j,1),3)/MPC.b.baseMVA+(vb(bus(MPC.b.gen(j,1)))-vb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)+(tetb(bus(MPC.b.gen(j,1)))-tetb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   qb(j)==+MPC.b.bus(MPC.b.gen(j,1),4)/MPC.b.baseMVA+(vb(bus(MPC.b.gen(j,1)))-vb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)-(tetb(bus(MPC.b.gen(j,1)))-tetb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   pb(j)*MPC.a.baseMVA>=MPC.b.gen(j,10)
   pb(j)*MPC.a.baseMVA<=MPC.b.gen(j,9)
   qb(j)*MPC.a.baseMVA>=MPC.b.gen(j,5)
   qb(j)*MPC.a.baseMVA<=MPC.b.gen(j,4)
  end

  vb>=.9;vb<=1.1;

 for l=1:nn
     for i=1:size(MPC.b.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(MPC.b.branch(i,1)),vb(MPC.b.branch(i,2)),tetb(MPC.b.branch(i,1)),tetb(MPC.b.branch(i,2))))/sind(360/nn);
     end
 end
  vc(1)==1;
  tetc(1)==0;
  
  for i=k1c 
   0==+MPC.c.bus(i,3)/MPC.c.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c)+(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c);
   0==+MPC.c.bus(i,4)/MPC.c.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c)-(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c);
   pc(i)==0;
   qc(i)==0;
  end
  
  for j=k2c
   pc(j)==+MPC.c.bus(MPC.c.gen(j,1),3)/MPC.c.baseMVA+(vc(bus(MPC.c.gen(j,1)))-vc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)+(tetc(bus(MPC.c.gen(j,1)))-tetc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   qc(j)==+MPC.c.bus(MPC.c.gen(j,1),4)/MPC.c.baseMVA+(vc(bus(MPC.c.gen(j,1)))-vc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)-(tetc(bus(MPC.c.gen(j,1)))-tetc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   pc(j)*MPC.a.baseMVA>=MPC.c.gen(j,10)
   pc(j)*MPC.a.baseMVA<=MPC.c.gen(j,9)
   qc(j)*MPC.a.baseMVA>=MPC.c.gen(j,5)
   qc(j)*MPC.a.baseMVA<=MPC.c.gen(j,4)
  end

  vc>=.9;vc<=1.1;

 for l=1:nn
     for i=1:size(MPC.c.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2))))/sind(360/nn);
     end
 end
 
 for j=k3
    pa(j)-peva(j)==+MPC.a.bus(MPC.a.gen(j,1),3)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)+(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
    qa(j)==+MPC.a.bus(MPC.a.gen(j,1),4)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)-(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
    pa(j)*MPC.a.baseMVA>=MPC.a.gen(j,8)*MPC.a.gen(j,10)
    pa(j)*MPC.a.baseMVA<=MPC.a.gen(j,8)*MPC.a.gen(j,9)
    qa(j)*MPC.a.baseMVA>=MPC.a.gen(j,5)
    qa(j)*MPC.a.baseMVA<=MPC.a.gen(j,4)
    pb(j)-pevb(j)==+MPC.b.bus(MPC.b.gen(j,1),3)/MPC.b.baseMVA+(vb(bus(MPC.b.gen(j,1)))-vb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)+(tetb(bus(MPC.b.gen(j,1)))-tetb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
    qb(j)==+MPC.b.bus(MPC.b.gen(j,1),4)/MPC.b.baseMVA+(vb(bus(MPC.b.gen(j,1)))-vb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)-(tetb(bus(MPC.b.gen(j,1)))-tetb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
    pb(j)*MPC.a.baseMVA>=MPC.b.gen(j,8)*MPC.b.gen(j,10)
    pb(j)*MPC.a.baseMVA<=MPC.b.gen(j,8)*MPC.b.gen(j,9)
    qb(j)*MPC.a.baseMVA>=MPC.b.gen(j,5)
    qb(j)*MPC.a.baseMVA<=MPC.b.gen(j,4)  
    pc(j)-pevc(j)==+MPC.c.bus(MPC.c.gen(j,1),3)/MPC.c.baseMVA+(vc(bus(MPC.c.gen(j,1)))-vc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)+(tetc(bus(MPC.c.gen(j,1)))-tetc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
    qc(j)==+MPC.c.bus(MPC.c.gen(j,1),4)/MPC.c.baseMVA+(vc(bus(MPC.c.gen(j,1)))-vc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)-(tetc(bus(MPC.c.gen(j,1)))-tetc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
    pc(j)*MPC.a.baseMVA>=MPC.c.gen(j,8)*MPC.c.gen(j,10)
    pc(j)*MPC.a.baseMVA<=MPC.c.gen(j,8)*MPC.c.gen(j,9)
    qc(j)*MPC.a.baseMVA>=MPC.c.gen(j,5)
    qc(j)*MPC.a.baseMVA<=MPC.c.gen(j,4)

   
      peva(j)+pevb(j)+pevc(j)==3*MPC.b.gen(j,12)
           
      peva(j)*MPC.a.baseMVA>=-5
      pevb(j)*MPC.a.baseMVA>=-5
      pevc(j)*MPC.a.baseMVA>=-5
      peva(j)*MPC.a.baseMVA<=5
      pevb(j)*MPC.a.baseMVA<=5
      pevc(j)*MPC.a.baseMVA<=5

 end 
 for i=kk
%(([0.0032 -0.0058 +0.0026 +0.0154 +0.2897 -0.2877]-vuf*[2.0563e-04 -1.0771e-04 -9.7921e-05 +0.3331 +0.3333 +0.3333])*[tetb(i) teta(i) tetc(i) va(i) vb(i) vc(i)]'-0.0798-vuf*0.0015)<=0
%(0.0032*tetb(i))-(0.0058*teta(i))+(0.0026*tetc(i))+(0.0154*va(i))+(0.2897*vb(i))-(0.2877*vc(i))-0.0798<=vuf*((2.0563e-04*teta(i))-(1.0771e-04*tetb(i))-(9.7921e-05*tetc(i))+(0.3331*va(i))+(0.3333*vb(i))+(0.3333*vc(i))+0.0015)
%(0.0032*tetb)-(0.00158*teta)+(0.0026*tetc)+(0.0154*va)+(0.2897*vb)-(0.2877*vc)-0.0798>=-vuf*((2.0563e-04*teta)-(1.0771e-04*tetb)-(9.7921e-05*tetc)+(0.3331*va)+(0.3333*vb)+(0.3333*vc)+0.0015)
 end
   %(teta-tetb).^2<.001
   %(teta-tetc).^2<.001
  % (tetb-tetc).^2<.001
   ((teta-tetb)*180/pi).^2<=(.3)^2
   ((teta-tetc)*180/pi).^2<=(.3)^2
   ((tetb-tetc)*180/pi).^2<=(.3)^2
   (va-vb).^2<=(.05)^2
   (va-vc).^2<=(.05)^2
   (vb-vc).^2<=(.05)^2

 cvx_end
%% cvx to matpower 

%% Results a
for i=1:size(MPC.a.branch(:,1),1)
   results3.branch.p.a(i,1)=MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)));
   results3.branch.q.a(i,1)=MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(MPC.a.branch(i,1)),va(MPC.a.branch(i,2)),teta(MPC.a.branch(i,1)),teta(MPC.a.branch(i,2)));
   results3.branch.s.a(i,1)=sqrt(results3.branch.p.a(i,1)^2+results3.branch.q.a(i,1)^2);
end
results3.bus.p.a(:,1)=MPC.a.baseMVA*pa(:);
results3.bus.q.a(:,1)=MPC.a.baseMVA*qa(:);
results3.bus.s.a(:,1)=sqrt((MPC.a.baseMVA*pa(:)).^2+(MPC.a.baseMVA*qa(:)).^2);
fa=pa'.^2*MPC.a.gencost(:,5)*(MPC.a.baseMVA)^2+pa'*MPC.a.gencost(:,6)*(MPC.a.baseMVA)+sum(MPC.a.gencost(:,7));
results3.f.a(1,1)=fa;
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

results3.bus.p.b(:,1)=MPC.b.baseMVA*pb(:);
results3.bus.q.b(:,1)=MPC.b.baseMVA*qb(:);
results3.bus.s.b(:,1)=sqrt((MPC.b.baseMVA*pb(:)).^2+(MPC.b.baseMVA*qb(:)).^2);
fb=pb'.^2*MPC.b.gencost(:,5)*(MPC.b.baseMVA)^2+pb'*MPC.b.gencost(:,6)*(MPC.b.baseMVA)+sum(MPC.b.gencost(:,7));
results3.f.b(1,1)=fb;
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
   results3.branch.s.c(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
end
results3.bus.p.c(:,1)=MPC.c.baseMVA*pc(:);
results3.bus.q.c(:,1)=MPC.c.baseMVA*qc(:);
results3.bus.s.c(:,1)=sqrt((MPC.c.baseMVA*pc(:)).^2+(MPC.c.baseMVA*qc(:)).^2);
fc=pc'.^2*MPC.c.gencost(:,5)*(MPC.c.baseMVA)^2+pc'*MPC.c.gencost(:,6)*(MPC.c.baseMVA)+sum(MPC.c.gencost(:,7));
results3.f.c(1,1)=fc;
results3.bus.V.c(:,1)=vc(:,1);
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
results3.bus.pEV(:,1)=MPC.c.baseMVA*peva;
results3.bus.pEV(:,2)=MPC.c.baseMVA*pevb;
results3.bus.pEV(:,3)=MPC.c.baseMVA*pevc;
%
results3.mismatch(:,1)=mismatch(results3.branch.p.a(:,1),results3.branch.p.b(:,1),results3.branch.p.c(:,1));

Results{snd,snq}=results3;
    end
end
%% remove library
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
end