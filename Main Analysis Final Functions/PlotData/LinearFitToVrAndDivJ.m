
%%% Buffer example drop
Capture_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\Buffer\Capture 3\';
ROI_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\Buffer\Capture 3\Velocity\STICS\ROI[87 115 342 320]DCC30_10\';
save_to_file='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\Buffer\Figures\';

%%% CCA example drop
Capture_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\CCA\Capture 20\';
ROI_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\CCA\Capture 20\Velocity\STICS\ROI[66 85 345 336]DCC30_10\';
save_to_file='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\CCA\Figures\';
mkdir(save_to_file)


%%% ActA example drop

close all
clear all

Capture_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Capture 7\';
ROI_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Capture 7\Velocity\STICS\ROI[83 96 298 267]DCC30_10\';
save_to_file='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Figures\';
mkdir(save_to_file)

Capture_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Capture 19\';
ROI_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Capture 19\Velocity\STICS\ROI[18 21 473 457]DCC30_10\';
save_to_file='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Figures\';
mkdir(save_to_file)

Capture_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Capture 23\';
ROI_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Capture 23\Velocity\STICS\ROI[82 109 369 360]DCC30_10\';
save_to_file='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\ActA\Figures\';
mkdir(save_to_file)

%%% 10uM alfa actinin example drop

close all
clear all

Capture_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\10uM alfa actinin\Capture 12\';
ROI_folder='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\10uM alfa actinin\Capture 12\Velocity\STICS\ROI[63 57 383 396]DCC30_10\';
save_to_file='C:\Users\Maya\Documents\Maya PhD\Droplet Paper\reviosion1 NaturePhysics\Linear Fits\10uM alfa actinin\Figures\';
mkdir(save_to_file)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

VelocityAsAFunctionOfR_STICSgridAsInput(Capture_folder,ROI_folder)
close all
DivJtoKK(Capture_folder,ROI_folder)

%%% Row data
R_sort=importdata([ROI_folder,'R_sort.m']);
Vr_sort=importdata([ROI_folder,'Vr_sort.m']);
%%% Average Line
Rr=importdata([ROI_folder,'Rr.m']);
Vr=importdata([ROI_folder,'Vr.m']);
lowerLine=importdata([ROI_folder,'lowerLine.m']);
upperLine=importdata([ROI_folder,'upperLine.m']);
%%% Linear Fit
RrLinearFitVr=importdata(fullfile(ROI_folder,'FinalVectors\RrLinearFitVr.mat'));
LinearFitVr=importdata(fullfile(ROI_folder,'FinalVectors\LinearFitVr.mat'));
LinearFitSlope=importdata(fullfile(ROI_folder,'FinalVectors\LinearFitSlope.mat'));
LinearFitP2=importdata(fullfile(ROI_folder,'FinalVectors\LinearFitP2.mat'));

dr=-(LinearFitP2/LinearFitSlope);

h=figure (1)

plot(R_sort-dr,Vr_sort,'.','LineWidth',0.1,'Color',[128/255 128/255 128/255])
hold on
plot(Rr-dr,Vr,'Color','k','LineWidth',1)
hold on
plot(Rr-dr,lowerLine,'Color','k','LineWidth',0.5)
hold on
plot(Rr-dr,upperLine,'Color','k','LineWidth',0.5)
hold on
plot(RrLinearFitVr-dr,LinearFitVr,'-','Color','b','LineWidth',1)


ylim([ -20 0])
xlim([0 inf])

xlabel('r-r_0[\mum]','FontSize',10)
ylabel('Vr[\mum/min]','FontSize',10)
box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])


savefig(fullfile(save_to_file,'Row data Vr VS r-r0.fig'));
saveas(figure (1),fullfile(save_to_file,'Row data Vr VS r-r0.tif'));
saveas(figure (1),fullfile(save_to_file,'Row data Vr VS r-r0'),'epsc');

%%%%% DivJ with Linear Fit

Div_Jr_Rho=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rho.mat'));
Div_Jr=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr.mat'));
LinearFitDivJ=importdata(fullfile(ROI_folder,'FinalVectors\LinearFitDivJ.mat'));
RhoForFit=importdata(fullfile(ROI_folder,'FinalVectors\RhoForFit.mat'));

h=figure (2)
plot(Div_Jr_Rho(1:end-1)/max(Div_Jr_Rho),Div_Jr/max(Div_Jr_Rho),'Color',[128/255 128/255 128/255],'LineWidth',0.5)
hold on
plot(RhoForFit/max(Div_Jr_Rho),LinearFitDivJ/max(Div_Jr_Rho),'k','LineWidth',0.5)

ylim([-1 1])
xlim([0 1])

xlabel('Normalized \rho [a.u]','FontSize',10)
ylabel('div(J) [a.u]','FontSize',10)

box off
ax=gca;
set(ax,'FontSize',8)
set(gcf,'units','centimeter')
set(gcf,'position',[7 7 5 4])

savefig(fullfile(save_to_file,'DivJ with Linear fit.fig'));
saveas(figure (2),fullfile(save_to_file,'DivJ with Linear fit.tif'));
saveas(figure (2),fullfile(save_to_file,'DivJ with Linear fit'),'epsc');





