addpath(genpath('D:\kinneret\protocols\Speckling\fromErin'));
addpath(genpath('\\phkinnerets\lab\LabProtocols\Speckling\fromErin'))

% read in velocity field
load('D:\kinneret\presentations\GRC2015\Maya 3D analysis\No ActA Life act_figures for presentation\VFieldData.mat');
rangeLimits=[0 20];

figure
mcQuiver(x, y, u, v, rangeLimits,jet(256),1.8);
%
axis ij
axis equal
axis off
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 20 20])
hold on

%draw inner region
calibration=0.2054;
Rchunk=12;
Rdroplet=70;
dropCenter=[191 200];
viscircles(dropCenter,Rchunk/calibration,'EdgeColor',[0.5 0.5 0.5])
% viscircles(dropCenter,20/calibration,'EdgeColor',[0.5 0.5 0.5])
% viscircles(dropCenter,30/calibration,'EdgeColor',[0.5 0.5 0.5])

% viscircles(dropCenter,Rdroplet/calibration,'EdgeColor','k')

%plot V vs R
load ('D:\kinneret\Nikta\Maya_Disassembly\No ActA Life act_figures for presentation\rambam3_2 2015_05_18 sample time 18_20 Capture 8\V\Vr.mat');
load ('D:\kinneret\Nikta\Maya_Disassembly\No ActA Life act_figures for presentation\rambam3_2 2015_05_18 sample time 18_20 Capture 8\V\Rr.mat');
figure
plot(Rr(1:end-25),Vr(1:end-25),'linewidth',3)
set (gca,'Xtick',0:20:60,'fontsize',14,'FontWeight','bold');
set (gca,'Ytick',-40:10:60,'fontsize',14,'FontWeight','bold');
xlabel('R [\mum]','fontsize',16)
ylabel('V_r [\mum/min]','fontsize',16)
line ([0 60],[0 0],'color','k','LineStyle',':','linewidth',1)
xlim ([0 47])
ylim ([-28 5])
box off
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])


%plot rau vs R
load ('D:\kinneret\Nikta\Maya_Disassembly\No ActA Life act_figures for presentation\rambam3_2 2015_05_18 sample time 18_20 Capture 8\Rho\Rho_background.mat');
load ('D:\kinneret\Nikta\Maya_Disassembly\No ActA Life act_figures for presentation\rambam3_2 2015_05_18 sample time 18_20 Capture 8\Rho\Rrho.mat');
figure
plot(Rrho(1:end),Rho_background(1:end)/max(Rho_background),'linewidth',3)
set (gca,'Xtick',0:20:60,'fontsize',14,'FontWeight','bold');
set (gca,'Ytick',0:1,'fontsize',14,'FontWeight','bold');
xlabel('R [\mum]','fontsize',16)
ylabel('\rho [a.u.]','fontsize',16)
line ([0 60],[0 0],'color','k','LineStyle',':','linewidth',1)
xlim ([0 47])
ylim ([0 1.2])
box off
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])

% now plot V vs R for different time points
load('D:\kinneret\presentations\GRC2015\Maya 3D analysis\steadyStateAnalysis_noActA\i3V_Vs_t_avg6.mat');
figure
colors=['rgb']
hold on
maxRange=find(i3V_Vs_t_avg6(3).Vr==min(i3V_Vs_t_avg6(3).Vr));

for i=1:3,
        plot(i3V_Vs_t_avg6(i).R(1:maxRange), i3V_Vs_t_avg6(i).Vr(1:maxRange),'linewidth',3,'color',colors(i));
end
legend('box','off')
legend({'0 min','5 min','10 min'},'edgeColor','w','fontsize',14)
set (gca,'Xtick',0:20:60,'fontsize',14,'FontWeight','bold');
set (gca,'Ytick',-40:10:60,'fontsize',14,'FontWeight','bold');
xlabel('R [\mum]','fontsize',16)
ylabel('V_r [\mum/min]','fontsize',16)
line ([0 60],[0 0],'color','k','LineStyle',':','linewidth',1)
xlim ([0 45])
ylim ([-28 5])
box off
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])


% now make density kymograph
% this one shows clear waves
load('D:\kinneret\presentations\GRC2015\Maya 3D analysis\steadyStateAnalysis_noActA\radialAveraging\i3RhoT')
figure
imshow(i3RhoT,[]); 
colormap
axis normal
axis off
xlabel('time')
ylabel('Distance from center')
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])

% this one looks pretty steady state
load('D:\kinneret\presentations\GRC2015\Maya 3D analysis\steadyStateAnalysis_noActA\radialAveraging\i6RhoT')
figure
imshow(i6RhoT,[]); colormap(jet)
axis normal
axis off
% xlabel('time')
% ylabel('Distance from center')
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 20 12])


