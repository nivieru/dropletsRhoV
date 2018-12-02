%%%% Maya Malik Garbi - last modified 22/10/17
%%%% OPTION1 - PLOT ALL WANTED DATA TOGTHER. EACH EXPERIMENT TYPE HAS A DIFFERENT COLOR

function DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPS,save_to_file)

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
    AverageValues(j).color=DROPS(placeDrops(j)).Color;
    AverageValues(j).LEG=DROPS(placeDrops(j)).typeOfExpString;
    LEG2{i}=(DROPS(placeDrops(j)).typeOfExpString);
    
    
    %%%% Aligne the profiles
    AVGy=AverageValues(j).meany;
    AVGx=AverageValues(j).xval;
    
    place=find(AVGy>-3);
    AVGy(place)=[];
    AVGx(place)=[];
    place=find(AVGy<-15);
    AVGy(place)=[];
    AVGx(place)=[];
    
    % for i=1:length(DROPS)
    for i=placeDrops(1):placeDrops(end)
        Rnorm=(DROPS(i).Rr-DROPS(i).CHUNK_radius);
        V=DROPS(i).Vr;
        place=find(V>-3);
        RnormTemp=Rnorm;
        RnormTemp(place)=[];
        V(place)=[];
        place=find(V<-15);
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
        DROPS(i).RrAfterSift=Rnorm+DROPS(i).dr;
        
    end
    
    
    place=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    [RrAllData,I]=sort([DROPS(place).RrAfterSift]);
    t=[DROPS(place).Vr];
    VrAllData=t(I);
    [AverageValues(j).meany2,AverageValues(j).lowerLine2,AverageValues(j).upperLine2,AverageValues(j).xval2] = meanGaussianMM(RrAllData,VrAllData, 1);
    [Nmeany2] = NmeanGaussian(RrAllData,VrAllData, 1);
    Nratio=Nmeany2/(length(place)*8);
    
    N_remove=find(Nratio<0.5);
    AverageValues(j).meany2(N_remove)=[];
    AverageValues(j).lowerLine2(N_remove)=[];
    AverageValues(j).upperLine2(N_remove)=[];
    AverageValues(j).xval2(N_remove)=[];
    
    %%%% Try to do secound itration
    
    AVGy=AverageValues(j).meany2;
    AVGx=AverageValues(j).xval2;
    
    place=find(AVGy>-3);
    AVGy(place)=[];
    AVGx(place)=[];
    place=find(AVGy<-15);
    AVGy(place)=[];
    AVGx(place)=[];
    
    % for i=1:length(DROPS)
    for i=placeDrops(1):placeDrops(end)
        Rnorm=(DROPS(i).RrAfterSift);
        V=DROPS(i).Vr;
        place=find(V>-3);
        RnormTemp=Rnorm;
        RnormTemp(place)=[];
        V(place)=[];
        place=find(V<-15);
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
        DROPS(i).RrAfterSift2=Rnorm+DROPS(i).dr2;
        
    end
    
    
    place=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    [RrAllData,I]=sort([DROPS(place).RrAfterSift]);
    t=[DROPS(place).Vr];
    VrAllData=t(I);
    [AverageValues(j).meany3,AverageValues(j).lowerLine3,AverageValues(j).upperLine3,AverageValues(j).xval3] = meanGaussianMM(RrAllData,VrAllData, 1);
    AverageValues(j).meanR=AverageValues(j).xval3;
    AverageValues(j).meanV=AverageValues(j).meany3;
    
    [Nmeany3] = NmeanGaussian(RrAllData,VrAllData, 1);
    Nratio=Nmeany3/(length(place)*8);
    close
    N_remove=find(Nratio<0.5);
    AverageValues(j).meany3(N_remove)=[];
    AverageValues(j).lowerLine3(N_remove)=[];
    AverageValues(j).upperLine3(N_remove)=[];
    AverageValues(j).xval3(N_remove)=[];
    
    
    %%%%Linear fit
    p=polyfit(AverageValues(j).xval3',AverageValues(j).meany3',1);
    SlopeVrVSr=p(1);
    AverageValues(j).LinearFit=p(1)*([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3])'+p(2);
    AverageValues(j).Xteanslation=p(2)/p(1);
    % hold on
    % plot(([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3]+AverageValues(j).Xteanslation)',AverageValues(j).LinearFit,'Color','b','LineWidth',2)
    
    %%%Save the total traslation for each drop
    
    for i=placeDrops(1):placeDrops(end)
        DROPS(i).TotalTranslation=DROPS(i).dr+DROPS(i).dr2+AverageValues(j).Xteanslation;
    end
        
end


figure (1)

if (NoOfConditions>1)
Jinitial=2;
else Jinitial=1;
end


 for j=Jinitial:NoOfConditions
     placeDrops=find([DROPS.typeOfExp]==typeOfExpVector(j)) ;
    
     for i=placeDrops(1):placeDrops(end)
        hold on
        h(i) = plot(DROPS(i).RrAfterSift+AverageValues(j).Xteanslation,DROPS(i).Vr,'LineWidth',2,'Color',DROPS(i).Color);
        hold on
    end  
   
    hold on
    plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).meany3,'Color','k','LineWidth',2)
    hold on
    plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).lowerLine3,'Color','k','LineWidth',1)
    hold on
    plot(AverageValues(j).xval3+AverageValues(j).Xteanslation,AverageValues(j).upperLine3,'Color','k','LineWidth',1)
    
    hold on
    plot(([-5:0.25:AverageValues(j).xval3(1) , AverageValues(j).xval3]+AverageValues(j).Xteanslation)',AverageValues(j).LinearFit,'--','Color','k','LineWidth',1)
      
 end

if (NoOfConditions>1) 
i=1;
hold on
plot(AverageValues(i).xval3+AverageValues(i).Xteanslation,AverageValues(i).meany3,'Color',[128/255 128/255 128/255],'LineWidth',2)
end     



%     hold on
%     plot(AverageValues(j).xval3(1:120)+AverageValues(j).Xteanslation,AverageValues(j).meany3(1:120),'Color','k','LineWidth',2)
%     hold on
%     plot(AverageValues(j).xval3(1:120)+AverageValues(j).Xteanslation,AverageValues(j).lowerLine3(1:120),'Color','k','LineWidth',1)
%     hold on
%     plot(AverageValues(j).xval3(1:120)+AverageValues(j).Xteanslation,AverageValues(j).upperLine3(1:120),'Color','k','LineWidth',1)
%     
% 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% i=1;
% j=2;
%
% hold on
% plot(AverageValues(i).xval,AverageValues(i).meany,'Color','m','LineWidth',2)
% hold on
% plot(AverageValues(j).xval,AverageValues(j).meany,'Color','k','LineWidth',2)
% hold on
% plot(AverageValues(j).xval,AverageValues(j).lowerLine,'Color','k','LineWidth',1)
% hold on
% plot(AverageValues(j).xval,AverageValues(j).upperLine,'Color','k','LineWidth',1)
% % end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% For many conditions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% togther
% h=figure;
% k=1;
% for i=1:NoOfConditions
% hold on
% h(k)=plot(AverageValues(i).xval,AverageValues(i).meany,'Color',AverageValues(i).color,'LineWidth',2);
% hold on
% h(k+1)=plot(AverageValues(i).xval,AverageValues(i).lowerLine,'Color',AverageValues(i).color,'LineWidth',1);
% hold on
% h(k+2)=plot(AverageValues(i).xval,AverageValues(i).upperLine,'Color',AverageValues(i).color,'LineWidth',1);
% k=k+3;
% % k=k+1
% end
% % index_drops2=(1:NoOfConditions);
%  index_drops2=(1:3:NoOfConditions*3);
% legend(h(index_drops2),LEG2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% OLD VERSION 
% box off
% ax=gca;
% % ax.XAxis.FontSize=20;
% % ax.YAxis.FontSize=20;
% set(ax,'FontSize',20)
% % xlabel('(r-R_0)/(R_d_r_o_p-R_0)','FontSize',24)
% xlabel('r-R_0[\mum]','FontSize',24)
% ylabel('V[\mum/min]','FontSize',24)
% xlim([-1 50])
% ylim([ -40 2])

box off
ax=gca;
set(ax,'FontSize',8)
% xlabel('(r-R_0)/(R_d_r_o_p-R_0)','FontSize',24)
xlabel('r-R_0[\mum]','FontSize',10)
ylabel('V[\mum/min]','FontSize',10)
ylim([ -40 2])
xlim([ -2 50])
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 3.5])

savefig(fullfile(save_to_file,'Vr vs R.fig'));
saveas(figure (1),fullfile(save_to_file,'Vr vs R.tif'));
saveas(figure (1),fullfile(save_to_file,'Vr vs R'),'epsc');

% legend(h(index_drops),LEG)

% savefig(fullfile(save_to_file,'Vr vs R v1.fig'));
% saveas(figure (1),fullfile(save_to_file,'Vr vs R v1.tif'));
% saveas(figure (1),fullfile(save_to_file,'Vr vs R v1.eps'));


save(fullfile(save_to_file,'AverageValues.mat'),'AverageValues');

DROPSafterVtranslation=DROPS;

save(fullfile(save_to_file,'AverageValues.mat'),'AverageValues');
save(fullfile(save_to_file,'DROPSafterVtranslation.mat'),'DROPSafterVtranslation');




% savefig(fullfile(save_to_file,'Vr vs R avg only.fig'));
% saveas(figure (1),fullfile(save_to_file,'Vr vs R avg only.tif'));
% saveas(figure (1),fullfile(save_to_file,'Vr vs R avg only.eps'));

end




