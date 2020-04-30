%%%% Maya Malik Garbi - 9/10/17
%%%% Niv Ierushalmi - 3/12/18
%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,experiment type indeces, colors for
%%%%% different experiment types

function DROPS=GenerateDropsStractureToKKforVforGUI_Niv(XLSfilename,expTypeInd,expTypeStrings)
    DROPS=GenerateDropsStractureToKKforGUICommon_Niv(XLSfilename,expTypeInd,expTypeStrings);
    for j=1:length(DROPS)
        Capture_folder=DROPS(j).name;
        find_ROI_folder=dir(fullfile(Capture_folder,'Velocity\STICS\'));
        ROI_folder=fullfile(Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name);
        DROPS(j).Vr=real(importdata(fullfile(ROI_folder,'Vr.m')));
        DROPS(j).VrlowerLine=real(importdata(fullfile(ROI_folder,'lowerLine.m')));
        DROPS(j).VrupperLine=real(importdata(fullfile(ROI_folder,'upperLine.m')));
        DROPS(j).Rr=importdata(fullfile(ROI_folder,'Rr.m'));
        DROPS(j).RrMinusR0=DROPS(j).Rr-DROPS(j).CHUNK_radius;
    end
end
