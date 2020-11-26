function doPlots(expTypes, expTypeStrings, filename, save_to_file, plotFlags)
experiments.expTypes = expTypes;
experiments.expTypeStrings = expTypeStrings;
save(fullfile(save_to_file,'experiments.mat'),'experiments')

if (plotFlags(1)  ||  plotFlags(2) )
    DROPSforV=GenerateDropsStractureToKKforVforGUI_Niv(filename,expTypes,expTypeStrings);
    save(fullfile(save_to_file,'DROPSforV.mat'),'DROPSforV')
    save_to_fileAllV=fullfile(save_to_file,'All V\');
    mkdir(save_to_fileAllV)   
    XtranslationByLinearFit='yes';
    DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileAllV,XtranslationByLinearFit);
    %%%% Rho
    %%%% For rambam 5 extract
    DROPSforRho=GenerateDropsStractureToKKforGUI_Niv(filename,expTypes,expTypeStrings);
    save(fullfile(save_to_file,'DROPSforRho.mat'),'DROPSforRho')
    PlotDiffConditionsToKKgray(DROPSforRho,DROPSafterVtranslation,save_to_file)
%     close all  
end

%%%% Only Average values
if plotFlags(3)
   
   XtranslationByLinearFit='yes';
   DROPSforV=GenerateDropsStractureToKKforVforGUI_Niv(filename,expTypes,expTypeStrings);
   save(fullfile(save_to_file,'DROPSforV.mat'),'DROPSforV')
   PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file,XtranslationByLinearFit)

   DROPSforRho=GenerateDropsStractureToKKforGUI_Niv(filename,expTypes,expTypeStrings);
   save(fullfile(save_to_file,'DROPSforRho.mat'),'DROPSforRho')
   DROPSafterVtranslation=importdata(fullfile(save_to_file,'DROPSafterVtranslation.mat'));
   PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_file)
end