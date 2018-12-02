function Spreads8bitTiffs(Capture_folder)

info=imfinfo([Capture_folder,'8bitC0.tif']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

mkdir([Capture_folder,'spread 8bitC0'])

for k=1:Number_of_frames;
    
    pix_c0(:,:,k)=imread([Capture_folder,'8bitC0.tif'],k);
    n=int2str(k);
    
    if (k<10)
        imwrite(pix_c0(:,:,k),[Capture_folder,'spread 8bitC0\','0',n,'.tiff' ]);
    else
        imwrite(pix_c0(:,:,k),[Capture_folder,'spread 8bitC0\',n,'.tiff' ]);
    end
    
end
end