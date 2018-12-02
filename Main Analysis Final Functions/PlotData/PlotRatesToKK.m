
AllDataRates=importdata('');
AverageRates=importdata('');
Save_to_file='';

%% Plot contraction rate vs turnover rate

figure (1)
for i=1:length(AllDataRates)
    h(i)=plot(AllDataRates(i).TurnoverRate,AllDataRates(i).ContractionRate,'.','LineWidth',1,'Color',AllDataRates(i).Color,'LineWidth',1);
    hold on
end

% legend([h(1),h(16),h(20),h(25),h(28),h(34),h(36)],[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name}])
% legend([h(1),h(6),h(9),h(14),h(20),h(25),h(30),h(36),h(39),h(47),h(61),h(65),h(73),h(79),h(84),h(99),h(110)],[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name},{AverageRates(7).name},{AverageRates(8).name},{AverageRates(9).name},{AverageRates(10).name},...
%     {AverageRates(11).name},{AverageRates(12).name},{AverageRates(13).name},{AverageRates(14).name},{AverageRates(15).name},{AverageRates(16).name},{AverageRates(17).name}])

box off
ax=gca;
set(ax,'FontSize',8)
xlabel('Actin turnover rate[1/min]','FontSize',10)
ylabel('Contraction rate[1/min]','FontSize',10)

for i=1:length(AverageRates)
    hold on
%     plot(AverageRates(i).AvgTurnoverRate,AverageRates(i).AvgContractionRate,'o','Color',AverageRates(i).color,'LineWidth',1)
    errorbarxy(AverageRates(i).AvgTurnoverRate,AverageRates(i).AvgContractionRate,AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate, AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate,'k+','k')
% %     errorbarxy(AverageRates(i).AvgTurnoverRate,AverageRates(i).AvgContractionRate,AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate, AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate,'k+','k')

end

ylim([0, 1.7])

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 6 6])

pp(1)=AverageRates(1).AvgContractionRate/AverageRates(1).AvgTurnoverRate;
x=[0:0.1:3];
Linear=pp(1)*x;

hold on
plot(x,Linear,'--','Color','k')

savefig(fullfile(save_to_file,'\All data contraction rate vs turnover rate.fig'));
saveas(figure (1),fullfile(save_to_file,'\All data contraction rate vs turnover rate.tif'));
saveas(figure (1),[save_to_file,'\All data contraction rate vs turnover rate'],'epsc');

%% PLOT contraction rate vs ActA concentration

x=[0 0.1 0.5 0.7 1 1.5];
figure (2)
for i=1:length(AverageRates)
    hold on
     plot(x(i),AverageRates(i).AvgContractionRate/AverageRates(1).AvgContractionRate,'.','Color','k','LineWidth',1)
     errorbarxy(x(i),AverageRates(i).AvgContractionRate/AverageRates(1).AvgContractionRate,0, AverageRates(i).STDContractionRate, 0, AverageRates(i).STDContractionRate,'k+' ,'k')
 %       errorbarxy(x(i),AverageRates(i).AvgContractionRate,[], AverageRates(i).STDContractionRate,'k+' ,'k')

end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
xlim([-0.1 1.7])
ylim([0 1.2])
% xlim([0 12])

ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
% ax.YAxis.TickValues=[ 0 0.2 0.4 0.6 ];

%  ax.XAxis.TickValues=[ 2 4 6 8 10];

xlabel('Added ActA [\muM]','FontSize',10)
ylabel('Net contraction rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\contraction rate vs ActA cincetration.fig'));
saveas(figure (2),fullfile(save_to_file,'\contraction rate vs ActA cincetration.tif'));
saveas(figure (2),[save_to_file,'\contraction rate vs ActA cincetration'],'epsc');

%%% PLOT turnover rate vs ActA concetration

 x=[0 0.1 0.5 0.7 1 1.5];
%x=[2 4 6 8 10 ];
figure (4)
for i=1:length(AverageRates)
    hold on
     plot(x(i),AverageRates(i).AvgTurnoverRate/AverageRates(1).AvgTurnoverRate,'.','Color','k','LineWidth',1)
     errorbarxy(x(i),AverageRates(i).AvgTurnoverRate/AverageRates(1).AvgTurnoverRate,0, AverageRates(i).STDTurnoverRate, 0, AverageRates(i).STDTurnoverRate,'k+' ,'k')
 %       errorbarxy(x(i),AverageRates(i).AvgContractionRate,[], AverageRates(i).STDContractionRate,'k+' ,'k')

end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
set(gcf,'position',[7 7 5 4])

xlim([-0.1 1.7])
ylim([0 2])

 ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
% ax.XAxis.TickValues=[ 2 4 6 8 10];
% ax.YAxis.TickValues=[ 0 1 2 ];

xlabel('Added ActA [\muM]','FontSize',10)
ylabel('Net turnover rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\turnover rate vs ActA cincetration.fig'));
saveas(figure (4),fullfile(save_to_file,'\turnover rate vs ActA cincetration.tif'));
saveas(figure (4),[save_to_file,'\turnover rate vs ActA cincetration'],'epsc');


%% PLOTS FOT LONG TL
AllDataRates=[AllDataRates1,AllDataRates2,AllDataRates3,AllDataRates4,AllDataRates5,AllDataRates6];
AllDataRatesDrops{1}=AllDataRates1;
AllDataRatesDrops{2}=AllDataRates2;
AllDataRatesDrops{3}=AllDataRates3;
AllDataRatesDrops{4}=AllDataRates4;
AllDataRatesDrops{5}=AllDataRates5;
AllDataRatesDrops{6}=AllDataRates6;

for i=1:length(AllDataRates)
    AllDataRates=AllDataRatesDrops{i};
% close all
% x=5*[1:12];
 x=5*[1:11];

% x=50*ones(length(AllDataRates));

figure (2)
% for i=1:length(AllDataRates)

for i=2:length(x)
    hold on
%      plot(x(i),AllDataRates(i).ContractionRate/AllDataRates(2).ContractionRate,'+','Color','k','LineWidth',1)
     plot(x(i),AllDataRates(i).ContractionRate/AllDataRates(2).ContractionRate,'+','Color',AllDataRates(i).Color,'LineWidth',1)
          plot(x(i),AllDataRates(i).ContractionRate,'+','Color',AllDataRates(i).Color,'LineWidth',1)

     hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 1.7])
xlim([0 60])
ylim([0 2])
% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
% ax.YAxis.TickValues=[ 0 0.2 0.4 0.6 ];

 ax.XAxis.TickValues=[0:10:60];
%  ax.XAxis.TickValues=[0:10:30];

xlabel('Time [min]','FontSize',10)
ylabel('Contraction rate','FontSize',10)

% savefig(fullfile(save_to_file,'\contraction rate vs time.fig'));
% saveas(figure (2),fullfile(save_to_file,'\contraction rate vs time.tif'));
% saveas(figure (2),[save_to_file,'\contraction rate vs time'],'epsc');
% 


% x=[0 0.1 0.5 0.7 1 1.5];
% x=5*[1:11];
x=5*[1:11];
% hold on
% x=50*ones(length(AllDataRates));


figure (3)
% for i=1:length(AllDataRates)
    for i=2:length(x)
    hold on
%      plot(x(i),AllDataRates(i).TurnoverRate/AllDataRates(2).TurnoverRate,'+','Color','k','LineWidth',1)
%      plot(x(i),AllDataRates(i).TurnoverRate/AllDataRates(2).TurnoverRate,'+','Color',AllDataRates(i).Color,'LineWidth',1)
     plot(x(i),AllDataRates(i).TurnoverRate,'+','Color',AllDataRates(i).Color,'LineWidth',1)

     hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 5])
xlim([0 60])
ylim([0 2])

% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
  ax.XAxis.TickValues=[0:10:60];
%  ax.XAxis.TickValues=[0:10:30];

% ax.YAxis.TickValues=[ 0 1 2 ];

xlabel('Time [min]','FontSize',10)
ylabel('Net turnover rate','FontSize',10)

% savefig(fullfile(save_to_file,'\turnover rate vs time.fig'));
% saveas(figure (3),fullfile(save_to_file,'\turnover rate vs time.tif'));
% saveas(figure (3),[save_to_file,'\turnover rate vs time'],'epsc');

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PLOT contraction rate vs mDia concentration

x=[0 0.3 0.5 1 1.5];
figure (1)
for i=1:length(AverageRates)
    hold on
     plot(x(i),AverageRates(i).AvgContractionRate/AverageRates(1).AvgContractionRate,'.','Color','k','LineWidth',1)
     errorbarxy(x(i),AverageRates(i).AvgContractionRate/AverageRates(1).AvgContractionRate,0, AverageRates(i).STDContractionRate, 0, AverageRates(i).STDContractionRate,'k+' ,'k')
 %       errorbarxy(x(i),AverageRates(i).AvgContractionRate,[], AverageRates(i).STDContractionRate,'k+' ,'k')

end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
xlim([-0.1 1.7])
ylim([0 1.2])
ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];


xlabel('Added mDia1 [\muM]','FontSize',10)
ylabel('Net contraction rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\contraction rate vs mDia1 concetration.fig'));
saveas(figure (1),fullfile(save_to_file,'\contraction rate vs mDia1 concetration.tif'));
saveas(figure (1),[save_to_file,'\contraction rate vs mDia1 concetration'],'epsc');

%%% PLOT turnover rate vs ActA concetration

x=[0 0.3 0.5 1 1.5];
figure (2)
for i=1:length(AverageRates)
    hold on
     plot(x(i),AverageRates(i).AvgTurnoverRate/AverageRates(1).AvgTurnoverRate,'.','Color','k','LineWidth',1)
     errorbarxy(x(i),AverageRates(i).AvgTurnoverRate/AverageRates(1).AvgTurnoverRate,0, AverageRates(i).STDTurnoverRate, 0, AverageRates(i).STDTurnoverRate,'k+' ,'k')
 %       errorbarxy(x(i),AverageRates(i).AvgContractionRate,[], AverageRates(i).STDContractionRate,'k+' ,'k')

end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
set(gcf,'position',[7 7 5 4])

xlim([-0.1 1.7])
ylim([0 2])
ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
 

xlabel('Added mDia1 [\muM]','FontSize',10)
ylabel('Net turnover rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\turnover rate vs mDia1 concetration.fig'));
saveas(figure (2),fullfile(save_to_file,'\turnover rate vs mDia1 concetration.tif'));
saveas(figure (2),[save_to_file,'\turnover rate vs mDia1 concetration'],'epsc');


%%



% %%%%% BAR PLOT
% 
% % x=[0 0.1 0.5 0.7 1 1.5];
% x=categorical({'buffer','cofilin','Aip1','coronin','CCA'});
% figure (5)
% for i=1:length(AverageRates)
%     hold on
%     R(i)=AverageRates(i).AvgTurnoverRate;
% %      bar(x(i),AverageRates(i).AvgTurnoverRate,'FaceColor','k')
% %      errorbarxy(x(i),AverageRates(i).AvgTurnoverRate,0, AverageRates(i).STDTurnoverRate, 0, AverageRates(i).STDTurnoverRate,'k+' ,'k')
%  %       errorbarxy(x(i),AverageRates(i).AvgContractionRate,[], AverageRates(i).STDContractionRate,'k+' ,'k')
% 
% end
% figure (5)
% bar(R)
% set(gca,'xticklabel',{'buffer','cofilin','Aip1','coronin','CCA'});
% 
% for i=1:length(AverageRates)
%     hold on
%       errorbarxy(i,AverageRates(i).AvgTurnoverRate,0, AverageRates(i).STDTurnoverRate, 0, AverageRates(i).STDTurnoverRate,'k+' ,'k')
%  %       errorbarxy(x(i),AverageRates(i).AvgContractionRate,[], AverageRates(i).STDContractionRate,'k+' ,'k')
% 
% end
% 
% box off
% ax=gca;
% set(ax,'FontSize',8)
% set(gcf,'units','centimeter')
% % set(gcf,'position',[7 7 5 4])
% set(gcf,'position',[7 7 5 4])
% % xlim([-0.1 5])
% xlim([0 12])
% ylim([0 inf])
% 
% % ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
%  ax.XAxis.TickValues=[ 2 4 6 8 10];
% % ax.YAxis.TickValues=[ 0 1 2 ];
% 
% xlabel('Added ActA [\muM]','FontSize',10)
% ylabel('Net turnover rate [1/min]','FontSize',10)
% 
% savefig(fullfile(save_to_file,'\turnover rate vs ActA cincetration.fig'));
% saveas(figure (4),fullfile(save_to_file,'\turnover rate vs ActA cincetration.tif'));
% saveas(figure (4),[save_to_file,'\turnover rate vs ActA cincetration'],'epsc');
% 
% %%%%% BOX PLOT
% 
% for i=1:length(AverageRates)
%     relvantDrops=find([AllDataRates.typeOfExp]==AverageRates(i).typeOfExp);
%     x=[AllDataRates(relvantDrops).TurnoverRate];
%     y=AverageRates(i).name;
%     boxplot(x,y)
%     hold on
% end
% 
% 
file='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper Figures\row data figures';
AllDataRates1=importdata(fullfile(file,'\longTL drop5\rates\AllDataRates.mat'));

for i=1:length(AllDataRates1)
AllDataRates1(i).Color=[250/255 173/255 64/255]; %%Yellow
end

AllDataRates2=importdata(fullfile(file,'\longTL drop6\rates\AllDataRates.mat'));
for i=1:length(AllDataRates2)
AllDataRates2(i).Color=[247/255 102/255 18/255]; %% orange
end

AllDataRates3=importdata(fullfile(file,'\longTL drop7\rates\AllDataRates.mat'));
for i=1:length(AllDataRates3)
AllDataRates3(i).Color=[195/255 105/255 165/255]; %%% magenta
end

AllDataRates4=importdata(fullfile(file,'\longTL drop8\rates\AllDataRates.mat'));
for i=1:length(AllDataRates4)
AllDataRates4(i).Color=[115/255 89/255 145/255]; %% parpel
end

AllDataRates5=importdata(fullfile(file,'\longTL drop9\rates\AllDataRates.mat'));
for i=1:length(AllDataRates5)
AllDataRates5(i).Color=[0 1 1]; %%% cayn 
end

AllDataRates6=importdata(fullfile(file,'\rates Long TL\AllDataRates.mat'));
for i=1:length(AllDataRates6)
AllDataRates6(i).Color=[0 1 0]; %%% cayn 
end

for i=2:length(AllDataRates1)
beta(i)=mean([AllDataRates1(i).TurnoverRate/AllDataRates1(2).TurnoverRate,AllDataRates2(i).TurnoverRate/AllDataRates2(2).TurnoverRate,AllDataRates3(i).TurnoverRate/AllDataRates3(2).TurnoverRate...
,AllDataRates4(i).TurnoverRate/AllDataRates4(2).TurnoverRate,AllDataRates5(i).TurnoverRate/AllDataRates5(2).TurnoverRate,AllDataRates6(i).TurnoverRate/AllDataRates6(2).TurnoverRate]);

STDbeta(i)=std([AllDataRates1(i).TurnoverRate/AllDataRates1(2).TurnoverRate,AllDataRates2(i).TurnoverRate/AllDataRates2(2).TurnoverRate,AllDataRates3(i).TurnoverRate/AllDataRates3(2).TurnoverRate...
,AllDataRates4(i).TurnoverRate/AllDataRates4(2).TurnoverRate,AllDataRates5(i).TurnoverRate/AllDataRates5(2).TurnoverRate,AllDataRates6(i).TurnoverRate/AllDataRates6(2).TurnoverRate]);

k(i)=mean([AllDataRates1(i).ContractionRate/AllDataRates1(2).ContractionRate,AllDataRates2(i).ContractionRate/AllDataRates2(2).ContractionRate,AllDataRates3(i).ContractionRate/AllDataRates3(2).ContractionRate...
,AllDataRates4(i).ContractionRate/AllDataRates4(2).ContractionRate,AllDataRates5(i).ContractionRate/AllDataRates5(2).ContractionRate,AllDataRates6(i).ContractionRate/AllDataRates6(2).ContractionRate]);

STDk(i)=std([AllDataRates1(i).ContractionRate/AllDataRates1(2).ContractionRate,AllDataRates2(i).ContractionRate/AllDataRates2(2).ContractionRate,AllDataRates3(i).ContractionRate/AllDataRates3(2).ContractionRate...
,AllDataRates4(i).ContractionRate/AllDataRates4(2).ContractionRate,AllDataRates5(i).ContractionRate/AllDataRates5(2).ContractionRate,AllDataRates6(i).ContractionRate/AllDataRates6(2).ContractionRate]);

end

meanDrop1_beta=mean([AllDataRates1.TurnoverRate]);
meanDrop1_k=mean([AllDataRates1.ContractionRate]);

meanDrop2_beta=mean([AllDataRates2.TurnoverRate]);
meanDrop2_k=mean([AllDataRates2.ContractionRate]);

meanDrop3_beta=mean([AllDataRates3.TurnoverRate]);
meanDrop3_k=mean([AllDataRates3.ContractionRate]);

meanDrop4_beta=mean([AllDataRates4.TurnoverRate]);
meanDrop4_k=mean([AllDataRates4.ContractionRate]);

meanDrop5_beta=mean([AllDataRates5.TurnoverRate]);
meanDrop5_k=mean([AllDataRates5.ContractionRate]);

meanDrop6_beta=mean([AllDataRates6.TurnoverRate]);
meanDrop6_k=mean([AllDataRates6.ContractionRate]);

for i=2:length(AllDataRates1)
beta(i)=mean([AllDataRates1(i).TurnoverRate/meanDrop1_beta,AllDataRates2(i).TurnoverRate/meanDrop2_beta,AllDataRates3(i).TurnoverRate/meanDrop3_beta...
,AllDataRates4(i).TurnoverRate/meanDrop4_beta,AllDataRates5(i).TurnoverRate/meanDrop5_beta,AllDataRates6(i).TurnoverRate/meanDrop6_beta]);

STDbeta(i)=std([AllDataRates1(i).TurnoverRate/meanDrop1_beta,AllDataRates2(i).TurnoverRate/meanDrop2_beta,AllDataRates3(i).TurnoverRate/meanDrop3_beta...
,AllDataRates4(i).TurnoverRate/meanDrop4_beta,AllDataRates5(i).TurnoverRate/meanDrop5_beta,AllDataRates6(i).TurnoverRate/meanDrop6_beta]);

k(i)=mean([AllDataRates1(i).ContractionRate/meanDrop1_k,AllDataRates2(i).ContractionRate/meanDrop2_k,AllDataRates3(i).ContractionRate/meanDrop3_k...
,AllDataRates4(i).ContractionRate/meanDrop4_k,AllDataRates5(i).ContractionRate/meanDrop5_k,AllDataRates6(i).ContractionRate/meanDrop6_k]);

STDk(i)=std([AllDataRates1(i).ContractionRate/meanDrop1_k,AllDataRates2(i).ContractionRate/meanDrop2_k,AllDataRates3(i).ContractionRate/meanDrop3_k...
,AllDataRates4(i).ContractionRate/meanDrop4_k,AllDataRates5(i).ContractionRate/meanDrop5_k,AllDataRates6(i).ContractionRate/meanDrop6_k]);

end

figure (1)
for i=2:6
plot(x(i),k(i)/mean(k(2:6)),'.','Color','k')
hold on
errorbarxy(x(i),k(i)/mean(k(2:6)),0,STDk(i), 0, STDk(i),'k' ,'k')
hold on
end

for i=7:length(x)
plot(x(i),k(i)/mean(k(2:6)),'.','Color',[90/255,90/255,90/255])
hold on
errorbarxy(x(i),k(i)/mean(k(2:6)),0,STDk(i), 0, STDk(i),'k' ,[125/255,125/255,125/255])
hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 1.7])
xlim([0 60])
ylim([0 2])
% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
% ax.YAxis.TickValues=[ 0 0.2 0.4 0.6 ];

 ax.XAxis.TickValues=[0:10:60];
%  ax.XAxis.TickValues=[0:10:30];

xlabel('Time [min]','FontSize',10)
ylabel('Contraction rate','FontSize',10)

savefig(fullfile(save_to_file,'\AVGcontraction rate vs time.fig'));
saveas(figure (1),fullfile(save_to_file,'\AVGcontraction rate vs time.tif'));
saveas(figure (1),[save_to_file,'\AVGcontraction rate vs time'],'epsc');



figure (2)
for i=2:6
plot(x(i),beta(i)/mean(beta(2:6)),'.','Color','k')
hold on
errorbarxy(x(i),beta(i)/mean(beta(2:6)),0,STDbeta(i), 0, STDbeta(i),'k' ,'k')
hold on
end

for i=7:length(x)
plot(x(i),beta(i)/mean(beta(2:6)),'.','Color',[90/255,90/255,90/255])
hold on
errorbarxy(x(i),beta(i)/mean(beta(2:6)),0,STDbeta(i), 0, STDbeta(i),'k' ,[125/255,125/255,125/255])
hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 5])
xlim([0 60])
ylim([0 2])

% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
  ax.XAxis.TickValues=[0:10:60];
%  ax.XAxis.TickValues=[0:10:30];

% ax.YAxis.TickValues=[ 0 1 2 ];

xlabel('Time [min]','FontSize',10)
ylabel('Net turnover rate','FontSize',10)

savefig(fullfile(save_to_file,'\AVGturnover rate vs time.fig'));
saveas(figure (2),fullfile(save_to_file,'\AVGturnover rate vs time.tif'));
saveas(figure (2),[save_to_file,'\AVturnover  rate vs time'],'epsc');


%%%%%%%%%%%%%%%%%%%%%%%%%% Not notmalized

for i=2:length(AllDataRates1)
beta(i)=mean([AllDataRates1(i).TurnoverRate,AllDataRates2(i).TurnoverRate,AllDataRates3(i).TurnoverRate...
,AllDataRates4(i).TurnoverRate,AllDataRates5(i).TurnoverRate,AllDataRates6(i).TurnoverRate]);

SRDbeta(i)=mean([AllDataRates1(i).TurnoverRate,AllDataRates2(i).TurnoverRate,AllDataRates3(i).TurnoverRate...
,AllDataRates4(i).TurnoverRate,AllDataRates5(i).TurnoverRate,AllDataRates6(i).TurnoverRate]);

k(i)=mean([AllDataRates1(i).ContractionRate,AllDataRates2(i).ContractionRate,AllDataRates3(i).ContractionRate...
,AllDataRates4(i).ContractionRate,AllDataRates5(i).ContractionRate,AllDataRates6(i).ContractionRate]);

STDk(i)=std([AllDataRates1(i).ContractionRate,AllDataRates2(i).ContractionRate,AllDataRates3(i).ContractionRate...
,AllDataRates4(i).ContractionRate,AllDataRates5(i).ContractionRate,AllDataRates6(i).ContractionRate]);

end

figure (1)
for i=2:6
plot(x(i),k(i),'.','Color','k')
hold on
errorbarxy(x(i),k(i),0,STDk(i), 0, STDk(i),'k' ,'k')
hold on
end

for i=7:length(x)
plot(x(i),k(i)/mean(k(2:6)),'.','Color',[90/255,90/255,90/255])
hold on
errorbarxy(x(i),k(i)/mean(k(2:6)),0,STDk(i), 0, STDk(i),'k' ,[125/255,125/255,125/255])
hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 1.7])
xlim([0 60])
ylim([0 2])
% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
% ax.YAxis.TickValues=[ 0 0.2 0.4 0.6 ];

 ax.XAxis.TickValues=[0:10:60];
%  ax.XAxis.TickValues=[0:10:30];

xlabel('Time [min]','FontSize',10)
ylabel('Contraction rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\AVGcontraction rate vs time non norm.fig'));
saveas(figure (1),fullfile(save_to_file,'\AVGcontraction rate vs time non norm.tif'));
saveas(figure (1),[save_to_file,'\AVGcontraction rate vs time non norm'],'epsc');



figure (2)
for i=2:6
plot(x(i),beta(i),'.','Color','k')
hold on
errorbarxy(x(i),beta(i),0,STDbeta(i), 0, STDbeta(i),'k' ,'k')
hold on
end

for i=7:length(x)
plot(x(i),beta(i)/mean(beta(2:6)),'.','Color',[90/255,90/255,90/255])
hold on
errorbarxy(x(i),beta(i)/mean(beta(2:6)),0,STDbeta(i), 0, STDbeta(i),'k' ,[125/255,125/255,125/255])
hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
set(gcf,'position',[7 7 5 4])
% xlim([-0.1 5])
xlim([0 60])
ylim([0 2])

% ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];
  ax.XAxis.TickValues=[0:10:60];
%  ax.XAxis.TickValues=[0:10:30];

% ax.YAxis.TickValues=[ 0 1 2 ];

xlabel('Time [min]','FontSize',10)
ylabel('Net turnover rate [1/min]','FontSize',10)

savefig(fullfile(save_to_file,'\AVGturnover rate vs time non norm.fig'));
saveas(figure (2),fullfile(save_to_file,'\AVGturnover rate vs time non norm.tif'));
saveas(figure (2),[save_to_file,'\AVturnover  rate vs time non norm'],'epsc');

