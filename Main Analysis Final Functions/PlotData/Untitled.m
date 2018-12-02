for i=1:length(Capture)
i
Capture_folder=[Capture(i).name];


rmdir ([Capture_folder,'Rho\'],'s')
%rmdir ([Capture_folder,'RhoFromFirstFrame\'],'s')
delete ([Capture_folder,'16bitC0 after bleach correction.tiff'])
delete ([Capture_folder,'16bitC0 after non Homo Illumination Corr.tiff'])

CalculateRho(Capture_folder)
close all;

end


