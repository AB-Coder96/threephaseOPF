function studyparent(opf)
load('Scenario.mat')
for i=1:size(Scenario,1)
study(Scenario(i,:),cd,opf)
end
end