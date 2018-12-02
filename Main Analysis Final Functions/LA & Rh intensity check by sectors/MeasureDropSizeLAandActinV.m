function MeasureDropSizeLAandActinV(Capture_folder,calibration)

im=imread([Capture_folder,'Rhodamine after non Homo Illumination Corr.tiff']);
imshow(im,[])
title('Choose: (1) Drop circle (2) Network circle (3) Chunk circle')

h1 = imellipse;
vert=wait(h1);
DROP_mask=createMask(h1);
DROP_Position=getPosition(h1);
DROP_radius=ceil( ((DROP_Position(3)+DROP_Position(4))/4) *calibration );
X0drop=ceil(DROP_Position(1)+(DROP_Position(3)/2));
Y0drop=ceil(DROP_Position(2)+(DROP_Position(4)/2));


h2 = imellipse;
vert=wait(h2);
ACTIN_NETWORK_mask=createMask(h2);
ACTIN_NETWORK_Position=getPosition(h2);
ACTIN_NETWORK_radius=ceil( ((ACTIN_NETWORK_Position(3)+ACTIN_NETWORK_Position(4))/4) *calibration );
MaxRr=ACTIN_NETWORK_radius;

h3 = imellipse;
vert=wait(h3);
CHUNK_mask=createMask(h3);
CHUNK_Position=getPosition(h3);
CHUNK_radius=ceil( ((CHUNK_Position(3)+CHUNK_Position(4))/4) * calibration );
MinRr=CHUNK_radius;
X0=ceil(CHUNK_Position(1)+(CHUNK_Position(3)/2));
Y0=ceil(CHUNK_Position(2)+(CHUNK_Position(4)/2));

mkdir([Capture_folder,'Analysis parameters']);
save([Capture_folder,'Analysis parameters\MaxRr.mat'],'MaxRr');  %% radius of network
save([Capture_folder,'Analysis parameters\MinRr.mat'],'MinRr');  %% radius of chenck 

save([Capture_folder,'Analysis parameters\','DROP_radius.mat'],'DROP_radius');
save([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_radius.mat'],'ACTIN_NETWORK_radius');
save([Capture_folder,'Analysis parameters\','CHUNK_radius.mat'],'CHUNK_radius');
save([Capture_folder,'Analysis parameters\','DROP_mask.mat'],'DROP_mask');
save([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_mask.mat'],'ACTIN_NETWORK_mask');
% save([Capture_folder,'Analysis parameters\','CHUNK_mask.m'],'CHUNK_mask');
save([Capture_folder,'Analysis parameters\','X0.mat'],'X0');
save([Capture_folder,'Analysis parameters\','Y0.mat'],'Y0');
save([Capture_folder,'Analysis parameters\','X0drop.mat'],'X0drop');
save([Capture_folder,'Analysis parameters\','Y0drop.mat'],'Y0drop');
save([Capture_folder,'Analysis parameters\','calibration.mat'],'calibration');

close all

end
