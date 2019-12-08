
function CLAHE_prefilter_MM(Capture_folder)

clahesize=importdata([Capture_folder,'Analysis parameters\pix_size_for_CLAHEprefilter.m']);
Dir=dir([Capture_folder,'spread 8bitC0\*tiff']);
mkdir([Capture_folder,'Velocity\CLAHE prefilter']);

for i=1:length(Dir)
    
    frameA=imread([Capture_folder,'spread 8bitC0\',Dir(i).name]);
    k=num2str(i);
    
    if (i<10)
        write_to_file=([Capture_folder,'Velocity\CLAHE prefilter\0',k,'.tiff']);
    else
        write_to_file=([Capture_folder,'Velocity\CLAHE prefilter\',k,'.tiff']);
    end
    
    in_roi=frameA(:,:,1);
    numberoftiles1=round(size(in_roi,1)/clahesize);
    numberoftiles2=round(size(in_roi,2)/clahesize);
    if numberoftiles1 < 2
        numberoftiles1=2;
    end
    if numberoftiles2 < 2
        numberoftiles2=2;
    end
    in_roi=adapthisteq(in_roi, 'NumTiles',[numberoftiles1 numberoftiles2], 'ClipLimit', 0.01, 'NBins', 256, 'Range', 'full', 'Distribution', 'uniform');
    frameAfter=in_roi;
    %imwrite(uint8(frameAfter),write_to_file,'WriteMode','append')
    imwrite(frameAfter,write_to_file,'WriteMode','append')
    
end


end






