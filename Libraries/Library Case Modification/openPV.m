function Mpc=openPV(X,Psun,Sinv,Mpc) 
Sinv=Sinv/1000;
Psun=Psun/1000;
%% for proposed method
Mpc.DevicePV=zeros(length(Mpc.All),3);
 for i=X
Mpc.DevicePV(i,1)=1;
Mpc.DevicePV(i,2)=Psun;
Mpc.DevicePV(i,3)=Sinv;
 end

