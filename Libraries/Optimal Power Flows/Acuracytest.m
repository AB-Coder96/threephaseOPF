function Results=Acuracytest(SN)
%%
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
%%
for snd=1:size(SN,1)
    for snq=1:size(SN,2)
%%
MPC=SN{snd,snq};
%%
plim=MPC.plim;
qlim=MPC.qlim;
%%
MPC.a.bus(:,3)=MPC.a.bus(:,3)+MPC.a.gen(:,12);
MPC.b.bus(:,3)=MPC.b.bus(:,3)+MPC.b.gen(:,12);
MPC.c.bus(:,3)=MPC.c.bus(:,3)+MPC.c.gen(:,12);
%% cvx to matpower a    
MPCtesta=MPC.a;
MPCtesta.bus(:,3)=MPC.a.bus(:,3)-results3.bus.p.a(:,1);
MPCtesta.bus(:,4)=MPC.a.bus(:,4)-results3.bus.q.a(:,1);
MPCtesta=openPV([],plim,qlim,MPCtesta);
restesta=runopf(MPCtesta);
for i=1:size(MPC.a.branch(:,1),1)
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
%% cvx to matpower b     
MPCtestb=MPC.b;
MPCtestb.bus(:,3)=MPC.b.bus(:,3)-results3.bus.p.b(:,1);
MPCtestb.bus(:,4)=MPC.b.bus(:,4)-results3.bus.q.b(:,1);
MPCtestb=openPV([],plim,qlim,MPCtestb);
restestb=runopf(MPCtestb);
for i=1:size(MPC.b.branch(:,1),1)
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
%% cvx to matpower c    
MPCtestc=MPC.c;
MPCtestc.bus(:,3)=MPC.c.bus(:,3)-results3.bus.p.c(:,1);
MPCtestc.bus(:,4)=MPC.c.bus(:,4)-results3.bus.q.c(:,1);
MPCtestc=openPV([],plim,qlim,MPCtestc);
restestc=runopf(MPCtestc);
for i=1:size(MPC.c.branch(:,1),1)
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
results3.VUFlin(:,1)=VUF_lin(results3.bus.V.a(:,1),results3.bus.tet.a(:,1),results3.bus.V.b(:,1),results3.bus.tet.b(:,1),results3.bus.V.c(:,1),results3.bus.tet.c(:,1));
results3.f.total(1,1)=results3.f.a(1,1)+results3.f.b(1,1)+results3.f.c(1,1);
%
results3.mismatch(:,1)=mismatch(results3.branch.p.a(:,1),results3.branch.p.b(:,1),results3.branch.p.c(:,1));
%%

Results{snd,snq}=results3;
    end
    end
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\graph_cal')
end