function results3=Runlinopf3UB(MPC,vuf)
%% input
Va=1.1;Vb=1;Vc=.9;
da=1;db=0;dc=-1;
%%
da=da;
db=db+120;
dc=dc-120;
syms va Daa vb Dbb vc Dcc
f1=V1(va,Daa,vb,Dbb,vc,Dcc);
syms g1(va,Daa,vb,Dbb,vc,Dcc)
g1(va,Daa,vb,Dbb,vc,Dcc)=gradient(f1,[va,Daa,vb,Dbb,vc,Dcc]);
x=g1(1,0.01,1,120,1,-120);
g1_1=double(x);
x=g1(1,0.01,1.1,123,1,-117);
g1_2=double(x);
f2=V2(va,Daa,vb,Dbb,vc,Dcc);
syms g2(va,Daa,vb,Dbb,vc,Dcc)
g2(va,Daa,vb,Dbb,vc,Dcc)=gradient(f2,[va,Daa,vb,Dbb,vc,Dcc]);
x=g2(1,0.01,1,120,1,-120);
g2_1=double(x);
x=g2(1,0.01,1.1,123,.9,-117);
g2_2=double(x);
syms V1_apx(va,Daa,vb,Dbb,vc,Dcc)
V1_apx(va,Daa,vb,Dbb,vc,Dcc)=V1(1,0.01,1,120,1,-120)+([va,Daa,vb,Dbb,vc,Dcc]-[1,0.01,1,120,1,-120])*g1_2;
syms V2_apx(va,Daa,vb,Dbb,vc,Dcc)
V2_apx(va,Daa,vb,Dbb,vc,Dcc)=V2(1,0.01,1,120,1,-120)+([va,Daa,vb,Dbb,vc,Dcc]-[1,0.01,1,120,1,-120])*g2_2;
VUF1=double(V2_apx(Va,da,Vb,db,Vc,dc))./double(V1_apx(Va,da,Vb,db,Vc,dc));
%% initiate 3 phase
n=size(MPC.a.bus,1);
bus=MPC.a.bus(:,1);
bus_con_from=cell(n,1);
bus_con_to=cell(n,1);
bus_con=cell(n,1);
k1=cell(n,1);
k2=cell(n,1);
for i=1:n
   bus_con_from(i,1)={find(MPC.a.branch(:,1)==i)};
   bus_con_to(i,1)={find(MPC.a.branch(:,2)==i)};
   bus_con(i,1)={union(MPC.a.branch(cell2mat(bus_con_from(i,1)),2),MPC.a.branch(cell2mat(bus_con_to(i,1)),1))}; 
   [mm,nn]=size(bus_con{i,1});
   if nn>1
   bus_con{i,1}=bus_con{i,1}';
   end
end
k=2:size(MPC.a.bus,1);
kk=2:size(MPC.a.bus,1);
% initiate a
for i=1:size(MPC.a.bus,1)
    if MPC.a.gen(i,8)==1
        kk(i)=i;
        k(i)=0;
    else
        k(i)=i;
        kk(i)=0;
    end
end
ka=nonzeros(k)';
kka=nonzeros(kk)';
% initiate b
for i=1:size(MPC.b.bus,1)
    if MPC.b.gen(i,8)==1
        kk(i)=i;
        k(i)=0;
    else
        k(i)=i;
        kk(i)=0;
    end
end
kb=nonzeros(k)';
kkb=nonzeros(kk)';
% initiate c
   for i=1:size(MPC.c.bus,1)
       if MPC.c.gen(i,8)==1
          kk(i)=i;
          k(i)=0;
       else
       k(i)=i;
       kk(i)=0;
   end
kc=nonzeros(k)';
kkc=nonzeros(kk)';
end
%% Begin CVX 3 phase
nn=5;
cvx_begin

  variable pa(n) 
  variable qa(n)
  variable teta(n)
  variable va(n)
  variable pb(n) 
  variable qb(n)
  variable tetb(n)
  variable vb(n)
  variable pc(n) 
  variable qc(n)
  variable tetc(n)
  variable vc(n)
  
  minimize(pa'.^2*MPC.a.gencost(:,5)*(MPC.a.baseMVA)^2+pa'*MPC.a.gencost(:,6)*(MPC.a.baseMVA)+sum(MPC.a.gencost(:,7))...
+pb'.^2*MPC.b.gencost(:,5)*(MPC.b.baseMVA)^2+pb'*MPC.b.gencost(:,6)*(MPC.b.baseMVA)+sum(MPC.b.gencost(:,7))...
+...
pc'.^2*MPC.c.gencost(:,5)*(MPC.c.baseMVA)^2+pc'*MPC.c.gencost(:,6)*(MPC.c.baseMVA)+sum(MPC.c.gencost(:,7)));
  
  subject to 
  
  va(1)==1;
  teta(1)==0;
  
  for i=ka 
   0==+MPC.a.bus(i,3)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a)+(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a);
   0==+MPC.a.bus(i,4)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a)-(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a);
   pa(i)==0;
   qa(i)==0;
  end
  
  for j=kka
   pa(j)==+MPC.a.bus(MPC.a.gen(j,1),3)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)+(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
   qa(j)==+MPC.a.bus(MPC.a.gen(j,1),4)/MPC.a.baseMVA+(va(bus(MPC.a.gen(j,1)))-va(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k2find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a)-(teta(bus(MPC.a.gen(j,1)))-teta(cell2mat(bus_con(bus(MPC.a.gen(j,1))))))'*k1find(MPC.a.gen(j,1),bus_con{MPC.a.gen(j,1)},MPC.a);
   pa(j)>=MPC.a.gen(j,10)
   pa(j)<=MPC.a.gen(j,9)
   qa(j)>=MPC.a.gen(j,5)
   qa(j)<=MPC.a.gen(j,4)
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
  
  for i=kb 
   0==+MPC.b.bus(i,3)/MPC.b.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b)+(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b);
   0==+MPC.b.bus(i,4)/MPC.b.baseMVA+(vb(bus(i))-vb(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b)-(tetb(bus(i))-tetb(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b);
   pb(i)==0;
   qb(i)==0;
  end
  
  for j=kkb
   pb(j)==+MPC.b.bus(MPC.b.gen(j,1),3)/MPC.b.baseMVA+(vb(bus(MPC.b.gen(j,1)))-vb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)+(tetb(bus(MPC.b.gen(j,1)))-tetb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   qb(j)==+MPC.b.bus(MPC.b.gen(j,1),4)/MPC.b.baseMVA+(vb(bus(MPC.b.gen(j,1)))-vb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)-(tetb(bus(MPC.b.gen(j,1)))-tetb(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   pb(j)>=MPC.b.gen(j,10)
   pb(j)<=MPC.b.gen(j,9)
   qb(j)>=MPC.b.gen(j,5)
   qb(j)<=MPC.b.gen(j,4)
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
  
  for i=kc 
   0==+MPC.c.bus(i,3)/MPC.c.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c)+(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c);
   0==+MPC.c.bus(i,4)/MPC.c.baseMVA+(vc(bus(i))-vc(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c)-(tetc(bus(i))-tetc(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c);
   pc(i)==0;
   qc(i)==0;
  end
  
  for j=kkc
   pc(j)==+MPC.c.bus(MPC.c.gen(j,1),3)/MPC.c.baseMVA+(vc(bus(MPC.c.gen(j,1)))-vc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)+(tetc(bus(MPC.c.gen(j,1)))-tetc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   qc(j)==+MPC.c.bus(MPC.c.gen(j,1),4)/MPC.c.baseMVA+(vc(bus(MPC.c.gen(j,1)))-vc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)-(tetc(bus(MPC.c.gen(j,1)))-tetc(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   pc(j)>=MPC.c.gen(j,10)
   pc(j)<=MPC.c.gen(j,9)
   qc(j)>=MPC.c.gen(j,5)
   qc(j)<=MPC.c.gen(j,4)
  end

  vc>=.9;vc<=1.1;

 for l=1:nn
     for i=1:size(MPC.c.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(MPC.c.branch(i,1)),vc(MPC.c.branch(i,2)),tetc(MPC.c.branch(i,1)),tetc(MPC.c.branch(i,2))))/sind(360/nn);
     end
 end
 
(0.0032*tetb)-(0.0058*teta)+(0.0026*tetc)+(0.0154*va)+(0.2897*vb)-(0.2877*vc)-0.0798<=vuf*((2.0563e-04*teta)-(1.0771e-04*tetb)-(9.7921e-05*tetc)+(0.3331*va)+(0.3333*vb)+(0.3333*vc)+0.0015)
%(0.0032*tetb)-(0.0058*teta)+(0.0026*tetc)+(0.0154*va)+(0.2897*vb)-(0.2877*vc)-0.0798>=-vuf*((2.0563e-04*teta)-(1.0771e-04*tetb)-(9.7921e-05*tetc)+(0.3331*va)+(0.3333*vb)+(0.3333*vc)+0.0015)
qb(33)==0
pb(33)==0.004
cvx_end
%% cvx to matpower 

%% Results
% Results a
results1a=runopf(MPC.a);
for i=1:size(results1a.branch(:,1),1)
   results3.branch.p.a(i,1)=results1a.branch(i,14);
   results3.branch.q.a(i,1)=results1a.branch(i,15);
   results3.branch.p.a(i,2)=MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(results1a.branch(i,1)),va(results1a.branch(i,2)),teta(results1a.branch(i,1)),teta(results1a.branch(i,2)));
   results3.branch.q.a(i,2)=MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(results1a.branch(i,1)),va(results1a.branch(i,2)),teta(results1a.branch(i,1)),teta(results1a.branch(i,2)));
   results3.branch.s.a(i,1)=sqrt(results3.branch.p.a(i,1)^2+results3.branch.q.a(i,1)^2);
   results3.branch.s.a(i,2)=sqrt(results3.branch.p.a(i,2)^2+results3.branch.q.a(i,2)^2);
end
results3.bus.p.a(:,1)=results1a.gen(:,2);
results3.bus.p.a(:,2)=MPC.a.baseMVA*pa(:);
results3.bus.q.a(:,1)=results1a.gen(:,3);
results3.bus.q.a(:,2)=MPC.a.baseMVA*qa(:);
results3.bus.s.a(:,1)=sqrt(results1a.gen(:,2).^2+results1a.gen(:,3).^2);
results3.bus.s.a(:,2)=sqrt((MPC.a.baseMVA*pa(:)).^2+(MPC.a.baseMVA*qa(:)).^2);
results3.f.a(1,1)=results1a.f;
fa=pa'.^2*MPC.a.gencost(:,5)*(MPC.a.baseMVA)^2+pa'*MPC.a.gencost(:,6)*(MPC.a.baseMVA)+sum(MPC.a.gencost(:,7));
results3.f.a(1,2)=fa;
results3.bus.V.a(:,1)=results1a.bus(:,8);
results3.bus.V.a(:,2)=va(:,1);
results3.bus.tet.a(:,1)=results1a.bus(:,9);
results3.bus.tet.a(:,2)=teta(:,1)*180/pi;
% S-linear a
nn=10;
 for l=1:nn
     for i=1:size(results1a.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(results1a.branch(i,1)),va(results1a.branch(i,2)),teta(results1a.branch(i,1)),teta(results1a.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(results1a.branch(i,1)),va(results1a.branch(i,2)),teta(results1a.branch(i,1)),teta(results1a.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1a.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.a(:,3)=S';
 for l=1:nn
     for i=1:size(results1a.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.a.baseMVA*p1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(results1a.branch(i,1)),va(results1a.branch(i,2)),teta(results1a.branch(i,1)),teta(results1a.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.a.baseMVA*q1find(MPC.a.branch(i,1),MPC.a.branch(i,2),MPC.a,va(results1a.branch(i,1)),va(results1a.branch(i,2)),teta(results1a.branch(i,1)),teta(results1a.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1a.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.a(:,4)=S';
% Results b
results1b=runopf(MPC.b);
for i=1:size(results1b.branch(:,1),1)
   results3.branch.p.b(i,1)=results1b.branch(i,14);
   results3.branch.q.b(i,1)=results1b.branch(i,15);
   results3.branch.p.b(i,2)=MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(results1b.branch(i,1)),vb(results1b.branch(i,2)),tetb(results1b.branch(i,1)),tetb(results1b.branch(i,2)));
   results3.branch.q.b(i,2)=MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(results1b.branch(i,1)),vb(results1b.branch(i,2)),tetb(results1b.branch(i,1)),tetb(results1b.branch(i,2)));
   results3.branch.s.b(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
   results3.branch.s.b(i,2)=sqrt(results3.branch.p.b(i,2)^2+results3.branch.q.b(i,2)^2);
end
results3.bus.p.b(:,1)=results1b.gen(:,2);
results3.bus.p.b(:,2)=MPC.b.baseMVA*pb(:);
results3.bus.q.b(:,1)=results1b.gen(:,3);
results3.bus.q.b(:,2)=MPC.b.baseMVA*qb(:);
results3.bus.s.b(:,1)=sqrt(results1b.gen(:,2).^2+results1b.gen(:,3).^2);
results3.bus.s.b(:,2)=sqrt((MPC.b.baseMVA*pb(:)).^2+(MPC.b.baseMVA*qb(:)).^2);
results3.f.b(1,1)=results1b.f;
fb=pb'.^2*MPC.b.gencost(:,5)*(MPC.b.baseMVA)^2+pb'*MPC.b.gencost(:,6)*(MPC.b.baseMVA)+sum(MPC.b.gencost(:,7));
results3.f.b(1,2)=fb;
results3.bus.V.b(:,1)=results1b.bus(:,8);
results3.bus.V.b(:,2)=vb(:,1);
results3.bus.tet.b(:,1)=results1b.bus(:,9);
results3.bus.tet.b(:,2)=tetb(:,1)*180/pi;
% S-linear b
nn=10;
 for l=1:nn
     for i=1:size(results1b.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(results1b.branch(i,1)),vb(results1b.branch(i,2)),tetb(results1b.branch(i,1)),tetb(results1b.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(results1b.branch(i,1)),vb(results1b.branch(i,2)),tetb(results1b.branch(i,1)),tetb(results1b.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1b.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.b(:,3)=S';
 for l=1:nn
     for i=1:size(results1b.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(results1b.branch(i,1)),vb(results1b.branch(i,2)),tetb(results1b.branch(i,1)),tetb(results1b.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,vb(results1b.branch(i,1)),vb(results1b.branch(i,2)),tetb(results1b.branch(i,1)),tetb(results1b.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1b.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.b(:,4)=S';
% Results c
results1c=runopf(MPC.c);
for i=1:size(results1c.branch(:,1),1)
   results3.branch.p.c(i,1)=results1c.branch(i,14);
   results3.branch.q.c(i,1)=results1c.branch(i,15);
   results3.branch.p.c(i,2)=MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(results1c.branch(i,1)),vc(results1c.branch(i,2)),tetc(results1c.branch(i,1)),tetc(results1c.branch(i,2)));
   results3.branch.q.c(i,2)=MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(results1c.branch(i,1)),vc(results1c.branch(i,2)),tetc(results1c.branch(i,1)),tetc(results1c.branch(i,2)));
   results3.branch.s.c(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
   results3.branch.s.c(i,2)=sqrt(results3.branch.p.b(i,2)^2+results3.branch.q.b(i,2)^2);
end
results3.bus.p.c(:,1)=results1c.gen(:,2);
results3.bus.p.c(:,2)=MPC.c.baseMVA*pc(:);
results3.bus.q.c(:,1)=results1c.gen(:,3);
results3.bus.q.c(:,2)=MPC.c.baseMVA*qc(:);
results3.bus.s.c(:,1)=sqrt(results1c.gen(:,2).^2+results1c.gen(:,3).^2);
results3.bus.s.c(:,2)=sqrt((MPC.c.baseMVA*pc(:)).^2+(MPC.c.baseMVA*qc(:)).^2);
results3.f.c(1,1)=results1c.f;
fc=pc'.^2*MPC.c.gencost(:,5)*(MPC.c.baseMVA)^2+pc'*MPC.c.gencost(:,6)*(MPC.c.baseMVA)+sum(MPC.c.gencost(:,7));
results3.f.c(1,2)=fc;
results3.bus.V.c(:,1)=results1c.bus(:,8);
results3.bus.V.c(:,2)=vc(:,1);
results3.bus.tet.c(:,1)=results1c.bus(:,9);
results3.bus.tet.c(:,2)=tetc(:,1)*180/pi;
% S-linear c
nn=10;
 for l=1:nn
     for i=1:size(results1c.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(results1c.branch(i,1)),vc(results1c.branch(i,2)),tetc(results1c.branch(i,1)),tetc(results1c.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(results1c.branch(i,1)),vc(results1c.branch(i,2)),tetc(results1c.branch(i,1)),tetc(results1c.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1c.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.c(:,3)=S';
 for l=1:nn
     for i=1:size(results1c.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(results1c.branch(i,1)),vc(results1c.branch(i,2)),tetc(results1c.branch(i,1)),tetc(results1c.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,vc(results1c.branch(i,1)),vc(results1c.branch(i,2)),tetc(results1c.branch(i,1)),tetc(results1c.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1c.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.c(:,4)=S';
% 3phase Results
results3.VUF(:,1)=VUF(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.lin_VUF(:,1)=VUF(results3.bus.V.a(:,2),results3.bus.tet.a(:,2),results3.bus.V.b(:,2),results3.bus.tet.b(:,2),results3.bus.V.c(:,2),results3.bus.tet.c(:,2));
results3.VUF(:,2)=VUF_lin(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.lin_VUF(:,2)=VUF_lin(results3.bus.V.a(:,2),results3.bus.tet.a(:,2),results3.bus.V.b(:,2),results3.bus.tet.b(:,2),results3.bus.V.c(:,2),results3.bus.tet.c(:,2));
results3.f.total(1,1)=results3.f.a(1,1)+results3.f.b(1,1)+results3.f.c(1,1);
results3.f.total(1,2)=cvx_optval;
end