function Mpc=openEV(X,Psch,Sinv,Mpc) 
Sinv=Sinv/1000;
Psch=Psch/1000;
%% for proposed methods
Mpc.DeviceEV=zeros(length(Mpc.All),3);
 for i=X
Mpc.DeviceEV(i,1)=1;
Mpc.DeviceEV(i,2)=Psch;
Mpc.DeviceEV(i,3)=Sinv;
 end