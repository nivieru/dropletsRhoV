MainFolder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Intensity Correction near drop edge\2017_06_21\80% extract CP actin and LA\Mix 2 15_20\';
% Capture=importdata([MainFolder,'Capture.mat']);
Dir=dir(MainFolder);

n=1;
for i=3:length(Dir)-1
    %%% Need tp fix the names here
   Capture_folder=[MainFolder,Dir(i).name,'\'];
   Rho=importdata([Capture_folder,'Rh\Rho\Rho.mat']);
   Rrho=importdata([Capture_folder,'Rh\Rho\Rrho.mat']);
   PlaceToAverage=find(Rrho<20);
   ActinIntensity(n)=mean(Rho(PlaceToAverage));
   n=n+1;
end

I=mean(ActinIntensity)
STD=std(ActinIntensity)