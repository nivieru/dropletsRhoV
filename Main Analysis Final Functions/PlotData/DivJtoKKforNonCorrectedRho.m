
function DivJtoKKforNonCorrectedRho(Capture_folder,ROI_folder)

save_to_file=([ROI_folder,'figures\']);
mkdir([ROI_folder,'FinalVectors\']);

Vr=importdata([ROI_folder,'Vr.m']);
Rr=importdata([ROI_folder,'Rr.m']);  %%%the vector that fits to Vr

Rrho=importdata([Capture_folder,'Rho\OriginalAvgRrho.mat']);
Rho=importdata([Capture_folder,'Rho\OriginalAvgRho.mat']);

% MinDistanceFromEdge=importdata([Capture_folder,'Rho\MinDistanceFromEdge.mat']);
% MaxDistanceFromEdge=importdata([Capture_folder,'Rho\MaxDistanceFromEdge.mat']);

MinRho=0;
CHUNK_radius=importdata([Capture_folder,'Analysis parameters\CHUNK_radius.m']); %%%chunk radius
DROP_radius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
ACTIN_NETWORK_radius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m']);
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
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% subtract the monomers Intensity mean [ I(Rnetwork):I(Rmin Reffective) ]

MonomersPlace=min(find(Rrho>ACTIN_NETWORK_radius));
DropEdgePlace=min(find(Rrho>DROP_radius));

if (length(MonomersPlace)==0)
    MonomersPlace=length(Rho);
    MonomersIntensity=Rho(MonomersPlace);
else
    MonomersIntensity=ceil(mean(Rho(MonomersPlace:DropEdgePlace)));
end

    
    RhoMinusMonomers=Rho-MonomersIntensity;
    Rho=RhoMinusMonomers;

%%%%% Find the Maxsimum of Rho 
MinRr=CHUNK_radius;
[MAX_Rho,MAX_Rho_place]=max(Rho);
MinRr2=ceil(Rrho(MAX_Rho_place));

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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


figure
plot(Rrho,new_Vr)
hold on
plot(Rrho,Rho)

% %%%%%%%%%%%%% Linear fit to Vr(r)
% 
p=polyfit(Rr',Vr',1);
LinearVr=p(1)*Rrho'+p(2);
ContractionRate=p(1);

% hold on
% plot(Rrho,LinearVr')

% new_Vr=LinearVr';


%%%Calculate Jr=Rho*(Vr) 
for i=1:length(Rrho)
Jr(i)=new_Vr(i)*Rho(i);
end

figure
plot(Rrho,Jr)

%%%Smooth the data before calculating the derivative
% figure
% plot((Rrho.^2).*Jr,'r')
 Smooth=((Rrho.^2).*Jr)';

% Smooth=smooth(Rrho,(Rrho.^2).*Jr,0.06,'sgolay');
% Smooth=smooth(Rrho,(Rrho.^2).*Jr,0.15,'rloess');
% hold on
% plot(Smooth,'b')

figure
plot(Rrho,(Rrho.^2).*Jr,'b')
hold on
plot(Rrho,Smooth,'r')
% 
%Calculating div(Jr) in sperical coordinates div(Jr)=(1/R^2) d/dr (R^2 Jr)
dy=diff(Smooth');
dx=diff(Rrho);
Div_Jr=((1./(Rrho(1:(end-1))).^2)).*(dy./dx);

figure
plot(Rho(1:end-1),Div_Jr)

%%% Fit only the negative part
DivJForFit=Div_Jr;
RhoForFit=Rho(1:end-1);
placePosative=find(Div_Jr>0);

DivJForFit(placePosative)=[];
RhoForFit(placePosative)=[];
Smooth=smooth(RhoForFit,DivJForFit,0.3,'sgolay');

pp=polyfit(RhoForFit',Smooth,1);
Linear=pp(1)*RhoForFit+pp(2);
TurnoverRate=pp(1);

save([Capture_folder,'Rho\RhoMinusMonomers.mat'],'RhoMinusMonomers')

save([ROI_folder,'FinalVectors\Jr.mat'],'Jr')
save([ROI_folder,'FinalVectors\Div_Jr.mat'],'Div_Jr')
save([ROI_folder,'FinalVectors\Div_Jr_Rrho.mat'],'Rrho')
save([ROI_folder,'FinalVectors\Div_Jr_Rho.mat'],'Rho')
save([ROI_folder,'FinalVectors\MinRr.mat'],'MinRr')
save([ROI_folder,'FinalVectors\TurnoverRate.mat'],'TurnoverRate')
save([ROI_folder,'FinalVectors\ContractionRate.mat'],'ContractionRate') %%% ca;culated only to the negative part

close all

end





% small=find(Rrho<MinRr);
% Rrho(small)=[]; 
% new_Vr(small)=[];
% Rho(small)=[];
% big=find(Rrho>MaxRr);
% Rrho(big)=[];
% new_Vr(big)=[];
% Rho(big)=[];
% 
% 
% big2=find(Rr>MaxRr);
% Rr(big2)=[];
% Vr(big2)=[];
% 
% small2=find(Rr<MinRr);
% Rr(small2)=[];
% Vr(small2)=[];
% 
% 
% % figure
% % plot(Rho,'r')
% % Rho_smooth = smooth(Rrho,Rho,0.15,'rloess');
% % Rho=Rho_smooth';
% % hold on
% % plot(Rho,'b')
% 
% 
% 


