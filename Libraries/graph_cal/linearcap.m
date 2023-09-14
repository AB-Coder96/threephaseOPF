function A=linearcap(P,Q,Acc)
for i=1:Acc
A(i)=(sind(360*i/Acc)-sind(360*(i-1)/Acc))*P/sind(360/Acc)-(cosd(360*i/Acc)-cosd(360*(i-1)/Acc))*Q/sind(360/Acc);
end
end