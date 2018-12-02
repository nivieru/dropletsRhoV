function CalculateAverageRhoLAandActinV2(Capture_folder,calibration,PixImage,file)

X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);
DROP_mask=importdata([Capture_folder,'Analysis parameters\','DROP_mask.mat']);
Capture_folder=[Capture_folder,file];
mkdir([Capture_folder,'Rho']);
pix_C0=PixImage;

%%%% PART 1 - transform the pixel matrix to matrix of distances from the
%%%% drop center.

L=size(pix_C0);

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

%%%% PART 2 - Set the length scale by multiply with calibration
R=R*calibration;
theta=theta(:);
R=R(:);
AverageIntensityMatrixDILUTE=pix_C0(:);

%%%% PART 3 - Take the desired area for the average intensity
remove1_4=find(theta<(pi/2));
remove3=find(theta>(pi));
removeEestN=[remove1_4;remove3];
R(removeEestN)=[];
AverageIntensityMatrixDILUTE(removeEestN)=[];
theta(removeEestN)=[];


%%%% PART 4 - Extract the average intensity profile using 'meanGaussianMM'

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