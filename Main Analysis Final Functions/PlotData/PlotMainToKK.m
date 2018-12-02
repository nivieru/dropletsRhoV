%%%% Maya Malik Garbi - last modified 9/10/17

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Main Data figures\mDia\';
save_to_file=[FileName,'figures\'];
mkdir(save_to_file);
DROPSforV=importdata(fullfile(FileName,'DROPSforV.mat'));
DROPSforRho=importdata(fullfile(FileName,'DROPSforRho.mat'));

%%%% only V
save_to_fileAllV=[save_to_file,'All V\'];
mkdir(save_to_fileAllV)
DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileAllV);
close all

%%%%Plot V profile only for the drops in Rho
PlotDiffConditionsToKKonlyV(DROPSforRho,save_to_file);
close all

%%%%Plot all the other figures: Rho(r), DivJ(rho), DivJ(r), DivJ4pir^2(R)
PlotDiffConditionsToKK(DROPSforRho,DROPSafterVtranslation,save_to_file)
close all

%%%%%Plot only AVG values for figure 3 - Buffer, ActA, mDia, CCA
FileName=[,'\Avg values Figure3\'];
save_to_file=[FileName,'figures\'];
mkdir(save_to_file);
DROPSforV=importdata(fullfile(FileName,'DROPSforV.mat'));
PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file)

%%%%%Plot only AVG values for figure 4 - Buffer, Fascin, alfa actinin
FileName=[,'Avg values Figure4\'];
save_to_file=[FileName,'figures\'];
mkdir(save_to_file);
DROPSforV=importdata(fullfile(FileName,'DROPSforV.mat'));
PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file)
