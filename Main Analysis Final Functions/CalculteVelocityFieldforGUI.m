function ROI_folder=CalculteVelocityFieldforGUI(Capture_folder,NumberOfFramedToAverage,SpetialAveraging,NotSymmetricNetworkFlag)

% % %%% Prefilter
CLAHE_HP_prefilter_MM(Capture_folder);
% % CLAHE_prefilter_MM(Capture_folder);

%%% Calculate velocity filed using STICS
EdgeLimit=3;  %%%%  for exculsion corrleations that the peak is inside the frame (boundries+-EdgeLimit)

% ROI_folder=STICS_multiple_areas(Capture_folder,EdgeLimit);
DetermineGridForSTICS(Capture_folder,NotSymmetricNetworkFlag)
GaussianWidthLimit=20;
TrashHold1=0.2; %%%% for excluding correlations with lower than TrashHold*Average peak in network area
% TrashHold1=0.05; %%%% for excluding correlations with lower than TrashHold*Average peak in network area
save([Capture_folder,'Analysis parameters\TrashHold1.m'],'TrashHold1')
TrashHold2=2;    %%%% for excluding vectors with Vtheta>TrashHold*mean Vtheta  ;    Vtheta<TrashHold*(-mean Vtheta)
save([Capture_folder,'Analysis parameters\TrashHold2.m'],'TrashHold2')


if (NumberOfFramedToAverage==0)
    
    ROI_folder=STICS_multiple_areasGridAsInput(Capture_folder,EdgeLimit);
    VectorExclusion(Capture_folder,ROI_folder,GaussianWidthLimit);
    
    %%% If the network is not symmetric - dont operate the optimization of the
    %%% blob center rether save X0,Y0 as the optimized values
    
    if (NotSymmetricNetworkFlag==0)
        DefineBlobCenter(Capture_folder,ROI_folder)
    else
        OptimizeX0=importdata([Capture_folder,'Analysis parameters\X0.m']);
        OptimizeY0=importdata([Capture_folder,'Analysis parameters\Y0.m']);
        save([Capture_folder,'Analysis parameters\OptimizeX0.mat'],'OptimizeX0')
        save([Capture_folder,'Analysis parameters\OptimizeY0.mat'],'OptimizeY0')
    end
    
    VectorExclusionNO2(Capture_folder,ROI_folder,TrashHold1,TrashHold2)
    close all
    %%% Calculate Vr
    VelocityAsAFunctionOfR_STICSgridAsInputforGUI(Capture_folder,ROI_folder,SpetialAveraging);
    close all
    
else
    
    
    info=imfinfo([Capture_folder,'16bitC0.tiff']);
    Size_info=size(info);
    Number_of_frames=Size_info(1,1);
    
    for k=1:Number_of_frames-(NumberOfFramedToAverage-1)
        
%         k
        FirstFrame=k;
        LastFrame=k+NumberOfFramedToAverage-1;
        
        ROI_folder=STICS_multiple_areasGridAsInputforGUI(Capture_folder,EdgeLimit,FirstFrame,LastFrame);
        VectorExclusion(Capture_folder,ROI_folder,GaussianWidthLimit);
        
        if (NotSymmetricNetworkFlag==0)
            DefineBlobCenter(Capture_folder,ROI_folder)
        else
            OptimizeX0=importdata([Capture_folder,'Analysis parameters\X0.m']);
            OptimizeY0=importdata([Capture_folder,'Analysis parameters\Y0.m']);
            save([Capture_folder,'Analysis parameters\OptimizeX0.mat'],'OptimizeX0')
            save([Capture_folder,'Analysis parameters\OptimizeY0.mat'],'OptimizeY0')
        end
        
        
        DefineBlobCenter(Capture_folder,ROI_folder)
        VectorExclusionNO2(Capture_folder,ROI_folder,TrashHold1,TrashHold2)
        close all
        %%% Calculate Vr
        VelocityAsAFunctionOfR_STICSgridAsInputforGUI(Capture_folder,ROI_folder,SpetialAveraging);
        close all
        
    end
    
end

end