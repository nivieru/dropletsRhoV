%%%%%% Maya Malik Garbi 13.7.2017
%%%%% CHANGE -
%%%%% Here the calculation is not by sectors beacuse we want only few examples..

%%%%%% General description: this function take original intensity profile
%%%%%% (Rho) by sectors and divide it by average intensity profile(AverageProfileX,AverageProfileY) to corrected
%%%%%% optical decrese in the intensity near the drop adge.
%%%%%% The average intensity profile was computed in function 'NoNetworkIntensityCheck.m'
%%%%%% based on experiments were done on 21/22.2017. In the experiments I imaged the
%%%%%% intensity of approx. 50 droplets. The mix was done with Life act and Rhodamine actin without
%%%%%% energy mix and Capping Protein for preventing the network formation.


function IntensityCorrectionNearDropEdgeLAandActinV(Capture_folder,AverageProfileX,AverageProfileY,NoLabelBack)

Rho=importdata([Capture_folder,'LA\Rho\Rho.mat']);
Rho=Rho-NoLabelBack;
Rrho=importdata([Capture_folder,'LA\Rho\Rrho.mat']);
DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.mat']);
NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.mat']);
X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);

xvalAftherCorr=AverageProfileX;
meanyAftherCorr=AverageProfileY;

placeMIN=min(find(meanyAftherCorr<0.05));
placeMAX=min(find(meanyAftherCorr<0.6));
placeMEAN=min(find(meanyAftherCorr<0.25));   %%%%% I=0.25 is the mean intensity value at Rdrop averged over 50 drops.
placeMINx=xvalAftherCorr(placeMIN);
placeMAXx=xvalAftherCorr(placeMAX);
pleaceMEANx=xvalAftherCorr(placeMEAN);

RhoDilute=Rho;
RrhoDilute=Rrho;

effectiveR=DropRadius;
effectiveRplace=min(find(RrhoDilute>effectiveR));

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
    
    RnetworkPlace=max(find(RrhoDilute<NetworkRadius));
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

% BestPlace=placeMAX+find(d==min(d))-1;
%BestPlace=placeMAX+find(d2==min(d2))-1;
placeEnd=BestPlace;

RhoDilute=Rho;
RrhoDilute=Rrho;

ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-effectiveR);
ProfileY=meanyAftherCorr(1:placeEnd);
removeRbiggerThanRdrop=find(Rrho>effectiveR);
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
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


hold on
plot(RrhoDilute,CorrectedRho,'b')
% hold on
% plot(RrhoDilute,RhoDilute,'r')
xlabel('R [\mum]','FontSize',16)
ylabel('<\rho>','FontSize',16)

savefig([Capture_folder,'LA\Rho\figures\Average Rho after intensity correction near drop egde.fig']);
saveas(h,[Capture_folder,'LA\Rho\figures\Average Rho after intensity correction near drop egde.tif']);
saveas(h,[Capture_folder,'LA\Rho\figures\Average Rho after intensity correction near drop egde..eps']);

save([Capture_folder,'LA\Rho\CorrectedRho.mat'],'CorrectedRho');
save([Capture_folder,'LA\Rho\RrhoDilute.mat'],'RrhoDilute');

end
