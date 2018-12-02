
addpath(genpath('\\phkinnerets\lab\LabProtocols\Speckling\fromErin'))

FileName='C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\Example Movies\Buffer\2016_10_2580percent_extract 0.5muM_LA-GFPmix3 sample1 30mu time20_10\Capture 6\';
% read in velocity field
calibration=importdata([FileName,'Analysis parameters\','calibration.m']);
Rchunk=importdata([FileName,'Analysis parameters\','CHUNK_radius.m']);
Rdroplet=importdata([FileName,'Analysis parameters\','DROP_radius.m']);
X0=importdata([FileName,'Analysis parameters\','X0.m']);
Y0=importdata([FileName,'Analysis parameters\','Y0.m']);
ROI=importdata([FileName,'Analysis parameters\','roi.m']);
dropCenter=[X0-ROI(1) Y0-ROI(2)];
dropCenter=[246 240];
x=importdata(fullfile(FileName,'Velocity\STICS\ROI[31 18 475 451]DCC30_10\','xtable.mat'));
y=importdata(fullfile(FileName,'Velocity\STICS\ROI[31 18 475 451]DCC30_10\','ytable.mat'));
u=importdata(fullfile(FileName,'Velocity\STICS\ROI[31 18 475 451]DCC30_10\','utable_AVG_EX3.mat'));
v=importdata(fullfile(FileName,'Velocity\STICS\ROI[31 18 475 451]DCC30_10\','vtable_AVG_EX3.mat'));

S=size(x);
BinningFactor=4;
k=1;
for i=1:22 
    t=1;
    for j=1:22
        binX(i,j)=ceil(mean(mean(x(k:k+1,t:t+1))));
        binY(i,j)=ceil(mean(mean(y(k:k+1,t:t+1))));
        binU(i,j)=mean(mean(u(k:k+1,t:t+1)));
        binV(i,j)=mean(mean(v(k:k+1,t:t+1)));
        t=t+2;
    end
    k=k+2;
end

rangeLimits=[0 7.3];

figure
mcQuiver(x, y, u, v, rangeLimits,jet(256),3);
figure
mcQuiver(binX, binY, binU,binV, rangeLimits,jet(256),3);

%
% axis ij
axis equal
% axis off
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 10])
hold on

%draw inner region

viscircles(dropCenter,Rchunk/calibration,'EdgeColor',[0.5 0.5 0.5])

savefig(fullfile(FileName,'flow field jet.fig'));
saveas(figure (3),fullfile(FileName,'flow field jet.tif'));
saveas(figure (3),[FileName,'flow field jet'],'epsc');



