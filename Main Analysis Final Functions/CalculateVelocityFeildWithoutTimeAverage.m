Capture_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Adam visit\2016_11_30\80% extract rambam5 HEK buffer control\Mix2 15_20\Capture 9\';

function CalculateVelocityFeildWithoutTimeAverage(Capture_folder)

EdgeLimit=3;
Dir=dir([Capture_folder,'Velocity\CLAHE_HP prefilter\*.tiff']);
NumberOfFrames=length(Dir);

for t=1:NumberOfFrames-1
    ROI_folder=STICS_multiple_areasGridAsInputWithoutTimeAverage(Capture_folder,EdgeLimit,t);
end

find_ROI_folder=dir([Capture_folder,'Velocity\STICS\']);
ROI_folder=[Capture_folder,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];

for t=1:NumberOfFrames-1
    ROI_folderTemp=[ROI_folder,int2str(t),'\'];
    GaussianWidthLimit=20;
    VectorExclusion(Capture_folder,ROI_folderTemp,GaussianWidthLimit);
    DefineBlobCenter(Capture_folder,ROI_folderTemp)
    TrashHold1=0.2; %%%% for excluding correlations with lower than TrashHold*Average peak in network area
    TrashHold2=2;    %%%% for excluding vectors with Vtheta>TrashHold*mean Vtheta  ;    Vtheta<TrashHold*(-mean Vtheta)
    VectorExclusionNO2(Capture_folder,ROI_folderTemp,TrashHold1,TrashHold2)
    close all
    %%% Calculate Vr
    % VelocityAsAFunctionOfR_STICS(Capture_folder,ROI_folder);
    VelocityAsAFunctionOfR_STICSgridAsInput(Capture_folder,ROI_folderTemp);
    close all
end

%%% Plot Vr(r) for all the time points
frame=struct;
figure
for t=1:NumberOfFrames-1
    ROI_folderTemp=[ROI_folder,int2str(t),'\'];
    frame(t).Vr=real(importdata([ROI_folderTemp,'Vr.m']));
    frame(t).Rr=real(importdata([ROI_folderTemp,'Rr.m']));
    plot(frame(t).Rr,frame(t).Vr,'Color',rand(3,1))
    frame(t).imagRr=find(imag(frame(t).Rr)>0);
    frame(t).imagVr=find(imag(frame(t).Vr)>0);
    hold on
end

VrAllData=[frame.Vr];
RrAllData=[frame.Rr];
[meany,lowerLine,upperLine,xval] = meanGaussianMM(RrAllData,VrAllData, 1);
[Nmeany] = NmeanGaussian(RrAllData,VrAllData, 1);
Nratio=Nmeany/max(Nmeany);
N_remove=find(Nratio<0.6);

meany(N_remove)=[];
lowerLine(N_remove)=[];
upperLine(N_remove)=[];
xval(N_remove)=[];

%%%% Aligne the profiles
AVGy=meany;
AVGx=xval;
minimumNumber=-15;
maxNumber=-3;

place=find(AVGy>maxNumber);
AVGy(place)=[];
AVGx(place)=[];
place=find(AVGy<minimumNumber);
AVGy(place)=[];
AVGx(place)=[];

for i=1:length(frame)
    
    Rnorm=frame(i).Rr;
    V=frame(i).Vr;
    RnormTemp=Rnorm;
    
    place=find(V>maxNumber);
    RnormTemp(place)=[];
    V(place)=[];
    
    place=find(V<minimumNumber);
    RnormTemp(place)=[];
    V(place)=[];
    
    figure
    plot(RnormTemp,V)
    
    interpRnorm=interp1(V,RnormTemp,AVGy);
    interpRnormWithoutNan=interpRnorm;
    AVGyWithoutNan=AVGy;
    AVGxWithoutNan=AVGx;
    interpRnormWithoutNan(isnan(interpRnorm))=[];
    AVGyWithoutNan(isnan(interpRnorm))=[];
    AVGxWithoutNan(isnan(interpRnorm))=[];
    %     figure
    %     plot(AVGxWithoutNan,AVGyWithoutNan,'r')
    %     hold on
    %     plot(interpRnormWithoutNan,AVGyWithoutNan,'g')
    dx=AVGxWithoutNan-interpRnormWithoutNan;
    [Min_dx,Min_dx_place]=min(dx.^2);
    frame(i).dr=dx(Min_dx_place);
    if length(frame(i).dr)==0
        frame(i).dr=0;
    end
    frame(i).RrAfterSift=Rnorm+frame(i).dr;
    
end

[RrAllData,I]=sort([frame.RrAfterSift]);
t=[frame.Vr];
VrAllData=t(I);
[meany2,lowerLine2,upperLine2,xval2] = meanGaussianMM(RrAllData,VrAllData, 1);

[Nmeany2] = NmeanGaussian(RrAllData,VrAllData, 1);
Nratio=Nmeany2/max(Nmeany2);
N_remove=find(Nratio<0.6);

meany2(N_remove)=[];
lowerLine2(N_remove)=[];
upperLine2(N_remove)=[];
xval2(N_remove)=[];

%%%% Try to do secound itration
close
AVGy=meany2;
AVGx=xval2;

place=find(AVGy>maxNumber);
AVGy(place)=[];
AVGx(place)=[];
place=find(AVGy<minimumNumber);
AVGy(place)=[];
AVGx(place)=[];

for i=1:length(frame)
    i
    Rnorm=(frame(i).RrAfterSift);
    V=frame(i).Vr;
    place=find(V>maxNumber);
    RnormTemp=Rnorm;
    RnormTemp(place)=[];
    V(place)=[];
    place=find(V<minimumNumber);
    RnormTemp(place)=[];
    V(place)=[];
    
    interpRnorm=interp1(V,RnormTemp,AVGy);
    interpRnormWithoutNan=interpRnorm;
    AVGyWithoutNan=AVGy;
    AVGxWithoutNan=AVGx;
    interpRnormWithoutNan(isnan(interpRnorm))=[];
    AVGyWithoutNan(isnan(interpRnorm))=[];
    AVGxWithoutNan(isnan(interpRnorm))=[];
    %     figure
    %     plot(AVGxWithoutNan,AVGyWithoutNan,'r')
    %     hold on
    %     plot(interpRnormWithoutNan,AVGyWithoutNan,'g')
    dx=AVGxWithoutNan-interpRnormWithoutNan;
    [Min_dx,Min_dx_place]=min(dx.^2);
    frame(i).dr2=dx(Min_dx_place);
    
    if (length(frame(i).dr2)==0)
        frame(i).dr2=0;
    end
    frame(i).RrAfterSift2=Rnorm+frame(i).dr2;
    
end

[RrAllData,I]=sort([frame.RrAfterSift2]);
t=[frame.Vr];
VrAllData=t(I);
[meany3,lowerLine3,upperLine3,xval3] = meanGaussianMM(RrAllData,VrAllData, 1);
meanR=xval3;
meanV=meany3;


end

figure
for t=1:NumberOfFrames-1
   
    plot(frame(t).RrAfterSift2,frame(t).Vr,'Color',rand(3,1))
   
    hold on
end

figure
plot(xval,meany,'r')
hold on
plot(xval3,meany3,'Color','k','lineWidth',3)
hold on

TimeAverageVr=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Adam visit\2016_11_30\80% extract rambam5 HEK buffer control\Mix2 15_20\Capture 23\Velocity\STICS\ROI[42 38 435 439]DCC30_10\Vr.m');
TimeAverageRr=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Adam visit\2016_11_30\80% extract rambam5 HEK buffer control\Mix2 15_20\Capture 23\Velocity\STICS\ROI[42 38 435 439]DCC30_10\Rr.m');

figure (3)
hold on
plot(TimeAverageRr,TimeAverageVr,'r')

RrTimeAverageOnVectorFeild=xval3;
VrTimeAverageOnVectorFeild=meany3;

save([ROI_folder,'RrTimeAverageOnVectorFeild.m'],'RrTimeAverageOnVectorFeild');
save([ROI_folder,'VrTimeAverageOnVectorFeild.m'],'VrTimeAverageOnVectorFeild');
