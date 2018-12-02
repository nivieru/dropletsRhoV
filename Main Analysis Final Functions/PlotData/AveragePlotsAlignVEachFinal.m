% this is the script we used to align ro for all the data that went into
% the paper.
% for each curve we either used the data as is or shifted by fitting to the
% control in the indicated region
clear all; close all
load('AverageValues');

% %%%% plot the original average lines
% figure
% for i=1:length(AverageValues)
%     plot(AverageValues(i).xval3,AverageValues(i).meany3,'Color',AverageValues(i).color,'LineWidth',1)
%     hold on
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i=1; % we will compare everyone to the control
meanshift=zeros(1,length(AverageValues));
NrangeJump=0.25; % jump for data shifting (about 1 pixel)
toPlotEach=1;
% this is the data for the line we will compare all to
x1=AverageValues(i).xval3 ; %  x values
y1=AverageValues(i).meany3;

% now we start going one by one and checking the shifts
%%%%%%%%%%%%%%% 
j=2; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=7;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=3;  toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=1; thisRangeEnd(j)=7;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=4; toShift(j)=0;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=4; thisRangeEnd(j)=15;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=5; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=3; thisRangeEnd(j)=10;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=6; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=3; thisRangeEnd(j)=10;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=7; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=15;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=8; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=15;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=9; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=15;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=10; toShift(j)=0;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=4;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift


%%%%%%%%%%%%%%% 
j=11; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=3; thisRangeEnd(j)=7;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=12; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=15;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=13; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=4; thisRangeEnd(j)=15;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift


%%%%%%%%%%%%%%% 
j=14; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=8;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=15; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=2; thisRangeEnd(j)=15;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=16; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=1; thisRangeEnd(j)=7;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=17; toShift(j)=1;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=1; thisRangeEnd(j)=7;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

%%%%%%%%%%%%%%% 
j=18; toShift(j)=0;
x2=AverageValues(j).xval3 ; % x-values
y2=AverageValues(j).meany3;% y values
% this is the range in um over which the fit is done
thisRangeStart(j)=3; thisRangeEnd(j)=7;

[thisShift,thisslopeJ,thisslope1]=findShiftJ(x1,y1,x2,y2,thisRangeStart(j),thisRangeEnd(j),toShift(j));
if toShift(j)==0, title([AverageValues(j).LEG, 'no shift']);else title([AverageValues(j).LEG,'fit from',num2str(thisRangeStart(j)),'to ',num2str(thisRangeEnd(j))]); end 
slopeJ(j)=thisslopeJ; % this is the slope of data j in this range
slope1(j)=thisslope1; % this is the slope of control data in this range
deltall(j)=thisShift; % this contains the normalized shift

% shift control is the overall shift of teh control data (determined from
% requiring the linear fit to go throiugh 0 V=-k(r-ro)
% final shift contains the determined shift + the control shift 
shiftControl=-2.58;
finalShift=deltall+shiftControl;


indexToplot={[1,4,15:18],[1,5,6,10,11],[1,2,4,6,7,8],[1,2,3,12,14]};
% this is the data in the combinations that go into all figures from the
% original data
figure
for k=1:4,
    subplot(2,2,k)
    theseI=indexToplot{k};
    thisLegend={};
    for j=1:length(theseI),
        i=theseI(j);
        plot((AverageValues(i).xval3),AverageValues(i).meany3,'Color',AverageValues(i).color,'LineWidth',1)
        hold on
        thisLegend{j}=AverageValues(i).LEG;
    end
    xlim([0 35])
    legend(thisLegend)
end

indexToplot={[1,4,15:18],[1,5,6,10,11],[1,2,4,6,7,8],[1,2,3,12,14]};
% this is the data in the combinations that go into all figures after the
% new shift
figure
for k=1:4,
    subplot(2,2,k)
    theseI=indexToplot{k};
    thisLegend={};
    for j=1:length(theseI),
        i=theseI(j);
        shiftedXval=(AverageValues(i).xval3)-finalShift(i);
        plot(shiftedXval,AverageValues(i).meany3,'Color',AverageValues(i).color,'LineWidth',1)
        hold on
        thisLegend{j}=AverageValues(i).LEG;
    end
    xlim([0 40])
    legend(thisLegend)
end



c=num2cell(finalShift);
[AverageValues(:).ShiftFinal]=c{:};

AverageValues(1).typeOfExp=37; %% Buffer 
AverageValues(2).typeOfExp=38; %% CCA 
AverageValues(3).typeOfExp=39; %% Coronin
AverageValues(4).typeOfExp=40; %% 1.5uM ActA
AverageValues(5).typeOfExp=57; %% 5uM alfa actinin
AverageValues(6).typeOfExp=58; %% 10uM alfa actinin
AverageValues(7).typeOfExp=59; %% 2.5uM fascin
AverageValues(8).typeOfExp=60; %% 0.5uM mDia
AverageValues(9).typeOfExp=90; %% Palloidin
AverageValues(10).typeOfExp=91; %% 4uM alfa actinin
AverageValues(11).typeOfExp=92; %% 2.5uM alfa actinin
AverageValues(12).typeOfExp=98; %% Cofilin
AverageValues(13).typeOfExp=117; %% 0.5uM CP
AverageValues(14).typeOfExp=135; %% Aip1
AverageValues(15).typeOfExp=16; %% 80% extract buffer rambam 4-1
AverageValues(16).typeOfExp=201; %% 0.1uM ActA rambam 4-1
AverageValues(17).typeOfExp=203; %% 0.5uM ActA rambam 4-1
AverageValues(18).typeOfExp=206; %% 1.5uM ActA rambam 4-1

rShift=struct;

% a=num2cell([AverageValues.ShiftFinal]);
[rShift.ShiftFinal]=[AverageValues.ShiftFinal];
[rShift(:).typeOfExp]=[AverageValues.typeOfExp];

save_to_file='C:\Users\Maya\Documents\Maya Analysis after GRC\';
save(fullfile(save_to_file,'rShift.mat'),'rShift');
