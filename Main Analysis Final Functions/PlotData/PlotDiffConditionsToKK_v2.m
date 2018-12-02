%%%% Maya Malik Garbi - last modified 9/10/17
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function PlotDiffConditionsToKK(DROPSforRho,DROPSafterVtranslation,save_to_file)

DROPS=DROPSforRho;
%%% Generate vector of indices for legend, each experiment type has one line
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

%%plots

%%% (1) Rho(R)

% %%%% Find rho net
% AverageValues=struct;
%
% for i=1:length(DROPS)
%     DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./max(DROPS(i).RhoMinusMonomers);
%     DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).MinRr);
% end
%
% typeOfExpVector=unique([DROPS.typeOfExp]);
% NoOfConditions=length(typeOfExpVector);
%
% for j=1:NoOfConditions
% placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
% RhoAllData=[DROPS(placeDrops).RhoNorm];
% RrAllData=[DROPS(placeDrops).Rnorm];
% [AverageValues(j).meanRho,AverageValues(j).lowerLineRho,AverageValues(j).upperLineRho,AverageValues(j).meanRrho] = meanGaussianMM(RrAllData,RhoAllData, 1);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all


for i=1:length(DROPS)
    i
    j=find([DROPSafterVtranslation.xslxIndex]==DROPS(i).xslxIndex);
    
    %   Rho=DROPS(i).RhoMinusMonomers
    DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./max(DROPS(i).RhoMinusMonomers);
    %   Rho=DROPS(i).Rho*(0.5/DROPS(i).IntensityUnitsNorm);    %%%%%% 3400 for (exposure time100 gain2 inten300)
    %   Rnorm=(DROPS(i).Rrho-DROPS(i).MinRr);
    DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPSafterVtranslation(j).TotalTranslation);
    
    %   Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius)/(DROPS(i).DropSize-DROPS(i).CHUNK_radius);
    %   Rnorm=(DROPS(i).Rrho);
    %     h(i)=plot(DROPS(i).Rnorm,DROPS(i).Rho,'LineWidth',3,'Color',DROPS(i).Color);
    %     hold on
    
end

%%%%%%% Calculate the average values for each condition

AverageValues=struct;
typeOfExpVector=unique([DROPS.typeOfExp]);
NoOfConditions=length(typeOfExpVector);

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    RhoAllData=[DROPS(placeDrops).RhoNorm];
    RrAllData=[DROPS(placeDrops).Rnorm];
    [AverageValues(j).meanRho,AverageValues(j).lowerLineRho,AverageValues(j).upperLineRho,AverageValues(j).meanRrho] = meanGaussianMM(RrAllData,RhoAllData, 1);
end
close all

h=figure (1);

if (NoOfConditions>1)
Jinitial=2;
else Jinitial=1;
end

% Jinitial=1;

for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    for i=placeDrops(1):placeDrops(end)
        h(i)=plot(DROPS(i).Rnorm,DROPS(i).RhoNorm,'LineWidth',2,'Color',DROPS(i).Color);
        hold on
    end
    
    hold on
    plot(AverageValues(j).meanRrho,AverageValues(j).meanRho,'Color','k','LineWidth',2)
    hold on
    plot(AverageValues(j).meanRrho,AverageValues(j).lowerLineRho,'Color','k','LineWidth',1)
    hold on
    plot(AverageValues(j).meanRrho,AverageValues(j).upperLineRho,'Color','k','LineWidth',1)
    
end

if (NoOfConditions>1)
j=1;
hold on
plot(AverageValues(j).meanRrho,AverageValues(j).meanRho,'Color',[128/255 128/255 128/255],'LineWidth',2)
end


% legend(h(index_drops),LEG)
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])

ylim([-0.1 1.1])
xlim([0 inf])
% ylim([-0.05 inf])
xlabel('r-R_0 [\mum]','FontSize',10)
% xlabel('(r-R_0)/(R_d_r_o_p-R_0)','FontSize',24)
ylabel('Normalized \rho [a.u]','FontSize',10)
% ylabel('\rho [\muM]','FontSize',24)
box off


% ax.XAxis.FontSize=20;
% ax.YAxis.FontSize=20;

savefig([save_to_file,'rho vs R.fig']);
saveas(figure (1),[save_to_file,'rho vs R.tif']);
saveas(figure (1),[save_to_file,'rho vs R'],'epsc');



%%% (3) DivJ vs Rho


for i=1:length(DROPS)
    % for i=1:14
    
    DROPS(i).NormRhoForDivJ=DROPS(i).Div_Jr_Rho(1:end-1)./max(DROPS(i).Div_Jr_Rho);
    DROPS(i).NormDivJ=DROPS(i).Div_Jr./max(DROPS(i).Div_Jr_Rho);
    
    %     h(i) = plot(Rho(1:end-1),DROPS(i).Div_Jr/max(DROPS(i).Div_Jr_Rho),'LineWidth',2,'Color',DROPS(i).Color);
end

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    NormRhoForDivJAllData=[DROPS(placeDrops).NormRhoForDivJ];
    NormDivJAllData=[DROPS(placeDrops).NormDivJ];
    [AverageValues(j).MeanDivJ,AverageValues(j).lowerLineMeanDivJ,AverageValues(j).upperLineMeanDivJ,AverageValues(j).MeanRhoForDivJ] = meanGaussianMMv2(NormRhoForDivJAllData,NormDivJAllData,0.05,0.05);
    close all
    
    %%%% For mDia remove rho>0.8
    if (j==2)
    removeFormDia=find(AverageValues(j).MeanRhoForDivJ>0.8);
    AverageValues(j).MeanRhoForDivJ(removeFormDia)=[];
    AverageValues(j).MeanDivJ(removeFormDia)=[];
    end
    
    %%%Linear fit only to the negative part of the profile
    negative_place=min(find(AverageValues(j).MeanDivJ<0));
    p=polyfit((AverageValues(j).MeanRhoForDivJ(negative_place:end))',(AverageValues(j).MeanDivJ(negative_place:end))',1);
    AverageValues(j).SlopeDivJ=p(1);
    AverageValues(j).MeanRhoForDivJnagative=AverageValues(j).MeanRhoForDivJ(negative_place:end);
    AverageValues(j).LinearFitDivJ=p(1)*(AverageValues(j).MeanRhoForDivJnagative)'+p(2);
end

%%%%%%Plot
h=figure (2);

if (NoOfConditions>1)
Jinitial=2;
else Jinitial=1;
end

% Jinitial=1;

for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
   for i=placeDrops(1):placeDrops(end)
% for i=1:length(DROPS)
        h(i)=plot(DROPS(i).NormRhoForDivJ,DROPS(i).NormDivJ,'LineWidth',1,'Color',DROPS(i).Color);
        hold on
    end
    
    hold on
    plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).MeanDivJ,'Color','k','LineWidth',2)
    hold on
%     plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).lowerLineMeanDivJ,'Color','k','LineWidth',1)
%     hold on
%     plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).upperLineMeanDivJ,'Color','k','LineWidth',1)
%     hold on
     plot(AverageValues(j).MeanRhoForDivJnagative,AverageValues(j).LinearFitDivJ,'--','Color','k','LineWidth',2)
%     
end

if (NoOfConditions>1)

j=1;
hold on
plot(AverageValues(j).MeanRhoForDivJ,AverageValues(j).MeanDivJ,'Color',[128/255 128/255 128/255],'LineWidth',2)
hold on
plot(AverageValues(j).MeanRhoForDivJnagative,AverageValues(j).LinearFitDivJ,'--','Color',[128/255 128/255 128/255],'LineWidth',1)

end

hold on
plot([0:0.05:1],ones(1,21)*0,'LineWidth',0.5,'Color','k');
% legend(h(index_drops),LEG)
box off
ax=gca;
ylim([-1.7 0.7])
xlim([0 1])
% ax.XAxis.FontSize=20;
% ax.YAxis.FontSize=20;
set(ax,'FontSize',8)
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])

xlabel('Normalized \rho [a.u]','FontSize',10)
ylabel('div(J) [a.u]','FontSize',10)

savefig([save_to_file,'divJ.fig']);
saveas(figure (2),[save_to_file,'divJ.tif']);
saveas(figure (2),[save_to_file,'divJ'],'epsc');



%%% (4) DivJ vs R


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
    Nratio=Nmeany2/(length(placeDrops)*8);
    
    N_remove=find(Nratio<0.6);
    AverageValues(j).MeanDivJvsR(N_remove)=[];
    AverageValues(j).lowerLineMeanDivJvsR(N_remove)=[];
    AverageValues(j).upperLineMeanDivJvsR(N_remove)=[];
    AverageValues(j).MeanR_ForDivJ(N_remove)=[];
end
close all

%%%%%%Plot
h=figure (3);

if (NoOfConditions>1)
Jinitial=2;
else Jinitial=1;
end

% Jinitial=1;

for j=Jinitial:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
    for i=placeDrops(1):placeDrops(end)
        h(i)=plot(DROPS(i).RnormForDivJ,DROPS(i).NormDivJ,'LineWidth',2,'Color',DROPS(i).Color);
        hold on
    end
    
    hold on
    plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).MeanDivJvsR,'Color','k','LineWidth',2)
    hold on
    plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).lowerLineMeanDivJvsR,'Color','k','LineWidth',1)
    hold on
    plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).upperLineMeanDivJvsR,'Color','k','LineWidth',1)
    
end

if (NoOfConditions>1)
j=1;
hold on
plot(AverageValues(j).MeanR_ForDivJ,AverageValues(j).MeanDivJvsR,'Color',[128/255 128/255 128/255],'LineWidth',2)
end

hold on
plot([0:1:25],zeros(1,length([0:1:25])),'LineWidth',0.5,'Color','k');

% legend(h(index_drops),LEG)
box off
ax=gca;
% ax.XAxis.FontSize=20;
% ax.YAxis.FontSize=20;
set(ax,'FontSize',8)
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])
xlabel('r-R_0 [\mum]','FontSize',10)
%xlabel('r[\mum]','FontSize',24)
ylabel('div(J) [a.u]','FontSize',10)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])

savefig([save_to_file,'divJ vs r.fig']);
saveas(figure (3),[save_to_file,'divJ vs r.tif']);
saveas(figure (3),[save_to_file,'divJ vs r'],'epsc');

save([save_to_file,'AverageValues.mat'],'AverageValues')

%%% (4) DivJ4piR^2 vs R

h=figure(4);

for i=1:length(DROPS)
    A=(DROPS(i).Div_Jr)*4*pi.*(DROPS(i).Div_Jr_Rrho(1:end-1)).^2;
    hold on
    h(i) = plot(DROPS(i).Div_Jr_Rrho(1:end-1),A,'LineWidth',2,'Color',DROPS(i).Color);
    A(isnan(A))=[];
    DROPS(i).SumDivj4piR2=sum(A);
end

% legend(h(index_drops),LEG)
box off
ax=gca;
% ax.XAxis.FontSize=20;
% ax.YAxis.FontSize=20;
set(ax,'FontSize',8)
% set(gca, 'XTick', [ 0 0.5 1 ])
% set(gca, 'YTick', [ -1 0 1 ])
xlabel('r[\mum]','FontSize',10)
ylabel('div(J)4piR^2','FontSize',10)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])


savefig([save_to_file,'divJ4piR2 vs r.fig']);
saveas(figure (4),[save_to_file,'divJdivJ4piR2 vs r.tif']);
saveas(figure (4),[save_to_file,'divJdivJ4piR2 vs r'],'epsc');

save([save_to_file,'DROPS.mat'],'DROPS')

end




