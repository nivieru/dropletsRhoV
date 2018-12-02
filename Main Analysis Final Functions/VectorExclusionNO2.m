function VectorExclusionNO2(Capture_folder,ROI_folder,TrashHold1,TrashHold2)

interrogationarea=importdata([Capture_folder,'Analysis parameters\interrogationarea.m']);

CorrelationPeak=importdata([ROI_folder,'CorrelationPeak.mat']);
xtable=importdata([ROI_folder,'xtable.mat']);
ytable=importdata([ROI_folder,'ytable.mat']);

utable_AVG=importdata([ROI_folder,'utable_AVG_EX3.mat']);
vtable_AVG=importdata([ROI_folder,'vtable_AVG_EX3.mat']);
utable_AVGall=importdata([ROI_folder,'utable_AVG.mat']);
vtable_AVGall=importdata([ROI_folder,'vtable_AVG.mat']);

MaxRr=importdata([Capture_folder,'Analysis parameters\MaxRr.m']);
MinRr=importdata([Capture_folder,'Analysis parameters\MinRr.m']); 

DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
ACTIN_NETWORK_radius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m']);
CHUNK_radius=importdata([Capture_folder,'Analysis parameters\CHUNK_radius.m']);

% X0=importdata([Capture_folder,'Analysis parameters\X0.m']);
% Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);

X0=importdata([Capture_folder,'Analysis parameters\OptimizeX0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\OptimizeY0.mat']);

roi=importdata([Capture_folder,'Analysis parameters\roi.m']);
size_of_window1=importdata([Capture_folder,'Analysis parameters\interrogationarea.m']);
Time_intervale1=importdata([Capture_folder,'Analysis parameters\Time_intervale.m']);
calibration1=importdata([Capture_folder,'Analysis parameters\calibration.m']);

CenterX=X0;
CenterY=Y0;

Size=size(xtable);
Lx=Size(2);
Ly=Size(1);

%Transformation of the axes, calculating R AND Vr
for i=1:Ly
    for j=1:Lx
  
        Y(i,j)=(ytable(i,j)+interrogationarea/2)-CenterY; 
        X(i,j)=(xtable(i,j)+interrogationarea/2)-CenterX;

        R(i,j)=sqrt( (X(i,j)^2) + (Y(i,j)^2) );
        
     
        theta(i,j)=atan( Y(i,j)/X(i,j) );
        
        if ( X(i,j)<0)
            theta(i,j)=theta(i,j)+pi;
        end
        
          Vr(i,j)= utable_AVG(i,j)*cos(theta(i,j)) +  vtable_AVG(i,j)*sin(theta(i,j));
          Vrall(i,j)= utable_AVGall(i,j)*cos(theta(i,j)) +  vtable_AVGall(i,j)*sin(theta(i,j));
          Vtheta(i,j)= -utable_AVG(i,j)*sin(theta(i,j)) +  vtable_AVG(i,j)*cos(theta(i,j));
        
    end
end

R=R*calibration1;

%%%% Exclusion rule no'1
%%%% Remove short peaks

CorrelationPeakNetworkArea=CorrelationPeak;
% [NetworkPlace_i,NetworkPlace_j]=find(R<CHUNK_radius |  R>ACTIN_NETWORK_radius);
[NetworkPlace]=find(R<CHUNK_radius);
CorrelationPeakNetworkArea(NetworkPlace)=NaN;
[NetworkPlace2]=find(R>ACTIN_NETWORK_radius);
CorrelationPeakNetworkArea(NetworkPlace2)=NaN;

CorrelationPeakNetworkArea=CorrelationPeakNetworkArea(:);
CorrelationPeakNetworkArea(isnan(CorrelationPeakNetworkArea))=[];
AverageCorrPeakInNetworkArea=mean(mean(CorrelationPeakNetworkArea));

[NotInRange]=find(CorrelationPeak<AverageCorrPeakInNetworkArea*TrashHold1);
utable_AVG_EX=utable_AVG;
vtable_AVG_EX=vtable_AVG;
utable_AVG_EX(NotInRange)=NaN;
vtable_AVG_EX(NotInRange)=NaN;


%%% BLUE - original vector field
figure (2)
quiver(xtable,ytable,utable_AVGall,vtable_AVGall,0,'LineWidth',1.5,'Color','b');
hold on
quiver(xtable,ytable,utable_AVG,vtable_AVG,0,'LineWidth',1.5,'Color','g');

%%% RED - after removing short peaks
hold on
quiver(xtable,ytable,utable_AVG_EX,vtable_AVG_EX,0,'LineWidth',1.5,'Color','r');

%%%% Exclusion rule no'2
%%%% remove vector that has Vtheta component
meanVtheta=Vtheta(:);
meanVtheta(isnan(meanVtheta))=[];
meanVtheta=mean(mean(abs(meanVtheta)));
[NotInRange2]=find(Vtheta>TrashHold2*meanVtheta);
[NotInRange3]=find(Vtheta<TrashHold2*(-meanVtheta));
utable_AVG_EX2=utable_AVG_EX;
vtable_AVG_EX2=vtable_AVG_EX;
utable_AVG_EX2(NotInRange2)=NaN;
vtable_AVG_EX2(NotInRange2)=NaN;
utable_AVG_EX2(NotInRange3)=NaN;
vtable_AVG_EX2(NotInRange3)=NaN;

% figure
% quiver(xtable,ytable,utable_AVG_EX,vtable_AVG_EX,0,'LineWidth',1.5,'Color','r');
hold on
quiver(xtable,ytable,utable_AVG_EX2,vtable_AVG_EX2,0,'LineWidth',1.5,'Color','k');
axis equal
%%%% Exclusion rule no'3
%%%% remove all the vectors that not in the main feature
binary=utable_AVG_EX2;
binary(~isnan(binary))=1;
binary(isnan(binary))=0;
% figure
% imshow(binary)
binary2=bwareaopen(binary,100);
% figure
% imshow(binary2)
utable_AVG_EX3=utable_AVG_EX2;
vtable_AVG_EX3=vtable_AVG_EX2;

utable_AVG_EX3(find(binary2==0))=NaN;
vtable_AVG_EX3(find(binary2==0))=NaN;
hold on
quiver(xtable,ytable,utable_AVG_EX3,vtable_AVG_EX3,0,'LineWidth',1.5,'Color','m');
axis equal

%%% Magemta - after third exclusion rule
h=figure (2);
savefig([ROI_folder,'Velocity Field ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),']exclusion No2.fig']);
saveas(h,[ROI_folder,'Velocity Field ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),']exclusion No2.tif']);

% utable_AVG_EX3=utable_AVG_EX2;
% vtable_AVG_EX3=vtable_AVG_EX2;

save([ROI_folder,'utable_AVG_EX3.mat'],'utable_AVG_EX3');
save([ROI_folder,'vtable_AVG_EX3.mat'],'vtable_AVG_EX3');

end
