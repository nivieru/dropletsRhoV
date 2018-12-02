%%%% Maya Malik Garbi - last modified at 10.12.17
%%%% The goal of this function is to optimize the blob center point by
%%%% finding the point where <Vr>/<Vtheta> gets maximum. At this point the 
%%%% the radial flow is optimal. 

function DefineBlobCenter(Capture_folder,ROI_folder)

xtable=importdata([ROI_folder,'xtable.mat']);
ytable=importdata([ROI_folder,'ytable.mat']);
interrogationarea=importdata([Capture_folder,'Analysis parameters\interrogationarea.m']);
xtable=xtable+interrogationarea/2;
ytable=ytable+interrogationarea/2;
utable_AVG=importdata([ROI_folder,'utable_AVG_EX3.mat']);
vtable_AVG=importdata([ROI_folder,'vtable_AVG_EX3.mat']);
DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m']);
BlobRadius=importdata([Capture_folder,'Analysis parameters\CHUNK_radius.m']);
calibration1=importdata([Capture_folder,'Analysis parameters\calibration.m']);
Time_intervale1=importdata([Capture_folder,'Analysis parameters\Time_intervale.m']);
X0=importdata([Capture_folder,'Analysis parameters\X0.m']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);

image1_roi=imread([Capture_folder,'Velocity\CLAHE_HP prefilter\01.tiff']);
S=size(image1_roi);
Size=size(xtable);
Lx=Size(2);
Ly=Size(1);

% CenterX=X0;
% CenterY=Y0;

searchingRange=11;
MinusRange=ceil(searchingRange/2)-1;

CenterX=zeros(searchingRange,searchingRange);
CenterY=zeros(searchingRange,searchingRange);
meanVtheta2=zeros(searchingRange,searchingRange);
meanVrdilute2=zeros(searchingRange,searchingRange);

for n=1:searchingRange
    for m=1:searchingRange
        
       CenterX(n,m)=X0-MinusRange+n-1; %%%% -1 be cause I want it will start at X0-MinusRange
       CenterY(n,m)=Y0-MinusRange+m-1; %%%% -1 be cause I want it will start at Y0-MinusRange
 
%%% this loop build CenterX, CenterY 
%Transformation of the axes, calculating R AND Vr

for i=1:Ly
    for j=1:Lx
        
        Y(i,j)=ytable(i,j)-CenterY(n,m);
        X(i,j)=xtable(i,j)-CenterX(n,m);

        R(i,j)=sqrt( (X(i,j)^2) + (Y(i,j)^2) );
        theta(i,j)=atan( Y(i,j)/X(i,j) );
        
        if ( X(i,j)<0)
            theta(i,j)=theta(i,j)+pi;
        end
        
        Vr(i,j)= utable_AVG(i,j)*cos(theta(i,j)) +  vtable_AVG(i,j)*sin(theta(i,j));
        Vtheta(i,j)= -utable_AVG(i,j)*sin(theta(i,j)) +  vtable_AVG(i,j)*cos(theta(i,j));
        
    end
end

R=R(:)*calibration1;
Vr=Vr(:)*(calibration1/(Time_intervale1/60));

Rdilute=R(:);
VthetaDilute=Vtheta(:);
VrDilute=Vr(:);

Rstart=BlobRadius+5;
Rend=NetworkRadius-5;
RsmallerThanRstrat=find(R(:)<Rstart);
RbiggerThanRend=find(R(:)>Rend);
remove=[RsmallerThanRstrat',RbiggerThanRend'];
Rdilute(remove)=[];
Rdilute(isnan(Rdilute))=[];
VthetaDilute(remove)=[];
VthetaDilute(isnan(VthetaDilute))=[];
VrDilute(remove)=[];
VrDilute(isnan(VrDilute))=[];

meanVtheta2(n,m)=mean(VthetaDilute.^2);
meanVrdilute2(n,m)=mean(VrDilute.^2);
clear remove
clear R
clear Vr
    end
end

Ratio=meanVrdilute2./meanVtheta2;

[MinVthetaPlaceX,MinVthetaPlaceY]=find(meanVtheta2==min(min(meanVtheta2)));
[MaxVrPlaceX,MaxVrPlaceY]=find(meanVrdilute2==max(max(meanVrdilute2)));

[MaxPlaceX,MaxPlaceY]=find(Ratio==max(max(Ratio)));

OptimizeX0=CenterX(MaxPlaceX,MaxPlaceY);
OptimizeY0=CenterY(MaxPlaceX,MaxPlaceY);

dx=abs(OptimizeX0-X0);
dy=abs(OptimizeY0-Y0);

save([Capture_folder,'Analysis parameters\OptimizeX0.mat'],'OptimizeX0')
save([Capture_folder,'Analysis parameters\OptimizeY0.mat'],'OptimizeY0')

end