function Mpc=open3EV(X,Psch,Sinv,Mpc)
Sinv=Sinv/1000;
Psch=Psch/1000;
%%
Mpc.Device3EV=zeros(length(Mpc.All),3);
 for i=X
Mpc.Device3EV(i,1)=1;
Mpc.Device3EV(i,2)=Psch;
Mpc.Device3EV(i,3)=Sinv;
 end
end