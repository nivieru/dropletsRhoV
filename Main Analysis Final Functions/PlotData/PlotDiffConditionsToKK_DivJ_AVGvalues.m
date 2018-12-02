%%%% Maya Malik Garbi - last modified 22/10/17
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_file)

DROPS=DROPSforRho;
AverageValues=struct;

%% Generate vector of indices for legend, each experiment type has one line
nn=1;
for i=1:length(DROPS)
    
    if (i==length(DROPS))
        LEG{nn}=(DROPS(i).typeOfExpString);
        index_drops(nn)=i;
        nn=nn+1;
    else if (DROPS(i).typeOfExp~=DROPS(i+1).typeOfExp)
            LEG{nn}=(DROPS(i).typeOfExpString);
            index_drops(nn)=i;
            nn=nn+1;
        end
    end
    
end

%% (1) Rho(R)

for i=1:length(DROPS)
    i
%     j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
%     DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./max(DROPS(i).RhoMinusMonomers);
%     DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
%     
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    placeNearblob=find(DROPS(i).Rrho>DROPS(i).CHUNK_radius-2);
    MaxRho=max(DROPS(i).RhoMinusMonomers(placeNearblob));
    DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./MaxRho;
    DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);


end

%%%%%%% Calculate the average values for each condition


typeOfExpVector=unique([DROPS.typeOfExp]);
NoOfConditions=length(typeOfExpVector);

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    RhoAllData=[DROPS(placeDrops).RhoNorm];
    RrAllData=[DROPS(placeDrops).Rnorm];
    AverageValues(j).color=DROPS(placeDrops(1)).Color;
    [AverageValues(j).meanRho,AverageValues(j).lowerLineRho,AverageValues(j).upperLineRho,AverageValues(j).meanRrho] = meanGaussianMM(RrAllData,RhoAllData, 1);
end
close all


h=figure (1);
Jinitial=1;

for j=Jinitial:NoOfConditions
    plot(AverageValues(j).meanRrho,AverageValues(j).meanRho,'Color',AverageValues(j).color,'LineWidth',1)
    hold on
    plot(AverageValues(j).meanRrho,AverageValues(j).lowerLineRho,'Color',AverageValues(j).color,'LineWidth',0.5)
    hold on
    plot(AverageValues(j).meanRrho,AverageValues(j).upperLineRho,'Color',AverageValues(j).color,'LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).MeanRhoForDivJnagative,AverageValues(j).LinearFitDivJ,'--','Color','k','LineWidth',2)
end

ylim([0 1.1])
% xlim([0 inf])
xlim([0 35])

xlabel('r-r_0 [\mum]','FontSize',10)
% xlabel('r-r_0/R_d_r_o_p','FontSize',10)

ylabel('Normalized \rho [a.u]','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'rho vs R.fig'));
saveas(figure (1),fullfile(save_to_file,'rho vs R.tif'));
saveas(figure (1),[save_to_file,'rho vs R'],'epsc');


%% (2) DivJ(Rho)

for i=1:length(DROPS)
    DROPS(i).NormRhoForDivJ=DROPS(i).Div_Jr_Rho(1:end-1)./max(DROPS(i).Div_Jr_Rho);
    DROPS(i).NormDivJ=DROPS(i).Div_Jr./max(DROPS(i).Div_Jr_Rho);
end

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    NormRhoForDivJAllData=[DROPS(placeDrops).NormRhoForDivJ];
    NormDivJAllData=[DROPS(placeDrops).NormDivJ];
    [AverageValues(j).MeanDivJ,AverageValues(j).lowerLineMeanDivJ,AverageValues(j).upperLineMeanDivJ,AverageValues(j).MeanRhoForDivJ] = meanGaussianMMv2(NormRhoForDivJAllData,NormDivJAllData,0.05,0.05);
    close all
    
    %     %%%% For mDia remove rho>0.8
    %     if (j==2)
    %     removeFormDia=find(AverageValues(j).MeanRhoForDivJ>0.8);
    %     AverageValues(j).MeanRhoForDivJ(removeFormDia)=[];
    %     AverageValues(j).MeanDivJ(removeFormDia)=[];
    %     end
    
    
    %%%Linear fit only to the negative part of the profile
    negative_place=min(find(AverageValues(j).MeanDivJ<0));
    p=polyfit((AverageValues(j).MeanRhoForDivJ(negative_place:end))',(AverageValues(j).MeanDivJ(negative_place:end))',1);
    AverageValues(j).SlopeDivJ=p(1);
    AverageValues(j).MeanRhoForDivJnagative=AverageValues(j).MeanRhoForDivJ(negative_place:end);
    AverageValues(j).LinearFitDivJ=p(1)*(AverageValues(j).MeanRhoForDivJnagative)'+p(2);
    
end

%%%%%%Plot
h=figure (2);
Jinitial=1;

for j=Jinitial:NoOfConditions
    plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).MeanDivJ,'Color',AverageValues(j).color,'LineWidth',1.5)
    hold on
    plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).lowerLineMeanDivJ,'Color',AverageValues(j).color,'LineWidth',0.5)
    hold on
    plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).upperLineMeanDivJ,'Color',AverageValues(j).color,'LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).MeanRhoForDivJnagative,AverageValues(j).LinearFitDivJ,'--','Color','k','LineWidth',2)
end


hold on
% legend(h(index_drops),LEG)
box off
ax=gca;
set(ax,'FontSize',8)
ylim([-2 0.5])
xlim([0 1])
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
xlabel('Normalized \rho [a.u]','FontSize',10)
ylabel('div(J) [a.u]','FontSize',10)

savefig(fullfile(save_to_file,'divJ AVG values.fig'));
saveas(figure (2),fullfile(save_to_file,'divJ AVG values.tif'));
saveas(figure (2),[save_to_file,'divJ AVG values'],'epsc');



%% Div v as a function of R

for i=1:length(DROPS)
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    DROPS(i).RnormForDivJ=(DROPS(i).Div_Jr_Rrho(1:end-1)-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
end

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    NormRnormForDivJAllData=[DROPS(placeDrops).RnormForDivJ];
    ForceBalanceEqAllData=[DROPS(placeDrops).ForceBalanceEq];
    [AverageValues(j).MeanForceBalanceEqVsR,AverageValues(j).lowerLineMeanForceBalanceEqVsR,AverageValues(j).upperLineMeanForceBalanceEqVsR,AverageValues(j).MeanR_ForForceBalanceEq] = meanGaussianMM(NormRnormForDivJAllData,ForceBalanceEqAllData, 1);

end
close all

%%%%%%Plot
h=figure (3);

Jinitial=1;
for j=Jinitial:NoOfConditions
    plot(AverageValues(j).MeanR_ForForceBalanceEq,-AverageValues(j).MeanForceBalanceEqVsR,'Color',AverageValues(j).color,'LineWidth',1)
    hold on
    plot(AverageValues(j).MeanR_ForForceBalanceEq,-AverageValues(j).lowerLineMeanForceBalanceEqVsR,'Color',AverageValues(j).color,'LineWidth',0.5)
    hold on
    plot(AverageValues(j).MeanR_ForForceBalanceEq,-AverageValues(j).upperLineMeanForceBalanceEqVsR,'Color',AverageValues(j).color,'LineWidth',0.5)
     hold on 
end


% legend(h(index_drops),LEG)

xlabel('r-r_0 [\mum]','FontSize',10)
ylabel('Div V','FontSize',10)
xlim([0 35])
ylim([0 5])


box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])

savefig(fullfile(save_to_file,'Div V vs r.fig'));
saveas(figure (3),fullfile(save_to_file,'Div V vs r.tif'));
saveas(figure (3),[save_to_file,'Div V vs r'],'epsc');



%% Div V as a function of Rho


for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)); 
    Div_Jr_RhoAllData=[DROPS(placeDrops).NormRhoForDivJ];
    ForceBalanceEqAllData=[DROPS(placeDrops).ForceBalanceEq];
    [AverageValues(j).MeanForceBalanceEqVsRho,AverageValues(j).lowerLineMeanForceBalanceEqVsRho,AverageValues(j).upperLineMeanForceBalanceEqVsRho,AverageValues(j).MeanRho_ForForceBalanceEq] =meanGaussianMMv2(Div_Jr_RhoAllData,ForceBalanceEqAllData, 0.05,0.05);

end
close all

%%%%%%Plot
h=figure (4);

Jinitial=1;


for j=Jinitial:NoOfConditions
    
    plot(AverageValues(j).MeanRho_ForForceBalanceEq,-AverageValues(j).MeanForceBalanceEqVsRho,'Color',AverageValues(j).color,'LineWidth',1)
    hold on
    plot(AverageValues(j).MeanRho_ForForceBalanceEq,-AverageValues(j).lowerLineMeanForceBalanceEqVsRho,'Color',AverageValues(j).color,'LineWidth',0.5)
    hold on
    plot(AverageValues(j).MeanRho_ForForceBalanceEq,-AverageValues(j).upperLineMeanForceBalanceEqVsRho,'Color',AverageValues(j).color,'LineWidth',0.5)
    hold on
     
end


% legend(h(index_drops),LEG)

xlabel('Normalized \rho [a.u]','FontSize',10)
ylabel('Div V','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])
ylim([0 5])

savefig(fullfile(save_to_file,'Div V vs rho.fig'));
saveas(figure (4),fullfile(save_to_file,'Div V vs rho.tif'));
saveas(figure (4),[save_to_file,'Div V vs rho'],'epsc');








% %%%%%% TRY 
% for i=1:length(DROPS)
%     DROPS(i).temp=DROPS(i).Div_Jr_Rho(1:end-1);
%     
% end
% 
% for j=1:NoOfConditions
%     placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j));
%     Div_Jr_RhoAllData=[DROPS(placeDrops).temp];
%     ForceBalanceEqAllData=[DROPS(placeDrops).ForceBalanceEq];
%     [AverageValues(j).MeanForceBalanceEqVsRho,AverageValues(j).lowerLineMeanForceBalanceEqVsRho,AverageValues(j).upperLineMeanForceBalanceEqVsRho,AverageValues(j).MeanRho_ForForceBalanceEq] =meanGaussianMM(Div_Jr_RhoAllData,ForceBalanceEqAllData, 1);
% 
% end
% close all
% 
% 
% %%%%%Plot
% h=figure (5);
% 
% Jinitial=1;
% 
% 
% for j=Jinitial:NoOfConditions
%     
%     plot(AverageValues(j).MeanRho_ForForceBalanceEq,-AverageValues(j).MeanForceBalanceEqVsRho,'Color',AverageValues(j).color,'LineWidth',1)
%     hold on
%     plot(AverageValues(j).MeanRho_ForForceBalanceEq,-AverageValues(j).lowerLineMeanForceBalanceEqVsRho,'Color',AverageValues(j).color,'LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).MeanRho_ForForceBalanceEq,-AverageValues(j).upperLineMeanForceBalanceEqVsRho,'Color',AverageValues(j).color,'LineWidth',0.5)
%     hold on
%      
% end
% 
% 
% % legend(h(index_drops),LEG)
% 
% xlabel('Normalized \rho [a.u]','FontSize',10)
% ylabel('Div V','FontSize',10)
% 
% box off
% ax=gca;
% set(ax,'FontSize',8)
% set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
% % set(gca, 'XTick', [ 0 0.5 1 ])
% % set(gca, 'YTick', [ -1 0 1 ])
% 
% savefig(fullfile(save_to_file,'Div V vs non norm rho.fig'));
% saveas(figure (5),fullfile(save_to_file,'Div V vs non norm rho.tif'));
% saveas(figure (5),[save_to_file,'Div V vs non norm rho'],'epsc');



%% (1) Rho(r-r0/Rdrop) 

for i=1:length(DROPS)
    i
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    placeNearblob=find(DROPS(i).Rrho>DROPS(i).CHUNK_radius-2);
    MaxRho=max(DROPS(i).RhoMinusMonomers(placeNearblob));
    DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./MaxRho;
    DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation)/DROPS(i).DropSize;

end

%%%%%%% Calculate the average values for each condition

% AverageValues=struct;
typeOfExpVector=unique([DROPS.typeOfExp]);
NoOfConditions=length(typeOfExpVector);

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    RhoAllData=[DROPS(placeDrops).RhoNorm];
    RrAllData=[DROPS(placeDrops).Rnorm];
    AverageValues(j).color=DROPS(placeDrops(1)).Color;
%     [AverageValues(j).meanRho,AverageValues(j).lowerLineRho,AverageValues(j).upperLineRho,AverageValues(j).meanRrho] = meanGaussianMM(RrAllData,RhoAllData, 1);
    [AverageValues(j).meanRho2,AverageValues(j).lowerLineRho2,AverageValues(j).upperLineRho2,AverageValues(j).meanRrho2] = meanGaussianMMv2(RrAllData,RhoAllData, 0.04,0.01);

end
close all


h=figure (6);
Jinitial=1;

for j=Jinitial:NoOfConditions
    plot(AverageValues(j).meanRrho2,AverageValues(j).meanRho2,'Color',AverageValues(j).color,'LineWidth',1)
    hold on
    plot(AverageValues(j).meanRrho2,AverageValues(j).lowerLineRho2,'Color',AverageValues(j).color,'LineWidth',0.5)
    hold on
    plot(AverageValues(j).meanRrho2,AverageValues(j).upperLineRho2,'Color',AverageValues(j).color,'LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).MeanRhoForDivJnagative,AverageValues(j).LinearFitDivJ,'--','Color','k','LineWidth',2)
end

ylim([0 1.1])
xlim([0 inf])
%xlabel('r-r_0 [\mum]','FontSize',10)
xlabel('r-r_0/R_d_r_o_p','FontSize',10)

ylabel('Normalized \rho [a.u]','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'rho vs r-r0_Rdrop.fig'));
saveas(figure (6),fullfile(save_to_file,'rho vs r-r0_Rdrop.tif'));
saveas(figure (6),[save_to_file,'rho vs r-r0_Rdrop'],'epsc');

AverageValues2=AverageValues;

save(fullfile(save_to_file,'AverageValues2.mat'),'AverageValues2')









end




