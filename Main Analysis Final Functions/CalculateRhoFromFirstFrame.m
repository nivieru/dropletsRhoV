%%%% Maya Malik Garbi
%%%% This function calculate rho(r) from the first movie frame 

function CalculateRhoFromFirstFrame(Capture_folder)

calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']);
X0=importdata([Capture_folder,'Analysis parameters\X0.m']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);
mkdir([Capture_folder,'RhoFromFirstFrame']);

info=imfinfo([Capture_folder,'16bitC0.tiff']);
%info=imfinfo([Capture_folder,'8bitC0.tif']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

pix_C0=imread([Capture_folder ,'16bitC0.tiff'],1);
MAXIMUM=max(max(pix_C0));
MAX=double(ceil(max(MAXIMUM)));
pix_matrix_C0_1=double(pix_C0);
pix_C0=pix_matrix_C0_1;

%%%Calculate the average intensity matrix
AverageIntensityMatrix=pix_C0;
figure (1)
imshow(AverageIntensityMatrix,[])

%%%Find the center of mass [X0 Y0]
L=length(pix_C0);

for i=1:L
    for j=1:L
        
        RhoX(i,j)=pix_C0(i,j,1)*j;
        RhoY(i,j)=pix_C0(i,j,1)*i;
        
    end
end

S_RhoX=sum(sum(RhoX));
S_RhoY=sum(sum(RhoY));
S_Rho=sum(sum(pix_C0(:,:,1)));

X0_CM=ceil(S_RhoX/S_Rho);
Y0_CM=ceil(S_RhoY/S_Rho);

%%%Calculate Rho as a function of R
%Transformation of corrdinates

for i=1:L
    for j=1:L
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
AverageIntensityMatrixDILUTE=AverageIntensityMatrix(:);


%%%Take the desired area for the average intensity
remove1_4=find(theta<(pi/2));
remove3=find(theta>(pi));
removeEestN=[remove1_4;remove3];
R(removeEestN)=[];
AverageIntensityMatrixDILUTE(removeEestN)=[];
theta(removeEestN)=[];


%%%Plot Rho vs R
plot(R,AverageIntensityMatrixDILUTE,'*')
%[Rho,Rrho] = meanGaussian(R(:),AverageIntensityMatrix(:), 1);
[Rho,upSTD,downSTD,Rrho] = meanGaussian(R(:),AverageIntensityMatrixDILUTE(:), 1);

RhoFromFirstFrame=Rho;

h=figure (2)
title('<\rho(R)>','FontSize',16)
xlabel('R [\mum]','FontSize',16)
ylabel('<\rho>','FontSize',16)
%xlim([Rchunk Rdrop])
mkdir([Capture_folder,'RhoFromFirstFrame\figures']);
savefig([Capture_folder,'RhoFromFirstFrame\figures\','Rho no back-subtraction.fig']);
saveas(h,[Capture_folder,'RhoFromFirstFrame\figures\','Rho no back-subtraction.tiff']);

h=figure (3)
plot(Rrho,Rho,'*')
title('<\rho(R)>','FontSize',16)
xlabel('R [\mum]','FontSize',16)
ylabel('<\rho>','FontSize',16)
%xlim([Rchunk Rdrop])
mkdir([Capture_folder,'RhoFromFirstFrame\figures']);
savefig([Capture_folder,'RhoFromFirstFrame\figures\','AverageRhoOverTheta.fig']);
saveas(h,[Capture_folder,'RhoFromFirstFrame\figures\','AverageRhoOverTheta.tiff']);

save([Capture_folder,'RhoFromFirstFrame\RhoFromFirstFrame.mat'],'RhoFromFirstFrame');
save([Capture_folder,'RhoFromFirstFrame\Rrho.mat'],'Rrho');
% save([Capture_folder,'RhoFromFirstFrame\X0.m'],'X0');
% save([Capture_folder,'RhoFromFirstFrame\Y0.m'],'Y0');


% %%%%Option to subtract the internal background from the average Intensity
% %%%%in the area between the network radius to the drop radius
% %%Internal Background subtraction
% 
% DROP_mask=importdata([Capture_folder,'Analysis parameters\','DROP_mask.m']);
% ACTIN_NETWORK_mask=importdata([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_mask.m']);
% 
% AverageIntensityMatrix=double(AverageIntensityMatrix);
% AverageIntensityMatrix(find(DROP_mask==0))=NaN;
% AverageIntensityMatrix(find(ACTIN_NETWORK_mask==1))=NaN;
% AverageIntensityMatrix=uint16(AverageIntensityMatrix);
% 
% % AverageIntensityMatrix(removeWestN)=[];
%  AverageIntensityMatrix(removeEestN)=[];
% 
% [countsIm,xIm] = imhist((AverageIntensityMatrix));
% internal_Beckground=xIm(find(countsIm(2:end)==max(countsIm(2:end)),1));
% Rho_background=Rho-internal_Beckground;
% 
% 
% h=figure
% plot(Rrho,Rho_background,'*')
% title('<\rho(R)-\rho_0>','FontSize',16)
% xlabel('R [\mum]','FontSize',16)
% ylabel('<\rho-\rho0>','FontSize',16)
% %xlim([Rchunk Rdrop])
% mkdir([Capture_folder,'RhoFromFirstFrame\figures']);
% savefig([Capture_folder,'RhoFromFirstFrame\figures\','AverageRho include back-subtraction.fig']);
% saveas(h,[Capture_folder,'RhoFromFirstFrame\figures\','AverageRho include back-subtraction.tiff']);
% 
% save([Capture_folder,'RhoFromFirstFrame\Rho_background.m'],'Rho_background');


close all

end