function MPC=Convert3Device(MPC)
%% convert PV
for i=length(MPC.All)
 MPC.a.DevicePV(i,1)= MPC.a.DevicePV(i,1)| MPC.Device3PV(i,1);
 MPC.b.DevicePV(i,1)= MPC.b.DevicePV(i,1)| MPC.Device3PV(i,1);
 MPC.c.DevicePV(i,1)= MPC.c.DevicePV(i,1)| MPC.Device3PV(i,1);
 MPC.a.DevicePV(i,2)= MPC.a.DevicePV(i,2)+ MPC.Device3PV(i,2)/3;
 MPC.b.DevicePV(i,2)= MPC.b.DevicePV(i,2)+ MPC.Device3PV(i,2)/3;
 MPC.c.DevicePV(i,2)= MPC.c.DevicePV(i,2)+ MPC.Device3PV(i,2)/3;
 MPC.a.DevicePV(i,3)= MPC.a.DevicePV(i,3)+ MPC.Device3PV(i,3)/3;
 MPC.b.DevicePV(i,3)= MPC.b.DevicePV(i,3)+ MPC.Device3PV(i,3)/3;
 MPC.c.DevicePV(i,3)= MPC.c.DevicePV(i,3)+ MPC.Device3PV(i,3)/3;
%% convert EV
 MPC.a.DeviceEV(i,1)= MPC.a.DeviceEV(i,1)| MPC.Device3EV(i,1);
 MPC.b.DeviceEV(i,1)= MPC.b.DeviceEV(i,1)| MPC.Device3EV(i,1);
 MPC.c.DeviceEV(i,1)= MPC.c.DeviceEV(i,1)| MPC.Device3EV(i,1);
 MPC.a.DeviceEV(i,2)= MPC.a.DeviceEV(i,2)+ MPC.Device3EV(i,2)/3;
 MPC.b.DeviceEV(i,2)= MPC.b.DeviceEV(i,2)+ MPC.Device3EV(i,2)/3;
 MPC.c.DeviceEV(i,2)= MPC.c.DeviceEV(i,2)+ MPC.Device3EV(i,2)/3;
 MPC.a.DeviceEV(i,3)= MPC.a.DeviceEV(i,3)+ MPC.Device3EV(i,3)/3;
 MPC.b.DeviceEV(i,3)= MPC.b.DeviceEV(i,3)+ MPC.Device3EV(i,3)/3;
 MPC.c.DeviceEV(i,3)= MPC.c.DeviceEV(i,3)+ MPC.Device3EV(i,3)/3;
end
end