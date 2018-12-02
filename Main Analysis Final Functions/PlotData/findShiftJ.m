function [thisShift,slopeJ,slope1] = findShiftJ (x1,y1,x2,y2,startFit,endFit,toShift);
% this function calculates the relative shift between two data sets x1,y1
% and x2,y2
NrangeJump=0.25; % jump for data shifting (about 1 pixel)
toPlotEach=1; % if to plot what is being fit
if not(exist('toShift','var') ),
    toShift=1;
end

thisRange=startFit:NrangeJump:endFit;
interpV1=interp1(x1,y1,thisRange);
interpV2=interp1(x2,y2,thisRange);
if toPlotEach,
    figure
    plot(thisRange,interpV1,'r.',thisRange,interpV2,'b.')
    hold on
    plot(x1,y1,'r:',x2,y2,'b:')
end

% determine the slope of each in this range
pj=polyfit(thisRange,interpV2,1);
slopeJ=-pj(1); % this is the slope of data j in this range
p1=polyfit(thisRange,interpV1,1);
slope1=-p1(1); % this is the slope of control data in this range

x1cal=x1 * slope1; % scaled x values
x2cal=x2 * slopeJ;% scaled x-values

interpV1cal=interp1(x1cal,y1,thisRange);
interpV2cal=interp1(x2cal,y2,thisRange);

c=nanmean(interpV2cal-interpV1cal)/slopeJ; % this is the average y distance; since the slope was normalized to one- this is also the mean x distance
%     [a,placemin] = min(c); % I is lowest value for the mean squares
thisShift=c; % this contains the normalized shift

if toShift==0, % not to shift
    thisShift=0;
end
if toPlotEach,
    plot(x2-thisShift,y2,'k-')
end

end