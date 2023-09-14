function Mpc=openGen(X,plimit,qlimit,Mpc)
for i=X
Mpc.a.gen(i,8)=1; 
Mpc.b.gen(i,8)=1; 
Mpc.c.gen(i,8)=1;
% p limits
Mpc.a.gen(i,9)=plimit(2);
Mpc.a.gen(i,10)=plimit(1);
Mpc.b.gen(i,9)=plimit(2);
Mpc.b.gen(i,10)=plimit(1);
Mpc.c.gen(i,9)=plimit(2);
Mpc.c.gen(i,10)=plimit(1);
% q limits
Mpc.a.gen(i,4)=qlimit(2);
Mpc.a.gen(i,5)=qlimit(1);
Mpc.b.gen(i,4)=qlimit(2);
Mpc.b.gen(i,5)=qlimit(1);
Mpc.c.gen(i,4)=qlimit(2);
Mpc.c.gen(i,5)=qlimit(1);
end
MPC.slack=[MPC.slack X]
end