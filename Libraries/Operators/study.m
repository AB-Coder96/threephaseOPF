%% %%%%%%%%%%%%%%%%%%% Studies to Perform %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function study(path,parent,X)
%%
load('Scenario.mat');
cd(path{1,2})
Data=Scenario;
load('SN.mat');
%% add lib
addpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Optimal Power Flows')
addpath('C:\Users\akarimi8\OneDrive - Georgia Institute of Technology\OPF\Simulation\Libraries\Optimal Power Flows')
%% studes
for i=1:length(X)
    eval(['results3phase' sprintf('%s',X(i)) '=Runlinopf3' sprintf('%s',X(i)) '(SN);']);
eval(['results3phase' sprintf('%s',X(i)) ';']);
save([cd '\results3phase' sprintf('%s',X(i)) '.mat'],['results3phase' sprintf('%s',X(i))])
end
%% remove lib
rmpath('C:\Users\akarimi8\PhD\OPF\Simulation\Libraries\Optimal Power Flows')

%%
method=dir(fullfile(cd,'results3phase*'));

for s=1:length(method)
Method{s,1}=method(s).name;
Method{s,1}=erase(Method{s,1},'results3phase');
Method{s,1}=erase(Method{s,1},'.mat');
Method{s,2}=[parent '\summary\' Method{s,1}];
assignin('base','method',method)
end
%%
ch=[path{1,1}];
ch=erase(ch,'-');
%% back to parent
cd(parent)
mkdir('summary')
cd([parent '/summary'])
save([cd '\Method.mat'],'Method')
for i=1:length(X)
    chh=['results3phase' path{1,1}]; 
    chh=erase(chh,'-');
    eval([chh '=results3phase' sprintf('%s',X(i)) ';']);  
    mkdir([sprintf('%s',X(i))])
    save([cd '\' sprintf('%s',X(i)) '\' chh '.mat'],chh)
    save([cd '\' sprintf('%s',X(i)) '\Data.mat'],'Data')
end
cd(parent)
cd(path{1,2})
Data=Method;
save([cd '\Data.mat'],'Data')
cd(parent)
end