%%%%%% Maya Malik Garbi - 11/11/18
%%%%%% This function takes image or movie and subtract background without
%%%%%% flu
 

function BackgroundWithoutFluSubtraction(Capture_folder,ImageName,BackNoFlu)

info=imfinfo([Capture_folder,ImageName,'.tiff']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

for k=1:Number_of_frames
Movie16{k}=double(imread([Capture_folder ,ImageName,'.tiff'],k)-BackNoFlu);
imwrite(uint16(Movie16{k}),[Capture_folder,ImageName,' after background subtraction.tiff'],'WriteMode','append');
end

end
        
