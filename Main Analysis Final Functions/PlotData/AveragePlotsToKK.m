

%%%% plot the original average lines
figure
for i=1:length(AverageValues)
    plot(AverageValues(i).xval3,AverageValues(i).meany3,'Color',AverageValues(i).color,'LineWidth',1)
    hold on
end

%%%% plot average lines devided by slope
figure 
for i=1:length(AverageValues)
    AverageValues(i).devidedBySlope=AverageValues(i).meany3./(-AverageValues(i).p(1));
    plot(AverageValues(i).xval3,AverageValues(i).meany3./(-AverageValues(i).p(1)),'Color',AverageValues(i).color,'LineWidth',1)
    hold on
end

 
%%%% calculate  1/r^2*(d/dr)*(r^2*V)

figure 

for i=1:length(AverageValues)
r=AverageValues(i).xval3;
v=AverageValues(i).meany3;
remove=find(r<AverageValues(i).RatMaxRho);
r(remove)=[];
v(remove)=[];
temp=(r.^2).*v;
dy=diff(temp);
dx=diff(r);
DivV=((1./(r(1:(end-1))).^2)).*(dy./dx);
AverageValues(i).DivV=DivV;

AverageValues(i).LinearFitDivV=polyfit(r(1:end-1),DivV,1);
LinearFit=AverageValues(i).LinearFitDivV(1)*r+AverageValues(i).LinearFitDivV(2);
AverageValues(i).DivVvsRslope=AverageValues(i).LinearFitDivV(1);

plot(r(1:(end-1)),-AverageValues(i).DivV,'Color',AverageValues(i).color,'LineWidth',1)
hold on
end

    
    