%%%Capture folder contain: 16bit movie, 8bit movie, AnalysisParemeters
%%%folder

function AnalysisOneMovieforGUI(Capture_folder,AnalysisParemeters,index)


if (index==1)
    
    %%SpreadsTiffs
    Spreads8bitTiffs(Capture_folder);
    
    mkdir([Capture_folder,'Analysis parameters'])
    
    %%%ChooseROI
%    [roi]=ChooseROI(Capture_folder);
    
    InitializeAnalysisParamters(Capture_folder,AnalysisParemeters)
    
    %%%Measure drop size
    MeasureDropSize(Capture_folder);
    
end
 
% ConvertFilesToMat([Capture_folder,'AnalysisParemeters\'])

  ROI_folder=CalculteVelocityField(Capture_folder);
  close all
  CalculateRho(Capture_folder)
  close all;

end
 



% %%%%% option to run different box size in a loop
% 
% k=0;
% 
% for i=1:3
% 
% AnalysisParemeters=[0.2054,10,30+k,60+k*2,10,2,15,15]; %% x63
% 
% InitializeAnalysisParamters(Capture_folder,AnalysisParemeters)
% 
% ROI_folder=CalculteVelocityField(Capture_folder);
% 
% interp_V_Rho(Capture_folder,ROI_folder)
% 
% close all
% 
% V_Rho_STICS_PLOTS(Capture_folder,ROI_folder)
% 
% close all
% 
% k=k+10;
% 
% end





