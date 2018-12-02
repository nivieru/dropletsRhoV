%%% Maya Malik Garbi - modified at 12.12.17


function CalculateAverageRhoBySectorsForLongTL(Capture_folder,NumberOfSectors,FirstFrame,LastFrame,X0,Y0)

%%%% STEP 1- 
calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']); %%% micropscope calibration [um/pixel] 
% X0=importdata([Capture_folder,'Analysis parameters\X0.m']);  %%% [pixel] calculated at measure drop size as the center of the blob
% Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);  %%% [pixel] calculated at measure drop size as the center of the blob
% X0=importdata([Capture_folder,'Analysis parameters\OptimizeX0.mat']);
% Y0=importdata([Capture_folder,'Analysis parameters\OptimizeY0.mat']);

mkdir([Capture_folder,'Rho']);
mkdir([Capture_folder,'Rho\figures']);

info=imfinfo([Capture_folder,'16bitC0.tiff']);
Size_info=size(info);
% Number_of_frames=Size_info(1,1);
Number_of_frames=LastFrame-FirstFrame+1;

%%%% STEP 2 - read the image data and calculate the time average intensity matrix.  
kk=1;
for k=FirstFrame:LastFrame;    
 %   pix_C0(:,:,kk)=imread([Capture_folder ,'16bitC0.tiff'],k);
      pix_C0(:,:,kk)=imread([Capture_folder ,'16bitC0 after bleach correction.tiff'],k);

    kk=kk+1;
end

pix_C0=double(pix_C0);
AverageIntensityMatrix=pix_C0;

%%%% STEP 3 - Calculate the time average intensity matrix
% AverageIntensityMatrix=AverageIntensity(pix_C0,Number_of_frames);
% figure (1)
% imshow(AverageIntensityMatrix,[])

%%%% STEP 4 - transform the pixel matrix to matrix of distances from the drop center.  
L=length(pix_C0);
for i=1:L
    for j=1:L
        Y(i,j)=i-Y0;
        X(i,j)=j-X0;
        
        R(i,j)=sqrt( (X(i,j)^2) + (Y(i,j)^2) );
        theta(i,j)=atan(Y(i,j)/X(i,j));
%         theta(i,j)=atan2(Y(i,j),X(i,j));
        
        if (X(i,j)<0)
            theta(i,j)=theta(i,j)+pi;
        end
        
        if (theta(i,j)<0)
            theta(i,j)=2*pi+theta(i,j);
        end
        
    end
end

%%%% NOTE - y axis is opposite thus theta goes from zero to 2pi clockwise 


%%%% STEP 5 - set the length scale by multiply with calibration 
R=R*calibration;
theta=theta(:);
R=R(:);
AverageIntensityMatrixDILUTE=AverageIntensityMatrix(:);

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
    
    %%%% Those lins are only for taking one sector of the drop
    thetaStart=(pi/2)+(pi/(2*NumberOfSectors))*index;
    index=index+1;
    thetaEnd=(pi/2)+(pi/(2*NumberOfSectors))*index;
    
%     %%%%% Only for taking all the angels
%     thetaStart=((2*pi)/NumberOfSectors)*index;
%     index=index+1;
%     thetaEnd=((2*pi)/NumberOfSectors)*index;
    
    removeSmall=find(theta<thetaStart);
    removeBig=find(theta>thetaEnd);
    remove=[ removeSmall ;  removeBig ];
    R_temp(remove)=[];
    Rho_temp(remove)=[];
    AverageRhoVsR(i).R=R_temp;
    AverageRhoVsR(i).Rho=Rho_temp;
    
         figure
         plot(AverageRhoVsR(i).R,AverageRhoVsR(i).Rho,'*')
    [AverageRhoVsR(i).AvgRho,AverageRhoVsR(i).upSTD,AverageRhoVsR(i).downSTD,AverageRhoVsR(i).AvgRrho] = meanGaussianMM(AverageRhoVsR(i).R,AverageRhoVsR(i).Rho, 1);   
    %close   
end

mkdir([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame)]);
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\AverageRhoVsRbySectors.mat'],'AverageRhoVsR');
close all


figure
for i=1:NumberOfSectors
    plot(AverageRhoVsR(i).AvgRrho,AverageRhoVsR(i).AvgRho)
    hold on
end

end
