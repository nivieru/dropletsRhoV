
AllDataRates=importdata('');
AverageRates=importdata('');
Save_to_file='';

%%%% Plot contraction time vs turnover time

figure (1)
for i=1:length(AllDataRates)
    h(i)=plot(AllDataRates(i).TurnoverTime,AllDataRates(i).ContractionTime,'*','Color',AllDataRates(i).Color,'LineWidth',1);
    hold on
end

% legend([h(1),h(16),h(20),h(25),h(28),h(34),h(36)],[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name}])
legend([h(1),h(6),h(9),h(14),h(20),h(25),h(30),h(36)],[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name},{AverageRates(7).name},{AverageRates(8).name}])

box off
ax=gca;
set(ax,'FontSize',8)
xlabel('Actin turnover time[min]','FontSize',10)
ylabel('Contraction time[min]','FontSize',10)

for i=1:length(AverageRates)
    hold on
    plot(AverageRates(i).AvgTurnoverTime,AverageRates(i).AvgContractionTime,'o','Color',AverageRates(i).color,'LineWidth',1)
    errorbarxy(AverageRates(i).AvgTurnoverTime,AverageRates(i).AvgContractionTime,AverageRates(i).STDTurnoverTime, AverageRates(i).STDContractionTime, AverageRates(i).STDTurnoverTime, AverageRates(i).STDContractionTime,'k+' ,'k')
end

savefig(fullfile(save_to_file,'\All data contraction vs turnover.fig'));
saveas(figure (1),fullfile(save_to_file,'\All data contraction vs turnover.tif'));
saveas(figure (1),[save_to_file,'\All data contraction vs turnover'],'epsc');


%%%% Plot contraction rate vs turnover rate

figure (2)
for i=1:length(AllDataRates)
    h(i)=plot(AllDataRates(i).TurnoverRate,AllDataRates(i).ContractionRate,'*','Color',AllDataRates(i).Color,'LineWidth',1);
    hold on
end

% legend([h(1),h(16),h(20),h(25),h(28),h(34),h(36)],[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name}])
legend([h(1),h(6),h(9),h(14),h(20),h(25),h(30),h(36),h(39),h(47)],[{AverageRates(1).name},{AverageRates(2).name},{AverageRates(3).name},{AverageRates(4).name},{AverageRates(5).name},{AverageRates(6).name},{AverageRates(7).name},{AverageRates(8).name},{AverageRates(9).name},{AverageRates(10).name}])

box off
ax=gca;
set(ax,'FontSize',8)
xlabel('Actin turnover rate[1/min]','FontSize',10)
ylabel('Contraction rate[1/min]','FontSize',10)

for i=1:length(AverageRates)
    hold on
    plot(AverageRates(i).AvgTurnoverRate,AverageRates(i).AvgContractionRate,'o','Color',AverageRates(i).color,'LineWidth',1)
    errorbarxy(AverageRates(i).AvgTurnoverRate,AverageRates(i).AvgContractionRate,AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate, AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate,'k+' ,'k')
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])


savefig(fullfile(save_to_file,'\All data contraction rate vs turnover rate.fig'));
saveas(figure (2),fullfile(save_to_file,'\All data contraction rate vs turnover rate.tif'));
saveas(figure (2),[save_to_file,'\All data contraction rate vs turnover rate'],'epsc');

