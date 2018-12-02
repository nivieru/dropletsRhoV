%%%% Maya Malik Garbi - Modified 18/9/17 
%%%% I removed the background subtraction from this function.
%%%% now the bleach correction is in CorrectNonHomoIntensity

function BleachCorrectionforGUI(Capture_folder,ImageNameForBleachCorr)

info=imfinfo(ImageNameForBleachCorr);
%info=imfinfo([Capture_folder,ImageName,'.tiff']);
Size_info=size(info);
number_of_frames=Size_info(1,1);
DROP_maskForBleachCorr=importdata([Capture_folder,'Analysis parameters\DROP_maskForBleachCorr.m']);

for i=1:number_of_frames
     RhoRGB=imread(ImageNameForBleachCorr,i);
   %  RhoRGB=imread([Capture_folder,ImageName,'.tiff'],i);
    Rho(:,:,i)=double(RhoRGB);                %% data from spinning disk unit16  
%   Rho(:,:,i)=double(RhoRGB(:,:,1));         %% data from Germany
end

DROP_mask=DROP_maskForBleachCorr;

Outside=find(DROP_mask==0);
Inside=find(DROP_mask==1);

for i=1:number_of_frames
    %%%total signal for each frame
    im=Rho(:,:,i);
    im(Outside)=0;
    TotalSignal(i)=sum(im(:));
    Time(i)=i;
%     RhoMinusBeck(:,:,i)=im;
end
 
h=figure
p=polyfit(Time,TotalSignal,1);
LinearFit=p(1)*Time+p(2);
plot(Time,TotalSignal/TotalSignal(1),'b','LineWidth',2)
hold on
plot(Time,LinearFit/TotalSignal(1),'b','LineStyle','--')
    
for i=1:number_of_frames
    RhoBleachC(:,:,i)= Rho(:,:,i)/(1+i*p(1)/p(2)); 
    imwrite(uint16(RhoBleachC(:,:,i)),[Capture_folder,'16bitC0',' after bleach correction.tiff'],'WriteMode','append');
    temp2=RhoBleachC(:,:,i);
    temp2(Outside)=0;
    TotalSignalAfterBleachC(i)=sum(temp2(:));
end

   hold on
   plot(Time,TotalSignalAfterBleachC/TotalSignalAfterBleachC(1),'k','LineWidth',2)
   p2=polyfit(Time,TotalSignalAfterBleachC,1);
   LinearFit2=p2(1)*Time+p2(2);
   hold on
   plot(Time,LinearFit2/TotalSignalAfterBleachC(1),'k','LineStyle','--')
   
   savefig([Capture_folder,'bleach correction fit.fig']);
   saveas(h,[Capture_folder,'bleach correction fit.tiff']);

end  
    

