function doPlots(expTypes, expTypeStrings, XLSfilename, save_to_folder, plotFlags)
% DOPLOTS(expTypes, expTypeStrings, filename, save_to_file, plotFlags)
% generates plots of contraction velocity, actin desitribution, divJ, etc.
% INPUTS:
% expTypes - cell array of expType indices in excel file.
% expTypeStrings - cell array of names for each expType.
% XLSfilename - name of excel file with experiment lists.
% save_to_folder - folder to save the plots.
% plotFlags - array of three boolean values setting which plots to make:
% [One_conditions, Condition_vs_control, Average].

experiments.expTypes = expTypes;
experiments.expTypeStrings = expTypeStrings;
save(fullfile(save_to_folder,'experiments.mat'),'experiments')

if (plotFlags(1)  ||  plotFlags(2) )
    DROPSforV=GenerateDropsStractureToKKforVforGUI_Niv(XLSfilename,expTypes,expTypeStrings);
    save(fullfile(save_to_folder,'DROPSforV.mat'),'DROPSforV')
    save_to_fileAllV=fullfile(save_to_folder,'All V\');
    mkdir(save_to_fileAllV)   
    XtranslationByLinearFit='yes';
    DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileAllV,XtranslationByLinearFit);
    %%%% Rho
    %%%% For rambam 5 extract
    DROPSforRho=GenerateDropsStractureToKKforGUI_Niv(XLSfilename,expTypes,expTypeStrings);
    save(fullfile(save_to_folder,'DROPSforRho.mat'),'DROPSforRho')
    PlotDiffConditionsToKKgray(DROPSforRho,DROPSafterVtranslation,save_to_folder)
%     close all  
end

%%%% Only Average values
if plotFlags(3)
   
   XtranslationByLinearFit='yes';
   DROPSforV=GenerateDropsStractureToKKforVforGUI_Niv(XLSfilename,expTypes,expTypeStrings);
   save(fullfile(save_to_folder,'DROPSforV.mat'),'DROPSforV')
   PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_folder,XtranslationByLinearFit)

   DROPSforRho=GenerateDropsStractureToKKforGUI_Niv(XLSfilename,expTypes,expTypeStrings);
   save(fullfile(save_to_folder,'DROPSforRho.mat'),'DROPSforRho')
   DROPSafterVtranslation=importdata(fullfile(save_to_folder,'DROPSafterVtranslation.mat'));
   PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_folder)
end

fprintf('Plots ready at %s\n', save_to_folder);