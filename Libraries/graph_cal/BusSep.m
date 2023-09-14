function K=BusSep(MPC)
% preallocate
K{2}=zeros(size(MPC.All)); %PVa
K{3}=zeros(size(MPC.All)); %PVb
K{4}=zeros(size(MPC.All)); %PVc
K{5}=zeros(size(MPC.All)); %EVa
K{6}=zeros(size(MPC.All)); %EVb
K{7}=zeros(size(MPC.All)); %EVc
K{8}=zeros(size(MPC.All)); %3PV
K{9}=zeros(size(MPC.All)); %3PV
%% 
K{1}=MPC.Slack; %Slack
for i=MPC.All
    if MPC.a.DevicePV(i,1)==1 
        K{2}(i)=i;
    end
    if MPC.b.DevicePV(i,1)==1 
        K{3}(i)=i;
    end
    if MPC.c.DevicePV(i,1)==1 
        A=1
        K{4}(i)=i;
    end
     if MPC.a.DeviceEV(i,1)==1 
        K{5}(i)=i;
    end
    if MPC.b.DeviceEV(i,1)==1 
        K{6}(i)=i;
    end
    if MPC.c.DeviceEV(i,1)==1 
        K{7}(i)=i;
    end
    if MPC.Device3PV(i,1)==1 
        K{8}(i)=i;
    end
    if MPC.Device3EV(i,1)==1 
        K{9}(i)=i;
    end
end
K{2}=nonzeros(K{2})';
K{3}=nonzeros(K{3})';
K{4}=nonzeros(K{4})';
K{5}=nonzeros(K{5})';
K{6}=nonzeros(K{6})';
K{7}=nonzeros(K{7})';
K{8}=nonzeros(K{8})';
K{9}=nonzeros(K{9})';
end