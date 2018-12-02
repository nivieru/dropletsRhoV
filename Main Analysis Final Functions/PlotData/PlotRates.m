%%%% Maya Malik Garbi - last modified 25/10/17

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Main Data figures\';
save_to_file=[FileName,'rates rambam4_1 and rambam5\'];
mkdir(save_to_file)

AverageRates=struct;
AverageRates(1).name='Buffer';
AverageRates(1).color=[128/255 128/255 128/255];
AverageRates(1).typeOfExp=37;

AverageRates(2).name='mDia';
AverageRates(2).color=[1 0 1];
AverageRates(2).typeOfExp=60;

AverageRates(3).name='ActA';
AverageRates(3).color=[1 0 0];
AverageRates(3).typeOfExp=40;

AverageRates(4).name='CCA';
AverageRates(4).color=[0 1 0];
AverageRates(4).typeOfExp=38;

AverageRates(5).name='Fascin';
AverageRates(5).color=[103/255 37/255 119/255];
AverageRates(5).typeOfExp=59;

AverageRates(6).name='10uM Alfa Actinin';
AverageRates(6).color=[0 0 1];
AverageRates(6).typeOfExp=58;

AverageRates(7).name='5uM Alfa Actinin';
AverageRates(7).color=[0 1 1];
AverageRates(7).typeOfExp=57;

AverageRates(8).name='Srv2 Abp1';
AverageRates(8).color=[0 153/255 0];
AverageRates(8).typeOfExp=135;

AverageRates(9).name='Coronin';
AverageRates(9).color=[0 0 0];
AverageRates(9).typeOfExp=135;

AverageRates(10).name='Aip1';
AverageRates(10).color=[1 1 0];
AverageRates(10).typeOfExp=61;

AverageRates(11).name='0_75uM ActA';
AverageRates(11).color=[1 153/255 0];
AverageRates(11).typeOfExp=69;

AverageRates(12).name='ActA GMF';
AverageRates(12).color=[204/255 102/255 0];
AverageRates(12).typeOfExp=70;

AverageRates(13).name='CCA and Tpm3_1';
AverageRates(13).color=[0 153/255 51/255];
AverageRates(13).typeOfExp=67;

AverageRates(14).name='CCA PFN';
AverageRates(14).color=[0 51/255 0];
AverageRates(14).typeOfExp=66;

AverageRates(15).name='Buffer rambam4_1';
AverageRates(15).color=[77/255 77/255 77/255];
AverageRates(15).typeOfExp=16;

AverageRates(16).name='Cofilin';
AverageRates(16).color=[1 153/255 1];
AverageRates(16).typeOfExp=214;

AverageRates(17).name='CP'; %%% 2uM CP
AverageRates(17).color=[102/255 0 1];
AverageRates(17).typeOfExp=18;


% %%% For ActA Data
% save_to_file=[FileName,'rates ActA\'];
% mkdir(save_to_file)
% 
% AverageRates(1).name='Buffer rambam4_1';
% AverageRates(1).color=[128/255 128/255 128/255];
% AverageRates(2).name='0_1uM ActA';
% AverageRates(2).color=[1 0 1] ; %%% megenta
% 
% AverageRates(3).name='0_3uM ActA';
% AverageRates(3).color=[0 0 1]; %%% blue
% 
% AverageRates(4).name='0_5uM ActA';
% AverageRates(4).color=[1 153/255 0]; %%% Orange
% 
% AverageRates(5).name='0_7uM ActA';
% AverageRates(5).color=[0 1 0]; %%% Green
% 
% AverageRates(6).name='1uM ActA';
% AverageRates(6).color=[0 1 1]; %%% cayn
% 
% AverageRates(7).name='1_5uM ActA';
% AverageRates(7).color=[1 0 0]; %%% red


% for i=2:7
for i=2:length(AverageRates)
    
AvgValuesV=importdata(fullfile(FileName,AverageRates(i).name,'\All V\','AverageValues.mat'));
AvgValuesRho=importdata(fullfile(FileName,AverageRates(i).name,'\AverageValues.mat'));

AverageRates(i).slopeV=AvgValuesV(2).SlopeVrVSr;
AverageRates(i).slopeDivJ=AvgValuesRho(2).SlopeDivJ;

end

%%% For buffer conditions
AvgValuesV=importdata(fullfile(FileName,AverageRates(2).name,'\All V\','AverageValues.mat'));
AvgValuesRho=importdata(fullfile(FileName,AverageRates(2).name,'\AverageValues.mat'));

AverageRates(1).slopeV=AvgValuesV(1).SlopeVrVSr;
AverageRates(1).slopeDivJ=AvgValuesRho(1).SlopeDivJ;

AvgValuesV=importdata(fullfile(FileName,AverageRates(15).name,'\All V\','AverageValues.mat'));
AvgValuesRho=importdata(fullfile(FileName,AverageRates(15).name,'\AverageValues.mat'));

AverageRates(16).slopeV=AvgValuesV(1).SlopeVrVSr;
AverageRates(16).slopeDivJ=AvgValuesRho(1).SlopeDivJ;


h=figure(1)

% for i=1:7
    for i=1:13
h(i)=plot(abs(1/AverageRates(i).slopeDivJ),abs(1/AverageRates(i).slopeV),'*','Color',AverageRates(i).color,'LineWidth',3)
hold on
end

legend(h,[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name},{AverageRates(7).name},{AverageRates(8).name}])
hold on
box off
ax=gca;
set(ax,'FontSize',8)
% set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])

xlabel('Actin turnover time[min]','FontSize',10)
ylabel('Contraction time[min]','FontSize',10)

savefig(fullfile(save_to_file,'\contraction vs turnover.fig'));
saveas(figure (1),fullfile(save_to_file,'\contraction vs turnover.tif'));
saveas(figure (1),[save_to_file,'\contraction vs turnover'],'epsc');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AllDataRates=struct;
DROPSforRho=importdata(fullfile(FileName,AverageRates(2).name,'\DROPSforRho.mat'));
% numberOfBufferDrops=15;
 numberOfBufferDrops=5;

for k=1:numberOfBufferDrops

AllDataRates(k).xslxIndex=DROPSforRho(k).xslxIndex;
AllDataRates(k).typeOfExp=DROPSforRho(k).typeOfExp;
AllDataRates(k).typeOfExpString=DROPSforRho(k).typeOfExpString;
%AllDataRates(k).Color=DROPSforRho(k).Color;
AllDataRates(k).Color=AverageRates(1).color;
AllDataRates(k).DropSize=DROPSforRho(k).DropSize;

AllDataRates(k).TurnoverRate=-DROPSforRho(k).TurnoverRate;
AllDataRates(k).TurnoverTime=-1/DROPSforRho(k).TurnoverRate;

AllDataRates(k).ContractionRate=-DROPSforRho(k).ContractionRate;
AllDataRates(k).ContractionTime=-1/DROPSforRho(k).ContractionRate;

end

AverageRates(1).AvgContractionRate=mean([AllDataRates(1:numberOfBufferDrops).ContractionRate]);
AverageRates(1).STDContractionRate=std([AllDataRates(1:numberOfBufferDrops).ContractionRate]);

AverageRates(1).AvgTurnoverRate=mean([AllDataRates(1:numberOfBufferDrops).TurnoverRate]);
AverageRates(1).STDTurnoverRate=std([AllDataRates(1:numberOfBufferDrops).TurnoverRate]);

AverageRates(1).AvgContractionTime=std([AllDataRates(1:numberOfBufferDrops).ContractionTime]);
AverageRates(1).STDContractionTime=std([AllDataRates(1:numberOfBufferDrops).ContractionTime]);

AverageRates(1).AvgTurnoverTime=std([AllDataRates(1:numberOfBufferDrops).TurnoverTime]);
AverageRates(1).STDTurnoverTime=std([AllDataRates(1:numberOfBufferDrops).TurnoverTime]);



% n=6;
 n=numberOfBufferDrops+1;
 for i=2:13
%for i=2:7
    
DROPSforRho=importdata(fullfile(FileName,AverageRates(i).name,'\DROPSforRho.mat'));
 t=n;
% for k=6:length(DROPSforRho)
for k=(numberOfBufferDrops+1):length(DROPSforRho)
    
AllDataRates(n).xslxIndex=DROPSforRho(k).xslxIndex;
AllDataRates(n).typeOfExp=DROPSforRho(k).typeOfExp;
AllDataRates(n).typeOfExpString=DROPSforRho(k).typeOfExpString;
%AllDataRates(n).Color=DROPSforRho(k).Color;
AllDataRates(n).Color=AverageRates(i).color;

AllDataRates(n).DropSize=DROPSforRho(k).DropSize;

AllDataRates(n).TurnoverRate=-DROPSforRho(k).TurnoverRate;
AllDataRates(n).TurnoverTime=-1/DROPSforRho(k).TurnoverRate;

AllDataRates(n).ContractionRate=-DROPSforRho(k).ContractionRate;
AllDataRates(n).ContractionTime=-1/DROPSforRho(k).ContractionRate;

n=n+1;

end


AverageRates(i).AvgContractionRate=mean([AllDataRates(t:n-1).ContractionRate]);
AverageRates(i).STDContractionRate=std([AllDataRates(t:n-1).ContractionRate]);

AverageRates(i).AvgTurnoverRate=mean([AllDataRates(t:n-1).TurnoverRate]);
AverageRates(i).STDTurnoverRate=std([AllDataRates(t:n-1).TurnoverRate]);

AverageRates(i).AvgContractionTime=std([AllDataRates(t:n-1).ContractionTime]);
AverageRates(i).STDContractionTime=std([AllDataRates(t:n-1).ContractionTime]);

AverageRates(i).AvgTurnoverTime=std([AllDataRates(t:n-1).TurnoverTime]);
AverageRates(i).STDTurnoverTime=std([AllDataRates(t:n-1).TurnoverTime]);
 end


 
%%% for rambam4-1 data


DROPSforRho=importdata(fullfile(FileName,AverageRates(14).name,'\DROPSforRho.mat'));
 numberOfBufferDrops=15;
% numberOfBufferDrops=5;
n=n-1;
for k=1:numberOfBufferDrops

AllDataRates(n+k).xslxIndex=DROPSforRho(k).xslxIndex;
AllDataRates(n+k).typeOfExp=DROPSforRho(k).typeOfExp;
AllDataRates(n+k).typeOfExpString=DROPSforRho(k).typeOfExpString;
%AllDataRates(k).Color=DROPSforRho(k).Color;
AllDataRates(n+k).Color=AverageRates(1).color;
AllDataRates(n+k).DropSize=DROPSforRho(k).DropSize;

AllDataRates(n+k).TurnoverRate=-DROPSforRho(k).TurnoverRate;
AllDataRates(n+k).TurnoverTime=-1/DROPSforRho(k).TurnoverRate;

AllDataRates(n+k).ContractionRate=-DROPSforRho(k).ContractionRate;
AllDataRates(n+k).ContractionTime=-1/DROPSforRho(k).ContractionRate;

end


AverageRates(14).AvgContractionRate=mean([AllDataRates((n+1):n+numberOfBufferDrops).ContractionRate]);
AverageRates(14).STDContractionRate=std([AllDataRates((n+1):n+numberOfBufferDrops).ContractionRate]);

AverageRates(14).AvgTurnoverRate=mean([AllDataRates((n+1):n+numberOfBufferDrops).TurnoverRate]);
AverageRates(14).STDTurnoverRate=std([AllDataRates((n+1):n+numberOfBufferDrops).TurnoverRate]);

AverageRates(14).AvgContractionTime=std([AllDataRates((n+1):n+numberOfBufferDrops).ContractionTime]);
AverageRates(14).STDContractionTime=std([AllDataRates((n+1):n+numberOfBufferDrops).ContractionTime]);

AverageRates(14).AvgTurnoverTime=std([AllDataRates((n+1):n+numberOfBufferDrops).TurnoverTime]);
AverageRates(14).STDTurnoverTime=std([AllDataRates((n+1):n+numberOfBufferDrops).TurnoverTime]);


 n=n+numberOfBufferDrops+1;
% n=6;
%  n=numberOfBufferDrops+1;

for i=15:16
%for i=2:7
    
DROPSforRho=importdata(fullfile(FileName,AverageRates(i).name,'\DROPSforRho.mat'));
 t=n;
% for k=6:length(DROPSforRho)
for k=(numberOfBufferDrops+1):length(DROPSforRho)
    
AllDataRates(n).xslxIndex=DROPSforRho(k).xslxIndex;
AllDataRates(n).typeOfExp=DROPSforRho(k).typeOfExp;
AllDataRates(n).typeOfExpString=DROPSforRho(k).typeOfExpString;
%AllDataRates(n).Color=DROPSforRho(k).Color;
AllDataRates(n).Color=AverageRates(i).color;

AllDataRates(n).DropSize=DROPSforRho(k).DropSize;

AllDataRates(n).TurnoverRate=-DROPSforRho(k).TurnoverRate;
AllDataRates(n).TurnoverTime=-1/DROPSforRho(k).TurnoverRate;

AllDataRates(n).ContractionRate=-DROPSforRho(k).ContractionRate;
AllDataRates(n).ContractionTime=-1/DROPSforRho(k).ContractionRate;

n=n+1;

end


AverageRates(i).AvgContractionRate=mean([AllDataRates(t:n-1).ContractionRate]);
AverageRates(i).STDContractionRate=std([AllDataRates(t:n-1).ContractionRate]);

AverageRates(i).AvgTurnoverRate=mean([AllDataRates(t:n-1).TurnoverRate]);
AverageRates(i).STDTurnoverRate=std([AllDataRates(t:n-1).TurnoverRate]);

AverageRates(i).AvgContractionTime=std([AllDataRates(t:n-1).ContractionTime]);
AverageRates(i).STDContractionTime=std([AllDataRates(t:n-1).ContractionTime]);

AverageRates(i).AvgTurnoverTime=std([AllDataRates(t:n-1).TurnoverTime]);
AverageRates(i).STDTurnoverTime=std([AllDataRates(t:n-1).TurnoverTime]);



end

 
 
 
 
figure (1)
hold on

for i=1:length(AllDataRates)
    h(i)=plot(abs(1/AllDataRates(i).TurnoverRate),abs(1/AllDataRates(i).ContractionRate),'*','Color',AllDataRates(i).Color,'LineWidth',1)
hold on
end

legend([h(1),h(6),h(9),h(14),h(20),h(25),h(30),h(36),h(39),h(47),h(61),h(65),h(73),h(84),h(99),h(110)],[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name},{AverageRates(7).name},{AverageRates(8).name},{AverageRates(9).name},{AverageRates(10).name},...
    {AverageRates(11).name},{AverageRates(12).name},{AverageRates(13).name},{AverageRates(14).name},{AverageRates(15).name},{AverageRates(16).name}])

hold on
box off
ax=gca;
set(ax,'FontSize',8)
% set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])

xlabel('Actin turnover time[min]','FontSize',10)
ylabel('Contraction time[min]','FontSize',10)

figure (1)
for i=1:16
hold on   
% plot(abs(1/AverageRates(i).slopeDivJ),abs(1/AverageRates(i).slopeV),'*','Color',AverageRates(i).color,'LineWidth',3)
% hold on
meanTurnoverTime=AverageRates(i).AvgTurnoverTime;
meanContTime=AverageRates(i).AvgContractionTime;
stdTurnover=AverageRates(i).STDTurnoverTime;
stdContTime=AverageRates(i).STDContractionTime;

plot(meanTurnoverTime,meanContTime,'o','Color',AverageRates(i).color,'LineWidth',1)
hold on
errorbarxy(meanTurnoverTime,meanContTime,stdTurnover, stdContTime, stdTurnover, stdContTime,'k+' ,'k')
hold on
end


xlabel('Actin turnover time[min]','FontSize',10)
ylabel('Contraction time[min]','FontSize',10)


figure (1)
for i=1:16
hold on   
% plot(abs(1/AverageRates(i).slopeDivJ),abs(1/AverageRates(i).slopeV),'*','Color',AverageRates(i).color,'LineWidth',3)
% hold on
meanTurnoverRate=AverageRates(i).AvgTurnoverRate;
meanContRate=AverageRates(i).AvgContractionRate;
stdTurnoverRate=AverageRates(i).STDTurnoverRate;
stdContRate=AverageRates(i).STDContractionRate;

plot(meanTurnoverRate,meanContRate,'o','Color',AverageRates(i).color,'LineWidth',1)
hold on
errorbarxy(meanTurnoverRate,meanContRate,stdTurnoverRate, stdContRate, stdTurnoverRate, stdContRate,'k+' ,'k')
hold on
end



xlabel('Actin turnover rate[min]','FontSize',10)
ylabel('Contraction rate[min]','FontSize',10)


place=[1,2,4,5,8];
ContractionRate=[AverageRates(place).AvgContractionRate];  
ContractionTime=abs(1./ContractionRate);
TurnOverRate=[AverageRates(place).AvgTurnoverRate];  
TurnOverTime=abs(1./TurnOverRate);

p=polyfit(TurnOverTime,ContractionTime,1);
x=[0:0.1:3];
hold on
plot(x,p(1)*x,'LineWidth',1,'Color',[128/255 128/255 128/255])

savefig(fullfile(save_to_file,'\All data contraction vs turnover.fig'));
saveas(figure (1),fullfile(save_to_file,'\All data contraction vs turnover.tif'));
saveas(figure (1),[save_to_file,'\All data contraction vs turnover'],'epsc');




