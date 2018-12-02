
FileName='';

CorrectedProfile=importdata('')
AllNewRangeCorrectedProfiles=importdata('')

h=figure
Colorsjet=jet(300);

for i=1:length(CorrectedProfile)
    plot(CorrectedProfile(i).NormCorrectedAvgRrho, CorrectedProfile(i).NormCorrectedAvgRho,'Color',Colorsjet(i*10,:))
    hold on    
end

savefig(fullfile(FileName,'\figures\','1-30 NORMCorrected Rho vs R.fig'));
saveas(h,[FileName,'\figures\','1-30 NORMCorrected Rho vs R.tiff']);
saveas(h,[FileName,'\figures\1-30 NORMCorrected Rho vs R'],'epsc');



%%% Kymograph
h=figure
imshow([AllNewRangeCorrectedProfiles]',[]);
colormap(jet);
axis normal
axis off
ylabel('time')
xlabel('Distance from center')
set(gcf,'units','centimeter')
set(gcf,'position', [2 2 10 8])

savefig(fullfile(FileName,'\figures\','normDensity Kymograph 1to30 r-r0 with monomers subtraction.fig'));
saveas(h,[FileName,'\figures\','normDensity Kymograph 1to30 r-r0 with monomers subtraction.tiff']);
saveas(h,[FileName,'\figures\','\normDensity Kymograph 1to30 r-r0 with monomers subtraction'],'epsc');

