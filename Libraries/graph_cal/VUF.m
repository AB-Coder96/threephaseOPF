function VUF1=VUF(Va,da,Vb,db,Vc,dc)
da=da;
db=db+120;
dc=dc-120;
v2=V2(Va,da,Vb,db,Vc,dc);
v1=V1(Va,da,Vb,db,Vc,dc);
VUF1=real(v2./v1);
end