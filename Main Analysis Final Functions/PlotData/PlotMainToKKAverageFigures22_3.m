%%%% Maya Malik Garbi - last modified 15/01/18

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper figures 21_3\S3 CCA\S3 a c\';
save_to_file=[FileName,'figures\'];
mkdir(save_to_file);
DROPSforV=importdata(fullfile(FileName,'Matlab functions and structures\DROPSforV.mat'));
DROPSforRho=importdata(fullfile(FileName,'Matlab functions and structures\DROPSforRho.mat'));

%%%% only V
save_to_fileV=fullfile(save_to_file,'V\');
mkdir(save_to_fileV)
PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file)
close all

%%%%Plot all the other figures
DROPSafterVtranslation=importdata(fullfile(save_to_file,'DROPSafterVtranslation.mat'));
PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_file)

%%%% Plot DivV(rho) from average Rho(r)
AverageValues2=importdata(fullfile(save_to_file,'AverageValues2.mat'));
PlotDivVvsR(AverageValues2,save_to_file)
