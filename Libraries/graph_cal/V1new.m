function V1=V1new(va,ta,vb,tb,vc,tc)
Va=va*cosd(ta)+1i*va*sind(ta);
Vb=vb*cosd(tb+120)+1i*vb*sind(tb+120);
Vc=vc*cosd(tc-120)+1i*vc*sind(tc-120);
V=[Va;Vb;Vc];
a=cosd(120)+1i*sind(120);
A=[1 a a^2;1 a^2 a;1 1 1];
Vs=(1/3)*A*V; 
V1r=real(Vs(1));
V2r=real(Vs(2));
V1i=imag(Vs(1));
V2i=imag(Vs(2));
V1=V1r+1i*V1i;
V1=abs(V1);
end