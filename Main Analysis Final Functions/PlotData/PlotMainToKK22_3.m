%%%% Maya Malik Garbi - last modified 15/01/18

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Paper figures 21_3\S4 phalloidin CP Fascin\S4c Fascin\';
save_to_file=[FileName,'figures\'];
mkdir(save_to_file);
DROPSforV=importdata(fullfile(FileName,'Matlab functions and structures\DROPSforV.mat'));
DROPSforRho=importdata(fullfile(FileName,'Matlab functions and structures\DROPSforRho.mat'));

%%%% only V
save_to_fileV=fullfile(save_to_file,'V\');
mkdir(save_to_fileV)
DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileV);
close all

%%%%Plot all the other figures
PlotDiffConditionsToKKgray(DROPSforRho,DROPSafterVtranslation,save_to_file)
close all

