%%%%% rerun choosen analysis functions;

directory=['C:\Users\Maya\Documents'];
% filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8.xlsx'];
filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8 modified for buffers.xlsx'];

% % backgroundNoFlu=1063;  %%% Buffer
% % backgroundNoFlu=1108;  %%% Buffer XB
% % backgroundNoFlu=1063;  %%% CCA
% % backgroundNoFlu=1139;  %%% mDia
% % backgroundNoFlu=1139;  %%% ActA
% % backgroundNoFlu=1063;  %%% Fascin
% % backgroundNoFlu=1063;  %%% Alfa Actinin
% backgroundNoFlu=1139;  %%% Srv2 Abp1

backgroundNoFlu=1139;
DropsForPlot=[906:907];

[num,txt]= xlsread(filename);
place=strfind(txt,'File name');
emptyCells = cellfun(@isempty,place);
[place_file_nameROW,place_file_nameCOLUMN]=find(emptyCells==0);
files_name=txt(:,place_file_nameCOLUMN);


for i=DropsForPlot
i
Capture_folder=[directory,files_name{i}];
oldCapture_folder=Capture_folder;
if (i<700)
 %Capture_folder=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',Capture_folder(59:end)];
Capture_folder=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',oldCapture_folder(44:end)];  %%% for ActA data

end

if (exist([Capture_folder,'Rho\']))
rmdir ([Capture_folder,'Rho\'],'s')
end
% %rmdir ([Capture_folder,'RhoFromFirstFrame\'],'s')
% delete ([Capture_folder,'16bitC0 after bleach correction.tiff'])
% delete ([Capture_folder,'16bitC0 after non Homo Illumination Corr.tiff'])
% 
find_ROI_folder=dir([Capture_folder,'Velocity\STICS\']);
ROI_folder=[Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];
% % mkdir(Capture_folder)
% 
% copyfile([oldCapture_folder,'16bitC0.tiff'],[Capture_folder,'16bitC0.tiff']);
% copyfile([oldCapture_folder,'8bitC0.tif'],[Capture_folder,'8bitC0.tif']);
% copyfile([oldCapture_folder,'Analysis parameters'],[Capture_folder,'Analysis parameters']);
% copyfile([oldCapture_folder,'spread 8bitC0'],[Capture_folder,'spread 8bitC0']);
% copyfile([oldCapture_folder,'Velocity'],[Capture_folder,'Velocity']);

  save([Capture_folder,'Analysis parameters\backgroundNoFlu.m'],'backgroundNoFlu')


%  MeasureDropSize(Capture_folder);
%  rmdir ([Capture_folder,'Rho\'],'s')
% rmdir ([Capture_folder,'RhoFromFirstFrame\'],'s')
%  delete ([Capture_folder,'16bitC0 after bleach correction.tiff'])
% AverageProfileX=importdata('C:\Users\Maya\Documents\Maya Analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\AverageProfileX.mat');
% AverageProfileY=importdata('C:\Users\Maya\Documents\Maya Analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\AverageProfileY.mat');
% IntensityCorrectionNearDropEdge(Capture_folder,AverageProfileX,AverageProfileY)


%%%% For V analysis

% find_ROI_folder=dir([Capture_folder,'Velocity\STICS\']);
% ROI_folder=[Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];
% % 
% % interp_V_Rho(Capture_folder,ROI_folder)
% 
% % AnalysisParemeters=[0.2054,2.5,30,60,10,2,15,15]; %% x63
% % InitializeAnalysisParamters(Capture_folder,AnalysisParemeters)
% %  ROI_folder=CalculteVelocityField(Capture_folder);
% 
% CalculteVelocityField(Capture_folder,ROI_folder);

% VelocityAsAFunctionOfR_STICSgridAsInput(Capture_folder,ROI_folder);

% close all
% 
% interp_V_Rho(Capture_folder,ROI_folder)
% 
% close all
% 
% V_Rho_STICS_PLOTS(Capture_folder,ROI_folder)

CalculteVelocityField(Capture_folder);
close all
CalculateRho(Capture_folder)
close all
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% % DropsForPlot=[337,339:344]; 
% % DropsForPlot=[331,333,334,337,338,340:344]; 
% % DropsForPlot=[397:402]; %%% ActA DROPS
% % DropsForPlot=[ 691 692 693]; %%% mDia DROPS
% % DropsForPlot=[670,672,673,675,678,679]; %%%fascin
% % DropsForPlot=[658,660,662,663,664,665]; %%%10uM alfa actinin
% % DropsForPlot=[714:719];  %%% 5uM alfa actinin


