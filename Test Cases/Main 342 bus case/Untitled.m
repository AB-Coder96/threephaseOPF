clc
clear 
close all
%% version
mpc.version = '2';
%% base MVA
mpc.a.baseMVA=1;
mpc.b.baseMVA=1;
mpc.c.baseMVA=1;
%% base kv
BASE_KV=.12;
%% bus data
A=load('Loadsa.mat');
B=load('Loadsb.mat');
C=load('Loadsc.mat');
A=A.LoadssecondaryA;
B=B.LoadssecondaryB;
C=C.LoadssecondaryC;
A(:,5)=A(:,4)./A(:,3);
A(:,6)=A(:,5).*sqrt(1-A(:,3).^2);
A(:,7)=sqrt(A(:,4).^2+A(:,6).^2);
A(:,3)=A(:,4);
A(:,4)=A(:,6);
A(:,5:7)=[];
B(:,5)=B(:,4)./B(:,3);
B(:,6)=B(:,5).*sqrt(1-B(:,3).^2);
B(:,7)=sqrt(B(:,4).^2+B(:,6).^2);
B(:,3)=B(:,4);
B(:,4)=B(:,6);
B(:,5:7)=[];
C(:,5)=C(:,4)./C(:,3);
C(:,6)=C(:,5).*sqrt(1-C(:,3).^2);
C(:,7)=sqrt(C(:,4).^2+C(:,6).^2);
C(:,3)=C(:,4);
C(:,4)=C(:,6);
C(:,5:7)=[];
for i=1:size(A,1)
K=find(A(:,1)==i);
if ~isnan(K) 
A(K(1),5)=sum(A(K,3));
A(K(1),6)=sum(A(K,4));
end
end
K=find(A(:,5)==0);
A(K,:)=[];
for i=1:size(B,1)
K=find(B(:,1)==i);
if ~isnan(K) 
B(K(1),5)=sum(B(K,3));
B(K(1),6)=sum(B(K,4));
end
end
K=find(B(:,5)==0);
B(K,:)=[];
for i=1:size(C,1)
K=find(C(:,1)==i);
if ~isnan(K) 
C(K(1),5)=sum(C(K,3));
C(K(1),6)=sum(C(K,4));
end
end
K=find(C(:,5)==0);
C(K,:)=[];
mpc.a.bus=A;
mpc.b.bus=B;
mpc.c.bus=C;
mpc.a.bus(:,13)=.9;
mpc.a.bus(:,12)=1.1;
mpc.a.bus(:,11)=1;
mpc.a.bus(:,10)=BASE_KV;
mpc.a.bus(:,8)=1;
mpc.a.bus(:,7)=1;
mpc.a.bus(:,2)=1;
mpc.a.bus(:,5:6)=0;
mpc.b.bus(:,13)=.9;
mpc.b.bus(:,12)=1.1;
mpc.b.bus(:,11)=1;
mpc.b.bus(:,10)=BASE_KV;
mpc.b.bus(:,8)=1;
mpc.b.bus(:,7)=1;
mpc.b.bus(:,2)=1;
mpc.b.bus(:,5:6)=0;
mpc.c.bus(:,13)=.9;
mpc.c.bus(:,12)=1.1;
mpc.c.bus(:,11)=1;
mpc.c.bus(:,10)=BASE_KV;
mpc.c.bus(:,8)=1;
mpc.c.bus(:,7)=1;
mpc.c.bus(:,2)=1;
mpc.c.bus(:,5:6)=0;
%% Gen Data 
mpc.a.gen=load('Gen.mat');
mpc.b.gen=load('Gen.mat');
mpc.c.gen=load('Gen.mat');
mpc.a.gen=mpc.a.gen.Gen;
mpc.b.gen=mpc.b.gen.Gen;
mpc.c.gen=mpc.c.gen.Gen;
mpc.a.gen(:,8)=1;
mpc.b.gen(:,8)=1;
mpc.c.gen(:,8)=1;
mpc.a.gen(:,2)=0;
mpc.b.gen(:,2)=0;
mpc.c.gen(:,2)=0;
mpc.a.gen(:,4)=10;
mpc.b.gen(:,4)=10;
mpc.c.gen(:,4)=10;
mpc.a.gen(:,5)=-10;
mpc.b.gen(:,5)=-10;
mpc.c.gen(:,5)=-10;
mpc.a.gen(:,6)=1;
mpc.b.gen(:,6)=1;
mpc.c.gen(:,6)=1;
mpc.a.gen(:,7)=mpc.a.baseMVA;
mpc.b.gen(:,7)=mpc.b.baseMVA;
mpc.c.gen(:,7)=mpc.c.baseMVA;
mpc.a.gen(:,9)=10;
mpc.b.gen(:,9)=10;
mpc.c.gen(:,9)=10;
mpc.a.gen(:,10)=-10;
mpc.b.gen(:,10)=-10;
mpc.c.gen(:,10)=-10;
mpc.a.gen(:,11:22)=0;
mpc.b.gen(:,11:22)=0;
mpc.c.gen(:,11:22)=0;
%% Line data
mpc.a.branch=load('Lines.mat');
mpc.b.branch=load('Lines.mat');
mpc.c.branch=load('Lines.mat');
mpc.a.branch=mpc.a.branch.Lines;
mpc.b.branch=mpc.b.branch.Lines;
mpc.c.branch=mpc.c.branch.Lines;
mpc.a.branch(:,5:10)=0;
mpc.b.branch(:,5:10)=0;
mpc.c.branch(:,5:10)=0;
mpc.a.branch(:,11)=1;
mpc.b.branch(:,11)=1;
mpc.c.branch(:,11)=1;
mpc.a.branch(:,12)=-360;
mpc.b.branch(:,12)=-360;
mpc.c.branch(:,12)=-360;
mpc.a.branch(:,13)=360;
mpc.b.branch(:,13)=360;
mpc.c.branch(:,13)=360;
%% gen to bus
for i=1:size(mpc.a.gen,1)
    k=find(mpc.a.bus(:,1)==mpc.a.gen(i,1));
    if size(k,1)<1
     mpc.a.bus(end+1,1)=mpc.a.gen(i,1);
 mpc.a.bus(end,2:13)=mpc.a.bus(end-1,2:13);
     mpc.b.bus(end+1,1)=mpc.b.gen(i,1);
     mpc.b.bus(end,2:13)=mpc.a.bus(end-1,2:13);
     mpc.c.bus(end+1,1)=mpc.c.gen(i,1);
     mpc.c.bus(end,2:13)=mpc.a.bus(end-1,2:13);
     mpc.a.bus(end,2)=3;
     mpc.b.bus(end,2)=3;
     mpc.c.bus(end,2)=3;
     mpc.a.bus(end,3:4)=0;
     mpc.b.bus(end,3:4)=0;
     mpc.c.bus(end,3:4)=0;
     mpc.a.bus(end,12:13)=1;
     mpc.b.bus(end,12:13)=1;
     mpc.c.bus(end,12:13)=1;
    end
end
%% add generator to all
for i=1:size(mpc.a.bus,1)
    K=find(mpc.a.gen(:,1)==mpc.a.bus(i,1));
    if size(K,1)<1
      
     mpc.a.gen(end+1,1)=mpc.a.bus(i,1);
     mpc.a.gen(end,2:22)=mpc.a.gen(end-1,2:22);
     mpc.b.gen(end+1,1)=mpc.b.bus(i,1);
     mpc.b.gen(end,2:22)=mpc.a.gen(end-1,2:22);
     mpc.c.gen(end+1,1)=mpc.c.bus(i,1);
     mpc.c.gen(end,2:22)=mpc.a.gen(end-1,2:22);
     mpc.a.gen(end,8)=0;
     mpc.b.gen(end,8)=0;
     mpc.c.gen(end,8)=0;
    end
end
%% gen cost
mpc.a.gencost(1:size(mpc.a.gen,1),1)=2;
mpc.a.gencost(:,4)=3;
mpc.a.gencost(:,5)=0;
mpc.a.gencost(:,6)=20;
mpc.a.gencost(:,7)=0;
mpc.b.gencost=mpc.a.gencost;
mpc.c.gencost=mpc.a.gencost;
%%
%% convert branch impedances from Ohms to p.u.
Vbase = mpc.a.bus(1, 10) * 1e3;      %% in Volts
Sbase = mpc.a.baseMVA * 1e6;              %% in VA
mpc.a.branch(:, [3 4]) = mpc.a.branch(:, [3 4]) / (Vbase^2 / Sbase);
Vbase = mpc.b.bus(1, 10) * 1e3;      %% in Volts
Sbase = mpc.b.baseMVA * 1e6;              %% in VA
mpc.b.branch(:, [3 4]) = mpc.b.branch(:, [3 4]) / (Vbase^2 / Sbase);
Vbase = mpc.c.bus(1, 10) * 1e3;      %% in Volts
Sbase = mpc.c.baseMVA * 1e6;              %% in VA
mpc.c.branch(:, [3 4]) = mpc.c.branch(:, [3 4]) / (Vbase^2 / Sbase);
%% convert loads from kW to MW
mpc.a.bus(:, [3, 4]) = mpc.a.bus(:, [3, 4]) / 1e3;
mpc.b.bus(:, [3, 4]) = mpc.b.bus(:, [3, 4]) / 1e3;
mpc.c.bus(:, [3, 4]) = mpc.c.bus(:, [3, 4]) / 1e3;