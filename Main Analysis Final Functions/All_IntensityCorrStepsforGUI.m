%%%% This function implament all 
% % ImageName='16bitC0.tiff';

function All_IntensityCorrStepsforGUI(Capture_folder,ImageName,BackNoFlu,Label,CorrectionFiles_folder,HomoCorrectionFlag,BleachCorrectionFlag)

info=imfinfo([Capture_folder,ImageName,'.tiff']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);
 
BackgroundWithoutFluSubtraction(Capture_folder,ImageName,BackNoFlu)
%%%% Label=2(Actin) =1(LA)

if (HomoCorrectionFlag==1)
CorrectNonHomoIntensityforGUI(Capture_folder,ImageName,BackNoFlu,Label,CorrectionFiles_folder) %%%% BackNoFlu Different to each experiment
ImageNameForBleachCorr=[Capture_folder,ImageName,' after non Homo Illumination Corr.tiff'];
else
    ImageNameForBleachCorr=[Capture_folder,ImageName,' after background subtraction.tiff'];
end

% if (exist('Movie','var'))
    if (Number_of_frames>1 && BleachCorrectionFlag==1)
        BleachCorrectionforGUI(Capture_folder,ImageNameForBleachCorr)
    end
% end

end



