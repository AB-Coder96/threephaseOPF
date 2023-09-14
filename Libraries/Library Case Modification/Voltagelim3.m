function mpc=Voltagelim3(mpc,up,down);
MPC.a.bus(:,13)=down;
MPC.b.bus(:,13)=down;
MPC.c.bus(:,13)=down;
MPC.a.bus(:,12)=up;
MPC.b.bus(:,12)=up;
MPC.c.bus(:,12)=up;
end