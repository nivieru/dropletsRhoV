%%%% Maya Malik Garbi - last modified 22/10/17
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function DROPSafterVtranslation=PlotDiffConditionsToKKonlyV_AVGvalues(DROPS,save_to_file,XtranslationByLinearFit)
% Directory='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\';
% rShift=importdata(fullfile(Directory,'Paper figures 21_3\GeneralFielsForData\rShift.mat'));
% DefineAverageVrange=importdata(fullfile(Directory,'Paper figures 21_3\GeneralFielsForData\DefineAverageVrange.mat'));
% DefineAverageVrangeTypeOfExp=[DefineAverageVrange.typeOfExp];
% rShiftTypeOfExp=[rShift.typeOfExp];
% rShiftSHIFTS=[rShift.ShiftFinal];


NremoveNumber=0.6;
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


%%% (1) Vr vs R

%%%%%%% average and STD to all the data
typeOfExpVector=unique([DROPS.typeOfExp]);
NoOfConditions=length(typeOfExpVector);

for j=1:NoOfConditions
    
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    VrAllData=[DROPS(placeDrops).Vr];
    RrAllData=[DROPS(placeDrops).RrMinusR0];
    [AverageValues(j).meany,AverageValues(j).lowerLine,AverageValues(j).upperLine,AverageValues(j).xval] = meanGaussianMM(RrAllData,VrAllData, 1);
    
    [Nmeany] = NmeanGaussian(RrAllData,VrAllData, 1);
    Nratio=Nmeany/max(Nmeany);
     N_remove=find(Nratio<NremoveNumber);
 %    N_remove=find(Nratio<0.6);
    
    AverageValues(j).meany(N_remove)=[];
    AverageValues(j).lowerLine(N_remove)=[];
    AverageValues(j).upperLine(N_remove)=[];
    AverageValues(j).xval(N_remove)=[];
    
    AverageValues(j).typeOfExp=DROPS(placeDrops(1)).typeOfExp;
    AverageValues(j).color=DROPS(placeDrops(1)).Color;
    AverageValues(j).LEG=DROPS(placeDrops(1)).typeOfExpString;
    LEG2{i}=(DROPS(placeDrops(1)).typeOfExpString);
    
    %%% modified at 15.1.18
    %%% loop to find (maxVnumber,minVnumber)
    n=1;
     for i=placeDrops(1):placeDrops(end)
         maxV(n)=max(DROPS(i).Vr);
         minV(n)=min(DROPS(i).Vr);
         n=n+1;
     end
     
    maxVnumber=min(maxV);
    minVnumber=max(minV);
    clear maxV
    clear minV
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% modification end
      minimumNumber=minVnumber;
      maxNumber=maxVnumber;

     
%     minimumNumber=-15;
%     maxNumber=-3;

% %%% change I made only for ActA data
% 
%      minimumNumber=-5;
%      maxNumber=-1;
%     
%     if (typeOfExpVector(j)==40) %%% for 1.5uM ActA data
%     minimumNumber=-5;
%     maxNumber=-1;
%     end
    
    %%%% Aligne the profiles
    AVGy=AverageValues(j).meany;
    AVGx=AverageValues(j).xval;
    
    place=find(AVGy>maxNumber);
    AVGy(place)=[];
    AVGx(place)=[];
    place=find(AVGy<minimumNumber);
    AVGy(place)=[];
    AVGx(place)=[];
    
    % for i=1:length(DROPS)
    for i=placeDrops(1):placeDrops(end)
        Rnorm=(DROPS(i).Rr-DROPS(i).CHUNK_radius);
        V=DROPS(i).Vr;
        place=find(V>maxNumber);
        RnormTemp=Rnorm;
        RnormTemp(place)=[];
        V(place)=[];
        place=find(V<minimumNumber);
        RnormTemp(place)=[];
        V(place)=[];
        
        interpRnorm=interp1(V,RnormTemp,AVGy);
        interpRnormWithoutNan=interpRnorm;
        AVGyWithoutNan=AVGy;
        AVGxWithoutNan=AVGx;
        interpRnormWithoutNan(isnan(interpRnorm))=[];
        AVGyWithoutNan(isnan(interpRnorm))=[];
        AVGxWithoutNan(isnan(interpRnorm))=[];
        %     figure
        %     plot(AVGxWithoutNan,AVGyWithoutNan,'r')
        %     hold on
        %     plot(interpRnormWithoutNan,AVGyWithoutNan,'g')
        dx=AVGxWithoutNan-interpRnormWithoutNan;
        [Min_dx,Min_dx_place]=min(dx.^2);
        DROPS(i).dr=dx(Min_dx_place);
        
        if (length(DROPS(i).dr)==0)
            DROPS(i).dr=0;
        end
        
        DROPS(i).RrAfterSift=Rnorm+DROPS(i).dr;
        
    end
    
    
    place=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    [RrAllData,I]=sort([DROPS(place).RrAfterSift]);
    t=[DROPS(place).Vr];
    VrAllData=t(I);
    [AverageValues(j).meany2,AverageValues(j).lowerLine2,AverageValues(j).upperLine2,AverageValues(j).xval2] = meanGaussianMM(RrAllData,VrAllData, 1);
    [Nmeany2] = NmeanGaussian(RrAllData,VrAllData, 1);
    Nratio=Nmeany2/max(Nmeany2);
     N_remove=find(Nratio<NremoveNumber);
%     N_remove=find(Nratio<0.6);
    
    AverageValues(j).meany2(N_remove)=[];
    AverageValues(j).lowerLine2(N_remove)=[];
    AverageValues(j).upperLine2(N_remove)=[];
    AverageValues(j).xval2(N_remove)=[];
    
    %%%% Try to do secound itration
    
    AVGy=AverageValues(j).meany2;
    AVGx=AverageValues(j).xval2;
    
    place=find(AVGy>maxNumber);
    AVGy(place)=[];
    AVGx(place)=[];
    place=find(AVGy<minimumNumber);
    AVGy(place)=[];
    AVGx(place)=[];
    
    % for i=1:length(DROPS)
    for i=placeDrops(1):placeDrops(end)
        Rnorm=(DROPS(i).RrAfterSift);
        V=DROPS(i).Vr;
        place=find(V>maxNumber);
        RnormTemp=Rnorm;
        RnormTemp(place)=[];
        V(place)=[];
        place=find(V<minimumNumber);
        RnormTemp(place)=[];
        V(place)=[];
        
        interpRnorm=interp1(V,RnormTemp,AVGy);
        interpRnormWithoutNan=interpRnorm;
        AVGyWithoutNan=AVGy;
        AVGxWithoutNan=AVGx;
        interpRnormWithoutNan(isnan(interpRnorm))=[];
        AVGyWithoutNan(isnan(interpRnorm))=[];
        AVGxWithoutNan(isnan(interpRnorm))=[];
        %     figure
        %     plot(AVGxWithoutNan,AVGyWithoutNan,'r')
        %     hold on
        %     plot(interpRnormWithoutNan,AVGyWithoutNan,'g')
        dx=AVGxWithoutNan-interpRnormWithoutNan;
        [Min_dx,Min_dx_place]=min(dx.^2);
        DROPS(i).dr2=dx(Min_dx_place);
        
        if (length(DROPS(i).dr2)==0)
            DROPS(i).dr2=0;
        end
        
        DROPS(i).RrAfterSift2=Rnorm+DROPS(i).dr2;
        
    end
    
    
    place=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    [RrAllData,I]=sort([DROPS(place).RrAfterSift2]);
    t=[DROPS(place).Vr];
    VrAllData=t(I);
    [AverageValues(j).meany3,AverageValues(j).lowerLine3,AverageValues(j).upperLine3,AverageValues(j).xval3] = meanGaussianMM(RrAllData,VrAllData, 1);
%     AverageValues(j).meanR=AverageValues(j).xval3;
%     AverageValues(j).meanV=AverageValues(j).meany3;
    
%     [Nmeany3] = NmeanGaussian(RrAllData,VrAllData, 1);
%     Nratio=Nmeany3/max(Nmeany3);
%      N_remove=find(Nratio<NremoveNumber);
% %    N_remove=find(Nratio<0.6);
%     close
%     AverageValues(j).meany3(N_remove)=[];
%     AverageValues(j).lowerLine3(N_remove)=[];
%     AverageValues(j).upperLine3(N_remove)=[];
%     AverageValues(j).xval3(N_remove)=[];
%     
     
    %%%%Linear fit
%     
%     if (typeOfExpVector(j)==58)  %%% for 10 uM alfa actinin
%        place=find(AverageValues(j).xval3>9);
%        LinearPartXval3=AverageValues(j).xval3;
%        LinearPartMeany3=AverageValues(j).meany3;
%        LinearPartXval3(place)=[];
%        LinearPartMeany3(place)=[];
%        p=polyfit(LinearPartXval3',LinearPartMeany3',1);
%        AverageValues(j).SlopeVrVSr=p(1);
%        AverageValues(j).LinearFit=p(1)*([-5:0.25:LinearPartXval3(1) , LinearPartXval3(1) ])'+p(2);
%        AverageValues(j).Xteanslation=p(2)/p(1);
%     else 
%     p=polyfit(AverageValues(j).xval3',AverageValues(j).meany3',1);
%     AverageValues(j).SlopeVrVSr=p(1);
%     AverageValues(j).LinearFit=p(1)*([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3])'+p(2);
%     AverageValues(j).Xteanslation=p(2)/p(1);
%     end
    
    p=polyfit(AverageValues(j).xval3',AverageValues(j).meany3',1);
    AverageValues(j).SlopeVrVSr=p(1);
    AverageValues(j).LinearFit=p(1)*([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3])'+p(2);
%     AverageValues(j).Xteanslation=p(2)/p(1);

%     if (XtranslationByLinearFit=='yes')
    AverageValues(j).Xteanslation=p(2)/p(1);
%     else
%     placeShift=find(rShiftTypeOfExp==AverageValues(j).typeOfExp);
%     AverageValues(j).Xteanslation=-rShiftSHIFTS(placeShift);
%     end
    
    
    %%%Save the total traslation for each drop
    
    for i=placeDrops(1):placeDrops(end)
        DROPS(i).TotalTranslation=DROPS(i).dr+DROPS(i).dr2+AverageValues(j).Xteanslation;
    end  
    
    
    %%% calculate and save final average V vs R
    AvgV=AverageValues(j).meany3;
    AvgR=AverageValues(j).xval3+AverageValues(j).Xteanslation;
%     placeCondition=find(DefineAverageVrangeTypeOfExp==AverageValues(j).typeOfExp);
    
    %%% Remove average on too little data points
%     MaxRForAverage=DefineAverageVrange(placeCondition).RmaxForAverageV;
    
%     if ( MaxRForAverage=='Rmax')
    AverageValues(j).meanR=AvgR;
    AverageValues(j).meanV=AvgV;
%     else
%         cutPlaces=find(AvgR>MaxRForAverage);
%         AvgV(cutPlaces)=[];
%         AvgR(cutPlaces)=[];
%         AverageValues(j).lowerLine3(cutPlaces)=[];
%         AverageValues(j).upperLine3(cutPlaces)=[];
%         AverageValues(j).meanR=AvgR;
%         AverageValues(j).meanV=AvgV;
%         
%     end
    
    
end
% close all
Fig = figure;

Jinitial=1;
 for j=Jinitial:NoOfConditions
     
   plot(AverageValues(j).meanR,AverageValues(j).meanV,'Color',AverageValues(j).color,'LineWidth',1.5)
    hold on
%     plot([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3]+AverageValues(j).Xteanslation,AverageValues(j).LinearFit,'k')
%     hold on
    plot(AverageValues(j).meanR,AverageValues(j).lowerLine3,'Color',AverageValues(j).color,'LineWidth',0.5)
    hold on
    plot(AverageValues(j).meanR,AverageValues(j).upperLine3,'Color',AverageValues(j).color,'LineWidth',0.5)
%      
 end
 
% legend(h(index_drops),LEG)     
box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])
% xlabel('(r-R_0)/(R_d_r_o_p-R_0)','FontSize',24)
xlabel('r-r_0[\mum]','FontSize',10)
ylabel('V[\mum/min]','FontSize',10)
% ylim([ -10 0])
% xlim([ 0 50])

ylim([ -35 0])
xlim([ 0 35])

savefig(fullfile(save_to_file,'Vr vs R.fig'));
saveas(Fig,fullfile(save_to_file,'Vr vs R.tif'));
saveas(Fig,fullfile(save_to_file,'Vr vs R'),'epsc');

save(fullfile(save_to_file,'AverageValues.mat'),'AverageValues');

DROPSafterVtranslation=DROPS;

save(fullfile(save_to_file,'AverageValues.mat'),'AverageValues');
save(fullfile(save_to_file,'DROPSafterVtranslation.mat'),'DROPSafterVtranslation');

close(Fig);
end
