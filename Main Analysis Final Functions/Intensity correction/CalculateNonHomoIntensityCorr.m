function TypeOfLabel=CalculateNonHomoIntensityCorr(Capture,TypeOfLabel,slide_folder)

for t=1:length(TypeOfLabel)
    
    label=TypeOfLabel(t).name;
    IntensityMatrix=zeros(512,512);

for i=1:length(Capture)
    
    temp=zeros(512,512);
    
    for j=1:length(Capture(i).RelventFrames)
          temp=temp+double(imread([Capture(i).name,label,'.tiff'],Capture(i).RelventFrames(j))-TypeOfLabel(t).NoLabelBack);
    end
    
    Capture(i).Intensity=temp./length(Capture(i).RelventFrames);
    IntensityMatrix=IntensityMatrix+Capture(i).Intensity;
end

IntensityMatrix=IntensityMatrix/length(Capture);

TypeOfLabel(t).IntensityMatrix=IntensityMatrix;
mkdir([slide_folder,label])
save([slide_folder,label,'\Capture.mat'],'Capture');
save([slide_folder,label,'\IntensityMatrix.mat'],'IntensityMatrix');
figure (1)
imshow(TypeOfLabel(t).IntensityMatrix,[])
saveas(figure (1),[slide_folder,label,'rho vs R.tif']);

end

save([slide_folder,'\TypeOfLabel.mat'],'TypeOfLabel');


%%%% try to do the filering 

t=1;
IntensityMatrix=TypeOfLabel(t).IntensityMatrix;
figure
imshow(IntensityMatrix,[])
IntensityMatrixAfterGaussFilter = imgaussfilt(IntensityMatrix,3);  %%%% defult STD(sigma)=0.5, if want to change imgaussfilt(A,sigma)
figure
imshow(IntensityMatrixAfterGaussFilter,[])
temp=-(IntensityMatrix-IntensityMatrixAfterGaussFilter);

figure
imshow(temp,[])

temp2=temp;
TypeOfLabel(t).threshold=300;

PlaceNinus=find(temp2<-TypeOfLabel(t).threshold);
PlacePlos=find(temp2>-TypeOfLabel(t).threshold);
temp2(PlaceNinus)=1;
temp2(PlacePlos)=0;
binary2=bwareaopen(temp2,10);

figure
imshow(binary2,[])

SEdilate = strel('disk',7,4);
SEerode=strel('disk',4,4);
IM2 = imdilate(binary2,SEdilate);
IM3 = imerode(IM2,SEerode);


IM4 = imfill(IM3,'holes') ;

figure
imshow(IM4,[])


B = bwboundaries(IM4);

stats = regionprops(IM4,'BoundingBox')
% hold on
% rectangle('Position',stats(6).BoundingBox,...
% 	'EdgeColor', 'r',...
% 	'LineWidth', 1,...
% 	'LineStyle','-')

% NoOfPixelToExtend=5;
NoOfPixelToEx=5;

figure
imshow(IM4,[])

IndexMatrix=zeros(512,512);
CorrIntensityMatrix=IntensityMatrix;

% for i=[2:49,51:length(stats)] %%% only for data from 23.3.17
for i=[2:length(stats)]
i

X=ceil(stats(i).BoundingBox(1)-NoOfPixelToEx); %%%% In order to have pixel place I will take int
if (X<1) 
    X=1;
end

Y=ceil(stats(i).BoundingBox(2)-NoOfPixelToEx);
if (Y<1) 
    Y=1;
end

W=ceil(stats(i).BoundingBox(3)+NoOfPixelToEx*2);
L=ceil(stats(i).BoundingBox(4)+NoOfPixelToEx*2);

if (X+W>512)
    W=511-X;
end

if (Y+L>512)
    L=511-Y;
end

RectangleAroundObject=[X,Y,W,L];
hold on
rectangle('Position',stats(i).BoundingBox,...
	'EdgeColor', 'r',...
	'LineWidth', 1,...
	'LineStyle','-')

hold on
rectangle('Position',RectangleAroundObject,...
	'EdgeColor', 'b',...
	'LineWidth', 1,...
	'LineStyle','-')

%%%% Take the relvant pixels places from IM4 and calculate the average
%%%% intenity in the balck regoin

Ystart=RectangleAroundObject(2);
Yend=RectangleAroundObject(2)+RectangleAroundObject(4);
Xstart=RectangleAroundObject(1);
Xend=RectangleAroundObject(1)+RectangleAroundObject(3);

rec=IM4(Ystart:Yend,Xstart:Xend);

% figure
% imshow(rec)

originalImRec=IntensityMatrix(Ystart:Yend,Xstart:Xend);
% figure
% imshow(originalImRec,[])

[PlacesToAvgY,PlacesToAvgX]=find(rec==0);

Y_PlacesToAvgInOriginalIm=PlacesToAvgY+Ystart;
X_PlacesToAvgInOriginalIm=PlacesToAvgX+Xstart;
PlacesToAvg=Y_PlacesToAvgInOriginalIm+((X_PlacesToAvgInOriginalIm-1)*512);
MeanInThisArea=mean(CorrIntensityMatrix(PlacesToAvg));

%%%%% IndexMatrix is for marking the different section for manully
%%%%% correction
IndexMatrix(PlacesToAvg)=i;

%%%Replace the bright spots with the average in this area 

[PlacesBrightSpotsY,PlacesBrightSpotsX]=find(rec==1);
Y_PlacesBrightSpotsInOriginalIm=PlacesBrightSpotsY+Ystart;
X_PlacesBrightSpotsInOriginalIm=PlacesBrightSpotsX+Xstart;
PlacesBrightSpots=Y_PlacesBrightSpotsInOriginalIm+((X_PlacesBrightSpotsInOriginalIm-1)*512);
CorrIntensityMatrix(PlacesBrightSpots)=MeanInThisArea;


end


figure
imshow(CorrIntensityMatrix,[])

figure
imshow(IntensityMatrix,[])

TypeOfLabel(t).CorrIntensityMatrix=CorrIntensityMatrix;

TypeOfLabel(t).CorrIntensityMatrixNorm=TypeOfLabel(t).CorrIntensityMatrix/(mean(mean(TypeOfLabel(t).CorrIntensityMatrix)));
figure
imshow(TypeOfLabel(t).CorrIntensityMatrixNorm,[]);


figure
imshow(temp,[])

figure
imshow(temp2,[])
figure
imshow(binary2,[]);

figure
imshow(IM2,[])

figure
imshow(IM4,[])

end
