
Capture_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Long TL with labeled actin\2018_07_17\long TL labeled actin\Mix1 11_40\Capture 4 1to30\';
NoOfFramesToAvg=1;

function AverageEdgeIntenistyCorrectionForLongTL(Capture_folder,NoOfFramesToAvg)

NumberOfSectors=9;

info=imfinfo([Capture_folder,'16bitC0 after bleach correction.tiff']);
%info=imfinfo([Capture_folder,'16bitC0.tiff']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);
kEND=int8(Number_of_frames/NoOfFramesToAvg);
kEND=double(kEND);

AverageProfileX=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA\AverageProfileX.mat');
AverageProfileY=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA\AverageProfileY.mat');
calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']);

for k=1:NoOfFramesToAvg:Number_of_frames-(NoOfFramesToAvg-1)

    
    k
    FirstFrame=k;
    LastFrame=k+NoOfFramesToAvg-1;
    
%     %%%%% Option to Determine Blob Radius to each frame
%     Frame_k=imread([Capture_folder,'16bitC0.tiff'],k);
%     imshow(Frame_k,[])
%     title('Mark Blob Radius')
% 
%     h3 = imellipse;
%     vert=wait(h3);
%     CHUNK_mask=createMask(h3);
%     CHUNK_Position=getPosition(h3);
%     CHUNK_radius(k)=ceil( ((CHUNK_Position(3)+CHUNK_Position(4))/4) * calibration );
%     MinRr=CHUNK_radius;
%     X0(k)=ceil(CHUNK_Position(1)+(CHUNK_Position(3)/2));
%     Y0(k)=ceil(CHUNK_Position(2)+(CHUNK_Position(4)/2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    CalculateAverageRhoBySectorsForLongTL(Capture_folder,NumberOfSectors,FirstFrame,LastFrame,X0(k),Y0(k))
    
    IntensityCorrectionNearDropEdgeBySectors7_9ForLongTL(Capture_folder,AverageProfileX,AverageProfileY,FirstFrame,LastFrame)
    
    close all
    
end


save([Capture_folder,'Rho\CHUNK_radius.mat'],'CHUNK_radius')
save([Capture_folder,'Rho\Y0.mat'],'Y0')
save([Capture_folder,'Rho\X0.mat'],'X0')



%%%% Combine all the corrected average profiles into one stracture
FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Long TL with labeled actin\2018_07_17\long TL labeled actin\Mix1 11_40\Capture 4 1to30\Rho without bleach correction\';
h=figure
Colorsjet=jet(300);

CorrectedProfile=struct;

for i=1:30
    i
    CorrectedProfile(i).Frame=i;
    FrameFile=[FileName,num2str(i),'\'];
    CorrectedAvgRho=importdata([ FrameFile,'CorrectedAvgRho.mat']);
    CorrectedProfile(i).CorrectedAvgRho=CorrectedAvgRho;
    CorrectedAvgRrho=importdata([ FrameFile,'CorrectedAvgRrho.mat']);
    CorrectedProfile(i).CorrectedAvgRrho=CorrectedAvgRrho;
    

    CorrectedProfile(i).CHUNK_radius=CHUNK_radius(i);
    CorrectedProfile(i).X0=X0(i);
    CorrectedProfile(i).Y0=Y0(i);
    CorrectedProfile(i).NormCorrectedAvgRrho=CorrectedProfile(i).CorrectedAvgRrho-CHUNK_radius(i);

    CorrectedProfile(i).NormCorrectedAvgRho=CorrectedProfile(i).CorrectedAvgRho/mean(CorrectedProfile(i).CorrectedAvgRho);

    AllCorrectedProfiles(:,i)=CorrectedAvgRho;
    
%     plot(CorrectedProfile(i).CorrectedAvgRrho-CHUNK_radius(i), CorrectedProfile(i).CorrectedAvgRho,'Color',Colorsjet(i*10,:))
    plot(CorrectedProfile(i).NormCorrectedAvgRrho, CorrectedProfile(i).NormCorrectedAvgRho,'Color',Colorsjet(i*10,:))
    
hold on
    
end

savefig([FileName,'\figures\','1-30 NORMCorrected Rho vs R.fig']);
saveas(h,[FileName,'\figures\','1-30 NORMCorrected Rho vs R.tiff']);
saveas(h,[FileName,'\figures\1-30 NORMCorrected Rho vs R'],'epsc');

%%%%% Cut the vectors 

for i=1:Number_of_frames
Rtemp=CorrectedProfile(i).NormCorrectedAvgRrho;
Rend(i)=Rtemp(end);
Rstrat(i)=Rtemp(1);
end
MaxRstart=max(Rstrat);
MinRend=min(Rend);

figure
for i=1:Number_of_frames
Rtemp=CorrectedProfile(i).NormCorrectedAvgRrho;
RhoTemp=CorrectedProfile(i).NormCorrectedAvgRho;
place=find(Rtemp<0);
Rtemp(place)=[];
RhoTemp(place)=[];
place=find(Rtemp>MinRend);
Rtemp(place)=[];
RhoTemp(place)=[];

CorrectedProfile(i).normCorrectedAvgRrhoNewRange=Rtemp;
CorrectedProfile(i).normCorrectedAvgRhoNewRange=RhoTemp;

plot(CorrectedProfile(i).normCorrectedAvgRrhoNewRange, CorrectedProfile(i).normCorrectedAvgRhoNewRange,'Color',Colorsjet(i*10,:))
    hold on

AllNewRangeCorrectedProfiles(:,i)=RhoTemp;
end 


%%% Kymograph
h=figure
imshow([AllNewRangeCorrectedProfiles]',[]);
colormap(jet);
axis normal
axis off
ylabel('time')
xlabel('Distance from center')
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])

mkdir([Capture_folder,'Rho\figures\'])

savefig([FileName,'\figures\','normDensity Kymograph 1to20 r-r0.fig']);
saveas(h,[FileName,'\figures\','normDensity Kymograph 1to20 r-r0.tiff']);
saveas(h,[FileName,'\figures\','\normDensity Kymograph 1to20 r-r0'],'epsc');


save([FileName,'\CorrectedProfile.mat'],'CorrectedProfile')
save([FileName,'\AllNewRangeCorrectedProfiles.mat'],'AllNewRangeCorrectedProfiles')



h=figure
imshow([AllCorrectedProfiles]',[]);
colormap(jet);
axis normal
axis off
ylabel('time')
xlabel('Distance from center')
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])

mkdir([Capture_folder,'Rho\figures\'])

savefig([FileName,'\figures\','Density Kymograph 1to20.fig']);
saveas(h,[FileName,'\figures\','Density Kymograph 1to20.tiff']);
saveas(h,[FileName,'\figures\','\Density Kymograph 1to20'],'epsc');


save([Capture_folder,'Rho\CorrectedProfile.mat'],'CorrectedProfile')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% Rho vs R divide by mean ONLY FOR DATA WITHOUT BLEACH CORRECTION
h=figure
for i=1:30
    
    normAllCorrectedProfiles(:,i)=CorrectedProfile(i).CorrectedAvgRho/mean(CorrectedProfile(i).CorrectedAvgRho);
    CorrectedProfile(i).normCorrectedAvgRrho=normAllCorrectedProfiles(:,i);
    
    plot(CorrectedProfile(i).CorrectedAvgRrho-CHUNK_radius(i), normAllCorrectedProfiles(:,i),'Color',Colorsjet(i*10,:))
    hold on
    
end

savefig([FileName,'\figures\','normCorrected Rho vs R.fig']);
saveas(h,[FileName,'\figures\','normCorrected Rho vs R.tiff']);
saveas(h,[FileName,'\figures\normCorrected Rho vs R'],'epsc');


%%% Kymograph
h=figure
imshow([normAllCorrectedProfiles]',[]);
colormap(jet);
axis normal
axis off
ylabel('time')
xlabel('Distance from center')
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])

mkdir([Capture_folder,'Rho\figures\'])

savefig([FileName,'\figures\','normDensity Kymograph 1to30.fig']);
saveas(h,[FileName,'\figures\','normDensity Kymograph 1to30.tiff']);
saveas(h,[FileName,'\figures\','\normDensity Kymograph 1to30'],'epsc');


% %%%% Try to do bleach correction after edge correction
% 
% Time=1:20;
% TotalSignal=sum(AllCorrectedProfiles);
% h=figure
% p=polyfit(Time,TotalSignal,1);
% Fit=p(1)*Time+p(2);
% plot(Time,TotalSignal/TotalSignal(1),'b','LineWidth',2)
% hold on
% plot(Time,Fit/TotalSignal(1),'b','LineStyle','--')
% 
% 
% for i=1:length(Time)
%     RhoBleachRho(:,i)= AllCorrectedProfiles(:,i)/(1+i*p(1)/p(2));
%     CorrectedProfile(i).RhoBleachRho=RhoBleachRho(:,i);
%     TotalSignalAfterBleachC(i)=sum(RhoBleachRho(:,i));  
% end
% 
% hold on
% plot(Time,TotalSignalAfterBleachC/TotalSignalAfterBleachC(1),'k','LineWidth',2)
% p2=polyfit(Time,TotalSignalAfterBleachC,1);
% LinearFit2=p2(1)*Time+p2(2);
% hold on
% plot(Time,LinearFit2/TotalSignalAfterBleachC(1),'k','LineStyle','--')
% 
% savefig([Capture_folder,'Rho\figures\bleach correction fit.fig']);
% saveas(h,[Capture_folder,'Rho\figures\bleach correction fit.tiff']);
% 
% 
% %%% Plot profiles after bleach correction
% h=figure
% 
% for i=1:20
% plot(CorrectedProfile(i).CorrectedAvgRrho,RhoBleachRho(:,i),'Color',Colorsjet(i*10,:))
%     hold on
% end
% 
% savefig([FileName,'\figures\','Corrected Rho vs R after bleach correction.fig']);
% saveas(h,[FileName,'\figures\','Corrected Rho vs R after bleach correction.tiff']);
% saveas(h,[FileName,'\figures\Corrected Rho vs R after bleach correction'],'epsc');
% 
% 
% h=figure
% imshow(RhoBleachRho',[]);
% colormap(jet);
% axis normal
% axis off
% ylabel('time')
% xlabel('Distance from center')
% set(gcf,'units','centimeter')
% set(gcf,'position', [2 2 10 8])
% 
% mkdir([Capture_folder,'Rho\figures\'])
% 
% 
% savefig([Capture_folder,'Rho\figures\Density Kymograph 1to20 bleach corr after edge corr.fig']);
% saveas(h,[Capture_folder,'Rho\figures\Density Kymograph 1to20 bleach corr after edge corr.tiff']);
% saveas(h,[Capture_folder,'Rho\figures\Density Kymograph 1to20 bleach corr after edge corr'],'epsc');
% 
% 
% 
% 
% %%% Correct the maximum place
% 
% for i=1:20
% CorrectedProfile(i).maxRho=max(CorrectedProfile(i).normCorrectedAvgRho);
% MaxPlace(i)=find(CorrectedProfile(i).normCorrectedAvgRho==CorrectedProfile(i).maxRho);
% Rtemp=CorrectedProfile(i).CorrectedAvgRrho;
% CorrectedProfile(i).RinMaxRho=Rtemp(MaxPlace(i))
% end
% 
% MeanMaxPlace=mean([CorrectedProfile.RinMaxRho]);
% 
% h=figure
% for i=1:20
%     dr=CorrectedProfile(i).RinMaxRho-MeanMaxPlace;
%     plot(CorrectedProfile(i).CorrectedAvgRrho-dr, CorrectedProfile(i).normCorrectedAvgRho,'Color',Colorsjet(i*10,:))
%     hold on
% 
% end
% 
% 
% % h=figure
% % for i=1:20
% %     dr(i)=CorrectedProfile(i).RinMaxRho-MeanMaxPlace;
% %     plot(CorrectedProfile(i).CorrectedAvgRrho-dr(i), CorrectedProfile(i).CorrectedAvgRho,'Color',Colorsjet(i*10,:))
% %     hold on
% % end
% 
% for i=1:20
% Rtemp=CorrectedProfile(i).CorrectedAvgRrho-dr(i);
% Rend(i)=Rtemp(end);
% Rstrat(i)=Rtemp(1);
% end
% MaxRstart=max(Rstrat);
% MinRend=min(Rend);
% 
% figure
% for i=1:20
% Rtemp=CorrectedProfile(i).CorrectedAvgRrho-dr(i);
% RhoTemp=CorrectedProfile(i).normCorrectedAvgRho;
% place=find(Rtemp<MaxRstart);
% Rtemp(place)=[];
% RhoTemp(place)=[];
% place=find(Rtemp>MinRend);
% Rtemp(place)=[];
% RhoTemp(place)=[];
% 
% CorrectedProfile(i).CorrectedAvgRrhoNewRange=Rtemp;
% CorrectedProfile(i).normCorrectedAvgRhoNewRange=RhoTemp;
% 
% plot(CorrectedProfile(i).CorrectedAvgRrhoNewRange, CorrectedProfile(i).normCorrectedAvgRhoNewRange,'Color',Colorsjet(i*10,:))
%     hold on
% 
% AllNewRangeCorrectedProfiles(:,i)=RhoTemp;
% end 
% 
% 
% %%% Kymograph
% h=figure
% imshow([AllNewRangeCorrectedProfiles]',[]);
% colormap(jet);
% axis normal
% axis off
% ylabel('time')
% xlabel('Distance from center')
% set(gcf,'units','centimeter')
% set(gcf,'position', [2 2 10 8])
% 
% mkdir([Capture_folder,'Rho\figures\'])
% 
% savefig([FileName,'\figures\','normDensity Kymograph 1to20 with peak place corr.fig']);
% saveas(h,[FileName,'\figures\','normDensity Kymograph 1to20 with peak place corr.tiff']);
% saveas(h,[FileName,'\figures\','\normDensity Kymograph 1to20 with peak place corr'],'epsc');
% 
% 
% save([Capture_folder,'Rho\CorrectedProfile.mat'],'CorrectedProfile')
