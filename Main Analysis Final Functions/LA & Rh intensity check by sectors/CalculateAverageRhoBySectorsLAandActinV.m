%%%% Maya Malik Garbi 22.9.2017
%%%% Modefied function of - 
%%%% CalculateAverageRhoBySectors(Capture_folder,NumberOfSectors)

function CalculateAverageRhoBySectorsLAandActinV(Capture_folder,PixImage,file,NumberOfSectors)

calibration=importdata([Capture_folder,'Analysis parameters\calibration.mat']);
X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);

Capture_folder=[Capture_folder,file];
mkdir([Capture_folder,'Rho']);

pix_C0=PixImage;
L=size(pix_C0);

%%%Calculate Rho as a function of R
%Transformation of corrdinates

for i=1:L(1,1)
    for j=1:L(1,2)
        Y(i,j)=i-Y0;
        X(i,j)=j-X0;

        R(i,j)=sqrt( (X(i,j)^2) + (Y(i,j)^2) );
        theta(i,j)=atan(Y(i,j)/X(i,j));
        
        if (X(i,j)<0)
            theta(i,j)=theta(i,j)+pi;
        end
        
    end
end

%%%Set scale
R=R*calibration;
theta=theta(:);
R=R(:);
AverageIntensityMatrixDILUTE=pix_C0(:);

%%%Take the desired area for the average intensity
remove1_4=find(theta<(pi/2));
remove3=find(theta>(pi));
removeEestN=[remove1_4;remove3];
R(removeEestN)=[];
AverageIntensityMatrixDILUTE(removeEestN)=[];
theta(removeEestN)=[];

%%%% This loop is for calculating the average over different sectors
%%%% d_theta=10

index=0;
AverageRhoVsR=struct;

for i=1:NumberOfSectors
    
    R_temp=R(:);
    Rho_temp=AverageIntensityMatrixDILUTE(:);
    
    thetaStart=(pi/2)+(pi/(2*NumberOfSectors))*index;
    index=index+1;
    thetaEnd=(pi/2)+(pi/(2*NumberOfSectors))*index;
    removeSmall=find(theta<thetaStart);
    removeBig=find(theta>thetaEnd);
    remove=[ removeSmall ;  removeBig ];
    R_temp(remove)=[];
    Rho_temp(remove)=[];
    AverageRhoVsR(i).R=R_temp;
    AverageRhoVsR(i).Rho=Rho_temp;
    
    %     figure
    %     plot(AverageRhoVsR(i).R,AverageRhoVsR(i).Rho,'*')
    [AverageRhoVsR(i).AvgRho,AverageRhoVsR(i).upSTD,AverageRhoVsR(i).downSTD,AverageRhoVsR(i).AvgRrho] = meanGaussianMM(AverageRhoVsR(i).R,AverageRhoVsR(i).Rho, 1);
    
    close
       
end

save([Capture_folder,'Rho\AverageRhoVsRbySectors.mat'],'AverageRhoVsR');
close all

end