function CalculateAverageRhoLAandActinV(Capture_folder,calibration,PixImage,file)

X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);
MaxRr=importdata([Capture_folder,'Analysis parameters\MaxRr.mat']);

DROP_mask=importdata([Capture_folder,'Analysis parameters\','DROP_mask.mat']);
ACTIN_NETWORK_mask=importdata([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_mask.mat']);

Capture_folder=[Capture_folder,file];
mkdir([Capture_folder,'Rho']);


% pix_LA=double(imread([Capture_folder ,'Rhodamine.tiff']));
% pix_Rh=double(imread([Capture_folder ,'LA.tiff']));

pix_C0=PixImage;

%%%Find the center of mass [X0 Y0]
L=size(pix_C0);

for i=1:L(1,1)
    for j=1:L(1,2)
        
        RhoX(i,j)=pix_C0(i,j)*j;
        RhoY(i,j)=pix_C0(i,j)*i;
        
    end
end

S_RhoX=sum(sum(RhoX));
S_RhoY=sum(sum(RhoY));
S_Rho=sum(sum(pix_C0));

X0_CM=ceil(S_RhoX/S_Rho);
Y0_CM=ceil(S_RhoY/S_Rho);

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

% %%%Take the desired area for the average intensity
% remove1_4=find(theta<(pi/2));
% remove3=find(theta>(pi));
% removeEestN=[remove1_4;remove3];
% R(removeEestN)=[];
% AverageIntensityMatrixDILUTE(removeEestN)=[];
% theta(removeEestN)=[];

%%%Plot Rho vs R
plot(R,AverageIntensityMatrixDILUTE,'*')
%[Rho,Rrho] = meanGaussian(R(:),AverageIntensityMatrix(:), 1);
[Rho,upSTD,downSTD,Rrho] = meanGaussianMM(R(:),AverageIntensityMatrixDILUTE(:), 1);

h=figure (2)
title('<\rho(R)>','FontSize',16)
xlabel('R [\mum]','FontSize',16)
ylabel('<\rho>','FontSize',16)
%xlim([Rchunk Rdrop])
mkdir([Capture_folder,'Rho\figures']);
savefig([Capture_folder,'Rho\figures\','Rho no back-subtraction.fig']);
saveas(h,[Capture_folder,'Rho\figures\','Rho no back-subtraction.tiff']);

h=figure (3)
plot(Rrho,Rho,'*')
title('<\rho(R)>','FontSize',16)
xlabel('R [\mum]','FontSize',16)
ylabel('<\rho>','FontSize',16)
%xlim([Rchunk Rdrop])
mkdir([Capture_folder,'Rho\figures']);
savefig([Capture_folder,'Rho\figures\','AverageRho no back-subtraction.fig']);
saveas(h,[Capture_folder,'Rho\figures\','AverageRho no back-subtraction.tiff']);

save([Capture_folder,'Rho\Rho.mat'],'Rho');
save([Capture_folder,'Rho\Rrho.mat'],'Rrho');
save([Capture_folder,'Rho\X0.mat'],'X0');
save([Capture_folder,'Rho\Y0.mat'],'Y0');

close all

end