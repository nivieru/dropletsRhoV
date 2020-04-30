%%%% Maya Malik Garbi - 9/10/17
%%%% Niv Ierushalmi - 3/12/18
%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,experiment type indeces, colors for
%%%%% different experiment types

function DROPS=GenerateDropsStractureToKKforGUI_Niv(XLSfilename,expTypeInd,expTypeStrings)
    DROPS = GenerateDropsStractureToKKforGUICommon_Niv(XLSfilename,expTypeInd,expTypeStrings);
    for j=1:length(DROPS)
        Capture_folder=DROPS(j).name;
        find_ROI_folder=dir(fullfile(Capture_folder,'Velocity\STICS\'));
        ROI_folder=fullfile(Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name);
        
        %%%% Call to modified function of - DivJtoKK
        %%%% to generate DivJ and save it to the relevent file
        DivJtoKK(Capture_folder,ROI_folder);
        
        DROPS(j).Rrho=importdata(fullfile(Capture_folder,'Rho\CorrectedAvgRrho.mat'));
        DROPS(j).Rho=importdata(fullfile(Capture_folder,'Rho\CorrectedAvgRho.mat'));
        
        DROPS(j).RhoMinusMonomers=importdata(fullfile(Capture_folder,'Rho\RhoMinusMonomers.mat'));
        DROPS(j).MinRr=importdata(fullfile(ROI_folder,'FinalVectors\MinRr.mat'));
        DROPS(j).Vr=real(importdata(fullfile(ROI_folder,'Vr.m')));
        DROPS(j).Rr=importdata(fullfile(ROI_folder,'Rr.m'));
        
        DROPS(j).RrMinusR0=DROPS(j).Rr-DROPS(j).CHUNK_radius;
        DROPS(j).Jr=importdata(fullfile(ROI_folder,'FinalVectors\Jr.mat'));
        DROPS(j).Div_Jr=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr.mat'));
        DROPS(j).Div_Jr_Rrho=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rrho.mat'));
        DROPS(j).Div_Jr_Rho=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rho.mat'));
        DROPS(j).ForceBalanceEq=importdata(fullfile(ROI_folder,'FinalVectors\ForceBalanceEq.mat'));
        
        DROPS(j).TurnoverRate=importdata(fullfile(ROI_folder,'FinalVectors\TurnoverRate.mat'));
        DROPS(j).ContractionRate=importdata(fullfile(ROI_folder,'FinalVectors\ContractionRate.mat'));
        DROPS(j).DivVvsRslope=importdata(fullfile(ROI_folder,'FinalVectors\DivVvsRslope.mat'));
    end
end
