%%%%% This function in modified function of - LA&RhodamineIntensityCheck.m
%%%%% Maya Malik Garbi - 22.9.17

function MainActinIntensityCheck(slide_folder,calibration,ActinNoLabelBack,LANoLabelBack)

%%%% PART 1 - make list of all the movies located in slide folder

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

%%%% PART 2 - takes the exported movies, generate folder to each movie and put it inside
k=1;
for i=1:Number_of_RhActin_movies(1,2)
    
    CurrentMovie=locations_of_LA_movies(i);
    
    if (length(Dir(CurrentMovie).name)==17)
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9),'\'];
        %     else Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    if (length(Dir(CurrentMovie).name)==18)
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    if (length(Dir(CurrentMovie).name)==30)
        MontageMovie(k)=i;
        k=k+1;
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9),'\'];
    end
    
    %%%% Montage movies name's are longer
    
    if (length(Dir(CurrentMovie).name)==31)
        MontageMovie(k)=i;
        k=k+1;
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    mkdir(Capture(i).name)
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'LA.tiff']);
    CurrentMovie=locations_of_RhActin_movies(i);
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'Rhodamine.tiff']);
    
end

save([slide_folder,'\Capture.mat'],'Capture');

%%%% PART 3 - Non homogenies intensity correction  

for i=1:length(Capture)
    
    Capture_folder=Capture(i).name;
 
    ImageName='LA';
    %%%%  1=Label - 'LA'
    All_IntensityCorrSteps(Capture_folder,ImageName,LANoLabelBack,1)
    
    ImageName='Rhodamine';
    %%%%  2=Label - 'Rhodamine'
    All_IntensityCorrSteps(Capture_folder,ImageName,ActinNoLabelBack,2)
 
end

%%%% PART 4 - If there are montage movies, run over all montage movies to build the monage
%%%% MontageMovie is a matrix includes all the places in capture containing
%%%% Montages
if (exist('MontageMovie','var'))

for i=1:length(MontageMovie)
    
    info=imfinfo([Capture(MontageMovie(i)).name,'LA.tiff']);
    Size_info=size(info);
    NumberOfFrames=Size_info(1,1);
    
    for k=1:NumberOfFrames
        imagesLA{k}=imread([Capture(MontageMovie(i)).name,'LA',' after non Homo Illumination Corr.tiff'],k);
        imagesRh{k}=imread([Capture(MontageMovie(i)).name,'Rhodamine',' after non Homo Illumination Corr.tiff'],k);
    end
    %     [ montage ] = generate_montage( images ,N, M, lineOverlap, colOverlap, lineOffX, colOffY)
    if (NumberOfFrames==4)
        N=2;
        M=2;
    end
    
    if (NumberOfFrames==6)
        N=3;
        M=2;
    end
    
    if (NumberOfFrames==9)
        N=3;
        M=3;
    end
    
    if (NumberOfFrames==12)
        N=4;
        M=3;
    end
    
    if (NumberOfFrames==16)
        N=4;
        M=4;
    end
    
    
    %       N=3;
    %       M=NumberOfFrames/N;
    %
    %       if (M==4);
    %           N=4;
    %           M=3;
    %       end
    
    [ montageLA ] = generate_montage( imagesLA ,N, M, 30, 30, -5, 10);
    montageLA=uint16(montageLA);
    imshow(montageLA,[])
    imwrite(montageLA,[Capture(MontageMovie(i)).name,'LA',' after non Homo Illumination Corr.tiff']);
    
    [ montageRh ] = generate_montage( imagesRh ,N, M, 30, 30, -5, 10);
    montageRh=uint16(montageRh);
    imshow(montageRh,[])
    imwrite(montageRh,[Capture(MontageMovie(i)).name,'Rhodamine',' after non Homo Illumination Corr.tiff']);
end
end
close all

%%%% PART 4 - Run over all the moveis and calculate Rho(R)

for i=1:length(Capture)
    Capture_folder=Capture(i).name;
    MeasureDropSizeLAandActinV(Capture_folder,calibration);
    
    NumberOfSectors=9;
    ImageName='LA';
    pix_LA=double(imread([Capture_folder,ImageName,'.tiff']));
    %%%%  1=Label - 'LA'
%     All_IntensityCorrSteps(Capture_folder,ImageName,LANoLabelBack,1)
    pix_LA_AfterCorr=double(imread([Capture_folder,ImageName,' after non Homo Illumination Corr.tiff']));
    CalculateAverageRhoBySectorsLAandActinV(Capture_folder,pix_LA_AfterCorr,'LA\',NumberOfSectors)
    
    ImageName='Rhodamine';
    pix_LA=double(imread([Capture_folder,ImageName,'.tiff']));
    %%%%  2=Label - 'Rhodamine'
%     All_IntensityCorrSteps(Capture_folder,ImageName,ActinNoLabelBack,2)
    pix_LA_AfterCorr=double(imread([Capture_folder,ImageName,' after non Homo Illumination Corr.tiff']));
    CalculateAverageRhoBySectorsLAandActinV(Capture_folder,pix_LA_AfterCorr,'Rh\',NumberOfSectors)
    
end

%%%% PART 5 - Run over all movies and correct the edge effect

for i=1:length(Capture)
    i
    close all
    Capture_folder=Capture(i).name;
    
    %%%%% Actin movie Correction
    AverageProfileX=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\Rh\AverageProfileX.mat');
    AverageProfileY=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\Rh\AverageProfileY.mat');
    IntensityCorrectionNearDropEdgeBySectorsActinV_7_9(Capture_folder,AverageProfileX,AverageProfileY,'Rh',NumberOfSectors)
    close all
    %%%%% Life Act movie Correction
    AverageProfileX=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA\AverageProfileX.mat');
    AverageProfileY=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\LA\AverageProfileY.mat');
    IntensityCorrectionNearDropEdgeBySectorsActinV_7_9(Capture_folder,AverageProfileX,AverageProfileY,'LA',NumberOfSectors)
    close all
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
