
function [meany,lowerLine,upperLine,xval] = meanGaussianMMv2( xi, yi, sigma, jump)

%%%%% Modified by Maya Malik 7.2017 
%%%%% xval jump = 0.25;
%%%%% Add STD

% function [meany,xval] = meanGaussian( xi, yi, sigma, varargin);

% function [meany,xval] = meanGaussian( xi, yi, sigma, varargin);
% this function takes the data xi and yi and calculates the moving average function meany(x)
% using a Gaussian weight function with width sigma
% meany(x) = sum  (yi * gxi) / sum (gxi)
% where gxi=exp( - (xi-x)^2/2sigma)  and the sum is on all i
% meany is evaluated in the positions given by the vector  xval (which is
% simply the range of data from min to max with Npoints equally spaced
% points in  between.)
%
% if there are nan values in either xi or yi the function ignores these
% values and calculates the mean value based on Gaussian weighting of
% neighboring points (with normalization of the weights of non-NaN values)
%
% optional variables toPlot = 1 draw  mean in new figure [default]
%                                               toPlot = 0 don't draw
%
% if exist('varargin', 'var')
%     assignVars(varargin); %parse optional variables
% end

% enter default for plotting
if ~exist('toPlot', 'var')
    toPlot = 1;
end
% enter default for Npoint

%determine the range for calculating the moving average as the [min,max] of
%xi and setting the num of points to be calculated at Npoints
xmin = nanmin(xi);
xmax = nanmax(xi);
xval = xmin: jump: xmax;

% %removing nan values from the data. In mnay cases it is better to
% interpolate based on neighboring point- rather than simply ignore which
% is why I changes the code below.
% newxi = xi ( find ( and ( ~ isnan(xi) , ~ isnan(yi))));
% newyi = yi ( find ( and ( ~ isnan(xi) , ~ isnan(yi))));
newxi = xi;
newyi = yi;

% deal with NaNs by getting a Gaussian mean which ignores them in the sum
% and also takes care in the normalization of the meany- to take into
% account only entries which are not NaN
for j = 1:length(xval),
    Gaussxi = exp( -(newxi-xval(j)).^2./2/sigma^2);
    meany(j) = nansum(newyi.*Gaussxi)/sum(Gaussxi (find ( and ( ~ isnan(newxi) , ~ isnan(newyi)))));
    
end
 

for j = 1:length(xval),
    Gaussxi = exp( -(newxi-xval(j)).^2./2/sigma^2);
    stdy(j) = sqrt ( nansum((newyi-meany(j)).^2 .* Gaussxi) / sum(Gaussxi (find ( and ( ~ isnan(newxi) , ~ isnan(newyi))))));
%     stdy(j) = sqrt ( nansum((newyi-meany(j)).^2 .* Gaussxi) / sum(Gaussxi));
end

lowerLine = meany-stdy;
upperLine = meany+stdy;

if toPlot==1,
    figure (2) 
    hold on
    plot(xi,yi,'*','Color','b')
    hold on
    plot(xval,meany,'k-','LineWidth',2)
    hold on
    plot(xval,lowerLine,'k-','LineWidth',1)
    hold on
    plot(xval,upperLine,'k-','LineWidth',1)
end
end