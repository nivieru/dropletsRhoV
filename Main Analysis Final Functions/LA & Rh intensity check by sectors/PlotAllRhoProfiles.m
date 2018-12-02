%%%%% Plot all Rho profiles

directory=['C:\Users\Maya\Documents'];
filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8.xlsx'];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Actin & LA labeling\Figures\'];
mkdir(save_to_file);

DropsIndex=[747:858];
DROPSforRho=GenerateDropsStractureToRho(directory,filename,DropsIndex);

DROPS=DROPSforRho;

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


%%%%% Figure 1 - Actin 

figure
for i=1:22
      if (DROPS(i).DropSize<40)
     % if (DROPS(i).DropSize<180) & (DROPS(i).DropSize>150)
%     h(i)=plot(DROPS(i).Rh_Rrho-DROPS(i).CHUNK_radius,(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).calibrationNum,'LineWidth',1,'Color',DROPS(i).Color);
      h(i)=plot(DROPS(i).Rh_Rrho,(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum,'LineWidth',1,'Color',DROPS(i).Color);
      hold on 
       end
end

% legend(h(index_drops),LEG)
% xlabel('r-R_0 [\mum]','FontSize',24)
xlabel('r [\mum]','FontSize',24)
ylabel('\rho [a.u]','FontSize',24)
title('Actin','FontSize',14)
xlim([0 inf])
box off
ax=gca;
set(ax,'FontSize',16)
 legend(h(index_drops),LEG)
% 
savefig([save_to_file,'Actin.fig']);
saveas(figure (1),[save_to_file,'Actin.tif']);
saveas(figure (1),[save_to_file,'Actin'],'epsc');


%%%%% Figure 1* - Actin sum(rho*4piR^2) 

figure
for i=1:length(DROPS)
%      if (DROPS(i).DropSize>180)
     %if (DROPS(i).DropSize<180) & (DROPS(i).DropSize>150)
     
%       rho=(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum;
rho=DROPS(i).Rh_Rho*DROPS(i).RhcalibrationNum;
      r=DROPS(i).Rh_Rrho;
      for j=1:length(rho)
%          rho4piR2(j)=abs(rho(j)*4*pi*(r(j).^2));
            rho4piR2(j)=abs(rho(j)*2*pi*(r(j)));
      end
       
   %    S(i)=sum(rho4piR2);
       S(i)=30*sum(rho4piR2);
%       
      h(i)=plot(DROPS(i).DropSize,S(i),'*','LineWidth',1,'Color',DROPS(i).Color);
      hold on 
%       end
end

% legend(h(index_drops),LEG)
% xlabel('r-R_0 [\mum]','FontSize',24)
xlabel('R_d_r_o_p [\mum]','FontSize',24)
ylabel('\rho [a.u]','FontSize',24)
title('Actin','FontSize',14)
xlim([0 inf])
box off
ax=gca;
set(ax,'FontSize',16)
 legend(h(index_drops),LEG)
% 
savefig([save_to_file,'rho4piR2 vs Rdrop.fig']);
saveas(figure (1),[save_to_file,'rho4piR2 vs Rdrop.tif']);
saveas(figure (1),[save_to_file,'rho4piR2 vs Rdrop'],'epsc');




%%%%% Figure 2 - max(Actin Intensity) vs drop size

figure
 for i=84:112
%      for i=1:length(DROPS)
%     if (DROPS(i).ActinNetworkRadius>100)
%     if (DROPS(i).ActinNetworkRadius>80) & (DROPS(i).ActinNetworkRadius>100)
    h(i)=plot(DROPS(i).DropSize,(max(DROPS(i).Rh_Rho)-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum,'*','Color',DROPS(i).Color);
    hold on 
%     end
 end

xlabel('R_d_r_o_p [\mum]','FontSize',24)
ylabel('max(\rho) [a.u]','FontSize',24)
title('Rh 1.5uM ActA','FontSize',24)
box off
ax=gca;
set(ax,'FontSize',16)

savefig([save_to_file,'Actin max rho vs Rdrop ActA.fig']);
saveas(figure (1),[save_to_file,'Actin max rho vs Rdrop ActA.tif']);
saveas(figure (1),[save_to_file,'Actin max rho vs Rdrop ActA'],'epsc');


%%%%% Figure 3 - Life Act

figure
for i=1:length(DROPS)
    h(i)=plot(DROPS(i).LA_Rrho,(DROPS(i).LA_Rho-DROPS(i).LA_background)*DROPS(i).LAcalibrationNum,'LineWidth',1,'Color',DROPS(i).Color);
    hold on  
end

% legend(h(index_drops),LEG)
% xlabel('r-R_0 [\mum]','FontSize',24)
xlabel('r [\mum]','FontSize',24)
ylabel('\rho [a.u]','FontSize',24)
title('LA','FontSize',24)
box off
ax=gca;
set(ax,'FontSize',16)
legend(h(index_drops),LEG)

savefig([save_to_file,'LA.fig']);
saveas(figure (2),[save_to_file,'LA.tif']);
saveas(figure (2),[save_to_file,'LA'],'epsc');


%%%%% Figure 4 - Actin and Life Act to each drop 


%for i=1:length(DROPS)
    for i=23:51
    figure
    rho=(DROPS(i).LA_Rho-DROPS(i).LA_background)*DROPS(i).LAcalibrationNum;
    h(i)=plot(DROPS(i).LA_Rrho,rho/max(rho),'LineWidth',1,'Color',DROPS(i).Color,'Marker','*');
    hold on
    rho=(DROPS(i).Rh_Rho-DROPS(i).Rh_background)*DROPS(i).RhcalibrationNum;
    g(i)=plot(DROPS(i).Rh_Rrho, rho/max(rho) ,'LineWidth',1,'Color',DROPS(i).Color,'LineStyle','--');
    hold on
    legend('LA','Rh') 
    
end
% legend(h(index_drops),LEG)
xlabel('r-R_0 [\mum]','FontSize',24)
ylabel('\rho [a.u]','FontSize',24)
title('LA','FontSize',24)
box off
ax=gca;
set(ax,'FontSize',16)
legend(h(index_drops),LEG)


%%%%% save figures and vectors

save([save_to_file,'DROPS.mat'],'DROPS')

savefig([save_to_file,'divJ4piR2 vs r.fig']);
saveas(figure (4),[save_to_file,'divJdivJ4piR2 vs r.tif']);
saveas(figure (4),[save_to_file,'divJdivJ4piR2 vs r'],'epsc');

save([save_to_file,'DROPS.mat'],'DROPS')

