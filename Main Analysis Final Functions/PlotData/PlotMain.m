%%%% Maya Malik Garbi - last modified 9/10/17
%%%% This function plot figures for desired data set

directory=['C:\Users\Maya\Documents'];
%filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8.xlsx'];
filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8 modified for buffers.xlsx'];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures Corrected\new filamin\'];
mkdir(save_to_file);

%%%% Final Figures Data - 

% % %%%% cofilin BUFFER 
% % DropsForPlotForV=[362:383,714:718,733:741]; %%% with new data with XB buffer
% %  DropsForPlotForRho=[362,363,364,368,373,379,381];
% % DropsForPlotForRho=[362,363,373,379,381,714:718,733:741];  %%% with new data with XB buffer
% DropsForPlotForV=[362:383]; %%% with new data with XB buffer
% DropsForPlotForRho=[362,363,373,379,381];

%%%% different Buffers
DropsForPlotForV=[362,363,373,379,381,733,735:741,931:933,935:938,549];
DropsForPlotForRho=[ 362,363,373,379,381,733,735:741,931:933,935:938,549]; 

AllBufferDrops=[362,363,373,379,381,733,735:741,931:933,935:938,549]; 
mDia= [691 ,692, 693];
CCA=[333,334,339:344];
ActA= [397:401];
Fascin=[670,672,673,675,679];

AlfaActinin2_5um=[1081:1087];
AlfaActinin4um=[1066:1078];
AlfaActinin5um=[647,649,651,652,654,655];
AlfaActinin10um=[658,662,663,665,666];
XBbuffer30deg=[941:947];
XBbuffer=[733:741];
% Filamin=[949:953];
Filamin=[1091:1093];
LongTLdrop1=[958:969];
Pallodin=[1056:1063];

DropsForPlotForV=[LongTLdrop1];
DropsForPlotForRho=[LongTLdrop1];



%%%% cofilin BUFFER 
DropsForPlotForV=[362,363,373,379,381];
DropsForPlotForRho=[ 362,363,373,379,381]; 

%%%% xb Buffer
DropsForPlotForV=[733:741];
DropsForPlotForRho=[ 733:741]; 

%%%% HEK Buffer
DropsForPlotForV=[931:933,935:938,549];
DropsForPlotForRho=[931:933,935:938,549]; 

% %%%% CCA & all buffers
% % DropsForPlotForV=[333,334,337,339:344 , 362:383];
DropsForPlotForV=[333,334,339:344,362,363,373,379,381,733,735:741,931:933,935:938,549]; 
DropsForPlotForRho=[333,334,339:344,362,363,373,379,381,733,735:741,931:933,935:938,549]; 

% %%%% Pallodin & All Buffer
DropsForPlotForV=[Pallodin,AllBufferDrops];
DropsForPlotForRho=[Pallodin,AllBufferDrops];

% DropsForPlotForV=[362:383 , 686:689 , 691:693]; 
DropsForPlotForV=[mDia,AllBufferDrops];
DropsForPlotForRho=[mDia,AllBufferDrops];

% %%%% 1.5uM ActA & All Buffer
% DropsForPlotForV=[362:383 , 686:689 , 691:693]; 
DropsForPlotForV=[ActA,AllBufferDrops];
DropsForPlotForRho=[ActA,AllBufferDrops];

% %%%% Fascin & All Buffer
DropsForPlotForV=[Fascin,AllBufferDrops];
DropsForPlotForRho=[Fascin,AllBufferDrops];

% %%%% 2.5uM alfa actinin & All Buffer
DropsForPlotForV=[AlfaActinin2_5um,AllBufferDrops];
DropsForPlotForRho=[AlfaActinin2_5um,AllBufferDrops];

% %%%% 4uM alfa actinin & All Buffer
DropsForPlotForV=[AlfaActinin4um,AllBufferDrops];
DropsForPlotForRho=[AlfaActinin4um,AllBufferDrops];

% %%%% 5uM alfa actinin & All Buffer
DropsForPlotForV=[AlfaActinin5um,AllBufferDrops];
DropsForPlotForRho=[AlfaActinin5um,AllBufferDrops];

% %%%% 10uM alfa actinin & All Buffer
DropsForPlotForV=[AlfaActinin10um,AllBufferDrops];
DropsForPlotForRho=[AlfaActinin10um,AllBufferDrops];

%%%% 3uM filamin & All buffers
DropsForPlotForV=[Filamin,AllBufferDrops];
DropsForPlotForRho=[Filamin,AllBufferDrops];

%%%% Xb buffer 30ded vs xb buffer
DropsForPlotForV=[XBbuffer,XBbuffer30deg];
DropsForPlotForRho=[XBbuffer,XBbuffer30deg];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%% CCA & cof buffer
% % DropsForPlotForV=[333,334,337,339:344 , 362:383];
% DropsForPlotForV=[  333,334,339:344,362,363,373,379,381]; 
% DropsForPlotForRho=[ 333,334,339:344,362,363,373,379,381]; 


% %%%% Buffer & CCA & PFN
% DropsForPlotForV=[333,334,340,341,343,344,362,363,373,379,381 ,868:870];
% DropsForPlotForRho=[ 333,334,340,341,343,344, 362,363,373,379,381 ,868:870]; 

% %%%% Buffer & CCA & Tpm3.1
% DropsForPlotForV=[333,334,340,341,343,344,362,363,373,379,381,873:878];
% DropsForPlotForRho=[ 333,334,340,341,343,344, 362,363,373,379,381,873:878]; 
% 

% %%%% Coronin & Buffer
% DropsForPlotForV=[362:383 , 349:351,353,355:358];
% DropsForPlotForRho=[ 362,363,373,379,381 , 349:351,353,355:358]; 

% %%%% Aip1 & Buffer
% DropsForPlotForV=[362:383 ,306, 308,310,312,313,315:317,322,324:328];
% DropsForPlotForRho=[ 362,363,373,379,381 ,306, 308,310,312,313,315:317,322,324:328]; 

% %%%% mDia & Buffer
% DropsForPlotForV=[362:383 , 686:689 , 691:693]; 
% DropsForPlotForV=[362,363,373,379,381, 691 ,692, 693];
% DropsForPlotForRho=[362,363,373,379,381, 691 ,692, 693];

% %%%% ActA & Buffer
% DropsForPlotForV=[362:383, 397:402]; 
% DropsForPlotForRho=[362,363,373,379,381,397:401];
% DropsForPlotForV=[362,363,373,379,381,397:401];

% %%%% Fascin & Buffer
% DropsForPlotForV=[362:383,670:677,679:680,682:683];
% % DropsForPlotForRho=[362,363,373,379,381,670,672,673,675,678,679];
% DropsForPlotForRho=[362,363,373,379,381,670,672,673,675,679];
% DropsForPlotForV=[362,363,373,379,381,670,672,673,675,679];

% %%%% 5uM  alfa actinin
% DropsForPlotForV=[362:383, 647,649,651:652,654:655];
% DropsForPlotForV=[362,363,373,379,381,647,649,651,652,654,655];
% DropsForPlotForRho=[362,363,373,379,381,647,649,651,652,654,655];
 
% %%%% 10uM alfa actinin
% DropsForPlotForV=[362:383, 657:660, 662:667];  
% DropsForPlotForRho=[362,363,373,379,381,658,662,663,665,666]; 

% %%%% Srv2 Abp1 
% DropsForPlotForV=[362:383,640,641,644];  
% DropsForPlotForRho=[362,363,373,379,381,640,641,644];  

%%% Buffer,0.75uM ActA GMFb , GMFb
% DropsForPlotForV= [362,363,373,379,381, 899:904,906:907 ,910:918 ];
% DropsForPlotForRho=[ 362,363,373,379,381 , 899:904,906:907,910:918];

%%% Buffer,GMF yeast
% DropsForPlotForV= [362,363,373,379,381, 920:928 ];
% DropsForPlotForRho=[ 362,363,373,379,381 , 920:928 ];

% %%% Buffer,0.75uM ActA, 0.75uM ActA GMFb 
% DropsForPlotForV= [362,363,373,379,381, 892,894:895, 899:904,906:907];
% DropsForPlotForRho=[ 362,363,373,379,381 ,892,894:895, 899:904,906:907];
% 
%%% Buffer, 0.75uM, 1.5uM ActA, 0.75uM ActA GMFb 
% DropsForPlotForV= [362,363,373,379,381, 397:401,892,894:895, 899:904,906:907];
% DropsForPlotForRho=[ 362,363,373,379,381 , 397:401,892,894:895, 899:904,906:907];


% % %%%% Buffer, ActA, mDia, & CCA - Figure3 
% DropsForPlotForV=[333,334,337,339:344 , 362:383, 686:689 , 691:693 , 397:402 ];
% DropsForPlotForRho=[333,334,340,341,343,344, 362,363,373,379,381, 691 ,692, 693 , 397:401];

% %%% Buffer, 10uM alfa actinin, Fascin - Figure4 
% DropsForPlotForV= [362:383,657:660, 662:667 ,670:677,679:680,682:683  ];
% DropsForPlotForRho=[ 362,363,373,379,381, 658,662,663,665,666 ,670,672,673,675,679 ];

%%% Buffer, 10uM alfa actinin, Fascin and ActA- Figure4 
% DropsForPlotForV= [362:383, 397:401, 657:660, 662:667 ,670:677,679:680,682:683  ];
% DropsForPlotForRho=[ 362,363,373,379,381, 397:401, 658,662,663,665,666 ,670,672,673,675,679 ];

% %%% Buffer, 5uM alfa actinin, 10uM alfa actinin, Fascin Srv2 Abp1 - Figure6 
% DropsForPlotForV= [362:383 , 647,649,651:652 , 654:655657:660, 662:667 ,670:677,679:680,682:683  ,640,641,644];
% DropsForPlotForRho=[ 362,363,373,379,381 , 658,662,663,665,666, 658,662,663,665,666 ,670,672,673,675,679,640,641,644 ];

%%% extract rambam 4-1
Buffer41=[11,13:21,23:27];
ActA01uM=[70:73];
ActA03uM=[75:79];
ActA05uM=[80:81,83];
ActA07uM=[85,89,91,93];
ActA1uM=[94,95];
ActA1_5uM=[97,100,102,103];

%%% extract rambam 4-1 0.1uMActA
DropsForPlotForV=[Buffer41];
DropsForPlotForRho=[Buffer41];

%%% extract rambam 4-1 0.1uMActA
DropsForPlotForV=[Buffer41,ActA01uM];
DropsForPlotForRho=[Buffer41,ActA01uM];

DropsForPlotForV=[Buffer41,ActA03uM];
DropsForPlotForRho=[Buffer41,ActA03uM];

DropsForPlotForV=[Buffer41,ActA05uM];
DropsForPlotForRho=[Buffer41,ActA05uM];

DropsForPlotForV=[Buffer41,ActA07uM];
DropsForPlotForRho=[Buffer41,ActA07uM];

DropsForPlotForV=[Buffer41,ActA1uM];
DropsForPlotForRho=[Buffer41,ActA1uM];

DropsForPlotForV=[Buffer41,ActA1_5uM];
DropsForPlotForRho=[Buffer41,ActA1_5uM];


% %%% Buffer extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27];
% DropsForPlotForRho=[11,13:21,23:27];
DropsForPlotForV= [Buffer41];
DropsForPlotForRho= [Buffer41];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Buffer rambam4_1\'];

% %%% Buffer extract rambam 4-1 & 15uM cofilin
% DropsForPlotForV= [11,13:21,23:27,46:48,50:56,60];
% DropsForPlotForRho=[11,13:21,23:27,46:48,50:56,60];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Cofilin\'];

% %%% Buffer extract rambam 4-1 & CP 
% DropsForPlotForV= [11,13:21,23:27,143:149,151:157];
% DropsForPlotForRho=[11,13:21,23:27,143:149,151:157];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\CP\'];


% %%%% 1um silica beads 
% DropsForPlotForV=[11,13:21,23:27,159:165,167];  
% DropsForPlotForRho=[11,13:21,23:27,159:165,167];
% 
%%%% 10um spacer 
% DropsForPlotForV=[159:165,167];  
% DropsForPlotForRho=[159:165,167];

% % %%% Buffer & 0.1uM ActA Data - extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27, 70:73];
% DropsForPlotForRho=[11,13:21,23:27,  70:73];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\0_1uM ActA\'];

% %%% Buffer & 0.3uM ActA Data - extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27, 75:79];
% DropsForPlotForRho=[11,13:21,23:27,  75:79];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\0_3uM ActA\'];

% %%% Buffer & 0.5uM ActA Data - extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27, 80:81,83];
% DropsForPlotForRho=[11,13:21,23:27,  80:81,83];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\0_5uM ActA\'];

% %%% Buffer & 0.7uM ActA Data - extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27,85,86,87,89,91,93];
% DropsForPlotForRho=[11,13:21,23:27,85,86,87,89,91,93];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\0_7uM ActA\'];

% % %%% Buffer & 1uM ActA Data - extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27,94,95];
% DropsForPlotForRho=[11,13:21,23:27,94,95];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\1uM ActA\'];


% %%% Buffer & 1.5uM ActA Data - extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27,97,100,102,103];
% DropsForPlotForRho=[11,13:21,23:27,97,100,102,103];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\1_5uM ActA\'];


%%%% PLOTS

%%%% only V
close all
DROPSforV=GenerateDropsStractureToKKforV(directory,filename,DropsForPlotForV);
save(fullfile(save_to_file,'DROPSforV.mat'),'DROPSforV')
save_to_fileAllV=[save_to_file,'All V\'];
mkdir(save_to_fileAllV)
DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileAllV);
close all

%%%% Rho
%%%% For rambam 5 extract
DROPSforRho=GenerateDropsStractureToKK(directory,filename,DropsForPlotForRho);
% %%%% For rambam 4-1 extract
% DROPSforRho=GenerateDropsStractureToKKforNonCorrectedRho(directory,filename,DropsForPlotForRho);

save(fullfile(save_to_file,'DROPSforRho.mat'),'DROPSforRho')

%%%%Plot V profile only for the drops in Rho
PlotDiffConditionsToKKonlyV(DROPSforRho,save_to_file);
close all
PlotDiffConditionsToKK(DROPSforRho,DROPSafterVtranslation,save_to_file)
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%% 0.1,0.7,1.5uM ActA Data - extract rambam 4-1
DropsForPlotForV= [11,13:21,23:27, 70:73,85,86,87,89,91,93,97,100,102,103];
DropsForPlotForRho=[11,13:21,23:27, 70:73,85,86,87,89,91,93,97,100,102,103];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Avg ActA 3 concentrations\'];
mkdir(save_to_file)
% 
% % %%% 0.1-1.5uM ActA Data - extract rambam 4-1
% DropsForPlotForV= [11,13:21,23:27, 70:73,75:79,80:81,83,85,86,87,89,91,93,94,95,97,100,102,103];
% DropsForPlotForRho=[11,13:21,23:27, 70:73,75:79,80:81,83,85,86,87,89,91,93,94,95,97,100,102,103];
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Avg ActA\'];
% mkdir(save_to_file)

% %%%% AVG values Figure 3 - Buffer, ActA, mDia, CCA
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Avg values Figure3\'];
% mkdir(save_to_file)
% 
% %%%% AVG values Figure 4 - Buffer, alfa actinin, Fascin
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Avg values Figure4\'];
% mkdir(save_to_file)
% 
% %%%% AVG values Figure 6 - Buffer, 5uM & 10uM alfa actinin, Fascin Srv2 Apb1
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Avg values Figure6\'];
% mkdir(save_to_file)


% %%%% AVG All CCA data & Buffer
% DropsForPlotForV=[362,363,373,379,381,333,334,340,341,343,344 ,306, 308,310,312,313,315:317,322,324:328,349:351,353,355:358 ];
% DropsForPlotForRho=[ 362,363,373,379,381,333,334,340,341,343,344,306, 308,310,312,313,315:317,322,324:328,349:351,353,355:358]; 
% save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\All CCA Data\'];
% mkdir(save_to_file)

%%%% 1um silica beads + 10um spacer
% DropsForPlotForV=[11,13:21,23:27,159:165,167,171:175,177,179];  
% DropsForPlotForRho=[11,13:21,23:27,159:165,167,171:175,177,179];
% 
% %%%% Summary Figure
DropsForPlotForV=[AllBufferDrops,CCA,mDia,ActA,Fascin,AlfaActinin10um];
DropsForPlotForRho=[AllBufferDrops,CCA,mDia,ActA,Fascin,AlfaActinin10um];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures Corrected\Summary\'];
mkdir(save_to_file)

%%%% ActA summary Figure
DropsForPlotForV=[Buffer41,ActA01uM,ActA03uM,ActA05uM,ActA07uM,ActA1uM,ActA1_5uM];
DropsForPlotForRho=[Buffer41,ActA01uM,ActA03uM,ActA05uM,ActA07uM,ActA1uM,ActA1_5uM];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures Corrected\ActA Summary\'];
mkdir(save_to_file)

%%%% ActA summary Figure2
DropsForPlotForV=[Buffer41,ActA01uM,ActA05uM,ActA07uM,ActA1_5uM];
DropsForPlotForRho=[Buffer41,ActA01uM,ActA05uM,ActA07uM,ActA1_5uM];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures Corrected\ActA Summary2\'];
mkdir(save_to_file)


%%%%%% AVG Figures

DROPSforV=GenerateDropsStractureToKKforV(directory,filename,DropsForPlotForV);
save(fullfile(save_to_file,'DROPSforV.mat'),'DROPSforV')
PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file)

DROPSforRho=GenerateDropsStractureToKK(directory,filename,DropsForPlotForRho);
save(fullfile(save_to_file,'DROPSforRho.mat'),'DROPSforRho')
DROPSafterVtranslation=importdata(fullfile(save_to_file,'DROPSafterVtranslation.mat'));
PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_file)



%%% Some old lines....
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
% DropsForPlot=[362:383, 647,649,651:652,654:655 , 662:672];  %%% 5uM  and 10uM alfa actinin 
% DropsForPlot=[362:383, 640 641 644] ; %%% Abp1 Srv2
DropsForPlotForV=[714:718, 721:728,733:741]; BackWithoutFlu=1139; IntensityUnitsNorm=3400;  %%% +30mM KCL
% DropsForPlot=[362:383 , 397:402, 686:689 , 691:693, 337,339:344  , 647,649,651:652,654:655, 657:660, 662:667,670:680,682:683]; %%% All for velocities

% DropsForPlot=[337:344,362:365 , 367 , 369:388,709:713];  %%%CCA  old and new 
% DropsForPlot=[ 11,15:29, 171:175, 177:179, 181];  %%% buffer +beads

%  %%%% For intensity

%  DropsForPlotForRho=[ 362,363,373,379,381,333,334,340,341,342,343,344]; BackWithoutFlu=1063; IntensityUnitsNorm=3400;  %%% CCA & Buffer good drops 
 
% %%% Crosslinkers- 

% DropsForPlot=[362,363,364,368,373,379,381,333,334,340,341,342,343,344,691 ,692, 693,397:401, 670, 672,673,675,678,679,658,662,663,665,666,647,649,651,652,654,655];

DROPSForPlotForRho=[714:718, 721:728,733:741]; %%% +30mM KCL





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % close all
% DROPS=GenerateDropsStractureToKKtemp(directory,filename,DropsForPlot);
% save(fullfile(save_to_file,'DROPS.mat'),'DROPS')
% close all
% PlotDiffConditionsToKKtemp(DROPS,save_to_file)
% 



% %%%% Run this function  
% %%%% Original lines
% 
% close all
% DROPS=GenerateDropsStractureToKK(directory,filename,DropsForPlot,BackWithoutFlu,IntensityUnitsNorm);
% save(fullfile(save_to_file,'DROPS.mat'),'DROPS')
% close all
% 
% PlotDiffConditionsToKKonlyV(DROPS,save_to_file);
% 
% PlotDiffConditionsToKK(DROPS,save_to_file)
% close all
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% 
% 
% 
% 
% PlotDiffConditionsToKK2(DROPS,save_to_file)
% 
% %%%% Choose which figures you want to drown: 
% PlotExampleDropToKK(DROPS,save_to_file)
% 
% PlotManyBufferDropsToKK(DROPS,save_to_file)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% DROPS=GenerateDropsStractureToTPM(directory,filename,DropsForPlot)
% save(fullfile(save_to_file,'DROPS.mat'),'DROPS')
% close all
% PlotDiffConditionsToTPM(DROPS,save_to_file)
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% DROPS=GenerateDropsStracture(directory,filename,DropsForPlot);
% 
% PlotExampleDrop(DROPS,save_to_file)
% 
% PlotRnetwrokVSRdrop(DROPS,save_to_file)
% 
% PlotRchunkVSRdrop(DROPS,save_to_file)
% 
% %%%This function plot different conditions on the same figure. Each
% %%%condition represented by a different color 
% PlotDiffConditions(DROPS,save_to_file)
% 
% %%%This function plot figures within actin network radius size. 
% LowLimit=0;
% HighLimit=30;
% PlotWithinNetworkSize(DROPS,save_to_file,LowLimit,HighLimit)
% 
% %%%This function plot specific condition shorted by actin network radius  
% PlotShortByRadius(DROPS,save_to_file)
% 
% PlotShortByTime(DROPS,save_to_file)
% 
% b=[DROPS.Slope];
% MeanBeta=mean(b(1:8));
% save(fullfile(save_to_file,'MeanBeta.mat'),'MeanBeta')
% StandartDev=std(b(1:8));
% save(fullfile(save_to_file,'StandartDev.mat'),'StandartDev')
% 
% 
% Data80per1_5uMActA_TPM3_1=struct;
% Data80per1_5uMActA_TPM3_1.Rho=DROPS.Rho;
% Data80per1_5uMActA_TPM3_1.rRho=DROPS.Rrho;
% Data80per1_5uMActA_TPM3_1.Vr=DROPS.Rho;
% Data80per1_5uMActA_TPM3_1.rVr=DROPS.Rr;
% Data80per1_5uMActA_TPM3_1.Jr=DROPS.Jr;
% save(fullfile(save_to_file,'Data80per1_5uMActA_TPM3_1.mat'),'Data80per1_5uMActA_TPM3_1')
% save([save_to_file,'Data80per1_5uMActA_TPM3_1.m'],'Data80per1_5uMActA_TPM3_1')
% 
% 
% 
% 
% 



