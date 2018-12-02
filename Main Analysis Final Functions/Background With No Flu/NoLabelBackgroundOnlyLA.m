


clear all;
close all;

slide_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\NoLabelBackground\2018_01_01\background no flu\Folders\Slide 11\';
Dir=dir([slide_folder,'*tiff']);  %%% The movies here need to be 16bit
Size_Dir=size(Dir);
names_array={Dir.name};
movies_LA_channels=strfind(names_array,'_C1');
emptyCells_LA = cellfun(@isempty,movies_LA_channels);
Number_of_LA_movies=size(find(emptyCells_LA==0));
locations_of_LA_movies=find(emptyCells_LA==0);
% CaptureLA=struct;

% movies_RhActin_channels=strfind(names_array,'_C2');
% emptyCells_RhActin = cellfun(@isempty,movies_RhActin_channels);
% Number_of_RhActin_movies=size(find(emptyCells_RhActin==0));
% locations_of_RhActin_movies=find(emptyCells_RhActin==0);
% % CaptureRhActin=struct;

movies_BF_channels=strfind(names_array,'_C0');
emptyCells_BF = cellfun(@isempty,movies_BF_channels);
Number_of_BF_movies=size(find(emptyCells_BF==0));
locations_of_BF_movies=find(emptyCells_BF==0);

%%% If one drop was imaged at different exposure time otherwise uncomment lines inside the loop to mark the edges of each drop 
%%% MARK THE DROP EDGES

    imageBFindex=locations_of_BF_movies(1);
    imageBF=imread([slide_folder,Dir(imageBFindex).name]);
    
    figure
    imshow(imageBF,[])
    title('Choose: (1) Drop circle')
    
    h1 = imellipse;
    vert=wait(h1);
    DROP_mask=createMask(h1);
    DROP_Position=getPosition(h1);

for i=1:Number_of_LA_movies(1,2)
    
    %%% MARK THE DROP EDGES
    
%     imageBFindex=locations_of_BF_movies(i);
%     imageBF=imread([slide_folder,Dir(imageBFindex).name]);
%     
%     figure
%     imshow(imageBF,[])
%     title('Choose: (1) Drop circle')
%     
%     h1 = imellipse;
%     vert=wait(h1);
%     DROP_mask=createMask(h1);
%     DROP_Position=getPosition(h1);
    
    
    imageLAindex=locations_of_LA_movies(i);
    imageLA=imread([slide_folder,Dir(imageLAindex).name]);
    imageLA(find(DROP_mask==0))=0;
    
    [countsIm,xIm] = imhist(imageLA,2^16);
    LA_Beckground(i)=xIm(find(countsIm(2:end)==max(countsIm(2:end)),1));
    %Rh_Beckground(i)=xIm(find(countsIm(2:end)==max(countsIm(2:end)),1));
    
    figure
    plot(xIm,countsIm)
    xlim([0 2500])
    ylim([0 300])
%     imageRhindex=locations_of_RhActin_movies(i);
%     imageRh=imread([slide_folder,Dir(imageRhindex).name]);
%     imageRh(find(DROP_mask==0))=NaN;
%     
%     [countsIm,xIm] = imhist(imageRh);
%     Rh_Beckground(i)=xIm(find(countsIm(2:end)==max(countsIm(2:end)),1));
%     
end

 save([slide_folder,'LA_Beckground.mat'],'LA_Beckground');
% save([slide_folder,'Rh_Beckground.mat'],'Rh_Beckground');

% file_name='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\NoLabelBackground\2018_01_01\background no flu\folders\';
% Dir=dir(file_name);
% 
% for i=3:length(Dir)
%     k=i-2
%     AllBackgrounds(k,:)=importdata([file_name,Dir(i).name,'\LA_Beckground.mat']);
% end

% exsposure200_3_300=mean(AllBackgrounds(:,1));
% exsposure400_3_300=mean(AllBackgrounds(:,2));
% exsposure500_3_300=mean(AllBackgrounds(:,3));
% exsposure200_2_300=mean(AllBackgrounds(:,4));
% 
% save([file_name,'exsposure200_3_300.mat'],'exsposure200_3_300')
% save([file_name,'exsposure400_3_300.mat'],'exsposure400_3_300')
% save([file_name,'exsposure500_3_300.mat'],'exsposure500_3_300')
% save([file_name,'exsposure200_2_300.mat'],'exsposure200_2_300')
save([file_name,'AllBackgrounds.mat'],'AllBackgrounds')

