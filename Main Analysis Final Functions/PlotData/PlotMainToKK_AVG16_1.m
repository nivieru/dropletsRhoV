%%%% Maya Malik Garbi - last modified 15/01/18

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\final figures for paper\Figure 3 ActA\';
save_to_file=[FileName,'figuresKK\'];
mkdir(save_to_file);
DROPSforV=importdata([FileName,'Matlab structures\DROPSforV.mat']);
DROPSforRho=importdata([FileName,'Matlab structures\DROPSforRho.mat']);

%%%%  Vr(r)
DROPSafterVtranslation=PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file);
close all

%%%% DivJ(rho)
PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_file)
close all


