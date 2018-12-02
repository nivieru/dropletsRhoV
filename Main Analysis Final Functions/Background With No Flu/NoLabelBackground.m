%%%% Maya Malik - last modification -  22.11.17
%%%% Calculate the most common value for drops imaged without fluorophore in order to get the intensity background.  
%%%% This function need to operate on slides where I imaged ONLY one drop at
%%%% different exsposures time. 


clear all;
close all;

slide_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\All intensity corrections\NoLabelBackground\2017_03_02\80% extract no label background check\Slide1\';

Dir=dir([slide_folder,'*tiff']);  %%% The movies here need to be 16bit
Size_Dir=size(Dir);
names_array={Dir.name};
movies_LA_channels=strfind(names_array,'_C1');
emptyCells_LA = cellfun(@isempty,movies_LA_channels);
Number_of_LA_movies=size(find(emptyCells_LA==0));
locations_of_LA_movies=find(emptyCells_LA==0);
% CaptureLA=struct;

movies_RhActin_channels=strfind(names_array,'_C2');
emptyCells_RhActin = cellfun(@isempty,movies_RhActin_channels);
Number_of_RhActin_movies=size(find(emptyCells_RhActin==0));
locations_of_RhActin_movies=find(emptyCells_RhActin==0);
% CaptureRhActin=struct;

movies_BF_channels=strfind(names_array,'_C0');
emptyCells_BF = cellfun(@isempty,movies_BF_channels);
Number_of_BF_movies=size(find(emptyCells_BF==0));
locations_of_BF_movies=find(emptyCells_BF==0);

%%% MARK THE DROP EDGES

imageBFindex=locations_of_BF_movies(1);
imageBF=imread([slide_folder,Dir(imageBFindex).name]);

imshow(imageBF,[])
title('Choose: (1) Drop circle')

h1 = imellipse;
vert=wait(h1);
DROP_mask=createMask(h1);
DROP_Position=getPosition(h1);


for i=1:Number_of_RhActin_movies(1,2)    
    
    imageLAindex=locations_of_LA_movies(i);
    imageLA=imread([slide_folder,Dir(imageLAindex).name]);
    imageLA(find(DROP_mask==0))=NaN;
    
    [countsIm,xIm] = imhist(imageLA);
    LA_Beckground(i)=xIm(find(countsIm(2:end)==max(countsIm(2:end)),1));
    
    imageRhindex=locations_of_RhActin_movies(i);
    imageRh=imread([slide_folder,Dir(imageRhindex).name]);
    imageRh(find(DROP_mask==0))=NaN;
    
    [countsIm,xIm] = imhist(imageRh);
    Rh_Beckground(i)=xIm(find(countsIm(2:end)==max(countsIm(2:end)),1));
    
end
    
save([slide_folder,'LA_Beckground.mat'],'LA_Beckground');
save([slide_folder,'Rh_Beckground.mat'],'Rh_Beckground');