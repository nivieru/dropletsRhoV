%%%%%% This function takes image or movie and implement non homogeneous
%%%%%% illumination correction 
%%%%%% Last modified 11.11.18

function CorrectNonHomoIntensityforGUI(Capture_folder,ImageName,BackNoFlu,Label,CorrectionFiles_folder)

%%%% Import the structure containing the correction matricies
% For experioments before 1.1.18:
%TypeOfLabel=importdata('C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction\2017_03_23\80% extract CP actin and LA\Mix1 12_50\Montage images only frames far from the egde\TypeOfLabel.mat');
% For experiments after 1.1.18:
TypeOfLabel=importdata([CorrectionFiles_folder,'\Non Homo Correction\TypeOfLabel.mat']);

%%%% Label=1 LA 
%%%% Label=2 Rhodamine Actin
%%%% TypeOfLabel(i).CorrIntensityMatrixNormin is, 
%%%% (Intensity-Background No flu)/mean(Intensity-Background No flu))

%%%% Import the image/ movie inside Capture_folder
info=imfinfo([Capture_folder,ImageName,'.tiff']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

for k=1:Number_of_frames
Movie16{k}=double(imread([Capture_folder ,ImageName,' after background subtraction.tiff'],k)-BackNoFlu);
% Movie16{k}=double(imread([Capture_folder ,ImageName,'.tiff'],k)-BackNoFlu);
NonHomoIlluminationCorrMovie16{k}=Movie16{k}./TypeOfLabel(Label).CorrIntensityMatrixNorm;
imwrite(uint16(NonHomoIlluminationCorrMovie16{k}),[Capture_folder,ImageName,' after non Homo Illumination Corr.tiff'],'WriteMode','append');
end

end
        

      