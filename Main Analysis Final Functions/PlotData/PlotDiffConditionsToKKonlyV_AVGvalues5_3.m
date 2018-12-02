%%%% Maya Malik Garbi - last modified 6/3/18
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function DROPSafterVtranslation=PlotDiffConditionsToKKonlyV_AVGvalues5_3(DROPS,save_to_file)

NremoveNumber=0.5;
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
    AverageValues(j).meanR=AverageValues(j).xval3;
    AverageValues(j).meanV=AverageValues(j).meany3;
    
    [Nmeany3] = NmeanGaussian(RrAllData,VrAllData, 1);
    Nratio=Nmeany3/max(Nmeany3);
     N_remove=find(Nratio<NremoveNumber);
%    N_remove=find(Nratio<0.6);
    close
    AverageValues(j).meany3(N_remove)=[];
    AverageValues(j).lowerLine3(N_remove)=[];
    AverageValues(j).upperLine3(N_remove)=[];
    AverageValues(j).xval3(N_remove)=[];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Modified at 5.3.18
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Maya
    for i=placeDrops(1):placeDrops(end)
    placeNearblob=find(DROPS(i).Rrho>DROPS(i).CHUNK_radius-2);
    MaxRho=max(DROPS(i).RhoMinusMonomers(placeNearblob));
    DROPS(i).RhoNorm=DROPS(i).RhoMinusMonomers./MaxRho;
    DROPS(i).Rnorm=(DROPS(i).Rrho-DROPS(i).CHUNK_radius+DROPS(i).dr+DROPS(i).dr2);
    end

    RhoAllData=[DROPS(placeDrops).RhoNorm];
    RrAllData=[DROPS(placeDrops).Rnorm];
    [AverageValues(j).meanRho,AverageValues(j).lowerLineRho,AverageValues(j).upperLineRho,AverageValues(j).meanRrho] = meanGaussianMM(RrAllData,RhoAllData, 1);
    close all
    
    placeNearZero=find(AverageValues(j).meanRrho>0);
    MaxRho=max(AverageValues(j).meanRho(placeNearZero));
    
    AvgRhoMaxPlace=find(AverageValues(j).meanRho==MaxRho);
    RatMaxRho=AverageValues(j).meanRrho(AvgRhoMaxPlace);
    AverageValues(j).RatMaxRho=RatMaxRho;
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
    
    RforLinearFit=AverageValues(j).xval3;
    VforLinearFit=AverageValues(j).meany3;
    remove=find(RforLinearFit<RatMaxRho);
    RforLinearFit(remove)=[];
    VforLinearFit(remove)=[];
    p=polyfit(RforLinearFit',VforLinearFit',1);
    AverageValues(j).p=p;
%     p=polyfit(AverageValues(j).xval3',AverageValues(j).meany3',1);
    AverageValues(j).SlopeVrVSr=p(1);
%      AverageValues(j).LinearFit=p(1)*([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3])'+p(2);
        AverageValues(j).LinearFit=[p(1)*([AverageValues(j).xval3])'+p(2)]';

     %%% NEW  
   %AverageValues(j).LinearFit=-1*([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3])'+p(2);
   
%     AverageValues(j).LinearFit=[-1*([AverageValues(j).xval3])'+p(2)]';

    AverageValues(j).Xteanslation=p(2)/p(1);
    
    
    %%%Save the total traslation for each drop
    
    for i=placeDrops(1):placeDrops(end)
        DROPS(i).TotalTranslation=DROPS(i).dr+DROPS(i).dr2+AverageValues(j).Xteanslation;
    end    
    
end
close all

figure (1)

Jinitial=1;
 for j=Jinitial:NoOfConditions
     
    plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).meany3,'Color',AverageValues(j).color,'LineWidth',1)
%     plot(AverageValues(j).xval3,AverageValues(j).meany3,'Color',AverageValues(j).color,'LineWidth',1)
    
     hold on
%     plot([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3]+AverageValues(j).Xteanslation,AverageValues(j).LinearFit,'Color',AverageValues(j).color)

    
    
    
    % %     hold on
%          plot([AverageValues(j).xval3],AverageValues(j).LinearFit,'Color',AverageValues(j).color)
%      hold on
%     plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).lowerLine3,'Color',AverageValues(j).color,'LineWidth',0.5)
%     hold on
%     plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).upperLine3,'Color',AverageValues(j).color,'LineWidth',0.5)
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

ylim([ -40 0])
xlim([ 0 40])

savefig([save_to_file,'Vr vs R.fig']);
saveas(figure (1),[save_to_file,'Vr vs R.tif']);
saveas(figure (1),[save_to_file,'Vr vs R'],'epsc');

DROPSafterVtranslation=DROPS;

save([save_to_file,'AverageValues.mat'],'AverageValues');
save([save_to_file,'DROPSafterVtranslation.mat'],'DROPSafterVtranslation');

end
