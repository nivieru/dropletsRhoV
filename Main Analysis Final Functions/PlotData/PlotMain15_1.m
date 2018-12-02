%%%% Maya Malik Garbi - last modified 9/10/17
%%%% This function plot figures for desired data set

directory=['C:\Users\Maya\Documents'];
%filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8.xlsx'];
filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8 modified for buffers.xlsx'];
% rShift=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\rShift.mat');
% save_to_file=[directory,'\Maya PhD\Thesis\Figures\Figure 3_4\new figures\'];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Paper figures 21_3\S rates different extracts\'];

mkdir(save_to_file);

%%%% Final Figures Data - 

% % %%%% cofilin BUFFER 
% % DropsForPlotForV=[362:383,714:718,733:741]; %%% with new data with XB buffer
% %  DropsForPlotForRho=[362,363,364,368,373,379,381];
% % DropsForPlotForRho=[362,363,373,379,381,714:718,733:741];  %%% with new data with XB buffer
% DropsForPlotForV=[362:383]; %%% with new data with XB buffer
% DropsForPlotForRho=[362,363,373,379,381];

AllBufferDrops=[362,363,373,379,381,733,735:741,931:933,935:938,549]; 
CofilinBuffer=[362,363,373,379,381];
HEKbuffer=[931:933,935:938,549];

mDia03uM=[1250:1261];
mDia0_5uM= [1118,1119,1121,1122,1126:1129,1242:1247];
mDia1uM=[1133:1135,1264:1272];
mDia1_5uM=[1194:1197,1275:1280];
% 
% mDia=[mDia2,mDia03,mDia1,mDia1_5];

Fascin5uM=[1138:1147];
Fascin8uM=[1149:1157];
Fascin10uM=[1159:1165];

XBbuffer30deg=[941,942,944,947];
XBbuffer30deg=[1200:1206,1208:1211];
XBbuffer34deg=[1287:1290,1292:1294];
CP=[151:153,156:157];
% Filamin=[949:953];
Filamin=[1091:1093];
LongTLdrop1=[959:969];
LongTLdrop2=[972:983];
LongTLdrop3=[986:991,993:997];
LongTLdrop4=[1000:1001,1003:1009];
LongTLdrop5=[1012:1022];
LongTLdrop6=[1026:1036];
LongTLdrop7=[1040:1050];
LongTLdrop8=[1325:1335];
LongTLdrop9=[1339:1349];


Spacer100um=[1214:1225];
Srv2Abp1=[362,363,373,379,381,640,641,644];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FINAL DATA FOR PAPER
XBnewData=[1104:1106,1108,1109,1111];
XBbuffer=[733,735:741];

CCA=[333,334,340:344];
CCAprofilin=[868,869,870];

mDia0_5uM= [1118,1119,1121,1122,1126:1129,1242,1244,1246,1247];
ActA1_5uM=[397:401];

AlfaActinin2_5um=[1081:1090];
AlfaActinin4um=[1066:1078];
AlfaActinin5um=[647,649,651,652,654,655];
AlfaActinin10um=[657,658,660,662,663,665,666];

Fascin2_5uM=[670,672,673,675,679];

%%%CCA- 
cofilin=[1185:1191];
coronin=[349:351,353,355:358];
Aip1=[306, 308,310,312,313,315:317,322,324:328]; 

Pallodin=[1056:1060,1062];
CPrambam5=[1228:1230,1234:1236];

% %%% rambam 4-1
Buffer41=[11,13:21,23:27];
ActA01uM=[70:73];
ActA05uM=[80:81,83];
ActA1_5uMrambam41=[97,100,102,103];

Space10um=[159:165,167]; 
SilicaBeads1um=[171:175,177,179]; 



rambam7=[1317,1319:1320] ;

rambam7=[1311,1315:1317,1319:1321] ;

rambam6=[1298:1308] ;

%%%% rambam 5 0.75uM ActA
ActA075uM=[894:896];
ActA075uM_GMFb=[899:904,906:907];
GMFb=[910:918];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Revision Data 

F_ActinLabeling=[1353:1361];
MyosinLabeling=[1364:1372];

DropsForPlotForV=[F_ActinLabeling,MyosinLabeling];
DropsForPlotForRho=DropsForPlotForV;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DropsForPlotForV=[XBbuffer,XBnewData,CCA,CPrambam5,mDia0_5uM,ActA1_5uM,Fascin2_5uM,AlfaActinin2_5um,AlfaActinin4um,AlfaActinin5um,AlfaActinin10um,Pallodin,cofilin,coronin,Aip1];
DropsForPlotForRho=DropsForPlotForV;

DropsForPlotForV=[Buffer41,ActA01uM,ActA05uM,ActA1_5uMrambam41];
DropsForPlotForV=[Buffer41,SilicaBeads1um];

DropsForPlotForRho=DropsForPlotForV;

DropsForPlotForV=[XBbuffer,XBnewData,AlfaActinin2_5um,AlfaActinin4um,AlfaActinin5um,AlfaActinin10um];
DropsForPlotForV=[XBbuffer,XBnewData,CCA,ActA1_5uM,Fascin2_5uM,AlfaActinin10um,mDia0_5uM,CPrambam5];
DropsForPlotForV=[XBbuffer,XBnewData,CCA,Aip1,cofilin,coronin];
DropsForPlotForV=[XBbuffer,XBnewData,mDia03uM,mDia0_5uM,mDia1uM,mDia1_5uM];
DropsForPlotForV=[LongTLdrop3];

DropsForPlotForV=[XBbuffer,XBnewData,XBbuffer30deg];

DropsForPlotForV=[XBbuffer,XBnewData,ActA075uM,ActA075uM_GMFb,GMFb];
XtranslationByLinearFit='yes';


DropsForPlotForV=[XBbuffer,XBnewData,Spacer100um];

DropsForPlotForV=[XBbuffer,XBnewData,Buffer41,rambam6,rambam7];

DropsForPlotForV=[LongTLdrop6];
XtranslationByLinearFit='yes';
DropsForPlotForRho=DropsForPlotForV;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%% PLOTS

    %%%% only V
    close all
    DROPSforV=GenerateDropsStractureToKKforV(directory,filename,DropsForPlotForV);
    save([save_to_file,'DROPSforV.mat'],'DROPSforV')
    save_to_fileAllV=[save_to_file,'All V\'];
    mkdir(save_to_fileAllV)
%     DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileAllV);
        
    DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileAllV,XtranslationByLinearFit);

    close all

    %%%% Rho
    %%%% For rambam 5 extract
    DROPSforRho=GenerateDropsStractureToKK(directory,filename,DropsForPlotForRho);
    % %%%% For rambam 4-1 extract
    % DROPSforRho=GenerateDropsStractureToKKforNonCorrectedRho(directory,filename,DropsForPlotForRho);

    save([save_to_file,'DROPSforRho.mat'],'DROPSforRho')

    %%%%Plot V profile only for the drops in Rho
%     PlotDiffConditionsToKKonlyV(DROPSforRho,save_to_file);
%     close all
    PlotDiffConditionsToKKgray(DROPSforRho,DROPSafterVtranslation,save_to_file)
    close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% AVG Figures

DROPSforV=GenerateDropsStractureToKKforV(directory,filename,DropsForPlotForV);
save([save_to_file,'DROPSforV.mat'],'DROPSforV')
PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file,XtranslationByLinearFit)

% PlotDiffConditionsToKKonlyV_AVGvalues5_3(DROPSforV,save_to_file)


DROPSforRho=GenerateDropsStractureToKK(directory,filename,DropsForPlotForRho);
save([save_to_file,'DROPSforRho.mat'],'DROPSforRho')
DROPSafterVtranslation=importdata([save_to_file,'DROPSafterVtranslation.mat']);
PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_file)

% PlotDiffConditionsToKKonlyVFORlongTL(DROPSforRho,save_to_file);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% extract rambam 4-1
Buffer41=[11,13:21,23:27];
Space10um=[159:165,167]; 
SilicaBeads1um=[171:175,177,179]; 

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


DropsForPlotForV= [Space10um];
DropsForPlotForRho= [Space10um];
save_to_file=[directory,'\Maya Analysis after GRC\Data Analysis\Main Data figures\Buffer rambam4_1\'];

DropsForPlotForV=[Buffer41,ActA01uM,ActA05uM,ActA07uM,ActA1_5uM];
DropsForPlotForRho=DropsForPlotForV;

DropsForPlotForV=[Buffer41,CP];
DropsForPlotForRho=DropsForPlotForV;

