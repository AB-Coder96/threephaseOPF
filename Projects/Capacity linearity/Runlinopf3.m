function results3=Runlinopf3(MPC)
%% initiate a
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
for i=1:size(MPC.a.bus,1)
    if MPC.a.gen(i,8)==1
        kk(i)=i;
        k(i)=0;
    else
        k(i)=i;
        kk(i)=0;
    end
end
k=nonzeros(k)';
kk=nonzeros(kk)';
nn=5;
%% Begin CVX a
cvx_begin
  variable pa(n) 
  variable qa(n)
  variable teta(n)
  variable va(n) 
  
  minimize(pa'.^2*MPC.a.gencost(:,5)*(MPC.a.baseMVA)^2+pa'*MPC.a.gencost(:,6)*(MPC.a.baseMVA)+sum(MPC.a.gencost(:,7)));
  
  subject to 
  
  va(1)==1;
  teta(1)==0;
  
  for i=k 
   0==+MPC.a.bus(i,3)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a)+(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a);
   0==+MPC.a.bus(i,4)/MPC.a.baseMVA+(va(bus(i))-va(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.a)-(teta(bus(i))-teta(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.a);
   pa(i)==0;
   qa(i)==0;
  end
  
  for j=kk
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
    cvx_end
%% Results a
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
results3.f.a(1,2)=cvx_optval;
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
%% cvx to matpower a    
MPCtesta=MPC.a;
MPCtesta.bus(:,3)=MPC.a.bus(:,3)-results3.bus.p.a(:,2);
MPCtesta.bus(:,4)=MPC.a.bus(:,4)-results3.bus.q.a(:,2);
MPCtesta=openPV([],MPCtesta);
restesta=runopf(MPCtesta);
for i=1:size(results1a.branch(:,1),1)
   results3.branch.p.a(i,3)=restesta.branch(i,14);
   results3.branch.q.a(i,3)=restesta.branch(i,15);
   results3.branch.s.a(i,3)=sqrt(results3.branch.p.a(i,3)^2+results3.branch.q.a(i,3)^2);
end
results3.bus.p.a(:,3)=restesta.gen(:,2);
results3.bus.q.a(:,3)=restesta.gen(:,3);
results3.bus.s.a(:,3)=sqrt(restesta.gen(:,2).^2+restesta.gen(:,3).^2);
results3.f.a(1,3)=restesta.f;
results3.bus.V.a(:,3)=restesta.bus(:,8);
results3.bus.tet.a(:,3)=restesta.bus(:,9);
%% initiate b
n=size(MPC.b.bus,1);
bus=MPC.b.bus(:,1);
bus_con_from=cell(n,1);
bus_con_to=cell(n,1);
bus_con=cell(n,1);
k1=cell(n,1);
k2=cell(n,1);
for i=1:n
   bus_con_from(i,1)={find(MPC.b.branch(:,1)==i)};
   bus_con_to(i,1)={find(MPC.b.branch(:,2)==i)};
   bus_con(i,1)={union(MPC.b.branch(cell2mat(bus_con_from(i,1)),2),MPC.b.branch(cell2mat(bus_con_to(i,1)),1))}; 
   [mm,nn]=size(bus_con{i,1});
   if nn>1
   bus_con{i,1}=bus_con{i,1}';
   end
end
k=2:size(MPC.b.bus,1);
kk=2:size(MPC.b.bus,1);
for i=1:size(MPC.b.bus,1)
    if MPC.b.gen(i,8)==1
        kk(i)=i;
        k(i)=0;
    else
        k(i)=i;
        kk(i)=0;
    end
end
k=nonzeros(k)';
kk=nonzeros(kk)';
nn=5;
%% Begin CVX b

cvx_begin
  variable p(n) 
  variable q(n)
  variable tet(n)
  variable v(n) 
  
  minimize(p'.^2*MPC.b.gencost(:,5)*(MPC.b.baseMVA)^2+p'*MPC.b.gencost(:,6)*(MPC.b.baseMVA)+sum(MPC.b.gencost(:,7)));
  
  subject to 
  
  v(1)==1;
  tet(1)==0;
  
  for i=k 
   0==+MPC.b.bus(i,3)/MPC.b.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b)+(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b);
   0==+MPC.b.bus(i,4)/MPC.b.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.b)-(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.b);
   p(i)==0;
   q(i)==0;
  end
  
  for j=kk
   p(j)==+MPC.b.bus(MPC.b.gen(j,1),3)/MPC.b.baseMVA+(v(bus(MPC.b.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)+(tet(bus(MPC.b.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   q(j)==+MPC.b.bus(MPC.b.gen(j,1),4)/MPC.b.baseMVA+(v(bus(MPC.b.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k2find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b)-(tet(bus(MPC.b.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.b.gen(j,1))))))'*k1find(MPC.b.gen(j,1),bus_con{MPC.b.gen(j,1)},MPC.b);
   p(j)>=MPC.b.gen(j,10)
   p(j)<=MPC.b.gen(j,9)
   q(j)>=MPC.b.gen(j,5)
   q(j)<=MPC.b.gen(j,4)
  end

  v>=.9;v<=1.1;

 for l=1:nn
     for i=1:size(MPC.b.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(MPC.b.branch(i,1)),v(MPC.b.branch(i,2)),tet(MPC.b.branch(i,1)),tet(MPC.b.branch(i,2))))/sind(360/nn);
     end
 end
    cvx_end
%% Results b
results1=runopf(MPC.b);
for i=1:size(results1.branch(:,1),1)
   results3.branch.p.b(i,1)=results1.branch(i,14);
   results3.branch.q.b(i,1)=results1.branch(i,15);
   results3.branch.p.b(i,2)=MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.q.b(i,2)=MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.s.b(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
   results3.branch.s.b(i,2)=sqrt(results3.branch.p.b(i,2)^2+results3.branch.q.b(i,2)^2);
end
results3.bus.p.b(:,1)=results1.gen(:,2);
results3.bus.p.b(:,2)=MPC.b.baseMVA*p(:);
results3.bus.q.b(:,1)=results1.gen(:,3);
results3.bus.q.b(:,2)=MPC.b.baseMVA*q(:);
results3.bus.s.b(:,1)=sqrt(results1.gen(:,2).^2+results1.gen(:,3).^2);
results3.bus.s.b(:,2)=sqrt((MPC.b.baseMVA*p(:)).^2+(MPC.b.baseMVA*q(:)).^2);
results3.f.b(1,1)=results1.f;
results3.f.b(1,2)=cvx_optval;
results3.bus.V.b(:,1)=results1.bus(:,8);
results3.bus.V.b(:,2)=v(:,1);
results3.bus.tet.b(:,1)=results1.bus(:,9);
results3.bus.tet.b(:,2)=tet(:,1)*180/pi;
% S-linear b
nn=10;
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.b(:,3)=S';
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.b.baseMVA*p1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.b.baseMVA*q1find(MPC.b.branch(i,1),MPC.b.branch(i,2),MPC.b,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.b(:,4)=S';
%% cvx to matpower b     
MPCtestb=MPC.b;
MPCtestb.bus(:,3)=MPC.b.bus(:,3)-results3.bus.p.b(:,2);
MPCtestb.bus(:,4)=MPC.b.bus(:,4)-results3.bus.q.b(:,2);
MPCtestb=openPV([],MPCtestb);
restestb=runopf(MPCtestb);
for i=1:size(results1.branch(:,1),1)
   results3.branch.p.b(i,3)=restestb.branch(i,14);
   results3.branch.q.b(i,3)=restestb.branch(i,15);
   results3.branch.s.b(i,3)=sqrt(results3.branch.p.b(i,3)^2+results3.branch.q.b(i,3)^2);
end
results3.bus.p.b(:,3)=restestb.gen(:,2);
results3.bus.q.b(:,3)=restestb.gen(:,3);
results3.bus.s.b(:,3)=sqrt(restestb.gen(:,2).^2+restestb.gen(:,3).^2);
results3.f.b(1,3)=restestb.f;
results3.bus.V.b(:,3)=restestb.bus(:,8);
results3.bus.tet.b(:,3)=restestb.bus(:,9);
%% initiate c
n=size(MPC.c.bus,1);
bus=MPC.c.bus(:,1);
bus_con_from=cell(n,1);
bus_con_to=cell(n,1);
bus_con=cell(n,1);
k1=cell(n,1);
k2=cell(n,1);
for i=1:n
   bus_con_from(i,1)={find(MPC.c.branch(:,1)==i)};
   bus_con_to(i,1)={find(MPC.c.branch(:,2)==i)};
   bus_con(i,1)={union(MPC.c.branch(cell2mat(bus_con_from(i,1)),2),MPC.c.branch(cell2mat(bus_con_to(i,1)),1))}; 
   [mm,nn]=size(bus_con{i,1});
   if nn>1
   bus_con{i,1}=bus_con{i,1}';
   end
   k=2:size(MPC.c.bus,1);
kk=2:size(MPC.c.bus,1);
for i=1:size(MPC.c.bus,1)
    if MPC.c.gen(i,8)==1
        kk(i)=i;
        k(i)=0;
    else
        k(i)=i;
        kk(i)=0;
    end
end
k=nonzeros(k)';
kk=nonzeros(kk)';
nn=5;

end
%% Begin CVX c

cvx_begin
  variable p(n) 
  variable q(n)
  variable tet(n)
  variable v(n) 
  
  minimize(p'.^2*MPC.c.gencost(:,5)*(MPC.c.baseMVA)^2+p'*MPC.c.gencost(:,6)*(MPC.c.baseMVA)+sum(MPC.c.gencost(:,7)));
  
  subject to 
  
  v(1)==1;
  tet(1)==0;
  
  for i=k 
   0==+MPC.c.bus(i,3)/MPC.c.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c)+(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c);
   0==+MPC.c.bus(i,4)/MPC.c.baseMVA+(v(bus(i))-v(cell2mat(bus_con(bus(i)))))'*k2find(i,bus_con{i},MPC.c)-(tet(bus(i))-tet(cell2mat(bus_con(bus(i)))))'*k1find(i,bus_con{i},MPC.c);
   p(i)==0;
   q(i)==0;
  end
  
  for j=kk
   p(j)==+MPC.c.bus(MPC.c.gen(j,1),3)/MPC.c.baseMVA+(v(bus(MPC.c.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)+(tet(bus(MPC.c.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   q(j)==+MPC.c.bus(MPC.c.gen(j,1),4)/MPC.c.baseMVA+(v(bus(MPC.c.gen(j,1)))-v(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k2find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c)-(tet(bus(MPC.c.gen(j,1)))-tet(cell2mat(bus_con(bus(MPC.c.gen(j,1))))))'*k1find(MPC.c.gen(j,1),bus_con{MPC.c.gen(j,1)},MPC.c);
   p(j)>=MPC.c.gen(j,10)
   p(j)<=MPC.c.gen(j,9)
   q(j)>=MPC.c.gen(j,5)
   q(j)<=MPC.c.gen(j,4)
  end

  v>=.9;v<=1.1;

 for l=1:nn
     for i=1:size(MPC.c.branch(:,1),1)   
     6>=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(MPC.c.branch(i,1)),v(MPC.c.branch(i,2)),tet(MPC.c.branch(i,1)),tet(MPC.c.branch(i,2))))/sind(360/nn);
     end
 end
    cvx_end
%% Results c
results1=runopf(MPC.c);
for i=1:size(results1.branch(:,1),1)
   results3.branch.p.c(i,1)=results1.branch(i,14);
   results3.branch.q.c(i,1)=results1.branch(i,15);
   results3.branch.p.c(i,2)=MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.q.c(i,2)=MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)));
   results3.branch.s.c(i,1)=sqrt(results3.branch.p.b(i,1)^2+results3.branch.q.b(i,1)^2);
   results3.branch.s.c(i,2)=sqrt(results3.branch.p.b(i,2)^2+results3.branch.q.b(i,2)^2);
end
results3.bus.p.c(:,1)=results1.gen(:,2);
results3.bus.p.c(:,2)=MPC.c.baseMVA*p(:);
results3.bus.q.c(:,1)=results1.gen(:,3);
results3.bus.q.c(:,2)=MPC.c.baseMVA*q(:);
results3.bus.s.c(:,1)=sqrt(results1.gen(:,2).^2+results1.gen(:,3).^2);
results3.bus.s.c(:,2)=sqrt((MPC.c.baseMVA*p(:)).^2+(MPC.c.baseMVA*q(:)).^2);
results3.f.c(1,1)=results1.f;
results3.f.c(1,2)=cvx_optval;
results3.bus.V.c(:,1)=results1.bus(:,8);
results3.bus.V.c(:,2)=v(:,1);
results3.bus.tet.c(:,1)=results1.bus(:,9);
results3.bus.tet.c(:,2)=tet(:,1)*180/pi;
% S-linear c
nn=10;
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.c(:,3)=S';
 for l=1:nn
     for i=1:size(results1.branch(:,1),1)   
     SS(i,l)=((sind(360*l/nn)-sind(360*(l-1)/nn))*MPC.c.baseMVA*p1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2)))...
         -(cosd(360*l/nn)-cosd(360*(l-1)/nn))*MPC.c.baseMVA*q1find(MPC.c.branch(i,1),MPC.c.branch(i,2),MPC.c,v(results1.branch(i,1)),v(results1.branch(i,2)),tet(results1.branch(i,1)),tet(results1.branch(i,2))))/sind(360/nn);
     end
 end
for i=1:size(results1.branch(:,1),1)
S(i)=max(SS(i,:));
end
results3.branch.s.c(:,4)=S';
%% cvx to matpower c    
MPCtestc=MPC.c;
MPCtestc.bus(:,3)=MPC.c.bus(:,3)-results3.bus.p.c(:,2);
MPCtestc.bus(:,4)=MPC.c.bus(:,4)-results3.bus.q.c(:,2);
MPCtestc=openPV([],MPCtestc);
restestc=runopf(MPCtestc);
for i=1:size(results1.branch(:,1),1)
   results3.branch.p.c(i,3)=restestc.branch(i,14);
   results3.branch.q.c(i,3)=restestc.branch(i,15);
   results3.branch.s.c(i,3)=sqrt(results3.branch.p.c(i,3)^2+results3.branch.q.c(i,3)^2);
end
results3.bus.p.c(:,3)=restestc.gen(:,2);
results3.bus.q.c(:,3)=restestc.gen(:,3);
results3.bus.s.c(:,3)=sqrt(restestc.gen(:,2).^2+restestc.gen(:,3).^2);
results3.f.c(1,3)=restestc.f;
results3.bus.V.c(:,3)=restestc.bus(:,8);
results3.bus.tet.c(:,3)=restestc.bus(:,9);   
%% 3phase Results
results3.VUF(:,1)=VUF(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.lin_VUF(:,1)=VUF(results3.bus.V.a(:,2),results3.bus.tet.a(:,2),results3.bus.V.b(:,2),results3.bus.tet.b(:,2),results3.bus.V.c(:,2),results3.bus.tet.c(:,2));
results3.VUF(:,2)=VUF_lin(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.lin_VUF(:,2)=VUF_lin(results3.bus.V.a(:,2),results3.bus.tet.a(:,2),results3.bus.V.b(:,2),results3.bus.tet.b(:,2),results3.bus.V.c(:,2),results3.bus.tet.c(:,2));
results3.VUF(:,3)=VUF_lin(results3.bus.V.a(:,3),results3.bus.tet.a(:,3),results3.bus.V.b(:,3),results3.bus.tet.b(:,3),results3.bus.V.c(:,3),results3.bus.tet.c(:,3));
results3.f.total(1,1)=results3.f.a(1,1)+results3.f.b(1,1)+results3.f.c(1,1);
results3.f.total(1,2)=results3.f.a(1,2)+results3.f.b(1,2)+results3.f.c(1,2);
end