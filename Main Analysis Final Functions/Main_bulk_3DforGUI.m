%%% This is the main function to run the analysis.
%%% It Get:
%%% 
%%% (1)Slide_folder: folder that containn movies that were exporte
%%% from SlideBook, C0(fluorecent) and C1 (BF) channels separately.

%%% (2)Analysis paremeters:

%%% (2.1)calibration - microscope length scale [micron/px].
%%% (2.2)Time_intervale - imaging time imtervals [sec]. 
%%% (2.3)step - jump size for the next window  (=> if interrogationarea < step
%%% for each window there is over lap in the correlation [px].
%%% (2.4)subpixfinder - this paremeter define the method for finding the
%%% correlation peek.
%%% 1 - SUBPIXGAUSS - finding the peek from 3 points.
%%% 2 - SUBPIX2DGAUSS - finding the peek by fitting it to 2D gaussian.
%%% (2.5)pix_size_for_CLAHEprefilter - size of window for CLAHE prefilter
%%% calculation [px].
%%% (2.6)pix_size_for_HPprefilter - size of window for High Pass prefilter
%%% calculation [px].

%%% This function has several steps:
 
%%% Step 1 - (performed in OperateOneSlide) SetFolderToEachCapture -
%%%          (1) copy the 8bit and 16bit movies to the relevent capture
%%%          folder, create STRUCTER, Capture, that contain the name of the folder for each movie. 
%%%          Than manually make 8bit movie and save as 8bitC0.tif
%%% Step 2 - Run for each movie the function AnalysisOneMovie       
%%%          (1) SpreadsTiffs - sperad the 8bit movie to tiffs (for the velocity calculation) and save
%%%          it in 'spread 8bit tiffs folder.
%%%          (2) ChooseROI - open the first tiff in each movie to define the ROI - the reader need to define
%%%          the left up correner and the right down correner of the ROI.
%%%          (3) FindTheRadiusOfTheDrop -
%%%          (4) InitializeAnalysisParamters - save them to the capture file.
%%%          (5) AnalysisOneMovie


function Main_bulk_3DforGUI(Capture,AnalysisParemeters,index,CorrectionFiles_folder,NumberOfFramedToAverage,HomoCorrectionFlag,BleachCorrectionFlag,EdgeCorrectionFlag,DropletParameters,SpetialAveraging,NumberOfSectors,NotSymmetricNetworkFlag,calibrationFile)
disp('Main_bulk_3DforGUI');


%%% pre running to set the parameters from image before running all the
%%%analysis for several movies

 for i=1:length(Capture)
    
    Capture_folder=Capture(i).name;
    if (DropletParameters==1)
    %%%SpreadsTiffs
    Spreads8bitTiffs(Capture_folder);
    
    mkdir([Capture_folder,'Analysis parameters'])
    %%%ChooseROI - choose almost entire droplet
    %[roi]=ChooseROI(Capture_folder);
   % Capture(i).roi=roi;
    
    InitializeAnalysisParamters(Capture_folder,AnalysisParemeters,calibrationFile)
    
    %%%Measure drop size
    %%% if DropletParameters==1 run the function to determine drop
    %%% parameters
    %%% if DropletParameters==2 use the saved droplet parameters from
    %%% previous run 
    
    MeasureDropSize(Capture_folder);
    end
    
 end
   

%  for i=1:length(Capture)  
   for i=1:length(Capture)  
    AnalysisOneMovieforGUI(Capture(i).name,AnalysisParemeters,index,CorrectionFiles_folder,NumberOfFramedToAverage,HomoCorrectionFlag,BleachCorrectionFlag,EdgeCorrectionFlag,DropletParameters,SpetialAveraging,NumberOfSectors,NotSymmetricNetworkFlag);
    close all
end


end

