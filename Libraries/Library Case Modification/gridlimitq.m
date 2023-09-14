function MPC=gridlimitq(MPC,min,max,slack)
 % phase a
 MPC.a.gen(slack,4)=max;
 MPC.a.gen(slack,5)=min;
 % phase b
 MPC.b.gen(slack,4)=max;
 MPC.b.gen(slack,5)=min;
 % phase c
 MPC.c.gen(slack,4)=max;
 MPC.c.gen(slack,5)=min;
end