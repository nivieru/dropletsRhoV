file='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper Figures\row data figures\ActA\ActA Summary New\';
save_to_file=[file,'DivV from average\'];

AverageValues=importdata([file,'AverageValues.mat']);
AverageValues2=importdata([file,'AverageValues2.mat']);

AverageValuesDivV=struct;
AverageValuesV=AverageValues;
AverageValuesRho=AverageValues2;

for i=1:length(AverageValues2);
R=AverageValuesRho(i).meanRrho; %%% NORMALIZED RHO
Rho=AverageValuesRho(i).meanRho;
% RforDivJ=AverageValuesRho(i).meanRrho;
% STDRhoMinus=AverageValues(i).lowerLineRho;
% STDRhoPlus=AverageValues(i).upperLineRho;
V=AverageValuesV(i).meanV;
R_V=AverageValuesV(i).meanR;
dr=AverageValuesV(i).Xteanslation;
R_V=R_V+dr;

% figure 
% plot(R_V,V)
% hold on
% plot(R,Rho)


%%%% FIND THE MAXIMUM
[MAX_Rho,MAX_Rho_place]=max(Rho);
MinRr=ceil(R(MAX_Rho_place));

%%%% FIND THE MINIMUM
maxRr=max(R_V);

placeSmall=find(R<MinRr);
R(placeSmall)=[];
Rho(placeSmall)=[];

placeBig=find(R>maxRr);
R(placeBig)=[];
Rho(placeBig)=[];

placeSmall=find(R_V<MinRr);
R_V(placeSmall)=[];
V(placeSmall)=[];

%%% Calculate DivV
%%%% calculate integrated force balance eq. 1/r^2*(d/dr)*(r^2V)
temp=(R_V.^2).*V;
dy=diff(temp);
dx=diff(R_V);
DivV=((1./(R_V(1:(end-1))).^2)).*(dy./dx);

figure (1)
plot(R_V(1:(end-1)),-DivV,'Color',AverageValues(i).color,'LineWidth',1)
hold on
% ppDivV=polyfit(R_V(1:end-1),ForceBalanceEq,1);
% % Linear=ppDivV(1)*R_V(1:end-1)+ppDivV(2);
% DivVvsRslope=ppDivV(1);
 
Rho_DivV=interp1(R,Rho,R_V);

figure (2)
hold on
plot(Rho_DivV(1:end-1),-DivV,'Color',AverageValues(i).color,'LineWidth',1)

end

%%%% Figure 1 - DivV(rho) 

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

savefig([save_to_file,'Div V vs Rho.fig']);
saveas(figure (1),[save_to_file,'Div V vs R.tif']);
saveas(figure (1),[save_to_file,'Div V vs R'],'epsc');

%%%% Figure 2 - DivV(r) 

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

savefig([save_to_file,'Div V vs Rho.fig']);
saveas(figure (1),[save_to_file,'Div V vs Rho.tif']);
saveas(figure (1),[save_to_file,'Div V vs Rho'],'epsc');

%%%%


