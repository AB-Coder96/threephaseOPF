function Plotgen(path,parent,out)
Parentname=path{1,1};
path=path{1,2};
cd(path)
%% add libraries
addpath(['C:\Users\akarimi8\PhD\OPF' '\Simulation\Libraries\Library 2 (Figures 33)'])
addpath(['C:\Users\akarimi8\PhD\OPF' '\Simulation\Libraries\Output functions'])
%%
%%
matfiles = dir(fullfile(path, 'results3phase*'));
for i=1:length(matfiles)
    matfiles(i).main=load([matfiles(i).folder '/' matfiles(i).name]);
    matfiles(i).fullname=erase(matfiles(i).name,'.mat');
    matfiles(i).Snmehtod=erase(matfiles(i).fullname,'results3phase');
end

for i=1:length(out)
    assignin('base','out',out)
    outname=sprintf('%s',out(i));
    if  ~contains(out(i),'(')
eval(['runoutput' sprintf('%s',out(i)) '(matfiles,Parentname,outname);']);
    else
eval(['runoutput' sprintf('%s',out(i)) 'matfiles,Parentname,outname);']);
    end
end
%% remove path
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Library 2 (Figures 33)')
rmpath('D:\imbalance aleviation strategies\Simulation\Libraries\Output functions')
cd(parent)
close all
end