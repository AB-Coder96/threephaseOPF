function MPC=scalingunbalaceq(MPC,a,b,c)
MPC.b.bus(:,4)=b*MPC.a.bus(:,4);
MPC.c.bus(:,4)=c*MPC.a.bus(:,4);
MPC.a.bus(:,4)=a*MPC.a.bus(:,4);
end