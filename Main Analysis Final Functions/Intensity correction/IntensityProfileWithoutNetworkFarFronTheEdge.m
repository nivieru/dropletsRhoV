%%% Maya Malik Garbi - last modified 13/9/2017

%%% The goal of this function in to correct the non homogemuse illumination of
%%% the microscope. I will average the intensities from images tooken at
%%% the middle of large drops (far from the center where I have decrease in
%%% the intensity caused by the geometry of the drop)
%%% In order to have no network I added large amount of Capping protein

%%% This function gets ‘slide_folder’ containing the experimental data and the microscope calibration.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% main_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction\2017_03_23\';
% slide_folder=[main_folder,'80% extract CP actin and LA\Mix1 12_50\Montage images only frames far from the egde\'];

main_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction\2018_01_01\';
slide_folder=[main_folder,'Intensity near drop edge\Slide 16_25 montage\'];
calibration=0.2054; %%% [um/pixel] Microscope calibration

%%%% PART 1 - find the locations of Life act(C1), Rhodamine(C2) and Bright Field (BF
%%%% C0) movies in slide_folder

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

%%%% PART 2 - This loop generates directory to each drop and put inside life act (LA),
%%%% Rhodamine actin (Rh) and Bright field (BF) movies. It generates structure named, Capture,
%%%% which contain the folder name of each drop.

k=1;
% for i=1:Number_of_RhActin_movies(1,2)
    for i=1:Number_of_LA_movies(1,2)
    
    CurrentMovie=locations_of_LA_movies(i);
    
    if (length(Dir(CurrentMovie).name)==17)
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9),'\'];
        %     else Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    if (length(Dir(CurrentMovie).name)==18)
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    %%%% Long movie names are monatge movies
    
    if (length(Dir(CurrentMovie).name)==30)
        MontageMovie(k)=i;
        k=k+1;
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9),'\'];
    end
    
    if (length(Dir(CurrentMovie).name)==31)
        MontageMovie(k)=i;
        k=k+1;
        Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    mkdir(Capture(i).name)
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'LA.tiff']);
%     CurrentMovie=locations_of_RhActin_movies(i);
%     copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'Rhodamine.tiff']);
    
    CurrentMovie=locations_of_BF_movies(i);
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'BF.tiff']);
    
    end

%%%% This loop build montage image using the function (generate_montage)

for i=1:length(MontageMovie)

    info=imfinfo([Capture(MontageMovie(i)).name,'LA.tiff']);
    Size_info=size(info);
    NumberOfFrames=Size_info(1,1);

    for k=1:NumberOfFrames
        imagesLA{k}=imread([Capture(MontageMovie(i)).name,'LA.tiff'],k);
%         imagesRh{k}=imread([Capture(MontageMovie(i)).name,'Rhodamine.tiff'],k);
        imagesBF{k}=imread([Capture(MontageMovie(i)).name,'BF.tiff'],k);
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

     if (NumberOfFrames==20)
         N=5;
         M=4;
     end
     
     if (NumberOfFrames==25)
         N=5;
         M=5;
     end
     
     if (NumberOfFrames==30)
         N=5;
         M=6;
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
      imwrite(montageLA,[Capture(MontageMovie(i)).name,'LAmontage.tiff']);

%       [ montageRh ] = generate_montage( imagesRh ,N, M, 30, 30, -5, 10);
%       montageRh=uint16(montageRh);
%       imshow(montageRh,[])
%       imwrite(montageRh,[Capture(MontageMovie(i)).name,'Rhodamine.tiff']);

      [ montageBF ] = generate_montage( imagesBF ,N, M, 30, 30, -5, 10);
      montageBF=uint16(montageBF);
      imshow(montageBF,[])
      imwrite(montageBF,[Capture(MontageMovie(i)).name,'BFmontage.tiff']);
end

    
    
%%%% I checked it manually

% Capture(1).RelventFrames=[7,10,11]; %%%% capture 10
% Capture(2).RelventFrames=[7]; %%%% capture 2
% Capture(3).RelventFrames=[6,7,10,11,14,15]; %%%% capture 4
% Capture(4).RelventFrames=[7,10]; %%%% capture 7

%%% Those numbers are for new set of experiments
Capture(1).name=[main_folder,'Intensity near drop edge\Slide 1 15_45 montage\Capture 2\'];
Capture(1).RelventFrames=[8,9,12,13]; %%%% 15_45 capture 2
Capture(2).name=[main_folder,'Intensity near drop edge\Slide 1 15_45 montage\Capture 3\'];
Capture(2).RelventFrames=[7,10]; %%%% 15_45 capture 3
Capture(3).name=[main_folder,'Intensity near drop edge\Slide 1 15_45 montage\Capture 9\'];
Capture(3).RelventFrames=[6,7,11,12]; %%%% 15_45 capture 9
Capture(4).name=[main_folder,'Intensity near drop edge\Slide 1 15_45 montage\Capture 10\'];
Capture(4).RelventFrames=[7]; %%%% 15_45 capture 10

Capture(5).name=[main_folder,'Intensity near drop edge\Slide 16_25 montage\Capture 4\'];
Capture(5).RelventFrames=[6,7,10,11]; %%%% 16_25 capture 4
Capture(6).name=[main_folder,'Intensity near drop edge\Slide 16_25 montage\Capture 5\'];
Capture(6).RelventFrames=[6,7,10,11]; %%%% 16_25 capture 5
Capture(7).name=[main_folder,'Intensity near drop edge\Slide 16_25 montage\Capture 8\'];
Capture(7).RelventFrames=[9,10,14,15,16,21,22]; %%%% 16_25 capture 8
Capture(8).name=[main_folder,'Intensity near drop edge\Slide 16_25 montage\Capture 10\'];
Capture(8).RelventFrames=[7]; %%%% 16_25 capture 10
Capture(9).name=[main_folder,'Intensity near drop edge\Slide 16_25 montage\Capture 12\'];
Capture(9).RelventFrames=[7]; %%%% 16_25 capture 12

slide_folder=[main_folder,'Intensity near drop edge\'];
save([slide_folder,'\Capture.mat'],'Capture');

%%%% PART 3 - This loop gets the intensity matrix only for the relevent frams  
%%%% in each montage. Relvent frames are frames far from the drop edge where I have
%%%% intensity decrease caused by the drop geomentry. 

TypeOfLabel=struct;
TypeOfLabel(1).name='LA';
% TypeOfLabel(1).NoLabelBack=1144; %%% calibration fits to 23.3.17
TypeOfLabel(1).NoLabelBack=1182; %%% calibration fits to 1.1.18
% TypeOfLabel(2).name='Rhodamine';
% TypeOfLabel(2).NoLabelBack=1605;


TypeOfLabel=CalculateNonHomoIntensityCorr(Capture,TypeOfLabel,slide_folder);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% %%%%% Try to implament of montage movie
% 
% for y=1:12
% TryLAMovie16{y}=double(imread('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Actin & LA labeling\2017_02_13\80% extract Rhodamine actin & LA GFP\Mix1 13_40\Capture 16 - Position 1_C2.tiff',y))-TypeOfLabel(t).NoLabelBack;
% NewTryLAMovie16{y}=TryLAMovie16{y}./TypeOfLabel(2).CorrIntensityMatrixNorm;
% end
%         N=4;
%           M=3;
%  [ montageLA ] = generate_montage( NewTryLAMovie16 ,N, M, 30, 30, -5, 10);
%       montageLA=uint16(montageLA);
%       figure 
%       imshow(montageLA,[])
%       imwrite(montageLA,['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction\Actin new montage.tiff']);       
% 
%       
%       
%       
%       
% for y=1:12
% TryLAMovie16{y}=double(imread('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Actin & LA labeling\2017_02_13\80% extract Rhodamine actin & LA GFP\Mix1 13_40\Capture 16 - Position 1_C2.tiff',y))-TypeOfLabel(t).NoLabelBack;
% NewTryLAMovie16{y}=TryLAMovie16{y};
% end
%         N=4;
%           M=3;
%  [ montageLA ] = generate_montage( NewTryLAMovie16 ,N, M, 30, 30, -5, 10);
%       montageLA=uint16(montageLA);
%       figure 
%       imshow(montageLA,[])
%       imwrite(montageLA,['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction\Actin.tiff']);       


for y=1:25
TryLAMovie16{y}=double(imread('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction\2018_01_01\Intensity near drop edge\Slide 1 15_45 montage\Capture 2\LA.tiff',y))-TypeOfLabel(1).NoLabelBack;
NewTryLAMovie16{y}=TryLAMovie16{y}./TypeOfLabel(1).CorrIntensityMatrixNorm;
end
        N=5;
          M=5;
 [ montageLA ] = generate_montage( NewTryLAMovie16 ,N, M, 30, 30, -5, 10);
      montageLA=uint16(montageLA);
      figure 
      imshow(montageLA,[])
      imwrite(montageLA,['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction\2018_01_01\Intensity near drop edge\Slide 1 15_45 montage\Capture 2\LA new montage.tiff']);       
      
      

TryLAMovie16=double(imread('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\2017_12_20\80% extract XB\Mix 1 11_15\Capture 10_C1.tiff',y))-TypeOfLabel(1).NoLabelBack;
NewTryLAMovie16=TryLAMovie16./TypeOfLabel(1).CorrIntensityMatrixNorm;
      

      figure 
      imshow(TryLAMovie16,[])
      saveas(figure (1),['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\2017_12_20\80% extract XB\Mix 1 11_15\after correction.tif']);
      imwrite(NewTryLAMovie16,['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\2017_12_20\80% extract XB\Mix 1 11_15\after correction.tif']);       

