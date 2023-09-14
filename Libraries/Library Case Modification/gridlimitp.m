function MPC=gridlimitp(MPC,min,max,slack)
 % phase a
 MPC.a.gen(slack,9)=max;
 MPC.a.gen(slack,10)=min;
 % phase b
 MPC.b.gen(slack,9)=max;
 MPC.b.gen(slack,10)=min;
 % phase c
 MPC.c.gen(slack,9)=max;
 MPC.c.gen(slack,10)=min;
end