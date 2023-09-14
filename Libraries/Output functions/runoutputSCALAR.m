function runoutputSCALAR(structt,parentname,outname)
mkdir(outname)
cd([cd '/' outname])
%% reading indexes     
for i=1:length(structt)
A=structt(i).main;
eval(['A=A.' ,structt(i).fullname , ';'])
Str(i).j=A;
end
%
time=length(A);
method=length(structt);     
f=Str(1).j{1,1};   
u=fieldnames(f);
n=0;
scalar{1}='a';
for uu=1:length(u)
    eval(['G=f.',u{uu,1},';'])
    if isscalar(G) && ~isstruct(G)
    n=n+1;    
       scalar{n}=u{uu,1};
    end
end
%% SCALARmethod
for x=1:length(scalar)
   sc=scalar{x};
   s=figure('Name',sc,'NumberTitle','off');
   eval([sc '=s;'])
   ax=axes('Parent',gcf,'NextPlot','add');
   for m=1:method
       v=zeros(time,1);
       for t=1:time
      eval(['v(t,1)=structt(m).main.' structt(m).fullname '{1, t}.' sc ';'])  
      assignin('base','v',v)
      end
      plot(1:time,v,'Parent',ax,'DisplayName',structt(m).Snmehtod,'LineWidth',2)
   end
   legend
   title([parentname ': ' sc],'LineWidth',1,'FontSize',12,'FontName','Times New Roman')
   set(ax,'FontName','Times New Roman','FontWeight','bold');
   box(ax,'on');
   saveas(gcf,[sc '.emf'])
   saveas(gcf,[sc '.jpg'])
   savefig([sc '.fig'])
   for t=1:time
      for m=1:method
          v=zeros(method,1);
          eval(['v(m,1)=structt(m).main.' structt(m).fullname '{1, t}.' sc ';'])  
          assignin('base','v',v)    
      Header{m,1}=structt(m).Snmehtod;
      Header{m,t+1}=v(m,1);
      end
      xlswrite(sc,Header',t)
   end
end
end