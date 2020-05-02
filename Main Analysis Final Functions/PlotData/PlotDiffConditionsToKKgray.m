%%%% Maya Malik Garbi - last modified 22/10/17
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function PlotDiffConditionsToKKgray(DROPSforRho,DROPSafterVtranslation,save_to_file)

DROPS=DROPSforRho;

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
     j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    placeNearblob=find(DROPS(i).Rrho>DROPS(i).CHUNK_radius-2);
    MaxRho=max(DROPS(i).RhoMinusMonomers(placeNearblob));
     DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./MaxRho;

%     DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers;
%      DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./max(DROPS(i).RhoMinusMonomers);

    DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);

     if (DROPS(i).xslxIndex==1121)
        pleacM=find(DROPS(i).Rnorm<4);
        DROPS(i).Rnorm(pleacM)=[];
        DROPS(i).RhoNorm(pleacM)=[];
    end

    if (DROPS(i).xslxIndex==1126)
        pleacM=find(DROPS(i).Rnorm<4);
        DROPS(i).Rnorm(pleacM)=[];
        DROPS(i).RhoNorm(pleacM)=[];
    end

end

%%%%%%% Calculate the average values for each condition

AverageValues=struct;
typeOfExpVector=unique([DROPS.typeOfExp]);
NoOfConditions=length(typeOfExpVector);

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    AverageValues(j).LEG=DROPS(placeDrops(1)).typeOfExpString;
    RhoAllData=[DROPS(placeDrops).RhoNorm];
    RrAllData=[DROPS(placeDrops).Rnorm];
    [AverageValues(j).meanRho,AverageValues(j).lowerLineRho,AverageValues(j).upperLineRho,AverageValues(j).meanRrho] = meanGaussianMM(RrAllData,RhoAllData, 1);
end
% close all

Fig=figure;
% Colorsjet=jet(120);

if (NoOfConditions>1)
    Jinitial=2;
else Jinitial=1;
end
% Jinitial=1;
for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    for i=placeDrops(1):placeDrops(end)
          h(i)=plot(DROPS(i).Rnorm,DROPS(i).RhoNorm,'LineWidth',0.5,'Color',[128/255 128/255 128/255]);
%         h(i)=plot(DROPS(i).Rnorm,DROPS(i).RhoNorm,'LineWidth',0.5,'Color',Colorsjet(i*10,:));
 %        h(i)=plot(DROPS(i).Rnorm,DROPS(i).RhoNorm,'LineWidth',0.5,'Color',DROPS(i).Color);

        hold on
    end
    
    hold on
     plot(AverageValues(j).meanRrho,AverageValues(j).meanRho,'Color',[128/255 128/255 128/255],'LineWidth',1.5)
%    plot(AverageValues(j).meanRrho,AverageValues(j).meanRho,'Color',DROPS(i).Color,'LineWidth',1.5)

%     hold on
%     plot(AverageValues(j).meanRrho,AverageValues(j).lowerLineRho,'Color','k','LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).meanRrho,AverageValues(j).upperLineRho,'Color','k','LineWidth',0.5)
%     
end

if (NoOfConditions>1)
    j=1;
    hold on
    plot(AverageValues(j).meanRrho,AverageValues(j).meanRho,'Color','k','LineWidth',1.5)
end

% legend(h(index_drops),LEG)
ylim([0 1.1])
% xlim([0 40])
xlabel('r-r_0 [\mum]','FontSize',10)
ylabel('Normalized \rho [a.u]','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'rho vs R.fig'));
saveas(Fig,fullfile(save_to_file,'rho vs R.tif'));
saveas(Fig,fullfile(save_to_file,'rho vs R'),'epsc');

close(Fig);
% Fig=figure;

for i=1:length(DROPS)
    i
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    placeNearblob=find(DROPS(i).Rrho>DROPS(i).CHUNK_radius-2)
    MaxRho=max(DROPS(i).RhoMinusMonomers(placeNearblob));
    DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./MaxRho;
%     DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./max(DROPS(i).RhoMinusMonomers);
    DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
    DROPS(i).RnormByRdrop=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation)/DROPS(i).DropSize;
end

%%%%%%% Calculate the average values for each condition

AverageValues=struct;
typeOfExpVector=unique([DROPS.typeOfExp]);
NoOfConditions=length(typeOfExpVector);

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
        AverageValues(j).LEG=DROPS(placeDrops(1)).typeOfExpString;

    RhoAllData=[DROPS(placeDrops).RhoNorm];
    RrAllData=[DROPS(placeDrops).RnormByRdrop];
    [AverageValues(j).meanRho2,AverageValues(j).lowerLineRho2,AverageValues(j).upperLineRho2,AverageValues(j).meanRrho2] = meanGaussianMMv2(RrAllData,RhoAllData, 0.04,0.01);
end
% close(Fig);

Fig=figure;

if (NoOfConditions>1)
    Jinitial=2;
else Jinitial=1;
end

for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    for i=placeDrops(1):placeDrops(end)
        h(i)=plot(DROPS(i).RnormByRdrop,DROPS(i).RhoNorm,'LineWidth',0.5,'Color',[128/255 128/255 128/255]);
        hold on
    end
    
    hold on
    plot(AverageValues(j).meanRrho2,AverageValues(j).meanRho2,'Color',[128/255 128/255 128/255],'LineWidth',1.5)
%     hold on
%     plot(AverageValues(j).meanRrho2,AverageValues(j).lowerLineRho2,'Color','k','LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).meanRrho2,AverageValues(j).upperLineRho2,'Color','k','LineWidth',0.5)
%     
end

if (NoOfConditions>1)
    j=1;
    hold on
    plot(AverageValues(j).meanRrho2,AverageValues(j).meanRho2,'Color','k','LineWidth',1.5)
end

% legend(h(index_drops),LEG)
ylim([0 1.1])
xlim([0 inf])
% xlabel('$\text{\frac{r-r_0}{R_{drop}}}$','FontSize',10,'Interpreter','latex')
% xlabel('^{r-r_0}/_{R_d_r_o_p}','FontSize',10)
xlabel('r-r_0/R_d_r_o_p','FontSize',10)
ylabel('Normalized \rho [a.u]','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'rho vs r_Rdrop.fig'));
saveas(Fig,fullfile(save_to_file,'rho vs r_Rdrop.tif'));
saveas(Fig,fullfile(save_to_file,'rho vs r_Rdrop'),'epsc');

close(Fig)

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
%     close all
    
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
Fig=figure;

if (NoOfConditions>1)
    Jinitial=2;
else Jinitial=1;
end
% Jinitial=1;
for j=Jinitial:NoOfConditions
    
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    for i=placeDrops(1):placeDrops(end)
        h(i)=plot(DROPS(i).NormRhoForDivJ,DROPS(i).NormDivJ,'LineWidth',0.5,'Color',[128/255 128/255 128/255]);
%         h(i)=plot(DROPS(i).NormRhoForDivJ,DROPS(i).NormDivJ,'LineWidth',0.5,'Color',DROPS(i).Color);

        hold on
    end
    
    hold on
   plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).MeanDivJ,'Color',[128/255 128/255 128/255],'LineWidth',1.5)
    
%     plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).MeanDivJ,'Color',DROPS(i).Color,'LineWidth',1.5)
    hold on
%         plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).lowerLineMeanDivJ,'Color','k','LineWidth',1)
%         hold on
%         plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).upperLineMeanDivJ,'Color','k','LineWidth',1)
%         hold on
%     plot(AverageValues(j).MeanRhoForDivJnagative,AverageValues(j).LinearFitDivJ,'--','Color','k','LineWidth',2)
end

if (NoOfConditions>1)
    
    j=1;
    hold on
    plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).MeanDivJ,'Color','k','LineWidth',1)
%     hold on
%     plot(AverageValues(j).MeanRhoForDivJnagative,AverageValues(j).LinearFitDivJ,'--','Color',[128/255 128/255 128/255],'LineWidth',1)
    
end

hold on
plot([0:0.05:1],ones(1,21)*0,'LineWidth',0.5,'Color','k');
% legend(h(index_drops),LEG)
box off

ylim([-1.2 0.2])
% ylim([-1.7 0.7])
xlim([0 1])
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])
xlabel('Normalized \rho [a.u]','FontSize',10)
ylabel('div(J) [a.u]','FontSize',10)

ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'divJ.fig'));
saveas(Fig,fullfile(save_to_file,'divJ.tif'));
saveas(Fig,fullfile(save_to_file,'divJ'),'epsc');

close(Fig)
%% (3) DivJ(R)

for i=1:length(DROPS)
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    DROPS(i).RnormForDivJ=(DROPS(i).Div_Jr_Rrho(1:end-1)-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
end

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    NormRnormForDivJAllData=[DROPS(placeDrops).RnormForDivJ];
    NormDivJAllData=[DROPS(placeDrops).NormDivJ];
    [AverageValues(j).MeanDivJvsR,AverageValues(j).lowerLineMeanDivJvsR,AverageValues(j).upperLineMeanDivJvsR,AverageValues(j).MeanR_ForDivJ] = meanGaussianMM(NormRnormForDivJAllData,NormDivJAllData, 1);
    [Nmeany2] = NmeanGaussian(NormRnormForDivJAllData,NormDivJAllData, 1);
%     Nratio=Nmeany2/(length(placeDrops)*8);
%     
%     N_remove=find(Nratio<0.6);
%     AverageValues(j).MeanDivJvsR(N_remove)=[];
%     AverageValues(j).lowerLineMeanDivJvsR(N_remove)=[];
%     AverageValues(j).upperLineMeanDivJvsR(N_remove)=[];
%     AverageValues(j).MeanR_ForDivJ(N_remove)=[];
end
% close all

%%%%%%Plot
Fig=figure;

if (NoOfConditions>1)
    Jinitial=2;
else Jinitial=1;
end

for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    for i=placeDrops(1):placeDrops(end)
        h(i)=plot(DROPS(i).RnormForDivJ,DROPS(i).NormDivJ,'LineWidth',0.5,'Color',DROPS(i).Color);
        hold on
    end
    
    hold on
    plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).MeanDivJvsR,'Color',DROPS(i).Color,'LineWidth',1)
%     hold on
%     plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).lowerLineMeanDivJvsR,'Color','k','LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).upperLineMeanDivJvsR,'Color','k','LineWidth',0.5)
%     
end

if (NoOfConditions>1)
    j=1;
    hold on
    plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).MeanDivJvsR,'Color',[128/255 128/255 128/255],'LineWidth',1)
end

hold on
plot([0:1:35],zeros(1,length([0:1:35])),'LineWidth',0.5,'Color','k');

% legend(h(index_drops),LEG)

xlabel('r-r_0 [\mum]','FontSize',10)
ylabel('div(J) [a.u]','FontSize',10)
ylim([-1.5 0.5])
% xlim([0 35])
% ylim([0 5])

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])

savefig(fullfile(save_to_file,'divJ vs r.fig'));
saveas(Fig,fullfile(save_to_file,'divJ vs r.tif'));
saveas(Fig,fullfile(save_to_file,'divJ vs r'),'epsc');

close(Fig)

%% Div v as a function of R

for i=1:length(DROPS)
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    DROPS(i).RnormForDivJ=(DROPS(i).Div_Jr_Rrho(1:end-1)-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
    DROPS(i).r0=DROPS(i).CHUNK_radius-DROPSafterVtranslation(j).TotalTranslation;
end

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    NormRnormForDivJAllData=[DROPS(placeDrops).RnormForDivJ];
    ForceBalanceEqAllData=[DROPS(placeDrops).ForceBalanceEq];
    [AverageValues(j).MeanForceBalanceEqVsR,AverageValues(j).lowerLineMeanForceBalanceEqVsR,AverageValues(j).upperLineMeanForceBalanceEqVsR,AverageValues(j).MeanR_ForForceBalanceEq] = meanGaussianMM(NormRnormForDivJAllData,ForceBalanceEqAllData, 1);
%     Nratio=Nmeany2/(length(placeDrops)*8);
%     
%     N_remove=find(Nratio<0.6);
%     AverageValues(j).MeanDivJvsR(N_remove)=[];
%     AverageValues(j).lowerLineMeanDivJvsR(N_remove)=[];
%     AverageValues(j).upperLineMeanDivJvsR(N_remove)=[];
%     AverageValues(j).MeanR_ForDivJ(N_remove)=[];
end
% close all

%%%%%%Plot
Fig=figure;

% if (NoOfConditions>1)
%     Jinitial=2;
% else Jinitial=1;
% end
Jinitial=1;

for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    r0=zeros(length(placeDrops));
    
    for i=placeDrops(1):placeDrops(end)
        plot(DROPS(i).RnormForDivJ,DROPS(i).ForceBalanceEq,'LineWidth',0.5,'Color',DROPS(i).Color);
        hold on
%         r0(k)=DROPS(i).CHUNK_radius-DROPSafterVtranslation(j).TotalTranslation;
    end
 
    AVGr0(j)=mean([DROPS(placeDrops).r0]);
    place_r0=max(find(AverageValues(j).MeanR_ForForceBalanceEq<AVGr0(j)));
    if (length(place_r0)==0) 
        place_r0=1;
    end
    r0ForThisCondition(j)=AverageValues(j).MeanR_ForForceBalanceEq(place_r0(1));
    DivVat_r0(j)=AverageValues(j).MeanForceBalanceEqVsR(place_r0);
    
    
    hold on
  %  hh(j)=plot(AverageValues(j).MeanR_ForForceBalanceEq,AverageValues(j).MeanForceBalanceEqVsR,'Color',DROPS(i).Color,'LineWidth',2);
   hh(j)=plot(AverageValues(j).MeanR_ForForceBalanceEq,AverageValues(j).MeanForceBalanceEqVsR,'Color',DROPS(placeDrops(1)).Color,'LineWidth',2);
    hold on
    plot(r0ForThisCondition(j),DivVat_r0(j),'*','LineWidth',3,'Color','k')
    hold on
     thisLegend{j}=AverageValues(j).LEG;
%     hold on
%     plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).lowerLineMeanDivJvsR,'Color','k','LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).upperLineMeanDivJvsR,'Color','k','LineWidth',0.5)
%     
end

% if (NoOfConditions>1)
%     j=1;
%     hold on
%     hh(j)=plot(AverageValues(j).MeanR_ForForceBalanceEq,AverageValues(j).MeanForceBalanceEqVsR,'Color',[128/255 128/255 128/255],'LineWidth',1)
%     thisLegend{j}=AverageValues(j).LEG;
% end


legend(hh,thisLegend)
%legend(thisLegend)

xlabel('r-r_0 [\mum]','FontSize',10)
ylabel('Div V','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
% set(gcf,'position',[7 7 5 4])
set(gcf,'position',[7 7 20 20])
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])

savefig(fullfile(save_to_file,'Div V vs r.fig'));
saveas(Fig,fullfile(save_to_file,'Div V vs r.tif'));
saveas(Fig,fullfile(save_to_file,'Div V vs r'),'epsc');

close(Fig);

%% Div V as a function of rho

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)); 
    Div_Jr_RhoAllData=[DROPS(placeDrops).NormRhoForDivJ];
    ForceBalanceEqAllData=[DROPS(placeDrops).ForceBalanceEq];
    [AverageValues(j).MeanForceBalanceEqVsRho,AverageValues(j).lowerLineMeanForceBalanceEqVsRho,AverageValues(j).upperLineMeanForceBalanceEqVsRho,AverageValues(j).MeanRho_ForForceBalanceEq] =meanGaussianMMv2(Div_Jr_RhoAllData,ForceBalanceEqAllData, 0.05,0.05);
%     Nratio=Nmeany2/(length(placeDrops)*8);
%     
%     N_remove=find(Nratio<0.6);
%     AverageValues(j).MeanDivJvsR(N_remove)=[];
%     AverageValues(j).lowerLineMeanDivJvsR(N_remove)=[];
%     AverageValues(j).upperLineMeanDivJvsR(N_remove)=[];
%     AverageValues(j).MeanR_ForDivJ(N_remove)=[];
end
% close all

%%%%%%Plot
Fig=figure;

if (NoOfConditions>1)
    Jinitial=2;
else Jinitial=1;
end

for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    for i=placeDrops(1):placeDrops(end)
        h(i)=plot(DROPS(i).NormRhoForDivJ,DROPS(i).ForceBalanceEq,'LineWidth',0.5,'Color',DROPS(i).Color);
        hold on
    end
    
    hold on
    plot(AverageValues(j).MeanRho_ForForceBalanceEq,AverageValues(j).MeanForceBalanceEqVsRho,'Color',DROPS(i).Color,'LineWidth',1)
%     hold on
%     plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).lowerLineMeanDivJvsR,'Color','k','LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).upperLineMeanDivJvsR,'Color','k','LineWidth',0.5)
%     
end

if (NoOfConditions>1)
    j=1;
    hold on
    plot(AverageValues(j).MeanRho_ForForceBalanceEq,AverageValues(j).MeanForceBalanceEqVsRho,'Color',[128/255 128/255 128/255],'LineWidth',1)
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

savefig(fullfile(save_to_file,'Div V vs rho.fig'));
saveas(Fig,fullfile(save_to_file,'Div V vs rho.tif'));
saveas(Fig,fullfile(save_to_file,'Div V vs rho'),'epsc');

close(Fig);
%% (4) DivJ4piR^2(R)

Fig=figure;

for i=1:length(DROPS)
    A=(DROPS(i).Div_Jr)*4*pi.*(DROPS(i).Div_Jr_Rrho(1:end-1)).^2;
    hold on
    h(i) = plot(DROPS(i).Div_Jr_Rrho(1:end-1),A,'LineWidth',0.5,'Color',DROPS(i).Color);
    A(isnan(A))=[];
    DROPS(i).SumDivj4piR2=sum(A);
end

% legend(h(index_drops),LEG)
box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])
xlabel('r[\mum]','FontSize',10)
ylabel('div(J)4piR^2','FontSize',10)

savefig(fullfile(save_to_file,'divJ4piR2 vs r.fig'));
saveas(Fig,fullfile(save_to_file,'divJdivJ4piR2 vs r.tif'));
saveas(Fig,fullfile(save_to_file,'divJdivJ4piR2 vs r'),'epsc');

save(fullfile(save_to_file,'DROPS.mat'),'DROPS')
save(fullfile(save_to_file,'AverageValues.mat'),'AverageValues')
close(Fig)
end




