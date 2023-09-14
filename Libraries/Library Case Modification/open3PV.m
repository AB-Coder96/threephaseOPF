function Mpc=open3PV(X,Psun,Sinv,Mpc)
Sinv=Sinv/1000;
Psun=Psun/1000;
%%
Mpc.Device3PV=zeros(length(Mpc.All),3);
 for i=X
Mpc.Device3PV(i,1)=1;
Mpc.Device3PV(i,2)=Psun;
Mpc.Device3PV(i,3)=Sinv;
 end
end