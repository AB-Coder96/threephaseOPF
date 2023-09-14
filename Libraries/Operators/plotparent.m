function plotparent(out)
load('Scenario.mat')
assignin('base','Scenario',Scenario)
for i=1:size(Scenario,1)
Plotgen(Scenario(i,:),cd,out)
end
parent=cd;
cd([cd '\summary'])
load('Method.mat')
assignin('base','Method',Method)
for i=1:size(Method)   
Plotgen(Method(i,:),cd,out)
end
cd(parent)
end