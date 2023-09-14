function Msmc=mismatch(pa,pb,pc)
M=(pa+pb+pc)/3;
for i=1:size(M,1)
Msmc(i,1)=max(M(i,1)-pa(i,1),M(i,1)-pb(i,1));
Msmc(i,1)=max(Msmc(i,1),M(i,1)-pc(i,1));
end
end