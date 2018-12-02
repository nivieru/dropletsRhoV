function [roi]=ChooseROI(Capture_folder)
f = figure;
imshow([Capture_folder,'spread 8bitC0\01.tiff']);
title('Choose ROI for PIV analysis')
% [Point]=ceil(ginput);
% roi(1)=Point(1,1);
% roi(2)=Point(1,2);
% roi(3)=Point(2,1)-Point(1,1);
% roi(4)=Point(2,2)-Point(1,2);

h= imrect;
vert=wait(h);
roi=getPosition(h);

save([Capture_folder,'Analysis parameters\roi.m'],'roi');
close(f)

end
