%%%Capture folder contain: 16bit movie, 8bit movie, AnalysisParemeters
%%%folder

function AnalysisOneMovieforGUI(Capture_folder,AnalysisParemeters,index,CorrectionFiles_folder,NumberOfFramedToAverage,HomoCorrectionFlag,BleachCorrectionFlag,EdgeCorrectionFlag,DropletParameters,SpetialAveraging,NumberOfSectors,NotSymmetricNetworkFlag,calibrationFile)
disp('AnalysisOneMovieforGUI');

if (index==1)
    
    if (DropletParameters==1)
    %%SpreadsTiffs
    Spreads8bitTiffs(Capture_folder);
    
    mkdir([Capture_folder,'Analysis parameters'])
    
    %%%ChooseROI
%    [roi]=ChooseROI(Capture_folder);
    
    InitializeAnalysisParamters(Capture_folder,AnalysisParemeters,calibrationFile)
    
    %%%Measure drop size
    %%% if DropletParameters==1 run the function to determine drop
    %%% parameters
    %%% if DropletParameters==2 use the saved droplet parameters from
    %%% previous run
    
    
    MeasureDropSize(Capture_folder);
    end
    
end
 
% ConvertFilesToMat([Capture_folder,'AnalysisParemeters\'])

%   ROI_folder=CalculteVelocityFieldforGUI(Capture_folder,NumberOfFramedToAverage);
  ROI_folder=CalculteVelocityFieldforGUI(Capture_folder,NumberOfFramedToAverage,SpetialAveraging,NotSymmetricNetworkFlag);
  close all
  CalculateRhoforGUI(Capture_folder,CorrectionFiles_folder,NumberOfFramedToAverage,HomoCorrectionFlag,BleachCorrectionFlag,EdgeCorrectionFlag,SpetialAveraging,NumberOfSectors)
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





