%%%% Maya Malik Garbi
%%%% Time Average density profiles over predetrmined number of frames 31-10-18  


function DensityTimeAverageOverNoOfFrames(Capture_folder,NumberOfSectors,NumberOfFramedToAverage,AverageProfileX,AverageProfileY,ImageToAnalyze,EdgeCorrectionFlag,SpetialAveraging)

info=imfinfo(ImageToAnalyze);
Size_info=size(info);
Number_of_frames=Size_info(1,1);
% kEND=int8(Number_of_frames/NumberOfFramedToAverage);
% kEND=double(kEND);
calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']);

for k=1:1:Number_of_frames-(NumberOfFramedToAverage-1)

    k
    FirstFrame=k;
    LastFrame=k+NumberOfFramedToAverage-1;

    CalculateAverageRhoBySectorsForGUI(Capture_folder,NumberOfSectors,FirstFrame,LastFrame,ImageToAnalyze,SpetialAveraging)
    
    if (EdgeCorrectionFlag==1)
    IntensityCorrectionNearDropEdgeBySectors7_9ForLongTL(Capture_folder,AverageProfileX,AverageProfileY,FirstFrame,LastFrame)
    end
    
    close all
    
end
end

% %%%% Combine all the corrected average profiles into one stracture
% FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Long TL with labeled actin\2018_07_17\long TL labeled actin\Mix1 11_40\Capture 4 1to30\Rho without bleach correction\';
% h=figure
% Colorsjet=jet(300);
% 
% CorrectedProfile=struct;
% 
% for i=1:30
%     i
%     CorrectedProfile(i).Frame=i;
%     FrameFile=[FileName,num2str(i),'\'];
%     CorrectedAvgRho=importdata([ FrameFile,'CorrectedAvgRho.mat']);
%     CorrectedProfile(i).CorrectedAvgRho=CorrectedAvgRho;
%     CorrectedAvgRrho=importdata([ FrameFile,'CorrectedAvgRrho.mat']);
%     CorrectedProfile(i).CorrectedAvgRrho=CorrectedAvgRrho;
%     
% 
%     CorrectedProfile(i).CHUNK_radius=CHUNK_radius(i);
%     CorrectedProfile(i).X0=X0(i);
%     CorrectedProfile(i).Y0=Y0(i);
%     CorrectedProfile(i).NormCorrectedAvgRrho=CorrectedProfile(i).CorrectedAvgRrho-CHUNK_radius(i);
% 
%     CorrectedProfile(i).NormCorrectedAvgRho=CorrectedProfile(i).CorrectedAvgRho/mean(CorrectedProfile(i).CorrectedAvgRho);
% 
%     AllCorrectedProfiles(:,i)=CorrectedAvgRho;
%     
% %     plot(CorrectedProfile(i).CorrectedAvgRrho-CHUNK_radius(i), CorrectedProfile(i).CorrectedAvgRho,'Color',Colorsjet(i*10,:))
%     plot(CorrectedProfile(i).NormCorrectedAvgRrho, CorrectedProfile(i).NormCorrectedAvgRho,'Color',Colorsjet(i*10,:))
%     
% hold on
%     
% end
% 
% savefig([FileName,'\figures\','1-30 NORMCorrected Rho vs R.fig']);
% saveas(h,[FileName,'\figures\','1-30 NORMCorrected Rho vs R.tiff']);
% saveas(h,[FileName,'\figures\1-30 NORMCorrected Rho vs R'],'epsc');
