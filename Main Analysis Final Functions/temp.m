
Capture_folder='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Actin & LA labeling\2017_02_13\80% extract Rhodamine actin & LA GFP\Mix1 13_40\Capture 11\';

DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.mat']);
DROP_mask=importdata([Capture_folder,'Analysis parameters\DROP_mask.mat']);
NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.mat']);
X0=importdata([Capture_folder,'Analysis parameters\X0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\Y0.mat']);

DropBoundaries=bwboundaries(DROP_mask);
DropBoundaries=DropBoundaries{1,1};
X_bound=DropBoundaries(:,2);
Y_bound=DropBoundaries(:,1);

figure
imshow([Capture_folder,'Rhodamine.tiff'])
hold on
plot(X_bound,Y_bound)
hold on
plot(X0,Y0,'+')

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


figure
imshow([Capture_folder,'Rhodamine.tiff'])
hold on
plot(X_bound(PlaceThirdQuarter),Y_bound(PlaceThirdQuarter))
hold on
plot(X0,Y0,'+')

NumberOfSectors=9;

for index=1:NumberOfSectors
thetaSectors(index) = 1.5*pi - ( (pi/(2*NumberOfSectors))*(index-0.5) );
%%%find the place of the closest angle thetaSectors(index) in ThirdQuarterTheta
d_theta=(abs(ThirdQuarterTheta-thetaSectors(index)));
place=find(d_theta==min(d_theta));
R=ThirdQuarterDistanceFromEdge(place(1));
Reff(index)=R*0.2054;
end
