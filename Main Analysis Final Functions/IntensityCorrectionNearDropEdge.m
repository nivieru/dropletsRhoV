%%%%%% Maya Malik Garbi 3.7.2017
%%%%%% General description: this function take original intensity profile
%%%%%% (Rho) and divide it by average intensity profile(AverageProfileX,AverageProfileY) to corrected
%%%%%% optical decrese in the intensity near the drop adge.
%%%%%% The average intensity profile was computed in function 'NoNetworkIntensityCheck.m' 
%%%%%% based on experiments were done on 21/22.2017. In the experiments I imaged the
%%%%%% intensity of approx. 50 droplets. The energy mix was done with Life act and Rhodamine actin without 
%%%%%% energy mix and Capping Protein for preventing the network formation. 


function IntensityCorrectionNearDropEdge(Capture_folder,AverageProfileX,AverageProfileY)

Rho=importdata([Capture_folder,'RhoFromFirstFrame\RhoFromFirstFrame.mat']);
Rho=Rho-1063;
Rrho=importdata([Capture_folder,'RhoFromFirstFrame\Rrho.mat']);

% Rho=importdata([Capture_folder,'Rho\Rho.m']);
% Rrho=importdata([Capture_folder,'Rho\Rrho.m']);
DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m']);

xvalAftherCorr=AverageProfileX;
meanyAftherCorr=AverageProfileY;

placeMIN=min(find(meanyAftherCorr<0.1));
placeMAX=min(find(meanyAftherCorr<0.5));
k=placeMAX;

h=figure

for i=1:(placeMIN-placeMAX)

RhoDilute=Rho;
RrhoDilute=Rrho;
    
placeEnd=k;
ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-DropRadius);
ProfileY=meanyAftherCorr(1:placeEnd);
removeRbiggerThanRdrop=find(Rrho>DropRadius);
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
newRho=RhoDilute./newProfileY;

RnetworkPlace=max(find(RrhoDilute<NetworkRadius));
p=polyfit(RrhoDilute(RnetworkPlace:end)',newRho(RnetworkPlace:end)',1);
SlopeVrVSr=p(1);
d(i)=abs(SlopeVrVSr);
LinearFit=p(1)*RrhoDilute(RnetworkPlace:end)'+p(2);
d2(i)=abs(LinearFit(end)-newRho(end));
% d(i)=abs(newRho(end)-newRho(RnetworkPlace));
d3(i)=sum(abs(LinearFit'-newRho(RnetworkPlace:end)));

plot(RrhoDilute,(RhoDilute./newProfileY),'g')
hold on
plot(RrhoDilute,RhoDilute,'r')
hold on
plot(RrhoDilute(RnetworkPlace:end)',p(1)*RrhoDilute(RnetworkPlace:end)'+p(2),'k')
k=k+1;
% 
end

% BestPlace=placeMAX+find(d==min(d))-1;
BestPlace=placeMAX+find(d3==min(d3))-1;
placeEnd=BestPlace;

RhoDilute=Rho;
RrhoDilute=Rrho;
    
ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-DropRadius);
ProfileY=meanyAftherCorr(1:placeEnd);
removeRbiggerThanRdrop=find(Rrho>DropRadius);
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
CorrectedRho=RhoDilute./newProfileY;


% %%% Option to subtract the monomers intensity by the average
% %%% I(Rnetwork):I(Rdrop)
% 
% RnetworkPlace=max(find(RrhoDilute<NetworkRadius));
% MonomersBackground=mean(newRho(RnetworkPlace:end));
% newRhoNetwork=newRho-MonomersBackground;


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
% 
% save([Capture_folder,'Rho\CorrectedRho.m'],'CorrectedRho');
% save([Capture_folder,'Rho\RrhoDilute.m'],'RrhoDilute');

savefig([Capture_folder,'RhoFromFirstFrame\figures\Average Rho after intensity correction near drop egde.fig']);
saveas(h,[Capture_folder,'RhoFromFirstFrame\figures\Average Rho after intensity correction near drop egde.tif']);
saveas(h,[Capture_folder,'RhoFromFirstFrame\figures\Average Rho after intensity correction near drop egde..eps']);

save([Capture_folder,'RhoFromFirstFrame\CorrectedRho.m'],'CorrectedRho');
save([Capture_folder,'RhoFromFirstFrame\RrhoDilute.m'],'RrhoDilute');



end
