slide_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Long TL with labeled actin\2018_07_17\long TL labeled actin\Mix1 11_40\';
%Analysis Paremeters Matrix 
%%AnalysisParemeters=[calibration,Time_intervale[sec],interrogationarea[px],SecondCorrWindowSize[px],step[px],subpixfinder,pix_size_for_CLAHEprefilter,pix_size_for_HPprefilter,backgroundNoFlu];
% interrogationarea[px]- size of correlation window for PIV
% SecondCorrWindowSize[px] = 2*interrogationarea[px]
% step- grid size for PIV
% subpixfinder- PIV method fro finding peak of correltaion; 2- fit to 2D
% gaussian ;
% pix_size_for_CLAHEprefilter, pix_size_for_HPprefilter - parameters for prefilter in PIV
% size in pixel of CLAHE filter (default 15) Highpass filter (default 15)
% backgroundNoFlu - average intensity value from sample with droplets and no fluor
% with the exact same imaging parameters to subtract the background with no
% signal
% AnalysisParemeters=[0.2054,2.5,30,60,10,2,15,15,0]; 
% AnalysisParemeters=[0.2054,2.5,30,60,10,2,15,15,0]; 
 
% AnalysisParemeters=[0.26,2,30,60,10,2,15,15,0]; %%% For labeld myosin data

AnalysisParemeters=[0.2054,60,30,60,10,2,15,15,1182]; %%% For long TL with labeld Actin

index=2; %%% index for slide - 2: whole slide or one movie; 1: one movie

[Capture]=SetFolderToEachCapture(slide_folder);

% Capture(1).name='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\2017_12_26\80% extract 0_5uM mDia\Mix1 12_35\Capture 5\';

% Capture(1).name='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Long TL with labeled actin\2018_07_17\long TL labeled actin\Mix1 11_40\Capture 4\';

% Capture(2).name='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\2018_02_25\rambam7\Mix 5 19_55\Capture 2 21_40\';
% Capture(3).name='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\2018_02_25\rambam7\Mix 5 19_55\Capture 14 1_20\';
% Capture(4).name='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\2018_02_25\rambam7\Mix 5 19_55\Capture 4 1_20\';


save([slide_folder,'Capture.mat'],'Capture')

Main_bulk_3D(Capture,AnalysisParemeters,index)