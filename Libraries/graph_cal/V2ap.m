function V2=V2ap(Va,da,Vb,db,Vc,dc)
V2=1000*(sum((Va-Vb).^2+(Va-Vc).^2+(Vc-Vb).^2+(da-db).^2+(da-dc).^2+(dc-db).^2));
end