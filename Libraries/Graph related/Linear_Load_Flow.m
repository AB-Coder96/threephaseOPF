function Res = Linear_Load_Flow(Sistema);
% This function calculates a linear approximation of the load flow
% in balanced systems (in pu)
NL = length(Sistema(:,1));  % number of lines
NN = NL + 1;                % number of nodes   
Ybus  = zeros(NN);          % initialize Ybus
SP = zeros(NN,1);           % vector to save constant power loads 
SZ = zeros(NN,1);           % to save constant impedance loads 
SI = zeros(NN,1);           % to save constat current loads
for k = 1:NL                % calculate the Ybus and separate loads 
     N1 = Sistema(k,1);
     N2 = Sistema(k,2);
     ykm = 1/(Sistema(k,3)+j*Sistema(k,4));
     bkm = j*Sistema(k,5);
     Ybus(N1,N1) = Ybus(N1,N1) + ykm + bkm;
     Ybus(N1,N2) = Ybus(N1,N2) - ykm;
     Ybus(N2,N1) = Ybus(N2,N1) - ykm;
     Ybus(N2,N2) = Ybus(N2,N2) + ykm + bkm;     
     alfa = Sistema(k,8);     
     S = (Sistema(k,6)+j*Sistema(k,7));     
     if alfa==0
         SP(N2) = -S;                  
     end
     if alfa==1
         SI(N2) = -S;
     end
     if alfa==2
         SZ(N2) = -S;                  
     end    
end  
kN = 2:NN;  % all nodes except the slack (slack = 1)
YNS = Ybus(kN,1);   % (vector of the Ybus related to the slack)
YNN = Ybus(kN,kN);  % (vector of the Ybus related to other nodes)
A = YNS-2*conj(SP(kN))-conj(SI(kN)); % matrix A (same as in the paper)
B = diag(conj(SP(kN)));              % matrix B (same as in the paper)  
C = YNN-diag(conj(SZ(kN)));          % matrix C (same as in the paper)  
MM = [real(B+C),imag(B-C);imag(B+C),real(C-B)]; % (same as in Eq 10 in the paper)
VRI = inv(MM)*[-real(A);-imag(A)];   % voltages (real and imaginary part)
Res.Vs = [1;VRI(1:NL)+j*VRI((NL+1):2*NL)];  % voltages including slack = 1<0?)