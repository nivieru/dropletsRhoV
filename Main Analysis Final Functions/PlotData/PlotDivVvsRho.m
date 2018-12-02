%%% This function plot DivV(rho) from average DivV(r-r0) Rho(r-r0) 

function PlotDivVvsRho(AverageValues2,save_to_file)

figure (1)

for i=1:length(AverageValues2);
R=AverageValues2(i).meanRrho;
Rho=AverageValues2(i).meanRho;
STDRhoMinus=AverageValues2(i).lowerLineRho;
STDRhoPlus=AverageValues2(i).upperLineRho;
DivV=AverageValues2(i).MeanForceBalanceEqVsR;
STDDivVMinus=AverageValues2(i).lowerLineMeanForceBalanceEqVsR;
STDDivVPlus=AverageValues2(i).upperLineMeanForceBalanceEqVsR;
R_DivV=AverageValues2(i).MeanR_ForForceBalanceEq;

Rmin=min(R_DivV);
Rmax=max(R_DivV);

placeSmall=find(R<Rmin);
R(placeSmall)=[];
Rho(placeSmall)=[];
STDRhoMinus(placeSmall)=[];
STDRhoPlus(placeSmall)=[];

placeBig=find(R>Rmax);
R(placeBig)=[];
Rho(placeBig)=[];
STDRhoMinus(placeBig)=[];
STDRhoPlus(placeBig)=[];


% figure
% plot(R,Rho)
% hold on
% plot(R_DivV,DivV)

Rho_DivV=interp1(R,Rho,R_DivV);
STDRhoMinus_DivV=interp1(R,STDRhoMinus,R_DivV);
STDRhoPlus_DivV=interp1(R,STDRhoPlus,R_DivV);

hold on
plot(Rho_DivV,-DivV,'Color',AverageValues2(i).color,'LineWidth',1)
hold on
plot(STDRhoMinus_DivV,-STDDivVMinus,'Color',AverageValues2(i).color,'LineWidth',0.5)
hold on
plot(STDRhoPlus_DivV,-STDDivVPlus,'Color',AverageValues2(i).color,'LineWidth',0.5)


end

ylim([0 5])
xlim([0 1])
%xlabel('r-r_0 [\mum]','FontSize',10)
ylabel('Div V','FontSize',10)
xlabel('Normalized \rho [a.u]','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'Div V vs Rho from avg.fig'));
saveas(figure (1),fullfile(save_to_file,'Div V vs Rho from avg.tif'));
saveas(figure (1),[save_to_file,'Div V vs Rho from avg'],'epsc');
end
