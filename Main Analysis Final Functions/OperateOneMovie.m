%%% This function run the anlysis on one movie. 
%%% Need to inseret: 1.Capture folder 2.Analysis paremeters and run the
%%% function AnalysisOneMovie

Capture_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Silvia visit\2016_11_03\Sample3_CCA TPM3_1\Slide14_25\';
%AnalysisParemeters=[0.3244,10,30,60,10,2,15,15]; %% x40
% AnalysisParemeters=[0.2054,5,30,60,10,2,15,15]; %% x63
%AnalysisParemeters=[0.3457,10,20,10,2,15,15]; %% x63
%AnalysisParemeters=[0.266,2,30,60,10,2,15,15]; %% EMBO Niv

%%AnalysisParemeters=[calibration,Time_intervale[sec],interrogationarea[px],SecondCorrWindowSize[px],step[px],subpixfinder,pix_size_for_CLAHEprefilter,pix_size_for_HPprefilter,backgroundNoFlu];
AnalysisParemeters=[0.2054,10,30,60,10,2,15,15,0]; 

index=1; %% Index for one movie
close all
AnalysisOneMovie(Capture_folder,AnalysisParemeters,index)
% 

find_ROI_folder=dir([Capture_folder,'Velocity\STICS\']);
ROI_folder=[Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];
%      
% 
% 
% 
BleachCorrection(Capture_folder)
