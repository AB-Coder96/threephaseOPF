function VUF1=VUF_lin(Va,da,Vb,db,Vc,dc)
da=da;
db=db+120;
dc=dc-120;
syms va Daa vb Dbb vc Dcc
f1=V1(va,Daa,vb,Dbb,vc,Dcc);
syms g1(va,Daa,vb,Dbb,vc,Dcc)
g1(va,Daa,vb,Dbb,vc,Dcc)=gradient(f1,[va,Daa,vb,Dbb,vc,Dcc]);
x=g1(1,0.01,1,120,1,-120);
g1_1=double(x);
x=g1(1,0.01,1.1,123,1,-117);
g1_2=double(x);
f2=V2(va,Daa,vb,Dbb,vc,Dcc);
syms g2(va,Daa,vb,Dbb,vc,Dcc)
g2(va,Daa,vb,Dbb,vc,Dcc)=gradient(f2,[va,Daa,vb,Dbb,vc,Dcc]);
x=g2(1,0.01,1,120,1,-120);
g2_1=double(x);
x=g2(1,0.01,1.1,123,.9,-117);
g2_2=double(x);
syms V1_apx(va,Daa,vb,Dbb,vc,Dcc)
V1_apx(va,Daa,vb,Dbb,vc,Dcc)=V1(1,0.01,1,120,1,-120)+([va,Daa,vb,Dbb,vc,Dcc]-[1,0.01,1,120,1,-120])*g1_2;
syms V2_apx(va,Daa,vb,Dbb,vc,Dcc)
V2_apx(va,Daa,vb,Dbb,vc,Dcc)=V2(1,0.01,1,120,1,-120)+([va,Daa,vb,Dbb,vc,Dcc]-[1,0.01,1,120,1,-120])*g2_2;
VUF1=double(V2_apx(Va,da,Vb,db,Vc,dc))./double(V1_apx(Va,da,Vb,db,Vc,dc));
end