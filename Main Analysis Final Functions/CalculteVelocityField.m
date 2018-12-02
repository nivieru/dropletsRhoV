function ROI_folder=CalculteVelocityField(Capture_folder)

% % %%% Prefilter
CLAHE_HP_prefilter_MM(Capture_folder);
% % CLAHE_prefilter_MM(Capture_folder);

%%% Calculate velocity filed using STICS
EdgeLimit=3;  %%%%  for exculsion corrleations that the peak is inside the frame (boundries+-EdgeLimit)

% ROI_folder=STICS_multiple_areas(Capture_folder,EdgeLimit);
DetermineGridForSTICS(Capture_folder)
ROI_folder=STICS_multiple_areasGridAsInput(Capture_folder,EdgeLimit);
% if ROI folder already exists comment previous line, uncomment next
% find_ROI_folder=dir([Capture_folder,'Velocity\STICS\']);
% ROI_folder=[Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];
% 
GaussianWidthLimit=20;
VectorExclusion(Capture_folder,ROI_folder,GaussianWidthLimit);
DefineBlobCenter(Capture_folder,ROI_folder)

 TrashHold1=0.2; %%%% for excluding correlations with lower than TrashHold*Average peak in network area
% TrashHold1=0.05; %%%% for excluding correlations with lower than TrashHold*Average peak in network area

save([Capture_folder,'Analysis parameters\TrashHold1.m'],'TrashHold1')
TrashHold2=2;    %%%% for excluding vectors with Vtheta>TrashHold*mean Vtheta  ;    Vtheta<TrashHold*(-mean Vtheta)
save([Capture_folder,'Analysis parameters\TrashHold2.m'],'TrashHold2')

VectorExclusionNO2(Capture_folder,ROI_folder,TrashHold1,TrashHold2)
close all

%%% Calculate Vr
% VelocityAsAFunctionOfR_STICS(Capture_folder,ROI_folder);
VelocityAsAFunctionOfR_STICSgridAsInput(Capture_folder,ROI_folder);

close all

% angularVelocityAsAFunctionOfR_STICS(Capture_folder,ROI_folder);

% LinearFitVr(Capture_folder,ROI_folder);
% 
% close all

end