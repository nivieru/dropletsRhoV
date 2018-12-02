function CalculateAverageRho(Capture_folder)

calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']);
X0=importdata([Capture_folder,'Analysis parameters\X0.m']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);
mkdir([Capture_folder,'Rho']);

info=imfinfo([Capture_folder,'16bitC0 after bleach correction.tiff']);
%info=imfinfo([Capture_folder,'16bitC0.tiff']);
%info=imfinfo([Capture_folder,'8bitC0.tif']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

%Number_of_frames=3;


%for k=1:Number_of_frames;
    for k=1:Number_of_frames;

pix_C0(:,:,k)=imread([Capture_folder ,'16bitC0 after bleach correction.tiff'],k);
%         
%pix_C0(:,:,k)=imread([Capture_folder ,'16bitC0.tiff'],k);
%pix_C0(:,:,k)=imread([Capture_folder ,'8bitC0.tif'],k);

    MAXIMUM(k)=max(max(pix_C0(:,:,k)));
    
end

MAX=double(ceil(max(MAXIMUM)));
Rho_for_movie=double(pix_C0);
% Rho_for_movie=(Rho_for_movie/MAX)*65536;   %% data from spinning disk unit16
% Rho_for_movie=uint16(Rho_for_movie);
Rho_for_movie=(Rho_for_movie/MAX)*255;   %% data from spinning disk unit16
Rho_for_movie=uint8(Rho_for_movie);



%%% Loop to get the jet movie
%for k=1:Number_of_frames;
    for k=1:Number_of_frames;
    
    imshow(Rho_for_movie(:,:,k))
    hold on
    plot(X0,Y0,'+')
    frame_jet(k)=getframe(gca);
    movie_jet(k)=im2frame(frame_jet(k).cdata(:,:,1),jet);
    imwrite(movie_jet(k).cdata(:,:,1),jet,[Capture_folder,'Rho\movie jet.tiff'],'WriteMode','append');
    
end

close all
movie2avi(movie_jet,[Capture_folder,'Rho\movie jet.avi'],'fps',5,'compression','MSVC')

%%%%% End of loop for the movie

pix_matrix_C0_1=double(pix_C0);
pix_C0=pix_matrix_C0_1;

%%%Calculate the average intensity matrix
%pix_matrix_C0=mat2gray(pix_matrix_C0_1);
AverageIntensityMatrix=AverageIntensity(pix_C0,Number_of_frames);
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

% %%%Take the desired area for the average intensity
% removeWestN=find(theta>0);
% R(removeWestN)=[];
% AverageIntensityMatrixDILUTE(removeWestN)=[];

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
[Rho,upSTD,downSTD,Rrho] = meanGaussianMM(R(:),AverageIntensityMatrixDILUTE(:), 1);

%slop=(MaxRho-Rho(place+50))/(Rrho(place)-Rrho(place+50));
% ReleventRrho=Rrho(place+20:end);
% ReleventRho=Rho(place+20:end);
% dy=diff(ReleventRho);
% dx=diff(ReleventRrho);
% m=diff(dy./dx);
% f=find(m<-10);
% place_Rdrop=f(1)+place+20+1;
% Rdrop=Rrho(place_Rdrop);
% MinRho=Rho(place_Rdrop);
%
% Rho=Rho-MinRho;
% MaxRho=MaxRho-MinRho;
% MinRho=MinRho-MinRho;

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

save([Capture_folder,'Rho\Rho.m'],'Rho');
save([Capture_folder,'Rho\Rrho.m'],'Rrho');
save([Capture_folder,'Rho\X0.m'],'X0');
save([Capture_folder,'Rho\Y0.m'],'Y0');

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

% % %%Outside background substraction
% DROP_mask=importdata([Capture_folder,'Analysis parameters\','DROP_mask.m']);
% 
% AverageIntensityMatrix=double(AverageIntensityMatrix);
% AverageIntensityMatrix(find(DROP_mask==1))=NaN;
% AverageIntensityMatrix=uint16(AverageIntensityMatrix);
% 
% %AverageIntensityMatrix(removeWestN)=[];
% AverageIntensityMatrix(removeEestN)=[];
% 
% [countsIm,xIm] = imhist((AverageIntensityMatrix));
% outside_Beckground=xIm(find(countsIm(2:end)==max(countsIm(2:end)),1));

% outside_Beckground=1624;
% Rho_background=Rho-outside_Beckground;


% %Find MaxRho and Rchenck
% [MaxRho place]=max(Rho_background);
% Rchunk=ceil(Rrho(place));
% p=find(Rrho<MaxRr);
% MinRho=Rho_background(p(length(p)));
% 
% h=figure
% plot(Rrho,Rho_background,'*')
% title('<\rho(R)-\rho_0>','FontSize',16)
% xlabel('R [\mum]','FontSize',16)
% ylabel('<\rho-\rho0>','FontSize',16)
% %xlim([Rchunk Rdrop])
% mkdir([Capture_folder,'Rho\figures']);
% savefig([Capture_folder,'Rho\figures\','AverageRho include back-subtraction.fig']);
% saveas(h,[Capture_folder,'Rho\figures\','AverageRho include back-subtraction.tiff']);
% 
% % savefig([Capture_folder,'Rho\figures\','AverageRho include outside back-subtraction.fig']);
% % saveas(h,[Capture_folder,'Rho\figures\','AverageRho include outside back-subtraction.tiff']);
% 
% % Rho_outside_background=Rho_background;
% % save([Capture_folder,'Rho\Rho_outside_background.m'],'Rho_outside_background');
% 
% save([Capture_folder,'Rho\Rho_background.m'],'Rho_background');
% save([Capture_folder,'Rho\MinRho.m'],'MinRho');
% save([Capture_folder,'Rho\MaxRho.m'],'MaxRho');

close all


end