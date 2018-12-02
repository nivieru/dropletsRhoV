%%%% Maya Malik Garbi - last modified 22/10/17
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function PlotDiffConditionsToKK_DivJ_AVGvaluesModefiedForMyosinData(DROPSforRho,DROPSafterVtranslation,save_to_file)

DROPS=DROPSforRho;
AverageValues=struct;


%% (1) Rho(R)

for i=1:length(DROPS)
    i
%     j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
%     DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./max(DROPS(i).RhoMinusMonomers);
%     DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
%     
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    placeNearblob=find(DROPS(i).Rrho>DROPS(i).CHUNK_radius-2);
    DROPS(i).MaxRho=max(DROPS(i).RhoMinusMonomers(placeNearblob));
    DROPS(i).PlaceMaxRho=find(DROPS(i).RhoMinusMonomers==DROPS(i).MaxRho);
    R=DROPS(i).Rrho;
    DROPS(i).RMaxRho=R(DROPS(i).PlaceMaxRho);
    DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./DROPS(i).MaxRho;
    DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);

end

for i=10:length(DROPS)
    i
%     j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
%     DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./max(DROPS(i).RhoMinusMonomers);
%     DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
%     
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    
    R=DROPS(i).Rrho;
    Rho=DROPS(i).RhoMinusMonomers;
    PlaceMaxRhoByLA=max(find(R<DROPS(i-9).RMaxRho));
    
    DROPS(i).MaxRhoByLA=Rho(PlaceMaxRhoByLA);
    
    DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./DROPS(i).MaxRhoByLA;
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
    MaxMeanRho(j)=max(AverageValues(j).meanRho);
    MaxMeanRhoPLACE(j)=find(AverageValues(j).meanRho==MaxMeanRho(j));
    Rtemp=AverageValues(j).meanRrho;
    RinMaxMeanRho(j)=Rtemp(MaxMeanRhoPLACE(j));
end
close all

%%% Normalize Myosin by the LA max place 
Rtemp=AverageValues(2).meanRrho;
RhoTEMP=AverageValues(2).meanRho;
RatMaxRhobyLA_Place=max(find(Rtemp<RinMaxMeanRho(1)));
MaxRhoForNormalization=RhoTEMP(RatMaxRhobyLA_Place);
MaxMeanRho(2)=MaxRhoForNormalization;

h=figure (1);
Jinitial=1;

for j=Jinitial:NoOfConditions
 %   plot(AverageValues(j).meanRrho,(AverageValues(j).meanRho),'Color',AverageValues(j).color,'LineWidth',1)
       plot(AverageValues(j).meanRrho,(AverageValues(j).meanRho)/MaxMeanRho(j),'Color',AverageValues(j).color,'LineWidth',1)

    hold on
%    plot(AverageValues(j).meanRrho,(AverageValues(j).lowerLineRho),'Color',AverageValues(j).color,'LineWidth',0.5)
        plot(AverageValues(j).meanRrho,(AverageValues(j).lowerLineRho)/MaxMeanRho(j),'Color',AverageValues(j).color,'LineWidth',0.5)

    hold on
%    plot(AverageValues(j).meanRrho,(AverageValues(j).upperLineRho),'Color',AverageValues(j).color,'LineWidth',0.5)
    plot(AverageValues(j).meanRrho,(AverageValues(j).upperLineRho)/MaxMeanRho(j),'Color',AverageValues(j).color,'LineWidth',0.5)

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

savefig(fullfile(save_to_file,'norm rho vs R.fig'));
saveas(figure (1),fullfile(save_to_file,'norm rho vs R.tif'));
saveas(figure (1),fullfile(save_to_file,'norm rho vs R'),'epsc');


