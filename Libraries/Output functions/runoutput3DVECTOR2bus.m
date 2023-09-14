function runoutput3DVECTOR2bus(structt,parentname,outname)
busbranch=1;
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
%% Data Read: Vector2 recognition 
% bus
if busbranch==1
   f=Str(1).j{1, 1}.bus;
else
   f=Str(1).j{1, 1}.branch;
end
   u=fieldnames(f);
   n=0;
   VECTOR{1}='a';
   for uu=1:length(u)
        assignin('base','f',f) 
        eval(['G=f.',u{uu,1},';'])
        assignin('base','G',G)            
        n=n+1;
        VECTOR{1,n}=u{uu,1};
        up=fieldnames(G);
        p=0;
        VECTORphase{1}='a';
        for upup=1:length(up)
        eval(['GG=G.',up{upup,1},';'])
        p=p+1;
        VECTORphase{1,p}=up{upup,1};
        end
        VECTOR{2,n}=VECTORphase;
   end
%% 
for x=1:length(VECTOR)  
   eval(['ff=f.' VECTOR{1,x} ';'])
   bus{x}=length(eval(['ff.' VECTOR{2, x}{1, 1}]));
end
%% phaseVECTORMethod
for x=1:length(VECTOR)
    for phi=1:length(VECTOR{2,x})
           scc=[VECTOR{1,x}];
           s=figure('Name',scc,'NumberTitle','off','visible','off');
           eval([scc VECTOR{2, x}{1, phi} '=s;'])
           ax=axes('Parent',gcf,'NextPlot','add');
           color=preferedcolors;
           for m=1:method
               v=zeros(time,bus{x});
               for b=1:bus{x}
                  for t=1:time
                      if busbranch==1;
                      eval(['v(t,b)=structt(m).main.' structt(m).fullname '{1, t}.bus.' scc '.' VECTOR{2, x}{1, phi} '(b,1);']) 
                      else
                      eval(['v(t,b)=structt(m).main.' structt(m).fullname '{1, t}.branch.' scc '.' VECTOR{2, x}{1, phi} '(b,1);'])    
                      end
                  end
               end
            [t b]=meshgrid(1:time,1:bus{x});
            Z=v(t,b)
            surf(t,b,v','Parent',ax,'DisplayName',structt(m).Snmehtod,'LineWidth',2,'FaceColor',color{m})
            end
            legend
            title({[ parentname  ': ' scc VECTOR{2, x}{1, phi} ]},'LineWidth',1,'FontSize',12,'FontName','Times New Roman')
            set(ax,'FontName','Times New Roman','FontWeight','bold');
            view(ax,[69.6 13.1999999999999]);
            box(ax,'on');
            saveas(gcf,[scc VECTOR{2, x}{1, phi} '.emf'])
            saveas(gcf,[scc VECTOR{2, x}{1, phi} '.jpg'])
            savefig([scc VECTOR{2, x}{1, phi} '.fig'])
            for t=1:time
                       for m=1:method
                           v=zeros(method,bus{x});       
                           for b=1:bus{x}
                               eval(['v(m,b)=structt(m).main.' structt(m).fullname '{1, t}.bus.' scc '.' VECTOR{2, x}{1, phi} '(b,1);'])     
                               Header{m,1}=structt(m).Snmehtod;
                               Header{m,b+1}=v(m,b);
                           end
                       end
            xlswrite([scc VECTOR{2, x}{1, phi}],Header',t)
            end
    end
end
% %% MethodVECTORPhase
% for x=1:length(VECTOR)          
%     for m=1:method
%            scc=[VECTOR{1,x}];
%            s=figure('Name',scc,'NumberTitle','off');
%            eval([scc structt(m).fullname '=s;'])
%            ax=axes('Parent',gcf,'NextPlot','add');
%            color=preferedcolors;
%            for phi=1:length(VECTOR{2,x})
%                v=zeros(time,bus{x});
%                for b=1:bus{x}
%                   for t=1:time
%                       if busbranch==1;
%                       eval(['v(t,b)=structt(m).main.' structt(m).fullname '{1, t}.bus.' scc '.' VECTOR{2, x}{1, phi} '(b,1);']) 
%                       else
%                       eval(['v(t,b)=structt(m).main.' structt(m).fullname '{1, t}.bus.' scc '.' VECTOR{2, x}{1, phi} '(b,1);'])    
%                       end
%                   end
%                end
%             [t b]=meshgrid(1:time,1:bus{x});
%             Z=v(t,b)
%             surf(t,b,v','Parent',ax,'DisplayName',VECTOR{2, x}{1, phi},'LineWidth',2,'FaceColor',color{phi})
%             end
%             legend
%             title({[ parentname  ': ' scc structt(m).Snmehtod]},'LineWidth',1,'FontSize',12,'FontName','Times New Roman')
%             set(ax,'FontName','Times New Roman','FontWeight','bold');
%             view(ax,[69.6 13.1999999999999]);
%             box(ax,'on');
%             saveas(gcf,[scc structt(m).Snmehtod '.emf'])
%             savefig([scc structt(m).Snmehtod '.fig'])
%      end          
% end
end