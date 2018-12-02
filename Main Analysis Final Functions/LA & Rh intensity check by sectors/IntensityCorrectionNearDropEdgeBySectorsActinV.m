%%%%%% Maya Malik Garbi 30.8.2017

%%%%%% General description: this function take original intensity profile
%%%%%% (Rho) and divide it by average intensity profile(AverageProfileX,AverageProfileY) to corrected
%%%%%% optical decrese in the intensity near the drop adge.
%%%%%% The average intensity profile was computed in function 'NoNetworkIntensityCheck.m' 
%%%%%% based on experiments were done on 21/22.2017. In the experiments I imaged the
%%%%%% intensity of approx. 50 droplets. The energy mix was done with Life act and Rhodamine actin without 
%%%%%% energy mix and Capping Protein for preventing the network formation. 


function IntensityCorrectionNearDropEdgeBySectorsActinV(AverageRhoVsRbySectors,Capture_folder,AverageProfileX,AverageProfileY,label,calibration)

DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.mat']);
NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.mat']);
X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);
X0drop=importdata([Capture_folder,'Analysis parameters\X0drop.mat']);
Y0drop=importdata([Capture_folder,'Analysis parameters\Y0drop.mat']);

NumberOfSectors=9;

r0x=(X0-X0drop)*calibration;
r0y=-(Y0-Y0drop)*calibration;
if(Y0drop>Y0)
    r0y=-r0y;
end
    

xvalAftherCorr=AverageProfileX;
meanyAftherCorr=AverageProfileY;

placeMIN=min(find(meanyAftherCorr<0.2));
placeMAX=min(find(meanyAftherCorr<0.6));
placeMEAN=min(find(meanyAftherCorr<0.25));   %%%%% I=0.25 is the mean intensity value at Rdrop averged over 50 drops.
placeMINx=xvalAftherCorr(placeMIN);
placeMAXx=xvalAftherCorr(placeMAX);
pleaceMEANx=xvalAftherCorr(placeMEAN);


  for index=1:length(AverageRhoVsRbySectors)
%     for index=1:5

    Rho=AverageRhoVsRbySectors(index).AvgRho;
    Rrho=AverageRhoVsRbySectors(index).AvgRrho;
    
    RhoDilute=Rho;
    RrhoDilute=Rrho;
    
    
%     %%%% charch the maximum of d_RhoDilute (minimum of negative function) and
%     %%%% define it as the edge of the drop.
%     DropRdiusPlace=max(find(RrhoDilute<DropRadius));
%     d_RhoDilute=diff(RhoDilute);
%     Min_d_RhoDilutePlace=find(d_RhoDilute==min(d_RhoDilute((DropRdiusPlace-40):end)));
%     effectiveRplace=Min_d_RhoDilutePlace;
%     effectiveR=RrhoDilute(effectiveRplace);

   %theta=(pi/2)+(pi/(2*NumberOfSectors))*(index-0.5);
    theta=(pi/(2*NumberOfSectors))*(index-0.5);
   
   a=1;
   b=2*(-r0x*sin(theta)-r0y*cos(theta));
   c=r0x^2+r0y^2-DropRadius^2;
   
   Reffective=roots([ a b c ]);
   effectiveR=Reffective(find(Reffective>0));
   AverageRhoVsRbySectors(index).DistanceFromEdge=effectiveR;
   
   effectiveRplace=min(find(RrhoDilute>effectiveR));

   if (length(effectiveRplace))==0
       AverageRhoVsRbySectors(index).considerThisSector=0;
   else
       AverageRhoVsRbySectors(index).considerThisSector=1;
   end
       
   
   
    k=placeMAX;
    
    h=figure

for i=1:(placeMIN-placeMAX)

RhoDilute=Rho;
RrhoDilute=Rrho;

placeEnd=k;
ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-effectiveR);
ProfileY=meanyAftherCorr(1:placeEnd);
removeRbiggerThanRdrop=find(Rrho>effectiveR);
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
newRho=RhoDilute./newProfileY;

% RnetworkPlace=max(find(RrhoDilute<(NetworkRadius-10)));   %%%%% -10 only for ActA data
RnetworkPlace=max(find(RrhoDilute<(NetworkRadius)));
FindMonotonicDecreasingFunction=diff(newRho(RnetworkPlace:end));

if (length(find(FindMonotonicDecreasingFunction<0))==length(newRho(RnetworkPlace:end))-1)
BoolDecrease(i)=1;
else BoolDecrease(i)=0;
end

p=polyfit(RrhoDilute(RnetworkPlace:end)',newRho(RnetworkPlace:end)',1);
SlopeVrVSr=p(1);
% d(i)=abs(SlopeVrVSr);
LinearFit=p(1)*RrhoDilute(RnetworkPlace:end)'+p(2);
% d2(i)=abs(LinearFit(end)-newRho(end));
% % d(i)=abs(newRho(end)-newRho(RnetworkPlace));
d3(i)=sum(abs(LinearFit'-newRho(RnetworkPlace:end)));

plot(RrhoDilute,(RhoDilute./newProfileY),'g')
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


%  BestPlace=placeMAX+find(d3==min(d3))-1;
% BestPlace=placeMAX+find(d==min(d))-1;
%BestPlace=placeMAX+find(d2==min(d2))-1;
placeEnd=BestPlace;
AverageRhoVsRbySectors(index).dDropRadius=abs(pleaceMEANx-xvalAftherCorr(BestPlace));

RhoDilute=Rho;
RrhoDilute=Rrho;
    
ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-effectiveR);
ProfileY=meanyAftherCorr(1:placeEnd);
removeRbiggerThanRdrop=find(Rrho>effectiveR);
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
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


%%%% I will take the average corrected profile only for sectors that the
%%%% drop edge in it. 

IndexForGoodSectors=find([AverageRhoVsRbySectors.considerThisSector]==1);

figure
for i=1:length(AverageRhoVsRbySectors)
    plot(AverageRhoVsRbySectors(i).RrhoDilute,AverageRhoVsRbySectors(i).CorrectedRho)
    d_CorrectedRho=diff(AverageRhoVsRbySectors(i).CorrectedRho);
    place=find(d_CorrectedRho<1*mean(d_CorrectedRho));
    AverageRhoVsRbySectors(i).CutPlace=place(max(find(diff(place)>1))+1);
    AverageRhoVsRbySectors(i).CutVal=AverageRhoVsRbySectors(i).RrhoDilute(place(max(find(diff(place)>1))+1));
    hold on;
    plot(AverageRhoVsRbySectors(i).RrhoDilute(AverageRhoVsRbySectors(i).CutPlace),AverageRhoVsRbySectors(i).CorrectedRho(AverageRhoVsRbySectors(i).CutPlace),'+')
end

MinReff=min([AverageRhoVsRbySectors(IndexForGoodSectors).DistanceFromEdge]);
MinCutVal=min([AverageRhoVsRbySectors(IndexForGoodSectors).CutVal]);
MinCutVal=MinReff;

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

mkdir([Capture_folder,label,'\Rho\figures\'])
savefig([Capture_folder,label,'\Rho\figures\All sectors Average Rho after correction.fig']);
saveas(h,[Capture_folder,label,'\Rho\figures\All sectors Average Rho after correction.tif']);
saveas(h,[Capture_folder,label,'\Rho\figures\All sectors Average Rho after correction.eps']);


h=figure
plot(OriginalAvgRrho,OriginalAvgRho,'r','LineWidth',3)
hold on
plot(CorrectedAvgRrho,CorrectedAvgRho,'g','LineWidth',3)

%%%%% mark points on the first frame of the movie
if (label=='Rh')
    image=[Capture_folder,'Rhodamine.tiff'];
else 
    image=[Capture_folder,'LA.tiff'];
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

savefig([Capture_folder,label,'\Rho\figures\Average Rho after intensity correction near drop egde.fig']);
saveas(h,[Capture_folder,label,'\Rho\figures\Average Rho after intensity correction near drop egde.tif']);
saveas(h,[Capture_folder,label,'\Rho\figures\Average Rho after intensity correction near drop egde..eps']);

AverageRhoVsRbySectorsAfterCorr=AverageRhoVsRbySectors;

save([Capture_folder,label,'\Rho\AverageRhoVsRbySectorsAfterCorr.mat'],'AverageRhoVsRbySectorsAfterCorr');
save([Capture_folder,label,'\Rho\CorrectedAvgRho.mat'],'CorrectedAvgRho');
save([Capture_folder,label,'\Rho\CorrectedAvgRrho.mat'],'CorrectedAvgRrho');
save([Capture_folder,label,'\Rho\CorrectedAvgRhoUpSTD.mat'],'CorrectedAvgRhoUpSTD');
save([Capture_folder,label,'\Rho\CorrectedAvgRhoDownSTD.mat'],'CorrectedAvgRhoDownSTD');
save([Capture_folder,label,'\Rho\MinDistanceFromEdge.mat'],'MinDistanceFromEdge');
save([Capture_folder,label,'\Rho\MaxDistanceFromEdge.mat'],'MaxDistanceFromEdge');


end






