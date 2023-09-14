%clear
%load_type:   1:PQ   ,  2:I  ,  3:Z
%BasekVmv = 4.8/sqrt(3);
%load : [bus load phase]
  load_data=[...
    2 140 70    1   1
    2 140 70    2   1
    2 350 175    3   1
    5 85    40    3   3
    8 85    40    1   2
    9 42    21    3   1
    10 140  70    1   2
    11 126  62    1   1
    13 42   21    3   2
    14 85   40    3   1
    16 17   8    1   2
    16 21   10    2   2
    17 85   40    1   3
    19 42   21    2   1
    20 85   40    3   1
    22 42   21    2   3
    23 140  70    2   2
    23 21   10    3   2
    24 85   40    3   1
    26 8    4    1   3
    26 85   40    2   3
    27 42   21    3   1
    28 42   21    1   1
    29 42   21    1   1
    29 42   21    2   1
    29 42   21    3   1
    30 42   21    1   2
    32 42   21    3   1
    33 42   21    2   3
    35 85   40    3   1
    36 85   40    3   1
    37 85   40    2   3
   ];
%load=[2 -3 -4 -2];
bus_data=[...
    1 4.8 inf  1
    2 4.8 inf    1
    3 4.8 inf  1
    4 4.8 inf  1
    5 4.8 inf  3
    6 4.8 inf  1
    7 4.8 inf  1
    8 4.8 inf  2
    9 4.8 inf  1
    10 4.8 inf  2
    11 4.8 inf  1
    12 4.8 inf  1
    13 4.8 inf  2
    14 4.8 inf  1    
    15 4.8 inf  1
    16 4.8 inf  2
    17 4.8 inf  3
    18 4.8 inf  1
    19 4.8 inf  1
    20 4.8 inf  1
    21 4.8 inf  1
    22 4.8 inf  3
    23 4.8 inf  2
    24 4.8 inf  1
    25 4.8 inf  1
    26 4.8 inf  3
    27 4.8 inf  1
    28 4.8 inf  1
    29 4.8 inf  1
    30 4.8 inf  2
    31 4.8 inf  1
    32 4.8 inf  1
    33 4.8 inf  3
    34 4.8 inf  1
    35 4.8 inf  1
    36 4.8 inf  1
    37 4.8 inf  3
 ];
% %load_data(:,2:3)=0;
% %Line_data :[bus_from bus_to length R1 X1 Rn Xn R0 X0 status];
Line_data= [...
%     1   2   0.5  1.056 0.323 1.056 0.323 1.056 0.323   1
%     2   3   0.5  1.056 0.323 1.056 0.323 1.056 0.323    1
%    3   4   5280  1.056 0.323 1.056 0.323 1.056 0.323    1
%     1   2   5280   0.292	0.197	0.292	0.197    0.292	0.197    1
%     2   3   5280   0.292	0.197	0.292	0.197    0.292	0.197    1 
%     3   4   5280   0.292	0.197	0.292	0.197    0.292	0.197    1
%     4   5   5280   0.292	0.197	0.292	0.197    0.292	0.197    1
    1   2   1850   0.2926	0.1973	0.2926	0.1973    0.2926	0.1973    1
    2   3   960   0.4751	0.2973	0.4751	0.2973    0.4751	0.2973    1 
    3   4   1320  0.4751	0.2973	0.4751	0.2973   0.4751     0.2973    1
    4   5   600   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    5   6   200   1.2936	0.6713	1.2936	0.6713     1.2936	0.6713    1
    6   7   320   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    7   8   320   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    8   9   560   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    9   10   640   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    10   11   400  1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    11   12   400  1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    12   13   400   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    12   36   200   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    9   34   520    2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    34   35   200   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    34   33   1280  2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    7   32   320   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    6   37   600   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    6   31   300   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    4   27   240   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    27   28   280   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    28   29   200  2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    28   30   280  2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    3   25   400   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    25   24   240   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    25   26   320   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    3   14   360   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    14   15   520  1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    15   16   80   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    16   17   520  2.0952	0.7758	2.0952	0.7758     2.0952	0.7758    1
    15   20   800   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    20   18   600   1.2936	0.6713	1.2936	0.6713    1.2936	0.6713    1
    18   19   280   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    20   21   920  2.0952	0.7758	2.0952	0.7758     2.0952	0.7758    1
    21   22   760   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
    21   23   120   2.0952	0.7758	2.0952	0.7758    2.0952	0.7758    1
  ];
%Line_data(:,4:9)=Line_data(:,4:9)/3;
%trans_data :[hv_bus lv_bus R1 X1 R0 X0 KVA shift status];
trans_data= [];%10	11	0.01	0.03	0.01	0.03    100 11   1];
%
%%
bus=[];
bus_V=[];
Jac_mat2=[];
%%
V0=1;
for i=1:length(bus_data(:,1))
    bus(i).Vabcn = V0* [1;(cosd(-120)+1j*sind(-120));(cosd(120)+1j*sind(120));0];
end
%%
Line_Voltage=zeros(length(Line_data(:,1)),1);
for i=1:length(Line_data(:,1))
    Line_Voltage(i)=bus_data(find(bus_data(:,1)==Line_data(i,1)),2);
end
%%
PF=0.9;
base_VA=100000; %kW

%%
Line_pu=Line_data;
Line_pu(find(Line_pu(:,10)==0),:)=[];
for i=4:9
    Line_pu(:,i)= 1* Line_pu(:,i).*Line_pu(:,3)./((1e6)*(Line_Voltage .^2)/base_VA/3);
end
Line_pu(:,3)=[];
% 0.000189394*
trans_pu=trans_data;
%trans_pu(find(trans_pu(:,9)==0),:)=[];
% for i=3:6
%     trans_pu(:,i) = trans_data(:,i) *3 .* (base_VA/1000)./ trans_data(:,7);
% end
%
shunt_R_pu=bus_data(2:end,:);
shunt_R_pu(:,3)=shunt_R_pu(:,3)./((1e6)*(shunt_R_pu(:,2).^2)/base_VA/3);
load_pu=load_data;
%
load_pu(:,2:3)= -load_pu(:,2:3)./(base_VA/1000);

delta_V_mat=zeros((length(bus_data(:,1))-1)*4,1);
%tic
%%
Ybus= zeros(4*length(bus_data(:,1)));
for i=1:length(Line_data(:,1))
    m=find(bus_data(:,1)==Line_data(i,1));
    n=find(bus_data(:,1)==Line_data(i,2));
    
    Ybus(4*m-3,4*n-3)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
    Ybus(4*m-2,4*n-2)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
    Ybus(4*m-1,4*n-1)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
    Ybus(4*m,4*n)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
    
    Ybus(4*n-3,4*m-3)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
    Ybus(4*n-2,4*m-2)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
    Ybus(4*n-1,4*m-1)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
    Ybus(4*n,4*m)= -1./(Line_pu(i,3)+1j*Line_pu(i,4));
end

%%%%%
if ~isempty(trans_pu)
    for i=1:length(trans_pu(:,1))
        
        if trans_pu(i,8)==1
            
            m=find(bus_data(:,1)==trans_pu(i,1));
            n=find(bus_data(:,1)==trans_pu(i,2));
            
            Ybus(4*m-3,4*n-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n-1)= 0;
            Ybus(4*m-3,4*n)= 0;
            
            Ybus(4*m-2,4*n-3)= 0;
            Ybus(4*m-2,4*n-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n)= 0;
            
            Ybus(4*m-1,4*n-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n-2)= 0;
            Ybus(4*m-1,4*n-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n)= 0;
            
            Ybus(4*m,4*n-3)= 0;
            Ybus(4*m,4*n-2)= 0;
            Ybus(4*m,4*n-1)= 0;
            Ybus(4*m,4*n)= 0;
            %
            Ybus(4*n-3,4*m-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m-2)= 0;
            Ybus(4*n-3,4*m-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m)= 0;
            
            Ybus(4*n-2,4*m-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m-1)= 0;
            Ybus(4*n-2,4*m)= 0;
            
            Ybus(4*n-1,4*m-3)= 0;
            Ybus(4*n-1,4*m-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m)= 0;
            
            Ybus(4*n,4*m-3)= 0;
            Ybus(4*n,4*m-2)= 0;
            Ybus(4*n,4*m-1)= 0;
            Ybus(4*n,4*m)= 0;
            %
        elseif trans_pu(i,8)==5
            
            m=find(bus_data(:,1)==trans_pu(i,1));
            n=find(bus_data(:,1)==trans_pu(i,2));
            
            Ybus(4*m-3,4*n-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n-2)= 0;
            Ybus(4*m-3,4*n-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n)= 0;
            
            Ybus(4*m-2,4*n-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n-1)= 0;
            Ybus(4*m-2,4*n)= 0;
            
            Ybus(4*m-1,4*n-3)= 0;
            Ybus(4*m-1,4*n-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n)= 0;
            
            Ybus(4*m,4*n-3)= 0;
            Ybus(4*m,4*n-2)= 0;
            Ybus(4*m,4*n-1)= 0;
            Ybus(4*m,4*n)= 0;
            %
            Ybus(4*n-3,4*m-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m-1)= 0;
            Ybus(4*n-3,4*m)= 0;
            
            Ybus(4*n-2,4*m-3)= 0;
            Ybus(4*n-2,4*m-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m)= 0;
            
            Ybus(4*n-1,4*m-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m-2)= 0;
            Ybus(4*n-1,4*m-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m)= 0;
            
            Ybus(4*n,4*m-3)= 0;
            Ybus(4*n,4*m-2)= 0;
            Ybus(4*n,4*m-1)= 0;
            Ybus(4*n,4*m)= 0;
            %
        elseif trans_pu(i,8)==7
            
            m=find(bus_data(:,1)==trans_pu(i,1));
            n=find(bus_data(:,1)==trans_pu(i,2));
            
            Ybus(4*m-3,4*n-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n-1)= 0;
            Ybus(4*m-3,4*n)= 0;
            
            Ybus(4*m-2,4*n-3)= 0;
            Ybus(4*m-2,4*n-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n)= 0;
            
            Ybus(4*m-1,4*n-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n-2)= 0;
            Ybus(4*m-1,4*n-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n)= 0;
            
            Ybus(4*m,4*n-3)= 0;
            Ybus(4*m,4*n-2)= 0;
            Ybus(4*m,4*n-1)= 0;
            Ybus(4*m,4*n)= 0;
            %
            Ybus(4*n-3,4*m-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m-2)= 0;
            Ybus(4*n-3,4*m-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m)= 0;
            
            Ybus(4*n-2,4*m-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m-1)= 0;
            Ybus(4*n-2,4*m)= 0;
            
            Ybus(4*n-1,4*m-3)= 0;
            Ybus(4*n-1,4*m-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m)= 0;
            
            Ybus(4*n,4*m-3)= 0;
            Ybus(4*n,4*m-2)= 0;
            Ybus(4*n,4*m-1)= 0;
            Ybus(4*n,4*m)= 0;
            %
        elseif trans_pu(i,8)==11
            
            m=find(bus_data(:,1)==trans_pu(i,1));
            n=find(bus_data(:,1)==trans_pu(i,2));
            
            Ybus(4*m-3,4*n-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n-2)= 0;
            Ybus(4*m-3,4*n-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-3,4*n)= 0;
            
            Ybus(4*m-2,4*n-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-2,4*n-1)= 0;
            Ybus(4*m-2,4*n)= 0;
            
            Ybus(4*m-1,4*n-3)= 0;
            Ybus(4*m-1,4*n-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*m-1,4*n)= 0;
            
            Ybus(4*m,4*n-3)= 0;
            Ybus(4*m,4*n-2)= 0;
            Ybus(4*m,4*n-1)= 0;
            Ybus(4*m,4*n)= 0;
            %
            Ybus(4*n-3,4*m-3)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m-2)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-3,4*m-1)= 0;
            Ybus(4*n-3,4*m)= 0;
            
            Ybus(4*n-2,4*m-3)= 0;
            Ybus(4*n-2,4*m-2)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m-1)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-2,4*m)= 0;
            
            Ybus(4*n-1,4*m-3)= 1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m-2)= 0;
            Ybus(4*n-1,4*m-1)= -1./(sqrt(3)*(trans_pu(i,3)+1j*trans_pu(i,4)));
            Ybus(4*n-1,4*m)= 0;
            
            Ybus(4*n,4*m-3)= 0;
            Ybus(4*n,4*m-2)= 0;
            Ybus(4*n,4*m-1)= 0;
            Ybus(4*n,4*m)= 0;
        end
        
    end
end
%
for i=1:length(bus_data(:,1))
    if i==11
        svda=1;
    end
    aa=0;
    bb=0;
    cc=0;
    dd=0;
    aa=sum(1./(Line_pu(find(Line_pu(:,1)==bus_data(i,1)),3) + 1j*Line_pu(find(Line_pu(:,1)==bus_data(i,1)),4)));
    bb=sum(1./(Line_pu(find(Line_pu(:,2)==bus_data(i,1)),3) + 1j*Line_pu(find(Line_pu(:,2)==bus_data(i,1)),4)));
    cc=sum(1./(shunt_R_pu(find(shunt_R_pu(:,1)==bus_data(i,1)),3)));
    
    Ybus(4*i-3,4*i-3)= Ybus(4*i-3,4*i-3) + aa+bb;
    Ybus(4*i-2,4*i-2)= Ybus(4*i-2,4*i-2) + aa+bb;
    Ybus(4*i-1,4*i-1)= Ybus(4*i-1,4*i-1) + aa+bb;
    Ybus(4*i,4*i)= Ybus(4*i,4*i) + aa+bb+cc;
    
    if ~isempty(trans_pu)
        
        trans_ind1=find(trans_pu(:,1)==bus_data(i,1));
        if ~isempty(trans_ind1)
            
            imped = trans_pu(trans_ind1,3) + 1j*trans_pu(trans_ind1,4);
            
            Ybus(4*i-3,4*i-3)= Ybus(4*i-3,4*i-3) + (2/(3*imped));
            Ybus(4*i-3,4*i-2)= Ybus(4*i-3,4*i-2) + (-1/(3*imped));
            Ybus(4*i-3,4*i-1)= Ybus(4*i-3,4*i-1) + (-1/(3*imped));
            Ybus(4*i-3,4*i)= Ybus(4*i-3,4*i) ;
            
            Ybus(4*i-2,4*i-3)= Ybus(4*i-2,4*i-3) + (-1/(3*imped));
            Ybus(4*i-2,4*i-2)= Ybus(4*i-2,4*i-2) + (2/(3*imped));
            Ybus(4*i-2,4*i-1)= Ybus(4*i-2,4*i-1) + (-1/(3*imped));
            Ybus(4*i-2,4*i)= Ybus(4*i-2,4*i);
            
            Ybus(4*i-1,4*i-3)= Ybus(4*i-1,4*i-3) + (-1/(3*imped));
            Ybus(4*i-1,4*i-2)= Ybus(4*i-1,4*i-2) + (-1/(3*imped));
            Ybus(4*i-1,4*i-1)= Ybus(4*i-1,4*i-1) + (2/(3*imped));
            Ybus(4*i-1,4*i)= Ybus(4*i-1,4*i);
            
            Ybus(4*i,4*i-3)= Ybus(4*i,4*i-3) ;
            Ybus(4*i,4*i-2)= Ybus(4*i,4*i-2) ;
            Ybus(4*i,4*i-1)= Ybus(4*i,4*i-1) ;
            Ybus(4*i,4*i)= Ybus(4*i,4*i) ;
            
        end
        
        trans_ind2= find(trans_pu(:,2)==bus_data(i,1));
        if ~isempty(trans_ind2)
            
            imped = trans_pu(trans_ind2,3) + 1j*trans_pu(trans_ind2,4);
            
            Ybus(4*i-3,4*i-3)= Ybus(4*i-3,4*i-3) + (1/(imped));
            Ybus(4*i-3,4*i-2)= Ybus(4*i-3,4*i-2) ;
            Ybus(4*i-3,4*i-1)= Ybus(4*i-3,4*i-1) ;
            Ybus(4*i-3,4*i)= Ybus(4*i-3,4*i) + (-1/(imped));
            
            Ybus(4*i-2,4*i-3)= Ybus(4*i-2,4*i-3) ;
            Ybus(4*i-2,4*i-2)= Ybus(4*i-2,4*i-2) + (1/(imped));
            Ybus(4*i-2,4*i-1)= Ybus(4*i-2,4*i-1) ;
            Ybus(4*i-2,4*i)= Ybus(4*i-2,4*i) + (-1/(imped));
            
            Ybus(4*i-1,4*i-3)= Ybus(4*i-1,4*i-3) ;
            Ybus(4*i-1,4*i-2)= Ybus(4*i-1,4*i-2) ;
            Ybus(4*i-1,4*i-1)= Ybus(4*i-1,4*i-1) + (1/(imped));
            Ybus(4*i-1,4*i)= Ybus(4*i-1,4*i) + (-1/(imped));
            
            Ybus(4*i,4*i-3)= Ybus(4*i,4*i-3) + (-1/(imped));
            Ybus(4*i,4*i-2)= Ybus(4*i,4*i-2) + (-1/(imped));
            Ybus(4*i,4*i-1)= Ybus(4*i,4*i-1) + (-1/(imped));
            Ybus(4*i,4*i)= Ybus(4*i,4*i) + (3/(imped));
            
        end
        
    end
end
Gbus=real(Ybus);
Bbus=imag(Ybus);
%
%%

for i=2:length(bus_data(:,1))
    for j=2:length(bus_data(:,1))
        
        Jac_mat1{i,j}= [Gbus(4*i-3:4*i , 4*j-3:4*j) , -Bbus(4*i-3:4*i , 4*j-3:4*j)
                        Bbus(4*i-3:4*i , 4*j-3:4*j) , Gbus(4*i-3:4*i , 4*j-3:4*j)];
        
    end
end
%%
for counter=1:20
    
    Jac_mat2=[];
    Jacobian=[];
    
    for i=2:length(bus_data(:,1))
        
        %connected_buses= [trans_pu(find(trans_pu(:,1)==i),2) ; trans_pu(find(trans_pu(:,2)==i),1)];
        %connected_buses= [Line_pu(find(Line_pu(:,1)==i),2) ; Line_pu(find(Line_pu(:,2)==i),1); trans_pu(find(trans_pu(:,1)==i),2) ; trans_pu(find(trans_pu(:,2)==i),1)];
        connected_buses= [Line_pu(find(Line_pu(:,1)==i),2) ; Line_pu(find(Line_pu(:,2)==i),1)];%; trans_pu(find(trans_pu(:,1)==i),2) ; trans_pu(find(trans_pu(:,2)==i),1)];
        
        bus(i).Ir_abcn_sch(1) = (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2)) *(real(bus(i).Vabcn(1)-bus(i).Vabcn(4))) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3)) *(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))) / (((real(bus(i).Vabcn(1)-bus(i).Vabcn(4))).^2) + ((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))).^2));
        bus(i).Ir_abcn_sch(2) = (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2)) *(real(bus(i).Vabcn(2)-bus(i).Vabcn(4))) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3)) *(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))) / (((real(bus(i).Vabcn(2)-bus(i).Vabcn(4))).^2) + ((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))).^2));
        bus(i).Ir_abcn_sch(3) = (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2)) *(real(bus(i).Vabcn(3)-bus(i).Vabcn(4))) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3)) *(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))) / (((real(bus(i).Vabcn(3)-bus(i).Vabcn(4))).^2) + ((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))).^2));
        bus(i).Ir_abcn_sch(4) = -(bus(i).Ir_abcn_sch(1) + bus(i).Ir_abcn_sch(2) + bus(i).Ir_abcn_sch(3));
        
        bus(i).Im_abcn_sch(1) = (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2)) *(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3)) *(real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))) / (((real(bus(i).Vabcn(1)-bus(i).Vabcn(4))).^2) + ((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))).^2));
        bus(i).Im_abcn_sch(2) = (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2)) *(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3)) *(real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))) / (((real(bus(i).Vabcn(2)-bus(i).Vabcn(4))).^2) + ((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))).^2));
        bus(i).Im_abcn_sch(3) = (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2)) *(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3)) *(real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))) / (((real(bus(i).Vabcn(3)-bus(i).Vabcn(4))).^2) + ((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))).^2));
        bus(i).Im_abcn_sch(4) = -(bus(i).Im_abcn_sch(1) + bus(i).Im_abcn_sch(2) + bus(i).Im_abcn_sch(3));
        
        %%%
        
        bus(i).Ir_abcn_calc(1) = (Gbus(4*i-3,4*i-3)*real(bus(i).Vabcn(1)) - Bbus(4*i-3,4*i-3)*imag(bus(i).Vabcn(1))) + (Gbus(4*i-3,4*i-2)*real(bus(i).Vabcn(2)) - Bbus(4*i-3,4*i-2)*imag(bus(i).Vabcn(2))) + (Gbus(4*i-3,4*i-1)*real(bus(i).Vabcn(3)) - Bbus(4*i-3,4*i-1)*imag(bus(i).Vabcn(3))) + (Gbus(4*i-3,4*i)*real(bus(i).Vabcn(4)) - Bbus(4*i-3,4*i)*imag(bus(i).Vabcn(4)));
        bus(i).Ir_abcn_calc(2) = (Gbus(4*i-2,4*i-3)*real(bus(i).Vabcn(1)) - Bbus(4*i-2,4*i-3)*imag(bus(i).Vabcn(1))) + (Gbus(4*i-2,4*i-2)*real(bus(i).Vabcn(2)) - Bbus(4*i-2,4*i-2)*imag(bus(i).Vabcn(2))) + (Gbus(4*i-2,4*i-1)*real(bus(i).Vabcn(3)) - Bbus(4*i-2,4*i-1)*imag(bus(i).Vabcn(3))) + (Gbus(4*i-2,4*i)*real(bus(i).Vabcn(4)) - Bbus(4*i-2,4*i)*imag(bus(i).Vabcn(4)));
        bus(i).Ir_abcn_calc(3) = (Gbus(4*i-1,4*i-3)*real(bus(i).Vabcn(1)) - Bbus(4*i-1,4*i-3)*imag(bus(i).Vabcn(1))) + (Gbus(4*i-1,4*i-2)*real(bus(i).Vabcn(2)) - Bbus(4*i-1,4*i-2)*imag(bus(i).Vabcn(2))) + (Gbus(4*i-1,4*i-1)*real(bus(i).Vabcn(3)) - Bbus(4*i-1,4*i-1)*imag(bus(i).Vabcn(3))) + (Gbus(4*i-1,4*i)*real(bus(i).Vabcn(4)) - Bbus(4*i-1,4*i)*imag(bus(i).Vabcn(4)));
        bus(i).Ir_abcn_calc(4) = (Gbus(4*i,4*i-3)*real(bus(i).Vabcn(1)) - Bbus(4*i,4*i-3)*imag(bus(i).Vabcn(1))) + (Gbus(4*i,4*i-2)*real(bus(i).Vabcn(2)) - Bbus(4*i,4*i-2)*imag(bus(i).Vabcn(2))) + (Gbus(4*i,4*i-1)*real(bus(i).Vabcn(3)) - Bbus(4*i,4*i-1)*imag(bus(i).Vabcn(3))) + (Gbus(4*i,4*i)*real(bus(i).Vabcn(4)) - Bbus(4*i,4*i)*imag(bus(i).Vabcn(4)));
        
        for k=1:length(connected_buses)
            
            j=connected_buses(k);
            bus(i).Ir_abcn_calc(1) = bus(i).Ir_abcn_calc(1) + (Gbus(4*i-3,4*j-3)*real(bus(j).Vabcn(1)) - Bbus(4*i-3,4*j-3)*imag(bus(j).Vabcn(1))) + (Gbus(4*i-3,4*j-2)*real(bus(j).Vabcn(2)) - Bbus(4*i-3,4*j-2)*imag(bus(j).Vabcn(2))) + (Gbus(4*i-3,4*j-1)*real(bus(j).Vabcn(3)) - Bbus(4*i-3,4*j-1)*imag(bus(j).Vabcn(3))) + (Gbus(4*i-3,4*j)*real(bus(j).Vabcn(4)) - Bbus(4*i-3,4*j)*imag(bus(j).Vabcn(4)));
            bus(i).Ir_abcn_calc(2) = bus(i).Ir_abcn_calc(2) + (Gbus(4*i-2,4*j-3)*real(bus(j).Vabcn(1)) - Bbus(4*i-2,4*j-3)*imag(bus(j).Vabcn(1))) + (Gbus(4*i-2,4*j-2)*real(bus(j).Vabcn(2)) - Bbus(4*i-2,4*j-2)*imag(bus(j).Vabcn(2))) + (Gbus(4*i-2,4*j-1)*real(bus(j).Vabcn(3)) - Bbus(4*i-2,4*j-1)*imag(bus(j).Vabcn(3))) + (Gbus(4*i-2,4*j)*real(bus(j).Vabcn(4)) - Bbus(4*i-2,4*j)*imag(bus(j).Vabcn(4)));
            bus(i).Ir_abcn_calc(3) = bus(i).Ir_abcn_calc(3) + (Gbus(4*i-1,4*j-3)*real(bus(j).Vabcn(1)) - Bbus(4*i-1,4*j-3)*imag(bus(j).Vabcn(1))) + (Gbus(4*i-1,4*j-2)*real(bus(j).Vabcn(2)) - Bbus(4*i-1,4*j-2)*imag(bus(j).Vabcn(2))) + (Gbus(4*i-1,4*j-1)*real(bus(j).Vabcn(3)) - Bbus(4*i-1,4*j-1)*imag(bus(j).Vabcn(3))) + (Gbus(4*i-1,4*j)*real(bus(j).Vabcn(4)) - Bbus(4*i-1,4*j)*imag(bus(j).Vabcn(4)));
            bus(i).Ir_abcn_calc(4) = bus(i).Ir_abcn_calc(4) + (Gbus(4*i,4*j-3)*real(bus(j).Vabcn(1)) - Bbus(4*i,4*j-3)*imag(bus(j).Vabcn(1))) + (Gbus(4*i,4*j-2)*real(bus(j).Vabcn(2)) - Bbus(4*i,4*j-2)*imag(bus(j).Vabcn(2))) + (Gbus(4*i,4*j-1)*real(bus(j).Vabcn(3)) - Bbus(4*i,4*j-1)*imag(bus(j).Vabcn(3))) + (Gbus(4*i,4*j)*real(bus(j).Vabcn(4)) - Bbus(4*i,4*j)*imag(bus(j).Vabcn(4)));
        end
        
        bus(i).Im_abcn_calc(1) = (Bbus(4*i-3,4*i-3)*real(bus(i).Vabcn(1)) + Gbus(4*i-3,4*i-3)*imag(bus(i).Vabcn(1))) + (Bbus(4*i-3,4*i-2)*real(bus(i).Vabcn(2)) + Gbus(4*i-3,4*i-2)*imag(bus(i).Vabcn(2))) + (Bbus(4*i-3,4*i-1)*real(bus(i).Vabcn(3)) + Gbus(4*i-3,4*i-1)*imag(bus(i).Vabcn(3))) + (Bbus(4*i-3,4*i)*real(bus(i).Vabcn(4)) + Gbus(4*i-3,4*i)*imag(bus(i).Vabcn(4)));
        bus(i).Im_abcn_calc(2) = (Bbus(4*i-2,4*i-3)*real(bus(i).Vabcn(1)) + Gbus(4*i-2,4*i-3)*imag(bus(i).Vabcn(1))) + (Bbus(4*i-2,4*i-2)*real(bus(i).Vabcn(2)) + Gbus(4*i-2,4*i-2)*imag(bus(i).Vabcn(2))) + (Bbus(4*i-2,4*i-1)*real(bus(i).Vabcn(3)) + Gbus(4*i-2,4*i-1)*imag(bus(i).Vabcn(3))) + (Bbus(4*i-2,4*i)*real(bus(i).Vabcn(4)) + Gbus(4*i-2,4*i)*imag(bus(i).Vabcn(4)));
        bus(i).Im_abcn_calc(3) = (Bbus(4*i-1,4*i-3)*real(bus(i).Vabcn(1)) + Gbus(4*i-1,4*i-3)*imag(bus(i).Vabcn(1))) + (Bbus(4*i-1,4*i-2)*real(bus(i).Vabcn(2)) + Gbus(4*i-1,4*i-2)*imag(bus(i).Vabcn(2))) + (Bbus(4*i-1,4*i-1)*real(bus(i).Vabcn(3)) + Gbus(4*i-1,4*i-1)*imag(bus(i).Vabcn(3))) + (Bbus(4*i-1,4*i)*real(bus(i).Vabcn(4)) + Gbus(4*i-1,4*i)*imag(bus(i).Vabcn(4)));
        bus(i).Im_abcn_calc(4) = (Bbus(4*i,4*i-3)*real(bus(i).Vabcn(1)) + Gbus(4*i,4*i-3)*imag(bus(i).Vabcn(1))) + (Bbus(4*i,4*i-2)*real(bus(i).Vabcn(2)) + Gbus(4*i,4*i-2)*imag(bus(i).Vabcn(2))) + (Bbus(4*i,4*i-1)*real(bus(i).Vabcn(3)) + Gbus(4*i,4*i-1)*imag(bus(i).Vabcn(3))) + (Bbus(4*i,4*i)*real(bus(i).Vabcn(4)) + Gbus(4*i,4*i)*imag(bus(i).Vabcn(4)));
        
        for k=1:length(connected_buses)
            
            j=connected_buses(k);
            bus(i).Im_abcn_calc(1) = bus(i).Im_abcn_calc(1) + (Bbus(4*i-3,4*j-3)*real(bus(j).Vabcn(1)) + Gbus(4*i-3,4*j-3)*imag(bus(j).Vabcn(1))) + (Bbus(4*i-3,4*j-2)*real(bus(j).Vabcn(2)) + Gbus(4*i-3,4*j-2)*imag(bus(j).Vabcn(2))) + (Bbus(4*i-3,4*j-1)*real(bus(j).Vabcn(3)) + Gbus(4*i-3,4*j-1)*imag(bus(j).Vabcn(3))) + (Bbus(4*i-3,4*j)*real(bus(j).Vabcn(4)) + Gbus(4*i-3,4*j)*imag(bus(j).Vabcn(4)));
            bus(i).Im_abcn_calc(2) = bus(i).Im_abcn_calc(2) + (Bbus(4*i-2,4*j-3)*real(bus(j).Vabcn(1)) + Gbus(4*i-2,4*j-3)*imag(bus(j).Vabcn(1))) + (Bbus(4*i-2,4*j-2)*real(bus(j).Vabcn(2)) + Gbus(4*i-2,4*j-2)*imag(bus(j).Vabcn(2))) + (Bbus(4*i-2,4*j-1)*real(bus(j).Vabcn(3)) + Gbus(4*i-2,4*j-1)*imag(bus(j).Vabcn(3))) + (Bbus(4*i-2,4*j)*real(bus(j).Vabcn(4)) + Gbus(4*i-2,4*j)*imag(bus(j).Vabcn(4)));
            bus(i).Im_abcn_calc(3) = bus(i).Im_abcn_calc(3) + (Bbus(4*i-1,4*j-3)*real(bus(j).Vabcn(1)) + Gbus(4*i-1,4*j-3)*imag(bus(j).Vabcn(1))) + (Bbus(4*i-1,4*j-2)*real(bus(j).Vabcn(2)) + Gbus(4*i-1,4*j-2)*imag(bus(j).Vabcn(2))) + (Bbus(4*i-1,4*j-1)*real(bus(j).Vabcn(3)) + Gbus(4*i-1,4*j-1)*imag(bus(j).Vabcn(3))) + (Bbus(4*i-1,4*j)*real(bus(j).Vabcn(4)) + Gbus(4*i-1,4*j)*imag(bus(j).Vabcn(4)));
            bus(i).Im_abcn_calc(4) = bus(i).Im_abcn_calc(4) + (Bbus(4*i,4*j-3)*real(bus(j).Vabcn(1)) + Gbus(4*i,4*j-3)*imag(bus(j).Vabcn(1))) + (Bbus(4*i,4*j-2)*real(bus(j).Vabcn(2)) + Gbus(4*i,4*j-2)*imag(bus(j).Vabcn(2))) + (Bbus(4*i,4*j-1)*real(bus(j).Vabcn(3)) + Gbus(4*i,4*j-1)*imag(bus(j).Vabcn(3))) + (Bbus(4*i,4*j)*real(bus(j).Vabcn(4)) + Gbus(4*i,4*j)*imag(bus(j).Vabcn(4)));
        end
        %%%
        bus(i).delta_Ir_abcn(1) = bus(i).Ir_abcn_sch(1) - bus(i).Ir_abcn_calc(1);
        bus(i).delta_Ir_abcn(2) = bus(i).Ir_abcn_sch(2) - bus(i).Ir_abcn_calc(2);
        bus(i).delta_Ir_abcn(3) = bus(i).Ir_abcn_sch(3) - bus(i).Ir_abcn_calc(3);
        bus(i).delta_Ir_abcn(4) = bus(i).Ir_abcn_sch(4) - bus(i).Ir_abcn_calc(4);
        
        bus(i).delta_Im_abcn(1) = bus(i).Im_abcn_sch(1) - bus(i).Im_abcn_calc(1);
        bus(i).delta_Im_abcn(2) = bus(i).Im_abcn_sch(2) - bus(i).Im_abcn_calc(2);
        bus(i).delta_Im_abcn(3) = bus(i).Im_abcn_sch(3) - bus(i).Im_abcn_calc(3);
        bus(i).delta_Im_abcn(4) = bus(i).Im_abcn_sch(4) - bus(i).Im_abcn_calc(4);
    end
    %%% Jacobian matrix
    %
    for i=2:length(bus_data(:,1))
        for j=2:length(bus_data(:,1))
            Jac_mat2{i,j}=zeros(8,8);
        end
    end
    
    for i=2:length(bus_data(:,1))
        
        if bus_data(i,4)==1
            
            ea= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) -2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^2);
            eb= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) -2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^2);
            ec= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) -2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^2);
            
            fa= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) + 2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^2);
            fb= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) + 2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^2);
            fc= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) + 2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^2);
            
            ga= (-sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) - 2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^2);
            gb= (-sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) - 2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^2);
            gc= (-sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) - 2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^2);
            
            ha= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2) -2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^2);
            hb= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2) -2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^2);
            hc= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2) -2*sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^2);
            
            
        elseif bus_data(i,4)==2
            
            ea= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^(3/2));
            eb= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^(3/2));
            ec= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))) + sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^(3/2));
            
            fa= (-sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^(3/2));
            fb= (-sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^(3/2));
            fc= (-sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^(3/2));
            
            ga= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^(3/2));
            gb= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^(3/2));
            gc= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^(3/2));
            
            ha= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2))*(imag(bus(i).Vabcn(1)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(1)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3))*((imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(1)-bus(i).Vabcn(4)))^2)^(3/2));
            hb= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2))*(imag(bus(i).Vabcn(2)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(2)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3))*((imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(2)-bus(i).Vabcn(4)))^2)^(3/2));
            hc= (sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2))*(imag(bus(i).Vabcn(3)-bus(i).Vabcn(4))) * (real(bus(i).Vabcn(3)-bus(i).Vabcn(4))) - sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3))*((imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2))/(((real(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2 + (imag(bus(i).Vabcn(3)-bus(i).Vabcn(4)))^2)^(3/2));
            
                 
        elseif bus_data(i,4)==3
            
            ea= sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3));
            eb= sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3));
            ec= sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3));
            
            fa= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2));
            fb= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2));
            fc= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2));
            
            ga= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),2));
            gb= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),2));
            gc= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),2));
            
            ha= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==1)),3));
            hb= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==2)),3));
            hc= -sum(load_pu(find((load_pu(:,1)==i) & (load_pu(:,4)==3)),3));
            
            
        end
        Jac_mat2{i,i} =[-ga 0   0   ga          -ha 0   0   ha
                         0   -gb 0   gb          0   -hb 0   hb
                         0   0   -gc gc          0   0   -hc hc
                         ga  gb  gc  -ga-gb-gc   ha  hb  hc  -ha-hb-hc
                         -ea 0   0   ea          -fa 0   0   fa
                         0   -eb 0   eb          0   -fb 0   fb
                         0   0   -ec ec          0   0   -fc fc
                         ea  eb  ec  -ea-eb-ec  fa  fb  fc  -fa-fb-fc
            ];
        
    end
    
    Jacobian = cell2mat(Jac_mat1) + cell2mat(Jac_mat2);
    %%
    delta_I=[];
    for i=2:length(bus_data(:,1))
        delta_I = [delta_I ; bus(i).delta_Ir_abcn.' ; bus(i).delta_Im_abcn.' ];
    end
    delta_V_mat = pinv(Jacobian) * delta_I;
    %%
    for n=1:(length(bus_data(:,1))-1)
        bus(n+1).Vabcn_r_new = real(bus(n+1).Vabcn) + delta_V_mat(8*n-7:8*n-4);
        bus(n+1).Vabcn_i_new = imag(bus(n+1).Vabcn) + delta_V_mat(8*n-3:8*n);
        bus(n+1).Vabcn_new = bus(n+1).Vabcn_r_new + 1j*bus(n+1).Vabcn_i_new;
        bus(n+1).Vabcn = bus(n+1).Vabcn_new;
    end
    
    if all(abs(delta_V_mat)<1e-4)==1
        break;
    end
end
%toc
%%
bus_V=[0,0,0,0;0,0,0,0];
for i=1:length(bus)
    bus_V(i,:)=(bus(i).Vabcn);
end
abs(bus_V);
%%
% branch_list = [Line_data(:,1), Line_data(:,2), 0.000189394.*Line_data(:,3).*(Line_data(:,4)+1j*Line_data(:,5)), zeros(length(Line_data(:,1)),1)];
% % for i=1:length(branch_list(:,1))
% %     a = find(bus_data(:,1)==branch_list(i,1));
% %     branch_list(i,4) = bus_data(a,1); 
% % end
% loss = 0;
% delta_V0 = zeros(1,4*length(branch_list(:,1)));
% dummy2 = bus_data(:,1);
% Nn = length(dummy2);
% Nb = size(branch_list,1);
% for i=1:Nb
%     ind1 = find(dummy2 == branch_list(i,1));
%     ind2 = find(dummy2 == branch_list(i,2));
%        % if branch_list(i,4)==1
%             delta_V0(4*i-3:4*i) = 1000*BasekVmv* (bus_V(ind1,:)- bus_V(ind2,:));
%         %elseif branch_list(i,4)==2
%        %     delta_V0(4*i-3:4*i) = 1000*BasekVlv* (bus_V(4*ind1-3:4*ind1)- bus_V(4*ind2-3:4*ind2));
%         %end
% end
% 
% R1=reshape(repmat(branch_list(:,3).',4,1),4*length(branch_list(:,3)),1);
% loss = sum(real(conj(((delta_V0) *inv(diag(R1))).') .* delta_V0.'));
% 
