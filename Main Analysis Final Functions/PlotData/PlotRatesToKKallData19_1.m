
AllDataRates=importdata('');
AverageRates=importdata('');
Save_to_file='';

%%%% Plot contraction rate vs turnover rate

figure (1)
for i=1:length(AllDataRates)
    h(i)=plot(AllDataRates(i).TurnoverRate,AllDataRates(i).ContractionRate,'*','Color',AllDataRates(i).Color,'LineWidth',1);
    hold on
end

box off
ax=gca;
set(ax,'FontSize',8)
xlabel('Actin turnover rate[1/min]','FontSize',10)
ylabel('Contraction rate[1/min]','FontSize',10)

for i=1:length(AverageRates)
    hold on
%     plot(AverageRates(i).AvgTurnoverRate,AverageRates(i).AvgContractionRate,'o','Color',AverageRates(i).color,'LineWidth',1)
    errorbarxy(AverageRates(i).AvgTurnoverRate,AverageRates(i).AvgContractionRate,AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate, AverageRates(i).STDTurnoverRate, AverageRates(i).STDContractionRate,'k+' ,'k')
end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])



savefig([save_to_file,'\All data contraction rate vs turnover rate.fig']);
saveas(figure (1),[save_to_file,'\All data contraction rate vs turnover rate.tif']);
saveas(figure (1),[save_to_file,'\All data contraction rate vs turnover rate'],'epsc');




