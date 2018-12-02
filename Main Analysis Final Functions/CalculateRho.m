%%% Maya Malik Garbi - last modified 8/10/17

function CalculateRho(Capture_folder)

ImageName='16bitC0';
BackNoFlu=importdata([Capture_folder,'Analysis parameters\backgroundNoFlu.m']);
Label=1; %%% Life Act

All_IntensityCorrSteps(Capture_folder,ImageName,BackNoFlu,Label)

NumberOfSectors=9;


if (NoOfFramesToAvg=
CalculateAverageRhoBySectors(Capture_folder,NumberOfSectors)

AverageProfileX=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA\AverageProfileX.mat');
AverageProfileY=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA\AverageProfileY.mat');

% AverageProfileX=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA old set of data\AverageProfileX.mat');
% AverageProfileY=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA old set of data\AverageProfileY.mat');

IntensityCorrectionNearDropEdgeBySectors7_9(Capture_folder,AverageProfileX,AverageProfileY)

%%%% Option to averge on predetrmined number of frames
else
    
for k=1:NoOfFramesToAvg:Number_of_frames-(NoOfFramesToAvg-1) 
    k
    FirstFrame=k;
    LastFrame=k+NoOfFramesToAvg-1;
    CalculateAverageRhoBySectorsForLongTL(Capture_folder,NumberOfSectors,FirstFrame,LastFrame,X0(k),Y0(k))
    IntensityCorrectionNearDropEdgeBySectors7_9ForLongTL(Capture_folder,AverageProfileX,AverageProfileY,FirstFrame,LastFrame)
    
    close all
    
end    
    
    
end


%%%%Calculate average intensity over theta as a function of T after bleach
%%%%correction
% CalculateRhoVsT(Capture_folder)
% RhoVSt(Capture_folder)



end