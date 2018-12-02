
function DivJtoKK(Capture_folder,ROI_folder)

save_to_file=(fullfile(ROI_folder,'figures\'));
mkdir(save_to_file);
mkdir(fullfile(ROI_folder,'FinalVectors\'));

if exist(fullfile(ROI_folder,'VrTimeAverageOnVectorFeild.m'), 'file')
Vr=importdata(fullfile(ROI_folder,'VrTimeAverageOnVectorFeild.m'));
Rr=importdata(fullfile(ROI_folder,'RrTimeAverageOnVectorFeild.m'));  %%%the vector that fits to Vr
else
Vr=importdata(fullfile(ROI_folder,'Vr.m'));
Rr=importdata(fullfile(ROI_folder,'Rr.m'));  %%%the vector that fits to Vr
end

Rrho=importdata(fullfile(Capture_folder,'Rho\CorrectedAvgRrho.mat'));
Rho=importdata(fullfile(Capture_folder,'Rho\CorrectedAvgRho.mat'));

% MinDistanceFromEdge=importdata([Capture_folder,'Rho\MinDistanceFromEdge.mat']);
% MaxDistanceFromEdge=importdata([Capture_folder,'Rho\MaxDistanceFromEdge.mat']);

MinRho=0;
CHUNK_radius=importdata(fullfile(Capture_folder,'Analysis parameters\CHUNK_radius.m')); %%%chunk radius
DROP_radius=importdata(fullfile(Capture_folder,'Analysis parameters\DROP_radius.m'));
ACTIN_NETWORK_radius=importdata(fullfile(Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m'));
%MaxRr=importdata([Capture_folder,'Analysis parameters\MaxRr.m']);

%%%% cut rho vector at MinDistanceFromEdge (minimum over the distance at
%%%% the different sectors)
% placeMinDistance=min(find(Rrho>MinDistanceFromEdge));
% Rho(placeMinDistance:end)=[];
% Rrho(placeMinDistance:end)=[];


% %%%% change made only for 10um samples
% Rrho=importdata([Capture_folder,'Rho\OriginalAvgRrho.mat']);
% Rho=importdata([Capture_folder,'Rho\OriginalAvgRho.mat']);
% 
% placeMinDistance=min(find(Rrho>(DROP_radius-20)));
% Rho(placeMinDistance:end)=[];
% Rrho(placeMinDistance:end)=[];
% save([ROI_folder,'FinalVectors\Rrho.mat'],'Rrho')
% %%%%%%%%%%%%%%%%%%%%%%%%%

%%%% subtract the monomers Intensity mean [ I(Rnetwork):I(Rmin Reffective) ]

MonomersPlace=min(find(Rrho>ACTIN_NETWORK_radius));
CHUNK_radiusPlace=min(find(Rrho>CHUNK_radius-3)); %%% I want to find the maxsimum in between (Rblob-3:end) 

if (length(MonomersPlace)==0)
    MonomersPlace=length(Rho);
    MonomersIntensity=Rho(MonomersPlace);
else
    MonomersIntensity=ceil(mean(Rho(MonomersPlace:end)));
end

    
    RhoMinusMonomers=Rho-MonomersIntensity;
    Rho=RhoMinusMonomers;

%%%%% Find the Maxsimum of Rho 
MinRr=CHUNK_radius;
[MAX_Rho,MAX_Rho_place]=max(Rho(CHUNK_radiusPlace:end));
MinRr2=ceil(Rrho(MAX_Rho_place+CHUNK_radiusPlace-1));

if (MinRr2>CHUNK_radius)
    MinRr=MinRr2;
end
 



%%%%% Cut rho vector to fit the area of Vr and interpulate to fit Rrho

% %%%% change that was made only for 10um spacer samples
% placeMaxR=find(Rr>(DROP_radius-20));
% Rr(placeMaxR)=[];
% Vr(placeMaxR)=[];
% save([ROI_folder,'FinalVectors\Rr.mat'],'Rr')
% save([ROI_folder,'FinalVectors\Vr.mat'],'Vr')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

placeMaxR=find(Rrho>Rr(end));
Rrho(placeMaxR)=[];
Rho(placeMaxR)=[];
placeMinR=find(Rrho<MinRr);
Rrho(placeMinR)=[];
Rho(placeMinR)=[];
placeMinR=find(Rr<MinRr);
Vr(placeMinR)=[];
Rr(placeMinR)=[];

new_Vr=interp1(Rr,Vr,Rrho);


% figure
% plot(Rrho,new_Vr)
% hold on
% plot(Rrho,Rho)

% %%%%%%%%%%%%% Linear fit to Vr(r)
% 
p=polyfit(Rr',Vr',1);
LinearFitVr=p(1)*Rrho'+p(2);
ContractionRate=p(1);
YaxisCrrosing=p(2);
% hold on
% plot(Rrho,LinearVr')

% new_Vr=LinearVr';


%%%Calculate Jr=Rho*(Vr) 
Jr=new_Vr.*Rho;

% figure
% plot(Rrho,Jr)

%%%Smooth the data before calculating the derivative
% figure
% plot((Rrho.^2).*Jr,'r')
 Smooth=((Rrho.^2).*Jr)';

% Smooth=smooth(Rrho,(Rrho.^2).*Jr,0.06,'sgolay');
% Smooth=smooth(Rrho,(Rrho.^2).*Jr,0.15,'rloess');
% hold on
% plot(Smooth,'b')

% figure
% plot(Rrho,(Rrho.^2).*Jr,'b')
% hold on
% plot(Rrho,Smooth,'r')
% 
%Calculating div(Jr) in sperical coordinates div(Jr)=(1/R^2) d/dr (R^2 Jr)
dy=diff(Smooth');
dx=diff(Rrho);
Div_Jr=((1./(Rrho(1:(end-1))).^2)).*(dy./dx);

% figure
% plot(Rho(1:end-1),Div_Jr)

%%% Fit only the negative part
DivJForFit=Div_Jr;
RhoForFit=Rho(1:end-1);
placePosative=find(Div_Jr>0);

DivJForFit(placePosative)=[];
RhoForFit(placePosative)=[];
Smooth=smooth(RhoForFit,DivJForFit,0.3,'sgolay');

% RhoForFit(find(isnan(DivJForFit)))=[];
% DivJForFit(find(isnan(DivJForFit)))=[];
% Smooth=DivJForFit';

pp=polyfit(RhoForFit',Smooth,1);
LinearFitDivJ=pp(1)*RhoForFit+pp(2);
TurnoverRate=pp(1);

%%%% Plot and save DivJ and its linear fit
% close all
h=figure (1)
plot(RhoForFit,DivJForFit,'b')
hold on
plot(RhoForFit,Smooth,'r')
hold on
plot(RhoForFit,LinearFitDivJ,'k')
% 
% savefig([save_to_file,'DivJ vs rho.fig']);
% saveas(h,[save_to_file,'DivJ vs rho.tif']);
% saveas(h,[save_to_file,'DivJ vs rho'],'epsc');


%%%% calculate integrated force balance eq. 1/r^2*(d/dr)*(r^2V)
temp=(Rrho.^2).*new_Vr;
dy=diff(temp);
dx=diff(Rrho);
ForceBalanceEq=((1./(Rrho(1:(end-1))).^2)).*(dy./dx);

ppDivV=polyfit(Rrho(1:end-1),ForceBalanceEq,1);
% Linear=ppDivV(1)*Rrho(1:end-1)+ppDivV(2);
DivVvsRslope=ppDivV(1);

save(fullfile(Capture_folder,'Rho\RhoMinusMonomers.mat'),'RhoMinusMonomers')

save(fullfile(ROI_folder,'FinalVectors\Jr.mat'),'Jr')
save(fullfile(ROI_folder,'FinalVectors\Div_Jr.mat'),'Div_Jr')
save(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rrho.mat'),'Rrho')
save(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rho.mat'),'Rho')
save(fullfile(ROI_folder,'FinalVectors\MinRr.mat'),'MinRr')
save(fullfile(ROI_folder,'FinalVectors\TurnoverRate.mat'),'TurnoverRate')%%% fitted only the negative part
save(fullfile(ROI_folder,'FinalVectors\ContractionRate.mat'),'ContractionRate') 
save(fullfile(ROI_folder,'FinalVectors\ForceBalanceEq.mat'),'ForceBalanceEq')
save(fullfile(ROI_folder,'FinalVectors\DivVvsRslope.mat'),'DivVvsRslope')

close all


save(fullfile(ROI_folder,'FinalVectors\LinearFitDivJ.mat'),'LinearFitDivJ')
save(fullfile(ROI_folder,'FinalVectors\LinearFitVr.mat'),'LinearFitVr')
save(fullfile(ROI_folder,'FinalVectors\RrLinearFitVr.mat'),'Rrho')

save(fullfile(ROI_folder,'FinalVectors\RhoForFit.mat'),'RhoForFit')

save(fullfile(ROI_folder,'FinalVectors\LinearFitSlope.mat'),'ContractionRate');
save(fullfile(ROI_folder,'FinalVectors\LinearFitP2.mat'),'YaxisCrrosing');


end







