function Spreads8bitTiffs(Capture_folder)
make8bitTiff(Capture_folder);
file8bit = fullfile(Capture_folder,'8bitC0.tif');
info=imfinfo(file8bit);
Size_info=size(info);
Number_of_frames=Size_info(1,1);
spreadDir = fullfile(Capture_folder,'spread 8bitC0\');
if isfolder(spreadDir)
    rmdir(spreadDir, 's');
end
mkdir(spreadDir);

for k=1:Number_of_frames
    
    pix_c0=imread(file8bit,k);
    n=int2str(k);
    
    if (k<10)
        imwrite(pix_c0,[spreadDir,'0',n,'.tiff' ]);
    else
        imwrite(pix_c0,[spreadDir,n,'.tiff' ]);
    end
    
end
end