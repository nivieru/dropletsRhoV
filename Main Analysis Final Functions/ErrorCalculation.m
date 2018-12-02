

directory=['C:\Users\Maya\Documents'];
filename=['C:\Users\Maya\Documents\Maya Analysis after GRC\3D networks data summary 10_8 modified for buffers.xlsx'];

%%%% FINAL DATA FOR PAPER
XBnewData=[1104:1106,1108,1109,1111];
XBbuffer=[733,735:741];
CCA=[333,334,340:344];
mDia0_5uM= [1118,1119,1121,1122,1126:1129,1242,1244,1246,1247];
ActA1_5uM=[397:401];
AlfaActinin10um=[657,658,660,662,663,665,666];
Fascin2_5uM=[670,672,673,675,679];
CPrambam5=[1228:1230,1234:1236];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
DropsForPlot=[XBbuffer,XBnewData,CCA,CPrambam5,mDia0_5uM,ActA1_5uM,Fascin2_5uM,AlfaActinin10um];

[num,txt]= xlsread(filename);
place=strfind(txt,'File name');
emptyCells = cellfun(@isempty,place);
[place_file_nameROW,place_file_nameCOLUMN]=find(emptyCells==0);
files_name=txt(:,place_file_nameCOLUMN);
ErrorData=struct;
i=1;

for k=DropsForPlot
    
    Capture_folder=[directory,files_name{k}];

    if (k<700)
        Capture_folder=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',Capture_folder(59:end)];
        %Capture_folder=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',oldCapture_folder(44:end)];  %%% for ActA data     
    end
    
    ErrorData(i).Capture_folder=Capture_folder;
    find_ROI_folder=dir([Capture_folder,'Velocity\STICS\']);
    ROI_folder=[Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];
   
    
    [R_sort,Vr_sort]= VelocityAsAFunctionOfR_STICSgridAsInputForERROR(Capture_folder,ROI_folder);
    ErrorData(i).Vr_sort=Vr_sort;
    ErrorData(i).R_sort=R_sort;
    CHUNK_radius=importdata([Capture_folder,'Analysis parameters\CHUNK_radius.m']); %%%chunk radius
    Rrho=importdata([Capture_folder,'Rho\CorrectedAvgRrho.mat']);
    Rho=importdata([Capture_folder,'Rho\CorrectedAvgRho.mat']);

    %%%%% Find the Maxsimum of Rho
    CHUNK_radiusPlace=min(find(Rrho>CHUNK_radius-3)); %%% I want to find the maxsimum in between (Rblob-3:end) 
    MinRr=CHUNK_radius;
    [MAX_Rho,MAX_Rho_place]=max(Rho(CHUNK_radiusPlace:end));
    MinRr2=ceil(Rrho(MAX_Rho_place+CHUNK_radiusPlace-1));
    
    if (MinRr2>CHUNK_radius)
        MinRr=MinRr2;
    end
    
    ErrorData(i).MinRr=MinRr;
    
    placeMinR=find(R_sort<MinRr);
    Vr_sort(placeMinR)=[];
    R_sort(placeMinR)=[];
    
    %%%% Linear fit
    
    FitPoly=fit(R_sort,Vr_sort,'poly1');
    ErrorData(i).ContractionRte=FitPoly.p1;
    CofecientError=confint(FitPoly);
    ErrorData(i).SlopeError=CofecientError(:,1);
    ErrorData(i).d_ContractionRte=abs(abs(CofecientError(1,1))-abs(CofecientError(2,1)))/2;
    
    %%% Calculate the error for DivJ
    
    Div_Jr=importdata([ROI_folder,'FinalVectors\Div_Jr.mat']);
    Div_Jr_Rho=importdata([ROI_folder,'FinalVectors\Div_Jr_Rho.mat']);
    place=find(Div_Jr>0);
    Div_Jr(place)=[];
    Div_Jr_Rho(place)=[];
    Div_Jr_Rho=Div_Jr_Rho(1:end-1);
    Smooth=smooth(Div_Jr_Rho,Div_Jr,0.3,'sgolay');
    
    FitPolyDivJ=fit(Div_Jr_Rho',Smooth,'poly1');
    ErrorData(i).TurnoverRte=FitPolyDivJ.p1;
    CofecientErrorDivJ=confint(FitPolyDivJ);
    ErrorData(i).SlopeErrorDivJ=CofecientErrorDivJ(:,1);
    ErrorData(i).d_TurnoverRate=abs(abs(CofecientErrorDivJ(1,1))-abs(CofecientErrorDivJ(2,1)))/2;
    
    i=i+1;
end
meanValuesAndError=struct

t1=1;
t2=14;
j=1;
meanValuesAndError(j).Name='Buffer';

t1=15;
t2=21;
j=2;
meanValuesAndError(j).Name='CCA';

t1=22;
t2=27;
j=3;
meanValuesAndError(j).Name='CP';

t1=28;
t2=39;
j=4;
meanValuesAndError(j).Name='mDia';

t1=40;
t2=44;
j=5;
meanValuesAndError(j).Name='ActA';

t1=45;
t2=49;
j=6;
meanValuesAndError(j).Name='Fascin';

t1=50;
t2=56;
j=7;
meanValuesAndError(j).Name='10uM alfa actinin';



meanValuesAndError(j).k=mean([ErrorData(t1:t2).ContractionRte]);
meanValuesAndError(j).dk=mean([ErrorData(t1:t2).d_ContractionRte]);
meanValuesAndError(j).beta=mean([ErrorData(t1:t2).TurnoverRte]);
meanValuesAndError(j).d_beta=mean([ErrorData(t1:t2).d_TurnoverRate]);

folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Error to linear fit\';
save([folder,'meanValuesAndError.mat'],'meanValuesAndError');
save([folder,'ErrorData.mat'],'ErrorData');
