function Mpc=ConvertMatpower(Mpc)
%% convert 1 phase PV
for i=Mpc.All
% phase a
Mpc.a.gen(i,8)=Mpc.a.DevicePV(i,1)|Mpc.a.gen(i,8);
Mpc.a.gen(i,9)=min(Mpc.a.DevicePV(i,2),Mpc.a.DevicePV(i,3))+Mpc.a.gen(i,9);
Mpc.a.gen(i,10)=0+Mpc.a.gen(i,10);
Mpc.a.gen(i,4)=sqrt(Mpc.a.DevicePV(i,3)^2-Mpc.a.DevicePV(i,2)^2)+Mpc.a.gen(i,4);
Mpc.a.gen(i,5)=-sqrt(Mpc.a.DevicePV(i,3)^2-Mpc.a.DevicePV(i,2)^2)+Mpc.a.gen(i,5);
% phase b
Mpc.b.gen(i,8)=Mpc.b.DevicePV(i,1)|Mpc.b.gen(i,8);
Mpc.b.gen(i,9)=min(Mpc.b.DevicePV(i,2),Mpc.b.DevicePV(i,3))+Mpc.b.gen(i,9);
Mpc.b.gen(i,10)=0+Mpc.b.gen(i,10);
Mpc.b.gen(i,4)=sqrt(Mpc.b.DevicePV(i,3)^2-Mpc.b.DevicePV(i,2)^2)+Mpc.b.gen(i,4);
Mpc.b.gen(i,5)=-sqrt(Mpc.b.DevicePV(i,3)^2-Mpc.b.DevicePV(i,2)^2)+Mpc.b.gen(i,5);
% phase c
Mpc.c.gen(i,8)=Mpc.c.DevicePV(i,1)|Mpc.c.gen(i,8);
Mpc.c.gen(i,9)=min(Mpc.c.DevicePV(i,2),Mpc.c.DevicePV(i,3))+Mpc.c.gen(i,9);
Mpc.c.gen(i,10)=0+Mpc.c.gen(i,10);
Mpc.c.gen(i,4)=sqrt(Mpc.c.DevicePV(i,3)^2-Mpc.c.DevicePV(i,2)^2)+Mpc.c.gen(i,4);
Mpc.c.gen(i,5)=-sqrt(Mpc.c.DevicePV(i,3)^2-Mpc.c.DevicePV(i,2)^2)+Mpc.c.gen(i,5);
%% convert 1 phase EV
% phase a 
Mpc.a.gen(i,8)=Mpc.a.DevicePV(i,1)|Mpc.a.gen(i,8);
Mpc.a.gen(i,9)=0+Mpc.a.gen(i,9);
Mpc.a.gen(i,10)=0+Mpc.a.gen(i,10);
Mpc.a.gen(i,4)=sqrt(Mpc.a.DevicePV(i,3)^2-Mpc.a.DevicePV(i,2)^2)+Mpc.a.gen(i,4);
Mpc.a.gen(i,5)=-sqrt(Mpc.a.DevicePV(i,3)^2-Mpc.a.DevicePV(i,2)^2)+Mpc.a.gen(i,5);
Mpc.a.bus(i,3)=Mpc.a.DevicePV(i,2)+Mpc.a.bus(i,3);
% phase b
Mpc.b.gen(i,8)=Mpc.b.DevicePV(i,1)|Mpc.b.gen(i,8);
Mpc.b.gen(i,9)=0+Mpc.b.gen(i,9);
Mpc.b.gen(i,10)=0+Mpc.b.gen(i,10);
Mpc.b.gen(i,4)=sqrt(Mpc.b.DevicePV(i,3)^2-Mpc.b.DevicePV(i,2)^2)+Mpc.b.gen(i,4);
Mpc.b.gen(i,5)=-sqrt(Mpc.b.DevicePV(i,3)^2-Mpc.b.DevicePV(i,2)^2)+Mpc.b.gen(i,5);
Mpc.b.bus(i,3)=Mpc.b.DevicePV(i,2)+Mpc.b.bus(i,3);
% phase c
Mpc.c.gen(i,8)=Mpc.c.DevicePV(i,1)|Mpc.c.gen(i,8);
Mpc.c.gen(i,9)=0+Mpc.c.gen(i,9);
Mpc.c.gen(i,10)=0+Mpc.c.gen(i,10);
Mpc.c.gen(i,4)=sqrt(Mpc.c.DevicePV(i,3)^2-Mpc.c.DevicePV(i,2)^2)+Mpc.c.gen(i,4);
Mpc.c.gen(i,5)=-sqrt(Mpc.c.DevicePV(i,3)^2-Mpc.c.DevicePV(i,2)^2)+Mpc.c.gen(i,5);
Mpc.c.bus(i,3)=Mpc.c.DevicePV(i,2)+Mpc.c.bus(i,3);
end
 
end