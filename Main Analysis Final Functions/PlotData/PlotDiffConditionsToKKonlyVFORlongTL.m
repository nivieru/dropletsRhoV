%%%% Maya Malik Garbi - last modified 22/10/17
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function DROPSafterVtranslation=PlotDiffConditionsToKKonlyVFORlongTL(DROPS,save_to_file)

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
    j
    placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    AverageValues(j).color=DROPS(placeDrops(1)).Color;
    AverageValues(j).LEG=DROPS(placeDrops(1)).typeOfExpString;
    LEG2{i}=(DROPS(placeDrops(1)).typeOfExpString);
    
    VrAllData=[DROPS(placeDrops).Vr];
    RrAllData=[DROPS(placeDrops).RrMinusR0];
    [AverageValues(j).meany,AverageValues(j).lowerLine,AverageValues(j).upperLine,AverageValues(j).xval] = meanGaussianMM(RrAllData,VrAllData, 1);
    
%     number_of_drops=length(placeDrops);
    
    [Nmeany] = NmeanGaussian(RrAllData,VrAllData, 1);
    Nratio=Nmeany/max(Nmeany);
    N_remove=find(Nratio<0.6);
    
    AverageValues(j).meany(N_remove)=[];
    AverageValues(j).lowerLine(N_remove)=[];
    AverageValues(j).upperLine(N_remove)=[];
    AverageValues(j).xval(N_remove)=[];
    
    %%%% Aligne the profiles
    AVGy=AverageValues(j).meany;
    AVGx=AverageValues(j).xval;

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
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%end modification
      minimumNumber=minVnumber;
      maxNumber=maxVnumber;
      
%     minimumNumber=-8;
%     maxNumber=-6.5;
  
    
%     minimumNumber=-5;
%     maxNumber=-1;

 %%%%% only for 1.5uM ActA RAMBAM 5   
% 
% if (j==1)
%     minimumNumber=-15;
%     maxNumber=-3;
% end
% 
% if (j==2)
%     minimumNumber=-5;
%     maxNumber=-1;
% end

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
        RnormTemp=Rnorm;
        
        
        
%         if (j==5) 
%             minimumNumber=-4;
%             maxNumber=-1;
%         end
        
%         if (AVGy(end)<V(end))
%             minimumNumber=V(end);
%             place=find(AVGy<minimumNumber);
%             AVGy(place)=[];
%             AVGx(place)=[];
%         end
            
        place=find(V>maxNumber);
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
        if length(DROPS(i).dr)==0
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
    N_remove=find(Nratio<0.6);
    
    AverageValues(j).meany2(N_remove)=[];
    AverageValues(j).lowerLine2(N_remove)=[];
    AverageValues(j).upperLine2(N_remove)=[];
    AverageValues(j).xval2(N_remove)=[];
    
    %%%% Try to do secound itration
    close 
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
        i
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
    
%     [Nmeany2] = NmeanGaussian(RrAllData,VrAllData, 1);
%     Nratio=Nmeany2/max(Nmeany2);
%     close
%     N_remove=find(Nratio<0.6);
%     
%     AverageValues(j).meany3(N_remove)=[];
%     AverageValues(j).lowerLine3(N_remove)=[];
%     AverageValues(j).upperLine3(N_remove)=[];
%     AverageValues(j).xval3(N_remove)=[];
    
     
    %%%%Linear fit
    
    %%% This part is only for fitting the linear part in non linear data
    %%% set (alfa actinin)
    %%% 
    if (DROPS(j).typeOfExp==58)
       place=find(AverageValues(j).xval3>9);
       LinearPartXval3=AverageValues(j).xval3;
       LinearPartMeany3=AverageValues(j).meany3;
       LinearPartXval3(place)=[];
       LinearPartMeany3(place)=[];
       p=polyfit(LinearPartXval3',LinearPartMeany3',1);
       AverageValues(j).SlopeVrVSr=p(1);
       AverageValues(j).LinearFit=p(1)*([-5:0.25:LinearPartXval3(1) , LinearPartXval3(1) ])'+p(2);
       AverageValues(j).Xteanslation=p(2)/p(1);
    else 
    p=polyfit(AverageValues(j).xval3',AverageValues(j).meany3',1);
    AverageValues(j).SlopeVrVSr=p(1);
    AverageValues(j).LinearFit=p(1)*([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3])'+p(2);
    AverageValues(j).Xteanslation=p(2)/p(1);
    end
   
    %%%Save the total traslation for each drop
    
    for i=placeDrops(1):placeDrops(end)
        DROPS(i).TotalTranslation=DROPS(i).dr+DROPS(i).dr2+AverageValues(j).Xteanslation;
    end    
    
end

%%%% Plot the figure
close all
figure (1)
Colorsjet=jet(120);

if (NoOfConditions>1)
Jinitial=2;
else Jinitial=1;
end

 for j=Jinitial:NoOfConditions
     placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
     for i=placeDrops(1):placeDrops(end)
        hold on
        h(i) = plot(DROPS(i).RrAfterSift2+AverageValues(j).Xteanslation,DROPS(i).Vr,'LineWidth',0.5,'Color',Colorsjet(i*10,:));
        hold on
    end  
   
    hold on
%     plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).meany3,'Color',DROPS(i).Color,'LineWidth',1)
plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).meany3,'Color',DROPS(i).Color,'LineWidth',1)
%     hold on
%     plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).lowerLine3,'Color','k','LineWidth',1)
%     hold on
%     plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).upperLine3,'Color','k','LineWidth',1)
%     
%     hold on
%     plot(([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3]+AverageValues(j).Xteanslation)',AverageValues(j).LinearFit,'--','Color','k','LineWidth',1)
%       
 end

if (NoOfConditions>1) 
i=1;
hold on
plot(AverageValues(i).xval3+AverageValues(i).Xteanslation,AverageValues(i).meany3,'Color',[128/255 128/255 128/255],'LineWidth',1)
end

xlabel('r-r_0[\mum]','FontSize',10)
ylabel('V[\mum/min]','FontSize',10)
 ylim([ -40 0])
% ylim([ -12 0])
xlim([ 0 40])

 ylim([ -15 0])
% xlim([ 0 40])
colorbar(jet)
colorbar('Ticks',[0,10,20,30,40,50,60],...
         'TickLabels',[0,10,20,30,40,50,60])


box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 7 6])
% xlabel('(r-R_0)/(R_d_r_o_p-R_0)','FontSize',24)

savefig([save_to_file,'Vr vs R.fig']);
saveas(figure (1),[save_to_file,'Vr vs R.tif']);
saveas(figure (1),[save_to_file,'Vr vs R'],'epsc');

save([save_to_file,'AverageValues.mat'],'AverageValues');

DROPSafterVtranslation=DROPS;

save([save_to_file,'AverageValues.mat'],'AverageValues');
save([save_to_file,'DROPSafterVtranslation.mat'],'DROPSafterVtranslation');

end
