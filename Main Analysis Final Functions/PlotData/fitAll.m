function p = fitAll(Drops)
for i=1:numel(Drops)
    p(i,:) = polyfit(Drops(i).Rr , Drops(i).Vr ,1);
end