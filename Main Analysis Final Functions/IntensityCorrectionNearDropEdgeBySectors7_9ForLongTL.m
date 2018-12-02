%%%%%% Maya Malik Garbi 6.10.2017
%%%%%% General description: this function take original intensity profile
%%%%%% (Rho) and divide it by average intensity profile(AverageProfileX,AverageProfileY) to corrected
%%%%%% optical decrese in the intensity near the drop adge.
%%%%%% The average intensity profile was computed in function 'NoNetworkIntensityCheck.m'
%%%%%% based on experiments were done on 21/22.2017. In the experiments I imaged the
%%%%%% intensity of approx. 50 droplets. The energy mix was done with Life act and Rhodamine actin without
%%%%%% energy mix and Capping Protein for preventing the network formation.


%%%% The changes I made for Long TL data - 
%%%% time average on set of frames determined by NoOfFramesToAvg
%%%% I call this function from - AverageEdgeIntenistyCorrectionForLongTL

function IntensityCorrectionNearDropEdgeBySectors7_9ForLongTL(Capture_folder,AverageProfileX,AverageProfileY,FirstFrame,LastFrame)


calibration=importdata([Capture_folder,'Analysis parameters\calibration.m']);
%AverageRhoVsRbySectors=importdata([Capture_folder,'Rho\AverageRhoVsRbySectors.mat']);

AverageRhoVsRbySectors=importdata([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\AverageRhoVsRbySectors.mat']);

DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m']);
X0=importdata([Capture_folder,'Analysis parameters\X0.m']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);
% X0=importdata([Capture_folder,'Analysis parameters\OptimizeX0.mat']);
% Y0=importdata([Capture_folder,'Analysis parameters\OptimizeY0.mat']);
% 
DROP_mask=importdata([Capture_folder,'Analysis parameters\DROP_mask.m']);
NumberOfSectors=9;

xvalAftherCorr=AverageProfileX;
meanyAftherCorr=AverageProfileY;

placeMIN=min(find(meanyAftherCorr<0.05));
placeMAX=min(find(meanyAftherCorr<0.7));
placeMEAN=min(find(meanyAftherCorr<0.25));   %%%%% I=0.25 is the mean intensity value at Rdrop averged over 50 drops.
% placeMINx=xvalAftherCorr(placeMIN);
% placeMAXx=xvalAftherCorr(placeMAX);
pleaceMEANx=xvalAftherCorr(placeMEAN);

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

% image=[Capture_folder,'16bitC0 after bleach correction.tiff'];
% 
% figure
% imshow(image)
% hold on
% plot(X_bound(PlaceThirdQuarter),Y_bound(PlaceThirdQuarter))
% hold on
% plot(X0,Y0,'+')
% close all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for index=1:length(AverageRhoVsRbySectors)
    
    Rho=AverageRhoVsRbySectors(index).AvgRho;
    Rrho=AverageRhoVsRbySectors(index).AvgRrho;
    
    %     RhoDilute=Rho;
    %     RrhoDilute=Rrho;
    
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
    
    if (ThirdQuarterY_bound(place)==512) | (ThirdQuarterX_bound(place)==512)| (ThirdQuarterY_bound(place)==1) | (ThirdQuarterX_bound(place)==1)
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
        ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-Reff(index));
        
        %%%% divide only the part between R effective to R effective -40
        %%%% because the effect is over appro. 30 um from the drop edge.
        
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
        
   %     RnetworkPlace=max(find(RrhoDilute<(NetworkRadius-10)));   %%%%% -10 only for ActA data
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
    
    
    %  BestPlace=placeMAX+find(d3==min(d3))-1;
    % BestPlace=placeMAX+find(d==min(d))-1;
    %BestPlace=placeMAX+find(d2==min(d2))-1;
    placeEnd=BestPlace;
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
    
    % d_CorrectedRho=diff(CorrectedRho);
    %
    % for t=RnetworkPlace:(length(d_CorrectedRho)-5)
    %     b_left=sum(abs(d_CorrectedRho(t-4:t)));
    %     b_right=sum(abs(d_CorrectedRho(t+2:t+5)));
    %     if (abs (d_CorrectedRho(t+2))>b)
    %         endPlace=t;
    %         break
    %     end
    % end
    
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
    d_CorrectedRho=diff(AverageRhoVsRbySectors(i).CorrectedRho)
    place=find(d_CorrectedRho<1*mean(d_CorrectedRho));
    AverageRhoVsRbySectors(i).CutPlace=place(max(find(diff(place)>1))+1);
    AverageRhoVsRbySectors(i).CutVal=AverageRhoVsRbySectors(i).RrhoDilute(place(max(find(diff(place)>1))+1));
    hold on;
    plot(AverageRhoVsRbySectors(i).RrhoDilute(AverageRhoVsRbySectors(i).CutPlace),AverageRhoVsRbySectors(i).CorrectedRho(AverageRhoVsRbySectors(i).CutPlace),'+')
end

MinCutVal=min([AverageRhoVsRbySectors(IndexForGoodSectors).CutVal]);

MinReff=min([AverageRhoVsRbySectors(IndexForGoodSectors).DistanceFromEdge]);
MinCutVal=MinReff;

for i=1:length(AverageRhoVsRbySectors)
    AverageRhoVsRbySectors(i).RrhoByMinReff=AverageRhoVsRbySectors(i).RrhoDilute;
    AverageRhoVsRbySectors(i).CorrectedRhoByMinReff=AverageRhoVsRbySectors(i).CorrectedRho;
    remove=find(AverageRhoVsRbySectors(i).RrhoDilute>MinCutVal);
    AverageRhoVsRbySectors(i).RrhoByMinReff(remove)=[];
    AverageRhoVsRbySectors(i).CorrectedRhoByMinReff(remove)=[];
end


figure
[OriginalAvgRho,OriginalAvgRhoUpSTD,OriginalAvgRhoDownSTD,OriginalAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors(IndexForGoodSectors).AvgRrho],[AverageRhoVsRbySectors(IndexForGoodSectors).AvgRho], 1);
[CorrectedAvgRho,CorrectedAvgRhoUpSTD,CorrectedAvgRhoDownSTD,CorrectedAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors(IndexForGoodSectors).RrhoByMinReff],[AverageRhoVsRbySectors(IndexForGoodSectors).CorrectedRhoByMinReff], 1);
MinDistanceFromEdge=min([AverageRhoVsRbySectors.DistanceFromEdge]);
MaxDistanceFromEdge=max([AverageRhoVsRbySectors.DistanceFromEdge]);

h=figure
plot(OriginalAvgRrho,OriginalAvgRho,'r','LineWidth',3)
hold on
plot(CorrectedAvgRrho,CorrectedAvgRho,'g','LineWidth',3)

%%%%% mark points on the first frame of the movie
info=imfinfo([Capture_folder,'8bitC0.tif']);
Size_info=size(info);
Number_of_frames=Size_info(1,1);

% figure
% for k=1:Number_of_frames
%     im=imread([Capture_folder,'8bitC0.tif'],k);
%     imshow(im,[])
%     hold on
%     plot(X0,Y0,'+')
%     hold on
%     % plot(X0drop,Y0drop,'+','Color','b')
%     % hold on
%     viscircles([X0,Y0],MinCutVal/calibration,'Color','w','LineWidth',0.5)
%     % hold on
%     % viscircles([X0drop,Y0drop],DropRadius/calibration,'Color','b','LineWidth',0.5)
%     hold on
%     viscircles([X0,Y0],NetworkRadius/calibration,'Color','b','LineWidth',0.5)
%     hold on
%     text(X0,Y0+10+MinCutVal/calibration,['R_c_u_t=',num2str(MinCutVal)],'Color','c')
%     frame(k)=getframe(gca);
%     imwrite(frame(k).cdata(:,:,1),[Capture_folder,'movie with marks.tiff'],'WriteMode','append');
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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



mkdir([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\figures\']);
savefig([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\figures\Average Rho after intensity correction near drop egde.fig']);
saveas(h,[Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\figures\Average Rho after intensity correction near drop egde.tif']);
saveas(h,[Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\figures\Average Rho after intensity correction near drop egde..eps']);

AverageRhoVsRbySectorsAfterCorr=AverageRhoVsRbySectors;

save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\AverageRhoVsRbySectorsAfterCorr.mat'],'AverageRhoVsRbySectorsAfterCorr');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\CorrectedAvgRho.mat'],'CorrectedAvgRho');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\CorrectedAvgRrho.mat'],'CorrectedAvgRrho');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\CorrectedAvgRhoUpSTD.mat'],'CorrectedAvgRhoUpSTD');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\CorrectedAvgRhoDownSTD.mat'],'CorrectedAvgRhoDownSTD');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\MinDistanceFromEdge.mat'],'MinDistanceFromEdge');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\MaxDistanceFromEdge.mat'],'MaxDistanceFromEdge');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\OriginalAvgRrho.mat'],'OriginalAvgRrho');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\OriginalAvgRho.mat'],'OriginalAvgRho');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\OriginalAvgRhoDownSTD.mat'],'OriginalAvgRhoDownSTD');
save([Capture_folder,'Rho\',num2str(FirstFrame),' to ',num2str(LastFrame),'\OriginalAvgRhoUpSTD.mat'],'OriginalAvgRhoUpSTD');


end






