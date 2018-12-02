%%%%%% Maya Malik Garbi 7.9.2017

%%%%%% General description: this function take original intensity profile
%%%%%% (Rho) and divide it by average intensity profile(AverageProfileX,AverageProfileY) to corrected
%%%%%% optical decrese in the intensity near the drop adge.
%%%%%% The average intensity profile was computed in function 'NoNetworkIntensityCheck.m' 
%%%%%% based on experiments were done on 21/22.2017. In the experiments I imaged the
%%%%%% intensity of approx. 50 droplets. The energy mix was done with Life act and Rhodamine actin without 
%%%%%% energy mix and Capping Protein for preventing the network formation. 

function IntensityCorrectionNearDropEdgeBySectorsActinV_7_9(Capture_folder,AverageProfileX,AverageProfileY,label,NumberOfSectors)

calibration=importdata([Capture_folder,'Analysis parameters\calibration.mat']);
DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.mat']);
NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.mat']);
X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);
DROP_mask=importdata([Capture_folder,'Analysis parameters\DROP_mask.mat']);
AverageRhoVsRbySectors=importdata([Capture_folder,label,'\Rho\AverageRhoVsRbySectors.mat']);


xvalAftherCorr=AverageProfileX;
meanyAftherCorr=AverageProfileY;

%%%% PART 1 - find R(I=0.2), R(I=0.6), R(I=0.25)  

placeMIN=min(find(meanyAftherCorr<0.2));
placeMAX=min(find(meanyAftherCorr<0.6));
placeMEAN=min(find(meanyAftherCorr<0.25));   %%%%% I=0.25 is the mean intensity value at Rdrop averged over 50 drops.
placeMINx=xvalAftherCorr(placeMIN);
placeMAXx=xvalAftherCorr(placeMAX);
pleaceMEANx=xvalAftherCorr(placeMEAN);

%%%% PART 2 - find R effective in each sector. Find the drop boundries and
%%%% find the distance of the center from each point in the boundry

DropBoundaries=bwboundaries(DROP_mask);
DropBoundaries=DropBoundaries{1,1};
X_bound=DropBoundaries(:,2);
Y_bound=DropBoundaries(:,1);

DistanceFromEdge=sqrt( (X_bound-X0).^2 + (Y_bound-Y0).^2 );
theta=atan2((-Y_bound+Y0),(X_bound-X0));
for i=1:length(theta)
if (theta(i)<0)
    theta(i)=theta(i)+2*pi;
end
end

PlaceThirdQuarter=find(theta>pi & theta<(1.5*pi));
ThirdQuarterTheta=theta(PlaceThirdQuarter);
ThirdQuarterDistanceFromEdge=DistanceFromEdge(PlaceThirdQuarter);
ThirdQuarterX_bound=X_bound(PlaceThirdQuarter);
ThirdQuarterY_bound=Y_bound(PlaceThirdQuarter);

%%%% Plot image with blob center and drop boundries  

if (label=='Rh')
    image=[Capture_folder,'Rhodamine.tiff'];
else 
    image=[Capture_folder,'LA.tiff'];
end

figure
imshow(image)
hold on
plot(X_bound(PlaceThirdQuarter),Y_bound(PlaceThirdQuarter),'*')
hold on
plot(X0,Y0,'+')
close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PART 2

%% Main loop
%%%% PART 3 - run over all sectors 

  for index=1:length(AverageRhoVsRbySectors)

    Rho=AverageRhoVsRbySectors(index).AvgRho;
    Rrho=AverageRhoVsRbySectors(index).AvgRrho;
    
    RhoDilute=Rho;
    RrhoDilute=Rrho;
    
    %%%% find R effective by distance calculating the distance from the drop
    %%%% boundries at the right angle. The drop boundies determined by the
    %%%% drop edge. 

   thetaSectors(index) = 1.5*pi - ( (pi/(2*NumberOfSectors))*(index-0.5) );
   %%%find the place of the closest angle thetaSectors(index) in ThirdQuarterTheta
   d_theta=(abs(ThirdQuarterTheta-thetaSectors(index)));
   place=find(d_theta==min(d_theta));
   Rpixel=ThirdQuarterDistanceFromEdge(place(1));
   Reff(index)=Rpixel*calibration;
   
   AverageRhoVsRbySectors(index).DistanceFromEdge=Reff(index);
   
%    effectiveRplace=min(find(RrhoDilute>Reff(index)));
   
   %%%% If the edge of the drop is not inside the image don't consider this
   %%%% sector
     
   if (ThirdQuarterY_bound(place)==512) | (ThirdQuarterX_bound(place)==512)| (ThirdQuarterY_bound(place)==1) | (ThirdQuarterX_bound(place)==1) 
       AverageRhoVsRbySectors(index).considerThisSector=0;
   else
       AverageRhoVsRbySectors(index).considerThisSector=1;
   end

%%%%% PART 4 - Optimize the best starting point for averaging between placeMIN to placeMAX   
   
h=figure
    
k=placeMAX;

for i=1:(placeMIN-placeMAX)

RhoDilute=Rho;
RrhoDilute=Rrho;

placeEnd=k;

ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-Reff(index));
FindIndexRange40=find(ProfileX<(Reff(index)-40));
ProfileY=meanyAftherCorr(1:placeEnd);

if length(FindIndexRange40>0)
   ProfileY(1:max(FindIndexRange40))=1;
end

removeRbiggerThanRdrop=find(Rrho>Reff(index));
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
newProfileY(isnan(newProfileY))=1;
newRho=RhoDilute./newProfileY;

%%%% check if the intensity between R network to R effective is monotomice
%%%% decrese

RnetworkPlace=max(find(RrhoDilute<(NetworkRadius)));
% RnetworkPlace=max(find(RrhoDilute<(NetworkRadius-10)));   %%%%% -10 only for ActA data
FindMonotonicDecreasingFunction=diff(newRho(RnetworkPlace:end));

if (length(find(FindMonotonicDecreasingFunction<0))==length(newRho(RnetworkPlace:end))-1)
BoolDecrease(i)=1; %%% monotonic decrease function
else BoolDecrease(i)=0;
end

%%%% do linear fit to I(R network):I(end) 

p=polyfit(RrhoDilute(RnetworkPlace:end)',newRho(RnetworkPlace:end)',1);
SlopeVrVSr=p(1);
% d(i)=abs(SlopeVrVSr);
LinearFit=p(1)*RrhoDilute(RnetworkPlace:end)'+p(2);
% d2(i)=abs(LinearFit(end)-newRho(end));
% % d(i)=abs(newRho(end)-newRho(RnetworkPlace));

%%%% calculating the total different between the linear fit to the original profile 
d3(i)=sum(abs(LinearFit'-newRho(RnetworkPlace:end)));

plot(RrhoDilute,newRho,'g')
hold on
plot(RrhoDilute,RhoDilute,'r')
hold on
plot(RrhoDilute(RnetworkPlace:end)',p(1)*RrhoDilute(RnetworkPlace:end)'+p(2),'k')
k=k+1;
% 
end


BestPlace=placeMAX+max(find(BoolDecrease==1))-1;

if (length(BestPlace)==0)
BestPlace=placeMAX+find(d3==min(d3))-1;
end

%%% some other options for finding the best place
%BestPlace=placeMAX+find(d3==min(d3))-1;
%BestPlace=placeMAX+find(d==min(d))-1;
%BestPlace=placeMAX+find(d2==min(d2))-1;

%%%% Implay the correction with the best place
placeEnd=BestPlace;
%%%% for each sector save the differnce between the average place of Rdrop(pleaceMEANx)
%%%% and the best starting point I found
AverageRhoVsRbySectors(index).dDropRadius=abs(pleaceMEANx-xvalAftherCorr(BestPlace));

RhoDilute=Rho;
RrhoDilute=Rrho;
    
ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-Reff(index));
ProfileY=meanyAftherCorr(1:placeEnd);

FindIndexRange40=find(ProfileX<(Reff(index)-40));
if length(FindIndexRange40>0)
   ProfileY(1:max(FindIndexRange40))=1;
end

removeRbiggerThanRdrop=find(Rrho>Reff(index));
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
newProfileY(isnan(newProfileY))=1;
CorrectedRho=RhoDilute./newProfileY;

AverageRhoVsRbySectors(index).CorrectedRho=CorrectedRho;
AverageRhoVsRbySectors(index).RrhoDilute=RrhoDilute;

% plot(RrhoDilute,newRhoNetwork,'g')
hold on
plot(RrhoDilute,CorrectedRho,'b')
% hold on
% plot(RrhoDilute,RhoDilute,'r')
xlabel('R [\mum]','FontSize',16)
ylabel('<\rho>','FontSize',16)

% savefig([Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde.fig']);
% saveas(h,[Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde.tif']);
% saveas(h,[Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde..eps']);

  end
% close all  
  
%%
%%%% PART 5 - I will take the average corrected profile only for sectors that the
%%%% drop edge in it. 

IndexForGoodSectors=find([AverageRhoVsRbySectors.considerThisSector]==1);

%%%% Before averaging the profiles cut them at min R effective or at MinCutVal  

MinReff=min([AverageRhoVsRbySectors(IndexForGoodSectors).DistanceFromEdge]);
MinCutVal=MinReff;

% %%%% OPTION: find MinCutVal=the point that the profile start to decrease
% figure
% for i=1:length(AverageRhoVsRbySectors)
%     plot(AverageRhoVsRbySectors(i).RrhoDilute,AverageRhoVsRbySectors(i).CorrectedRho)
%     d_CorrectedRho=diff(AverageRhoVsRbySectors(i).CorrectedRho);
%     place=find(d_CorrectedRho<1*mean(d_CorrectedRho));
%     AverageRhoVsRbySectors(i).CutPlace=place(max(find(diff(place)>1))+1);
%     AverageRhoVsRbySectors(i).CutVal=AverageRhoVsRbySectors(i).RrhoDilute(place(max(find(diff(place)>1))+1));
%     hold on;
%     plot(AverageRhoVsRbySectors(i).RrhoDilute(AverageRhoVsRbySectors(i).CutPlace),AverageRhoVsRbySectors(i).CorrectedRho(AverageRhoVsRbySectors(i).CutPlace),'+')
% end
% MinCutVal=min([AverageRhoVsRbySectors(IndexForGoodSectors).CutVal]);
% %%%%

for i=1:length(AverageRhoVsRbySectors)
    AverageRhoVsRbySectors(i).RrhoByMinReff=AverageRhoVsRbySectors(i).RrhoDilute;
    AverageRhoVsRbySectors(i).CorrectedRhoByMinReff=AverageRhoVsRbySectors(i).CorrectedRho;
    remove=find(AverageRhoVsRbySectors(i).RrhoDilute>MinCutVal);
    AverageRhoVsRbySectors(i).RrhoByMinReff(remove)=[];
    AverageRhoVsRbySectors(i).CorrectedRhoByMinReff(remove)=[];
end
    


[OriginalAvgRho,OriginalAvgRhoUpSTD,OriginalAvgRhoDownSTD,OriginalAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors(IndexForGoodSectors).AvgRrho],[AverageRhoVsRbySectors(IndexForGoodSectors).AvgRho], 1);
h=figure
[CorrectedAvgRho,CorrectedAvgRhoUpSTD,CorrectedAvgRhoDownSTD,CorrectedAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors(IndexForGoodSectors).RrhoByMinReff],[AverageRhoVsRbySectors(IndexForGoodSectors).CorrectedRhoByMinReff], 1);
MinDistanceFromEdge=min([AverageRhoVsRbySectors.DistanceFromEdge]);
MaxDistanceFromEdge=max([AverageRhoVsRbySectors.DistanceFromEdge]);
h=gcf;
mkdir([Capture_folder,label,'\Rho\figures\'])
savefig([Capture_folder,label,'\Rho\figures\All sectors Average Rho after correction.fig']);
saveas(h,[Capture_folder,label,'\Rho\figures\All sectors Average Rho after correction.tif']);
saveas(h,[Capture_folder,label,'\Rho\figures\All sectors Average Rho after correction.eps']);


h=figure
plot(OriginalAvgRrho,OriginalAvgRho,'r','LineWidth',3)
hold on
plot(CorrectedAvgRrho,CorrectedAvgRho,'g','LineWidth',3)

savefig([Capture_folder,label,'\Rho\figures\Average Rho after intensity correction near drop egde.fig']);
saveas(h,[Capture_folder,label,'\Rho\figures\Average Rho after intensity correction near drop egde.tif']);
saveas(h,[Capture_folder,label,'\Rho\figures\Average Rho after intensity correction near drop egde.eps']);


%%%%% mark points on the first frame of the movie
if (label=='Rh')
    image=[Capture_folder,'Rhodamine after non Homo Illumination Corr.tiff'];
else 
    image=[Capture_folder,'LA after non Homo Illumination Corr.tiff'];
end

info=imfinfo(image);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

figure
for k=1:Number_of_frames
im=imread(image,k);
imshow(im,[])
hold on
plot(X0,Y0,'+')
hold on
% plot(X0drop,Y0drop,'+','Color','b')
% hold on 
viscircles([X0,Y0],MinCutVal/calibration,'Color','w','LineWidth',0.5) 
hold on 
viscircles([X0,Y0],NetworkRadius/calibration,'Color','b','LineWidth',0.5)
hold on
text(X0,Y0+NetworkRadius/calibration,['R_n_e_t=',num2str(NetworkRadius)])
frame(k)=getframe(gca);
imwrite(frame(k).cdata(:,:,1),[Capture_folder,label,'\image with marks.tiff']);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure
% [OriginalAvgRho,OriginalAvgRhoUpSTD,OriginalAvgRhoDownSTD,OriginalAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors(IndexForGoodSectors).AvgRrho],[AverageRhoVsRbySectors(IndexForGoodSectors).AvgRho], 1);
% [CorrectedAvgRho,CorrectedAvgRhoUpSTD,CorrectedAvgRhoDownSTD,CorrectedAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors(IndexForGoodSectors).RrhoDilute],[AverageRhoVsRbySectors(IndexForGoodSectors).CorrectedRho], 1);
% MinDistanceFromEdge=min([AverageRhoVsRbySectors.DistanceFromEdge]);
% MaxDistanceFromEdge=max([AverageRhoVsRbySectors.DistanceFromEdge]);
% 
% h=figure
% plot(OriginalAvgRrho,OriginalAvgRho,'r','LineWidth',3)
% hold on
% plot(CorrectedAvgRrho,CorrectedAvgRho,'g','LineWidth',3)


% % %%%%% Those lines are for cutting the vectors at the manualy determined R
% CutR=55;
% removeR=find(CorrectedAvgRrho>CutR);
% CorrectedAvgRho(removeR)=[];
% CorrectedAvgRrho(removeR)=[];
% CorrectedAvgRhoUpSTD(removeR)=[];
% CorrectedAvgRhoDownSTD(removeR)=[];
% 
% hold on
% plot(CorrectedAvgRrho,CorrectedAvgRho,'b')
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


AverageRhoVsRbySectorsAfterCorr=AverageRhoVsRbySectors;

save([Capture_folder,label,'\Rho\AverageRhoVsRbySectorsAfterCorr.mat'],'AverageRhoVsRbySectorsAfterCorr');
save([Capture_folder,label,'\Rho\CorrectedAvgRho.mat'],'CorrectedAvgRho');
save([Capture_folder,label,'\Rho\CorrectedAvgRrho.mat'],'CorrectedAvgRrho');
save([Capture_folder,label,'\Rho\CorrectedAvgRhoUpSTD.mat'],'CorrectedAvgRhoUpSTD');
save([Capture_folder,label,'\Rho\CorrectedAvgRhoDownSTD.mat'],'CorrectedAvgRhoDownSTD');
save([Capture_folder,label,'\Rho\MinDistanceFromEdge.mat'],'MinDistanceFromEdge');
save([Capture_folder,label,'\Rho\MaxDistanceFromEdge.mat'],'MaxDistanceFromEdge');


end






