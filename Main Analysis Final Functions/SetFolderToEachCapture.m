function [Capture]=SetFolderToEachCapture(slide_folder)

% Dir8=dir([slide_folder,'*tif']);  %%% The movies here need to be 8bit
% Size_Dir8=size(Dir8);
% names_array8={Dir8.name};
% movies_8bit=strfind(names_array8,'8bit');
% emptyCells8bit = cellfun(@isempty,movies_8bit);
% Number_of_8bit_movies=size(find(emptyCells8bit==0));
% locations_of_8bit_movies=find(emptyCells8bit==0);

Dir16=dir([slide_folder,'*tiff']);  %%% The movies here need to be 16bit
Size_Dir=size(Dir16);
names_array={Dir16.name};
movies_C0_channels=strfind(names_array,'_C1');
emptyCells_C0 = cellfun(@isempty,movies_C0_channels);
Number_of_C0_movies=length(find(emptyCells_C0==0));
locations_of_C0_movies=find(emptyCells_C0==0);

Capture=struct;

for i=1:Number_of_C0_movies  
%     dir_8bit=locations_of_8bit_movies(i);
%     Capture(i).name=[slide_folder,'Capture ',Dir8(dir_8bit).name(9),'\'];
%     mkdir(Capture(i).name)
%     copyfile([slide_folder Dir8(dir_8bit).name],[Capture(i).name,'8bitC0.tif']);
%     
    dir_C0=locations_of_C0_movies(i);
    
    if (length(Dir16(dir_C0).name)==17)
    Capture(i).name=[slide_folder,'Capture ',Dir16(dir_C0).name(9),'\'];
    else Capture(i).name=[slide_folder,'Capture ',Dir16(dir_C0).name(9:10),'\'];
    end
    
    mkdir(Capture(i).name)
    copyfile([slide_folder Dir16(dir_C0).name],[Capture(i).name,'16bitC0.tiff']);
    delete ([slide_folder Dir16(dir_C0).name])
    info=imfinfo([Capture(i).name,'16bitC0.tiff']);
    Size_info=size(info);
    Number_of_frames=Size_info(1,1);

    
%     for k=1:Number_of_frames
%     Movie16bit=imread([Capture(i).name,'16bitC0.tiff'],k);
%     Movie8bit=uint8((Movie16bit-min(min(Movie16bit)))/256);
%     %Movie8bit=imadjust(Movie8bit);
%       if (k=1)  
%       imwrite(Movie8bit,[Capture(i).name,'8bitC0.tif']);
%       end
%      imwrite(Movie8bit,[Capture(i).name,'8bitC0.tif'],'WriteMode','append');
%     end

% for k=1:Number_of_frames
%     Movie16bit=imread([Capture(1).name,'16bitC0.tiff'],k);
%     Movie8bit=double(Movie16bit)-min(double(Movie16bit(:)));
%     Movie8bit=Movie8bit/max(Movie8bit(:));
%     Movie8bit=uint8(Movie8bit*255);
% %     Movie8bit=imadjust(Movie8bit);
%       if (k==1)  
%       imwrite(Movie8bit,[Capture(1).name,'8bitC0.tif']);
%       else
%      imwrite(Movie8bit,[Capture(1).name,'8bitC0.tif'],'WriteMode','append');
%       end
% end
    

end

end

%  for k=1:40
%     Movie16bit=imread('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Kinneret movies\2016_10_20\mix1 sample2 time17_08\5sec\Capture 1\16bitC0.tiff',k);
%     DoubleMovie16bit=double(Movie16bit);
% %     MAX_NO=max(max(DoubleMovie16bit));
% %     MIN_NO=min(min(DoubleMovie16bit));
% %     DoubleMovie8bit=((DoubleMovie16bit-MIN_NO)/(MAX_NO-MIN_NO));
% %     Movie8bit=uint8(DoubleMovie8bit)*256;
% %     Movie8bit=imadjust(Movie8bit);
%     %Movie8bit=imadjust(Movie8bit,[0 1],[0 200/256]);
% %     Movie8bit=Movie8bit*256;
%     Movie8bit=uint8((Movie16bit-min(min(Movie16bit)))/255);
%     Movie8bit=imadjust(Movie8bit,[0 1],[0 200/255]);
%     imwrite(Movie8bit,'C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Kinneret movies\2016_10_20\mix1 sample2 time17_08\5sec\Capture 1\8bitC0try2.tif','WriteMode','append');
%     end
