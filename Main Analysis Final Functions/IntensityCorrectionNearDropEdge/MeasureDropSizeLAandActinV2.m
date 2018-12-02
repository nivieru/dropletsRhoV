function MeasureDropSizeLAandActinV2(Capture_folder,calibration)

%image=imread([Capture_folder ,'BF.tiff'],15);
image=imread([Capture_folder ,'LA.tiff'],15);
imshow(image,[])
title('Choose: (1) Drop circle ')

h1 = imellipse;
vert=wait(h1);
DROP_mask=createMask(h1);
DROP_Position=getPosition(h1);
DROP_radius=ceil( ((DROP_Position(3)+DROP_Position(4))/4) *calibration );
X0=ceil(DROP_Position(1)+(DROP_Position(3)/2));
Y0=ceil(DROP_Position(2)+(DROP_Position(4)/2));

mkdir([Capture_folder,'Analysis parameters']);

save([Capture_folder,'Analysis parameters\','DROP_radius.mat'],'DROP_radius');
save([Capture_folder,'Analysis parameters\','DROP_mask.mat'],'DROP_mask');
save([Capture_folder,'Analysis parameters\','X0.mat'],'X0');
save([Capture_folder,'Analysis parameters\','Y0.mat'],'Y0');

close all

end
