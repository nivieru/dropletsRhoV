function make8bitTiff(folder)
file16bit = fullfile(folder, '16bitC0.tiff');
info=imfinfo(file16bit);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

file8bit = fullfile(folder, '8bitC0.tif');
for k=1:Number_of_frames
%     writeValidated = false;
%     while ~writeValidated
        Movie16bit=imread(file16bit,k);
        Movie8bit=im2uint8(Movie16bit);
        Movie8bit=imadjust(Movie8bit);
        if (k==1)
            imwrite(Movie8bit,file8bit);
        else
            imwrite(Movie8bit,file8bit,'WriteMode','append');
        end
%         % I get a weird problem when sometimes the 8bit file is written
%         % corrupted, this is to validate that the image on disk matches the
%         % data we were writing
%         validateMovie8bit = imread(file8bit,k);
%         if isequal(Movie8bit, validateMovie8bit)
%             writeValidated = true;
%         else
%             warning('Problem writing 8bit movie');
%         end
%     end
end