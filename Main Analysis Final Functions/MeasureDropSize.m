function MeasureDropSize(Capture_folder)

calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']);
roi=importdata([Capture_folder,'Analysis parameters\roi.m']);

%%% New, choose the area from min and max projection 

Dir=dir([Capture_folder,'spread 8bitC0\*tiff']);
number_of_frames=length(Dir);
names_array={Dir.name};

%Movie minmum projection

Proj=(zeros(512,512));
for i=1:number_of_frames
    RhoRGB=imread([Capture_folder,'spread 8bitC0\',Dir(i).name]);
    Rho(:,:,i)=double(RhoRGB);                  %% data from spinning disk unit16
%     Rho(:,:,i)=double(RhoRGB(:,:,1));         %% data from Germany
end

for i=1:512;
    for j=1:512;
        
        minProj(i,j)=min(Rho(i,j,:));
        maxProj(i,j)=max(Rho(i,j,:));
    
    end
end

%%%% End New

%Drop_image=imread([Capture_folder,'spread 8bitC0\40.tiff']);
f=figure;
imshow(maxProj,[])
title('Choose: (1) Drop circle (2) Network circle')

h1 = imellipse;
vert=wait(h1);
DROP_mask=createMask(h1);
DROP_Position=getPosition(h1);
DROP_radius=ceil( ((DROP_Position(3)+DROP_Position(4))/4) *calibration );
X0drop=ceil(DROP_Position(1)+(DROP_Position(3)/2));
Y0drop=ceil(DROP_Position(2)+(DROP_Position(4)/2));

%%% Take bigger ellipse for bleach correction
setPosition(h1,[DROP_Position(1)-5,DROP_Position(2)-5,DROP_Position(3)+10,DROP_Position(4)+10]);
DROP_maskForBleachCorr=createMask(h1);

h2 = imellipse;
vert=wait(h2);
ACTIN_NETWORK_mask=createMask(h2);
ACTIN_NETWORK_Position=getPosition(h2);
ACTIN_NETWORK_radius=ceil( ((ACTIN_NETWORK_Position(3)+ACTIN_NETWORK_Position(4))/4) *calibration );
MaxRr=ACTIN_NETWORK_radius;
roiRadius=ceil(((roi(3)+roi(4))/4)*calibration);

if (roiRadius<MaxRr)
    MaxRr=roiRadius;
end

close(f)
f = figure;
imshow(minProj,[])
title('Choose: Chunk circle')



h3 = imellipse;
vert=wait(h3);
CHUNK_mask=createMask(h3);
CHUNK_Position=getPosition(h3);
CHUNK_radius=ceil( ((CHUNK_Position(3)+CHUNK_Position(4))/4) * calibration );
MinRr=CHUNK_radius;
X0=ceil(CHUNK_Position(1)+(CHUNK_Position(3)/2));
Y0=ceil(CHUNK_Position(2)+(CHUNK_Position(4)/2));

% CHUNK_radius=0;
% MinRr=CHUNK_radius;


save([Capture_folder,'Analysis parameters\MaxRr.m'],'MaxRr');  %% Rnetwork
save([Capture_folder,'Analysis parameters\MinRr.m'],'MinRr');  %% Rchenck 


save([Capture_folder,'Analysis parameters\','DROP_radius.m'],'DROP_radius');
save([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_radius.m'],'ACTIN_NETWORK_radius');
save([Capture_folder,'Analysis parameters\','CHUNK_radius.m'],'CHUNK_radius');
save([Capture_folder,'Analysis parameters\','DROP_mask.m'],'DROP_mask');
save([Capture_folder,'Analysis parameters\DROP_maskForBleachCorr.m'],'DROP_maskForBleachCorr'); 
save([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_mask.m'],'ACTIN_NETWORK_mask');
% save([Capture_folder,'Analysis parameters\','CHUNK_mask.m'],'CHUNK_mask');
save([Capture_folder,'Analysis parameters\','X0.m'],'X0');
save([Capture_folder,'Analysis parameters\','Y0.m'],'Y0');
save([Capture_folder,'Analysis parameters\','X0drop.m'],'X0drop');
save([Capture_folder,'Analysis parameters\','Y0drop.m'],'Y0drop');


close(f)

end