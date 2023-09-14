clc
clear
close all
%define_constants;
pmain=cd;
%% Computer Install directory
mkdir('summary')
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Adding scenario %%%%%%%%%%%%%%%%%%%%%
[Scenar] = GetSubDirsFirstLevelOnly(pmain);
Scenar=Scenar';
for i=1:length(Scenar)
Scenar{i,1}=Scenar{i};
Scenar{i,2}=[pmain '\' Scenar{i}];
end
 for i=1:length(Scenar)
     if Scenar{i}=="summary"
         a=i;
     end
 end
 Scenar(a,:)=[];
 Scenario=Scenar;
save([cd '\Scenario.mat'],'Scenario')
xlswrite('Scenario',Scenario)