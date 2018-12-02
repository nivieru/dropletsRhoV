%%%% Maya Malik Garbi - last modified 15/01/18

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\final figures for paper\Figure1 Control\';
save_to_file=[FileName,'figuresKKth\'];
mkdir(save_to_file);
DROPSforV=importdata([FileName,'Matlab structures\DROPSforV.mat']);
DROPSforRho=importdata([FileName,'Matlab structures\DROPSforRho.mat']);

%%%% only V
save_to_fileV=[save_to_file,'V\'];
mkdir(save_to_fileV)
DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileV);
close all

%%%%Plot all the other figures
PlotDiffConditionsToKK(DROPSforRho,DROPSafterVtranslation,save_to_file)
close all

