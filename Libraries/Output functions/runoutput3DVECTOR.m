function runoutput3DVECTOR(structt,parentname,outname,Tindex,Tval)
mkdir(outname)
cd([cd '/' outname])
assignin('base','structt',structt)
%% creating name     
for i=1:length(structt)
A=structt(i).main;
eval(['A=A.' ,structt(i).fullname , ';'])
Str(i).j=A;
end
%% reading indexes
time=length(A);
method=length(structt);

%% Data Read: Vector recognition 
f=Str(1).j{1, 1}; 
u=fieldnames(f);
n=0;
VECTOR{1}='a';
for uu=1:length(u)
    eval(['G=f.',u{uu,1},';'])
            
    if  isa(G,'double') && ~isscalar(G)
        %u{uu,1}
        n=n+1;
VECTOR{n}=u{uu,1};
    end
end

for x=1:length(VECTOR)
eval(['f=Str(1).j{1, 1}.' VECTOR{x} ';'])
bus{x}=length(f);
end
%% 3D
for x=1:length(VECTOR)
    sc=VECTOR{x};
    s=figure('Name',sc,'NumberTitle','off','visible','off');
    eval([sc '=s;'])
    ax=axes('Parent',gcf,'NextPlot','add');
    color=preferedcolors;
    for m=1:method
       v=zeros(time,bus{x});       
       for b=1:bus{x}
            for t=1:time
                eval(['v(t,b)=structt(m).main.' structt(m).fullname '{1, t}.' sc '(b,1);']) 
            end
       end
     [t b]=meshgrid(1:time,1:bus{x});
     Z=v(t,b)
     surf(t,b,v','Parent',ax,'DisplayName',structt(m).Snmehtod,'LineWidth',2,'FaceColor',color{m})
    end
    legend
    title({[ parentname  ': ' sc]},'LineWidth',1,'FontSize',12,'FontName','Times New Roman')
    set(ax,'FontName','Times New Roman','FontWeight','bold');
    view(ax,[69.6 13.1999999999999]);
    box(ax,'on');
    saveas(gcf,[sc '.emf'])
    savefig([sc '.fig'])
    saveas(gcf,[sc '.jpg'])
    for t=1:time
       for m=1:method
       v=zeros(method,bus{x});       
          for b=1:bus{x}
                eval(['v(m,b)=structt(m).main.' structt(m).fullname '{1, t}.' sc '(b,1);'])     
                Header{m,1}=structt(m).Snmehtod;
                Header{m,b+1}=v(m,b);
          end
       end
      xlswrite([sc num2str(t)],Header',t)
    end
end

end