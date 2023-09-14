function bus_con=ConCell(MPC)
% Extract line sets from bus sets 
n=size(MPC.bus,1);
bus_con_from=cell(n,1);
bus_con_to=cell(n,1);
bus_con=cell(n,1);
for i=1:n
   bus_con_from(i,1)={find(MPC.branch(:,1)==i)};
   bus_con_to(i,1)={find(MPC.branch(:,2)==i)};
   bus_con(i,1)={union(MPC.branch(cell2mat(bus_con_from(i,1)),2),MPC.branch(cell2mat(bus_con_to(i,1)),1))}; 
   [mm,nn]=size(bus_con{i,1});
   if nn>1
   bus_con{i,1}=bus_con{i,1}';
   end
end
end