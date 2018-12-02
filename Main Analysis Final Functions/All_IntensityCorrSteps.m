%%%% This function implament all 
% % ImageName='16bitC0.tiff';

function All_IntensityCorrSteps(Capture_folder,ImageName,BackNoFlu,Label)

info=imfinfo([Capture_folder,ImageName,'.tiff']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);
 
%%%% Label=2(Actin) =1(LA)
CorrectNonHomoIntensity(Capture_folder,ImageName,BackNoFlu,Label) %%%% BackNoFlu Different to each experiment

% if (exist('Movie','var'))
    if (Number_of_frames>1)
        BleachCorrection(Capture_folder,ImageName)
    end
% end

end



