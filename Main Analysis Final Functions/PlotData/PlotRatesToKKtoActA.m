
AllDataRates=importdata('');
AverageRates=importdata('');
save_to_file='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper figures 21_3\S Nucleators turnover rates\Figures ActA\';


%% PLOT contraction rate vs ActA concentration

x=[0 0.1 0.5 0.7 1.5];
figure (1)
for i=1:length(AverageRates)
    hold on
     plot(x(i),AverageRates(i).AvgContractionRate/AverageRates(1).AvgContractionRate,'.','Color','k','LineWidth',1)
     errorbarxy(x(i),AverageRates(i).AvgContractionRate/AverageRates(1).AvgContractionRate,0, AverageRates(i).STDContractionRate/AverageRates(1).AvgContractionRate, 0, AverageRates(i).STDContractionRate/AverageRates(1).AvgContractionRate,'k+' ,'k')
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

xlabel('Added ActA [\muM]','FontSize',10)
ylabel('Net contraction rate [1/min]','FontSize',10)

savefig([save_to_file,'\contraction rate vs ActA concetration.fig']);
saveas(figure (1),[save_to_file,'\contraction rate vs ActA concetration.tif']);
saveas(figure (1),[save_to_file,'\contraction rate vs ActA concetration'],'epsc');


%% PLOT turnover rate vs ActA concentration

x=[0 0.1 0.5 0.7 1.5];
figure (2)
for i=1:length(AverageRates)
    hold on
     plot(x(i),AverageRates(i).AvgTurnoverRate/AverageRates(1).AvgTurnoverRate,'.','Color','k','LineWidth',1)
     errorbarxy(x(i),AverageRates(i).AvgTurnoverRate/AverageRates(1).AvgTurnoverRate,0, AverageRates(i).STDTurnoverRate/AverageRates(1).AvgTurnoverRate, 0, AverageRates(i).STDTurnoverRate/AverageRates(1).AvgTurnoverRate,'k+' ,'k')
 %       errorbarxy(x(i),AverageRates(i).AvgContractionRate,[], AverageRates(i).STDContractionRate,'k+' ,'k')

end

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
xlim([-0.1 1.7])
ylim([0 2])
ax.XAxis.TickValues=[ 0 0.5 1 1.5 ];

xlabel('Added ActA [\muM]','FontSize',10)
ylabel('Net Turnover rate [1/min]','FontSize',10)

savefig([save_to_file,'\Turnover rate vs ActA concetration.fig']);
saveas(figure (2),[save_to_file,'\Turnover rate vs ActA concetration.tif']);
saveas(figure (2),[save_to_file,'\Turnover rate vs ActA concetration'],'epsc');
