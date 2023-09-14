function runoutputSCALAR2(structt,parentname,outname)
mkdir(outname)
cd([cd '/' outname])
%% creating name     
for i=1:length(structt)
A=structt(i).main;
eval(['A=A.' ,structt(i).fullname , ';'])
Str(i).j=A;
end
%% reading indexes
time=length(A);
method=length(structt);
%% Data Read 
f=Str(1).j{1, 1}; 
u=fieldnames(f);
n=0;
scalar2{1}='a';
for uu=1:length(u)
    eval(['G=f.',u{uu,1},';'])
    if isscalar(G) && isstruct(G)
       scalar2{n+1}=u{uu,1};
    end
end
for x=1:length(scalar2)
eval(['f=Str(1).j{1, 1}.' scalar2{x} ';']) 
U{x}=fieldnames(f);
end
U{2}=fieldnames(f);

phase=length(U{1});
%U(1,x){phase,1}
%% Method * SCALARphase
for x=1:length(scalar2)
    sc=scalar2{x};
    for m=1:method
    s=figure('Name',sc,'NumberTitle','off');
    eval([structt(m).Snmehtod sc '=s;'])
    ax=axes('Parent',gcf,'NextPlot','add');
    for ph=1:phase
       phi=char(U{1,x}(ph,1));
       v=zeros(time,1);
       for t=1:time
       eval(['v(t,1)=structt(m).main.' structt(m).fullname '{1, t}.' sc '.' phi ';'])  
       end
       plot(1:time,v,'Parent',ax,'DisplayName',phi,'LineWidth',2)
      
    end
    legend
    title({[ parentname ': ' structt(m).Snmehtod ': ' sc]},'LineWidth',1,'FontSize',12,'FontName','Times New Roman')
    set(ax,'FontName','Times New Roman','FontWeight','bold');
    box(ax,'on');
    saveas(gcf,[sc structt(m).Snmehtod '.emf'])
    saveas(gcf,[sc structt(m).Snmehtod '.jpg'])
    savefig([sc structt(m).Snmehtod '.fig'])
    end
end
%% phase * SCALARmethod
for x=1:length(scalar2)
    sc=scalar2{x};
    for ph=1:phase
    s=figure('Name',sc,'NumberTitle','off');
    phi=char(U{1,x}(ph,1));
    eval([phi sc '=s;'])
    ax=axes('Parent',gcf,'NextPlot','add');
    for m=1:method
       v=zeros(time,1);
       for t=1:time
       eval(['v(t,1)=structt(m).main.' structt(m).fullname '{1, t}.' sc '.' phi ';'])  
       end
       plot(1:time,v,'Parent',ax,'DisplayName',structt(m).Snmehtod,'LineWidth',2)
      
    end
    legend
    title({[ parentname ': ' phi ': ' sc]},'LineWidth',1,'FontSize',12,'FontName','Times New Roman')
    set(ax,'FontName','Times New Roman','FontWeight','bold');
    box(ax,'on');
    saveas(gcf,[sc phi '.emf'])
    saveas(gcf,[sc phi '.jpg'])
    savefig([sc phi '.fig'])
    end
end
end