function bce=BHS(a0,a1,a2,a3,a4,a5,a6,x1,x2,x3,x4,x5,x6,y)
yhat=sigmoid((a0+a1*x1+a2*x2+a3*x3+a4*x4+a5*x5+a6*x6)^2);
bce=(1-y)*(-log(1-yhat))+(y-0)*(-log(yhat-0));
end