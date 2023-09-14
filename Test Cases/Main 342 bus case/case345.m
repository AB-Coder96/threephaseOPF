clc
clear all
close all
addpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')
addpath 'C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Library Case Modification'
%% version
MPC.version = '2';
%% base MVA
MPC.a.baseMVA=1;
MPC.b.baseMVA=1;
MPC.c.baseMVA=1;
%% base kv
BASE_KV=.12;
MPC.baseKVA=10;
MPC.baseMVA=MPC.baseKVA/1000; 
MPC.a.baseKVA=MPC.baseKVA;
MPC.b.baseKVA=MPC.baseKVA;
MPC.c.baseKVA=MPC.baseKVA;
MPC.a.baseMVA=MPC.baseMVA;
MPC.b.baseMVA=MPC.baseMVA;
MPC.c.baseMVA=MPC.baseMVA;
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
MPC.a.bus=A;
MPC.b.bus=B;
MPC.c.bus=C;
MPC.a.bus(:,13)=.9;
MPC.a.bus(:,12)=1.1;
MPC.a.bus(:,11)=1;
MPC.a.bus(:,10)=BASE_KV;
MPC.a.bus(:,8)=1;
MPC.a.bus(:,7)=1;
MPC.a.bus(:,2)=1;
MPC.a.bus(:,5:6)=0;
MPC.b.bus(:,13)=.9;
MPC.b.bus(:,12)=1.1;
MPC.b.bus(:,11)=1;
MPC.b.bus(:,10)=BASE_KV;
MPC.b.bus(:,8)=1;
MPC.b.bus(:,7)=1;
MPC.b.bus(:,2)=1;
MPC.b.bus(:,5:6)=0;
MPC.c.bus(:,13)=.9;
MPC.c.bus(:,12)=1.1;
MPC.c.bus(:,11)=1;
MPC.c.bus(:,10)=BASE_KV;
MPC.c.bus(:,8)=1;
MPC.c.bus(:,7)=1;
MPC.c.bus(:,2)=1;
MPC.c.bus(:,5:6)=0;
%% Gen Data 
MPC.a.gen=load('Gen.mat');
MPC.b.gen=load('Gen.mat');
MPC.c.gen=load('Gen.mat');
MPC.a.gen=MPC.a.gen.Gen;
MPC.b.gen=MPC.b.gen.Gen;
MPC.c.gen=MPC.c.gen.Gen;
MPC.a.gen(:,8)=1;
MPC.b.gen(:,8)=1;
MPC.c.gen(:,8)=1;
MPC.a.gen(:,2)=0;
MPC.b.gen(:,2)=0;
MPC.c.gen(:,2)=0;
MPC.a.gen(:,4)=10;
MPC.b.gen(:,4)=10;
MPC.c.gen(:,4)=10;
MPC.a.gen(:,5)=-10;
MPC.b.gen(:,5)=-10;
MPC.c.gen(:,5)=-10;
MPC.a.gen(:,6)=1;
MPC.b.gen(:,6)=1;
MPC.c.gen(:,6)=1;
MPC.a.gen(:,7)=MPC.a.baseMVA;
MPC.b.gen(:,7)=MPC.b.baseMVA;
MPC.c.gen(:,7)=MPC.c.baseMVA;
MPC.a.gen(:,9)=10;
MPC.b.gen(:,9)=10;
MPC.c.gen(:,9)=10;
MPC.a.gen(:,10)=-10;
MPC.b.gen(:,10)=-10;
MPC.c.gen(:,10)=-10;
MPC.a.gen(:,11:22)=0;
MPC.b.gen(:,11:22)=0;
MPC.c.gen(:,11:22)=0;
MPC=openSlack([MPC.a.gen(:,1)],10,-10,MPC);
%% Line data
MPC.a.branch=load('Lines.mat');
MPC.b.branch=load('Lines.mat');
MPC.c.branch=load('Lines.mat');
MPC.a.branch=MPC.a.branch.Lines;
MPC.b.branch=MPC.b.branch.Lines;
MPC.c.branch=MPC.c.branch.Lines;
MPC.a.branch(:,5:10)=0;
MPC.b.branch(:,5:10)=0;
MPC.c.branch(:,5:10)=0;
MPC.a.branch(:,11)=1;
MPC.b.branch(:,11)=1;
MPC.c.branch(:,11)=1;
MPC.a.branch(:,12)=-360;
MPC.b.branch(:,12)=-360;
MPC.c.branch(:,12)=-360;
MPC.a.branch(:,13)=360;
MPC.b.branch(:,13)=360;
MPC.c.branch(:,13)=360;
%% gen to bus
for i=1:size(MPC.a.gen,1)
    k=find(MPC.a.bus(:,1)==MPC.a.gen(i,1));
    if size(k,1)<1
     MPC.a.bus(end+1,1)=MPC.a.gen(i,1);
     MPC.a.bus(end,2:13)=MPC.a.bus(end-1,2:13);
     MPC.b.bus(end+1,1)=MPC.b.gen(i,1);
     MPC.b.bus(end,2:13)=MPC.a.bus(end-1,2:13);
     MPC.c.bus(end+1,1)=MPC.c.gen(i,1);
     MPC.c.bus(end,2:13)=MPC.a.bus(end-1,2:13);
     MPC.a.bus(end,2)=3;
     MPC.b.bus(end,2)=3;
     MPC.c.bus(end,2)=3;
     MPC.a.bus(end,3:4)=0;
     MPC.b.bus(end,3:4)=0;
     MPC.c.bus(end,3:4)=0;
     MPC.a.bus(end,12:13)=1;
     MPC.b.bus(end,12:13)=1;
     MPC.c.bus(end,12:13)=1;
    end
end

for j=1:max(MPC.a.bus(:,1))
 KK=find(MPC.a.bus(:,1)==j);
if size(KK,1)==0
    
MPC.a.bus(end+1,1)=j;
MPC.a.bus(end,2)=1;
MPC.a.bus(end,3:4)=0;
MPC.a.bus(end,3:4)=0;
MPC.a.bus(end,5:13)=MPC.a.bus(96,5:13);
MPC.b.bus(end+1,1)=j;
MPC.b.bus(end,2)=1;
MPC.b.bus(end,3:4)=0;
MPC.b.bus(end,3:4)=0;
MPC.b.bus(end,5:13)=MPC.b.bus(96,5:13);
MPC.c.bus(end+1,1)=j;
MPC.c.bus(end,2)=1;
MPC.c.bus(end,3:4)=0;
MPC.c.bus(end,3:4)=0;
MPC.c.bus(end,5:13)=MPC.c.bus(96,5:13);
end   
end

%% add generator to all
for i=1:size(MPC.a.bus,1)
    K=find(MPC.a.gen(:,1)==MPC.a.bus(i,1));
    if size(K,1)<1
      
     MPC.a.gen(end+1,1)=MPC.a.bus(i,1);
     MPC.a.gen(end,2:22)=MPC.a.gen(end-1,2:22);
     MPC.b.gen(end+1,1)=MPC.b.bus(i,1);
     MPC.b.gen(end,2:22)=MPC.a.gen(end-1,2:22);
     MPC.c.gen(end+1,1)=MPC.c.bus(i,1);
     MPC.c.gen(end,2:22)=MPC.a.gen(end-1,2:22);
     MPC.a.gen(end,8)=0;
     MPC.b.gen(end,8)=0;
     MPC.c.gen(end,8)=0;
    end
end
%% gen cost
MPC.a.gencost(1:size(MPC.a.gen,1),1)=2;
MPC.a.gencost(:,4)=3;
MPC.a.gencost(:,5)=0;
MPC.a.gencost(:,6)=20;
MPC.a.gencost(:,7)=0;
MPC.b.gencost=MPC.a.gencost;
MPC.c.gencost=MPC.a.gencost;
%%
%% convert branch impedances from Ohms to p.u.
Vbase = MPC.a.bus(1, 10) * 1e3;      %% in Volts
Sbase = MPC.a.baseMVA * 1e6;              %% in VA
test=MPC.a.branch(:, [3 4]);
MPC.a.branch(:, [3 4]) = MPC.a.branch(:, [3 4]) / (Vbase^2 / Sbase);
test1=MPC.a.branch(:, [3 4]);
Vbase = MPC.b.bus(1, 10) * 1e3;      %% in Volts
Sbase = MPC.b.baseMVA * 1e6;              %% in VA
MPC.b.branch(:, [3 4]) = MPC.b.branch(:, [3 4]) / (Vbase^2 / Sbase);
Vbase = MPC.c.bus(1, 10) * 1e3;      %% in Volts
Sbase = MPC.c.baseMVA * 1e6;              %% in VA
MPC.c.branch(:, [3 4]) = MPC.c.branch(:, [3 4]) / (Vbase^2 / Sbase);
%% convert loads from kW to MW
MPC.a.bus(:, [3, 4]) = MPC.a.bus(:, [3, 4]) / 1e3;
MPC.b.bus(:, [3, 4]) = MPC.b.bus(:, [3, 4]) / 1e3;
MPC.c.bus(:, [3, 4]) = MPC.c.bus(:, [3, 4]) / 1e3;
%% sort
MPC.a.bus=sortrows(MPC.a.bus);
MPC.b.bus=sortrows(MPC.b.bus);
MPC.c.bus=sortrows(MPC.c.bus);
MPC.a.gen=sortrows(MPC.a.gen);
MPC.b.gen=sortrows(MPC.b.gen);
MPC.c.gen=sortrows(MPC.c.gen);
%% voltage limit
MPC.a.bus(:,13)=.9;
MPC.b.bus(:,13)=.9;
MPC.c.bus(:,13)=.9;
MPC.a.bus(:,12)=1.1;
MPC.b.bus(:,12)=1.1;
MPC.c.bus(:,12)=1.1;
%%
MPC.All=1:length(MPC.a.gen);
MPC.a.All=MPC.All;
MPC.b.All=MPC.All;
MPC.c.All=MPC.All;

save('MPC.mat','MPC')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library Case Modification')