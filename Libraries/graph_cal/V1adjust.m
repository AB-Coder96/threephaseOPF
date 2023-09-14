function V=V1adjust(va,ta,vb,tb,vc,tc)
V=zeros(length(va),length(ta),length(vb),length(tb),length(vc),length(tc))
for i=1:length(va)
   for ii=1:length(ta)
      for j=1:length(vb)
         for jj=1:length(tb)
            for k=1:length(vc)
                for kk=1:length(tc)
                    V(i,ii,j,jj,k,kk)=V1new(i,ii,j,jj,k,kk);
                end
            end
         end
      end
    end
end
V=squeeze(V)
end