function qneutral=qneutral(pa,pb,pc,qa,qb,qc)

r3=sqrt(3)/2;
a=complex(-0.5,r3);
j=complex(0,1);
qneutral=imag(pa+a*pb+a*a*pc+j*(qa+a*qb+a*a*qc));
end