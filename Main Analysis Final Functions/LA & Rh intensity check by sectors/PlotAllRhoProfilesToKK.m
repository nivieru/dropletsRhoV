%%%%% Maya Malik Garbi - last modified 20/10/17
%%%%% This function import structure named DROPS located in 'FileName' containing the average
%%%%% intensity profiles for drops labeld with Rhodamine actin and Life act

%%%%% DROPS has the following fields:

%%%%% (1) DROPS.xslxIndex - The drop line number at the xslx sheet
%%%%% (2) DROPS.FileName - The file name the drop save in.
%%%%% (3) DROPS.typeOfExp - code number indicating the type of experiment.
%%%%% (4) DROPS.typeOfExpString
%%%%% (5) DROPS.Color - specify the color in which the profile will be drawen.
%%%%% (6) DROPS.RhcalibrationNum - Actin calibration number = 1/(ratio between different exposure times)
%%%%% (7) DROPS.LAcalibrationNum - Life Act calibration number = 1/(ratio between different exposure times)
%%%%% (8) DROPS.DropSize - Drop radius.
%%%%% (9) DROPS.ActinNetworkRadius - Actin network radius.
%%%%% (10) DROPS.CHUNK_radius - blob radius.
%%%%% (11) DROPS.LA_Rho - Average rho for life act.
%%%%% (12) DROPS.LA_Rrho - R vector fit to LA Rho vector.
%%%%% (13) DROPS.LA_background - LA monomers background - mean I(Rnetwork:Rdrop).
%%%%% (14) DROPS.LA_Rho - Average rho for actin.
%%%%% (15) DROPS.LA_Rrho - R vector fit to actin Rho vector.
%%%%% (16) DROPS.Rh_background - actin monomers background - mean I(Rnetwork:Rdrop).

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Actin & LA labeling\'; %%%% insert the file name the DROPS structure located in.
save_to_file=[FileName,'figures\']; %%%% insert file name in which the figures will be saved in.
mkdir(save_to_file)
DROPS=importdata([FileName,'DROPS.mat']);

%% PART 1 - creating LEG vector to insert only one legend line for each type of experiment.

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

%% PART 2 - Calculating the average rho(r) over the differnet drops in each type of experiment.

AverageValuesRho=struct;
typeOfExpVector=unique([DROPS.typeOfExp]);
NoOfConditions=length(typeOfExpVector);

for j=1:NoOfConditions
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    placeSmallThen45=find([DROPS(placeDrops).DropSize]<45);
    placeDrops=placeDrops(placeSmallThen45);
    RhoAllData=[DROPS(placeDrops).Rh_Rho];
    RrAllData=[DROPS(placeDrops).Rh_Rrho];
    [AverageValuesRho(j).meanRho,AverageValuesRho(j).lowerLineRho,AverageValuesRho(j).upperLineRho,AverageValuesRho(j).meanRrho] = meanGaussianMM(RrAllData,RhoAllData, 1);
    
    [Nmeany2] = NmeanGaussian(RrAllData,RhoAllData,1);
    Nratio=Nmeany2/(length(placeDrops)*8);
    
    N_remove=find(Nratio<0.6);
    AverageValuesRho(j).meanRho(N_remove)=[];
    AverageValuesRho(j).lowerLineRho(N_remove)=[];
    AverageValuesRho(j).upperLineRho(N_remove)=[];
    AverageValuesRho(j).meanRrho(N_remove)=[];
    figure
    plot(AverageValuesRho(j).meanRrho, AverageValuesRho(j).meanRho)
    
end

%% PART 3 - PLOT  Actin Rho(r)

%%%%% Figure 1 - Actin

figure (1)
for i=1:length(DROPS)
%     if (DROPS(i).DropSize<40)  %%% OPTION TO CHOOSE SPESIFIC DROP RADIUS RANGE
        %     if (DROPS(i).DropSize<180) & (DROPS(i).DropSize>150)
        %     h(i)=plot(DROPS(i).Rh_Rrho-DROPS(i).CHUNK_radius,(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).calibrationNum,'LineWidth',1,'Color',DROPS(i).Color);
        h(i)=plot(DROPS(i).Rh_Rrho,(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum,'LineWidth',1,'Color',DROPS(i).Color);
        hold on
%     end
end

ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])
%xlabel('r-R_0 [\mum]','FontSize',24)
xlabel('r [\mum]','FontSize',10)
ylabel('\rho [a.u]','FontSize',10)
title('Actin','FontSize',10)
ylim([-3000 inf])
xlim([0 160])

box off
legend(h(index_drops),LEG)

savefig([save_to_file,'Actin.fig']);
saveas(figure (1),[save_to_file,'Actin.tif']);
saveas(figure (1),[save_to_file,'Actin'],'epsc');

%% PART 4 - PLOT  Actin Rho(r/Rdrop)

%%%%% Figure 1 - Actin

figure (2)

for i=1:length(DROPS)
%     if (DROPS(i).DropSize<40)  %%% OPTION TO CHOOSE SPESIFIC DROP RADIUS RANGE
        %     if (DROPS(i).DropSize<180) & (DROPS(i).DropSize>150)
        %     h(i)=plot(DROPS(i).Rh_Rrho-DROPS(i).CHUNK_radius,(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).calibrationNum,'LineWidth',1,'Color',DROPS(i).Color);
        h(i)=plot(DROPS(i).Rh_Rrho./DROPS(i).DropSize,(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum,'LineWidth',0.5,'Color',DROPS(i).Color);
        hold on
%     end
end

ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])
%xlabel('r-R_0 [\mum]','FontSize',24)
xlabel('r/R_d_r_o_p','FontSize',10)
ylabel('\rho [a.u]','FontSize',10)
title('Actin','FontSize',10)
 xlim([0 1])
 ylim([-3000 inf])
box off
legend(h(index_drops),LEG)

savefig([save_to_file,'Actin vs r_Rdrop.fig']);
saveas(figure (2),[save_to_file,'Actin vs r_Rdrop.tif']);
saveas(figure (2),[save_to_file,'Actin vs r_Rdrop'],'epsc');



%% PART 5 - PLOT  sum (rho*4piR^2) vs Rdrop

figure (2)
for i=1:length(DROPS)
    %rho=(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum;
    rho=DROPS(i).Rh_Rho*DROPS(i).RhcalibrationNum;
    r=DROPS(i).Rh_Rrho;
    for j=1:length(rho)
        rho4piR2(j)=abs(rho(j)*4*pi*(r(j).^2));   %%%% Sum in spherical coordinates
%         rho4piR2(j)=abs(rho(j)*2*pi*(r(j)));  %%%% Sum in cylindrical coordinates
    end
    S(i)=sum(rho4piR2);        %%%% Sum in spherical coordinates
%     S(i)=30*sum(rho4piR2);   %%%% For sum in cylindrical coordinates
    %
    h(i)=plot(DROPS(i).DropSize,S(i),'*','LineWidth',1,'Color',DROPS(i).Color);
    hold on
end

ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])
xlabel('R_d_r_o_p [\mum]','FontSize',10)
ylabel('sum(4\pi*r(i)^2\rho(i))[a.u]','FontSize',10)
title('Actin','FontSize',10)
xlim([0 inf])
box off
legend(h(index_drops),LEG)

savefig([save_to_file,'rho4piR2 vs Rdrop.fig']);
saveas(figure (2),[save_to_file,'rho4piR2 vs Rdrop.tif']);
saveas(figure (2),[save_to_file,'rho4piR2 vs Rdrop'],'epsc');

%% PART 6 - PLOT  max(Actin Intensity) vs drop size

figure (3)
for i=1:length(DROPS)
    h(i)=plot(DROPS(i).DropSize,(max(DROPS(i).Rh_Rho)-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum,'*','Color',DROPS(i).Color);
    hold on
end

ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])

xlabel('R_d_r_o_p [\mum]','FontSize',10)
ylabel('max(\rho) [a.u]','FontSize',10)
title('Rh 1.5uM ActA','FontSize',10)
box off

savefig([save_to_file,'Actin max rho vs Rdrop ActA.fig']);
saveas(figure (3),[save_to_file,'Actin max rho vs Rdrop ActA.tif']);
saveas(figure (3),[save_to_file,'Actin max rho vs Rdrop ActA'],'epsc');

%% PART 7 - PLOT  LA Rho(r)

figure (4)
for i=1:length(DROPS)
    h(i)=plot(DROPS(i).LA_Rrho,(DROPS(i).LA_Rho-DROPS(i).LA_background)*DROPS(i).LAcalibrationNum,'LineWidth',1,'Color',DROPS(i).Color);
    hold on
end

ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])
xlabel('r [\mum]','FontSize',10)
ylabel('\rho [a.u]','FontSize',10)
title('LA','FontSize',10)
xlim([0 160])
box off
legend(h(index_drops),LEG)

savefig([save_to_file,'LA.fig']);
saveas(figure (4),[save_to_file,'LA.tif']);
saveas(figure (4),[save_to_file,'LA'],'epsc');


%% PART 8 - Actin and Life Act to each drop

for i=1:length(DROPS)
    figure
    rho=(DROPS(i).LA_Rho-DROPS(i).LA_background)*DROPS(i).LAcalibrationNum;
    placeRblob=max(find(DROPS(i).LA_Rrho<DROPS(i).CHUNK_radius));
    h(i)=plot(DROPS(i).LA_Rrho,rho/max(rho(placeRblob-16:placeRblob+16)),'LineWidth',1,'Color',DROPS(i).Color,'Marker','*');
    hold on
    rho=(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum;
    g(i)=plot(DROPS(i).Rh_Rrho, rho/max(rho) ,'LineWidth',1,'Color',DROPS(i).Color,'LineStyle','--');
    hold on
    
    ax=gca;
    set(ax,'FontSize',8)
    set(gcf,'units','centimeter')
    set(gcf,'position',[7 7 5 3.5])
    legend('LA','Rh')
    xlabel('r [\mum]','FontSize',10)
    ylabel('\rho [a.u]','FontSize',10)
    box off
end

%% PART 9 - Actin I(monomers) vs Rdrop

figure
for i=1:length(DROPS)
    h(i)=plot(DROPS(i).DropSize,DROPS(i).Rh_background,'*','Color',DROPS(i).Color,'Marker','*');
    hold on
end
    
    ax=gca;
    set(ax,'FontSize',8)
    set(gcf,'units','centimeter')
    set(gcf,'position',[7 7 5 3.5])
    title('Actin')
    xlabel('R_d_r_o_p [\mum]','FontSize',10)
    ylabel('I_m_o_n_o_m_e_r_s [a.u]','FontSize',10)
    box off
    
    
savefig([save_to_file,'Imonomers vs Rdrop.fig']);
saveas(figure (1),[save_to_file,'Imonomers vs Rdro.tif']);
saveas(figure (1),[save_to_file,'Imonomers vs Rdro'],'epsc');


%% PART 10 - LA I(monomers) vs Rdrop

figure
for i=1:length(DROPS)
    h(i)=plot(DROPS(i).DropSize,DROPS(i).LA_background,'*','Color',DROPS(i).Color,'Marker','*');
    hold on
end
    
    ax=gca;
    set(ax,'FontSize',8)
    set(gcf,'units','centimeter')
    set(gcf,'position',[7 7 5 3.5])
    title('Life Act')
    xlabel('R_d_r_o_p [\mum]','FontSize',10)
    ylabel('I_m_o_n_o_m_e_r_s [a.u]','FontSize',10)
    box off
    
savefig([save_to_file,'LA Imonomers vs Rdrop.fig']);
saveas(figure (1),[save_to_file,'LA Imonomers vs Rdro.tif']);
saveas(figure (1),[save_to_file,'LA Imonomers vs Rdro'],'epsc');

