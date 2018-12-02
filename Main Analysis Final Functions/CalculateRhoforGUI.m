%%% Maya Malik Garbi - last modified 8/10/17

function CalculateRhoforGUI(Capture_folder,CorrectionFiles_folder,NumberOfFramedToAverage,HomoCorrectionFlag,BleachCorrectionFlag,EdgeCorrectionFlag,SpetialAveraging,NumberOfSectors)

ImageName='16bitC0';
BackNoFlu=importdata([Capture_folder,'Analysis parameters\backgroundNoFlu.m']);
Label=1; %%% Life Act

All_IntensityCorrStepsforGUI(Capture_folder,ImageName,BackNoFlu,Label,CorrectionFiles_folder,HomoCorrectionFlag,BleachCorrectionFlag)

% NumberOfSectors=9;
AverageProfileX=importdata([CorrectionFiles_folder,'\Edge Correction\LA\AverageProfileX.mat']);
AverageProfileY=importdata([CorrectionFiles_folder,'\Edge Correction\LA\AverageProfileY.mat']);

%%% Set the input image by the type of corrections opreated ImageToAnalyze
if (BleachCorrectionFlag==1)
    ImageToAnalyze = [Capture_folder,ImageName,' after bleach correction.tiff'];
else if (HomoCorrectionFlag==1)
        ImageToAnalyze = [Capture_folder,ImageName,' after non Homo Illumination Corr.tiff'];
    else 
        ImageToAnalyze = [Capture_folder ,ImageName,' after background subtraction.tiff'];
    end
end


%%%% Option to time average over whole movie, NumberOfFramedToAverage=0

if (NumberOfFramedToAverage==0)

CalculateAverageRhoBySectors(Capture_folder,NumberOfSectors,ImageToAnalyze,SpetialAveraging)

if (EdgeCorrectionFlag==1)
IntensityCorrectionNearDropEdgeBySectors7_9forGUI(Capture_folder,AverageProfileX,AverageProfileY,ImageToAnalyze)
end
%%% Option to averge on predetrmined number of frames
else
    
DensityTimeAverageOverNoOfFrames(Capture_folder,NumberOfSectors,NumberOfFramedToAverage,AverageProfileX,AverageProfileY,ImageToAnalyze,EdgeCorrectionFlag,SpetialAveraging) 
      
end


%%%%Calculate average intensity over theta as a function of T after bleach
%%%%correction
% CalculateRhoVsT(Capture_folder)
% RhoVSt(Capture_folder)



end