%%%%%%% This function draw few points on the image

function MarkPointOnMovie(Capture_folder)

X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);
X0drop=importdata([Capture_folder,'Analysis parameters\X0drop.mat']);
Y0drop=importdata([Capture_folder,'Analysis parameters\Y0drop.mat']);
DROP_radius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']);

info=imfinfo([Capture_folder,'16bitC0 after bleach correction.tiff']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

for k=1:Number_of_frames;
pix_C0(:,:,k)=imread([Capture_folder ,'16bitC0 after bleach correction.tiff'],k);
MAXIMUM(k)=max(max(pix_C0(:,:,k)));
end

% MAX=double(ceil(max(MAXIMUM)));
% Rho_for_movie=double(pix_C0);
% Rho_for_movie=(Rho_for_movie/MAX)*255;   %% data from spinning disk unit16
% Rho_for_movie=uint8(Rho_for_movie);

%%% Loop to get the jet movie
for k=1:Number_of_frames;
    
    imshow(pix_C0(:,:,k),[])
    hold on
    plot(X0,Y0,'+')
    hold on
    plot(X0drop,Y0drop,'+','Color','b')
    hold on 
    viscircles([X0drop,Y0drop],DROP_radius/calibration,'Color','w','LineWidth',2) 
    hold on
     frame_jet(k)=getframe(gca);
     new_movie(k)=im2frame(frame_jet(k).cdata(:,:,1),frame_jet(k).colormap);
    %movie_jet(k)=im2frame(frame_jet(k).cdata(:,:,1),jet);
%     imwrite(new_movie(k).cdata(:,:,1),jet,[Capture_folder,'Rho\movie with marks.tiff'],'WriteMode','append');
    imwrite(new_movie(k).cdata(:,:,1),new_movie(k).colormap,[Capture_folder,'Rho\movie with marks.tiff'],'WriteMode','append');

    
end

close all
% movie2avi(new_movie,[Capture_folder,'Rho\movie with marks.avi'],'fps',5,'compression','MSVC')
