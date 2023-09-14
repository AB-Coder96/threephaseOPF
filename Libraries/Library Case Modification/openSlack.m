function MPC=openSlack(X,Plim,Qlim,MPC)
MPC.Slack=X;
for i=1:length(X)
% phase a
MPC.a.bus(i,2)=3;
MPC.a.bus(i,12:13)=1;
MPC.a.gen(i,8)=1;
MPC.a.gen(i,4)=Qlim+MPC.a.gen(i,4);
MPC.a.gen(i,5)=-Qlim+MPC.a.gen(i,5);
MPC.a.gen(i,9)=Plim+MPC.a.gen(i,9);
MPC.a.gen(i,10)=-Plim+MPC.a.gen(i,10);
% phase b
MPC.b.bus(i,2)=3;
MPC.b.bus(i,12:13)=1;
MPC.b.gen(i,8)=1;
MPC.b.gen(i,4)=Qlim+MPC.b.gen(i,4);
MPC.b.gen(i,5)=-Qlim+MPC.b.gen(i,5);
MPC.b.gen(i,9)=Plim+MPC.b.gen(i,9);
MPC.b.gen(i,10)=-Plim+MPC.b.gen(i,10);
% phase c
MPC.c.bus(i,2)=3;
MPC.c.bus(i,12:13)=1;
MPC.c.gen(i,8)=1;
MPC.c.gen(i,4)=Qlim+MPC.c.gen(i,4);
MPC.c.gen(i,5)=-Qlim+MPC.c.gen(i,5);
MPC.c.gen(i,9)=Plim+MPC.c.gen(i,9);
MPC.c.gen(i,10)=-Plim+MPC.c.gen(i,10);
%%
MPC.a.gen(:,6)=1;
MPC.b.gen(:,6)=1;
MPC.c.gen(:,6)=1;
MPC.a.gen(:,7)=MPC.a.baseMVA;
MPC.b.gen(:,7)=MPC.b.baseMVA;
MPC.c.gen(:,7)=MPC.c.baseMVA;
end