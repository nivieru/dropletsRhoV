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

ylim([0, 2])

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
