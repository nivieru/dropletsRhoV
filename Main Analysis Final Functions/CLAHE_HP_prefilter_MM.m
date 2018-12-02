
function CLAHE_HP_prefilter_MM(Capture_folder)

clahesize=importdata([Capture_folder,'Analysis parameters\pix_size_for_CLAHEprefilter.m']);
highpsize=importdata([Capture_folder,'Analysis parameters\pix_size_for_HPprefilter.m']);

Dir=dir([Capture_folder,'spread 8bitC0\*tiff']);
mkdir([Capture_folder,'Velocity\CLAHE_HP prefilter']);

for i=1:length(Dir);
    
    frameA=imread([Capture_folder,'spread 8bitC0\',Dir(i).name]);
    k=num2str(i);
    
    if (i<10)
        write_to_file=([Capture_folder,'Velocity\CLAHE_HP prefilter\0',k,'.tiff']);
    else
        write_to_file=([Capture_folder,'Velocity\CLAHE_HP prefilter\',k,'.tiff']);
    end
    
 
    %CLAHE
    
%     in_roi=frameA(:,:,1);
    in_roi=frameA;
    numberoftiles1=round(size(in_roi,1)/clahesize);
    numberoftiles2=round(size(in_roi,2)/clahesize);
    
    if numberoftiles1 < 2
        numberoftiles1=2;
    end
    
    if numberoftiles2 < 2
        numberoftiles2=2;
    end
    
    in_roi=adapthisteq(in_roi, 'NumTiles',[numberoftiles1 numberoftiles2], 'ClipLimit', 0.01, 'NBins', 256, 'Range', 'full', 'Distribution', 'uniform');
    
   %High Pass Filter
    highpsize
    
    h = fspecial('gaussian',32,highpsize);
%     in_roi=(double(in_roi))-(double(imfilter(in_roi,h,'replicate')));
    in_roi=double(in_roi)-double(imfilter(in_roi,h,'replicate'));

    in_roi=in_roi/max(max(in_roi))*255;
    
    frameAfter=in_roi;
    imwrite(uint8(frameAfter),write_to_file,'WriteMode','append')
    
end

end








