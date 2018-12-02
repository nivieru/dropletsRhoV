function VectorExclusion(Capture_folder,ROI_folder,GaussianWidthLimit)

interrogationarea=importdata([Capture_folder,'Analysis parameters\interrogationarea.m']);

% allOutoCorrTable=importdata([ROI_folder,'allOutoCorrTable.mat']);
% CorrelationPeak=importdata([ROI_folder,'CorrelationPeak.mat']);
% OutoCorrelationPeak=importdata([ROI_folder,'OutoCorrelationPeak.mat']);
xtable=importdata([ROI_folder,'xtable.mat']);
ytable=importdata([ROI_folder,'ytable.mat']);
utable_AVG=importdata([ROI_folder,'utable_AVG.mat']);
vtable_AVG=importdata([ROI_folder,'vtable_AVG.mat']);
GaussianWidth1=importdata([ROI_folder,'GaussianWidth1.mat']);
GaussianWidth2=importdata([ROI_folder,'GaussianWidth2.mat']);
removeCorr=importdata([ROI_folder,'removeCorr.mat']);
roi=importdata([Capture_folder,'Analysis parameters\roi.m']);
% OutoCorrelationPeak=importdata([ROI_folder,'OutoCorrelationPeak.mat']);

%allAverage_correlation=importdata([ROI_folder,'allAverage_correlation.mat']);

xtable_EX=xtable+interrogationarea/2;
ytable_EX=ytable+interrogationarea/2;
utable_AVG_EX1=utable_AVG;
vtable_AVG_EX1=vtable_AVG;
utable_AVG_EX2=utable_AVG;
vtable_AVG_EX2=vtable_AVG;

%%%% Exclusion rule no'1
%%%% removeCorr include the correlation that have two peaks (==1) and
%%%% correlation that the peak located at the boundry (==2)
%%%% Velocities that bigger than the window size (==3)

[NotInRange1]=find(removeCorr==1);
[NotInRange2]=find(removeCorr==2);
[NotInRange22]=find(removeCorr==3);
[NotInRange]=[NotInRange1;NotInRange2;NotInRange22];

utable_AVG_EX1(NotInRange)=NaN;
vtable_AVG_EX1(NotInRange)=NaN;

%%% BLUE - original vector field
figure (1)
quiver(xtable_EX,ytable_EX,utable_AVG,vtable_AVG,0,'LineWidth',1.5,'Color','b');

%%% RED - after first exclusion rule
hold on
quiver(xtable_EX,ytable_EX,utable_AVG_EX1,vtable_AVG_EX1,0,'LineWidth',1.5,'Color','r');


%%%% Exclusion rule no'2
%%%% remove all the correlations with large width

[NotInRange3]=find(GaussianWidth1>GaussianWidthLimit);
[NotInRange4]=find(GaussianWidth2>GaussianWidthLimit);

[NotInRange]=[NotInRange;NotInRange3;NotInRange4]; 
utable_AVG_EX2(NotInRange)=NaN;
vtable_AVG_EX2(NotInRange)=NaN;

%%% GREEN - after secound exclusion rule
hold on
quiver(xtable_EX,ytable_EX,utable_AVG_EX2,vtable_AVG_EX2,0,'LineWidth',1.5,'Color','g');

%%%% Exclusion rule no'3
%%%% remove all the vectors that not in the main feature
binary=utable_AVG_EX2;
binary(~isnan(binary))=1;
binary(isnan(binary))=0;
% figure
% imshow(binary)
binary2=bwareaopen(binary,100);
% figure
% imshow(binary2)
utable_AVG_EX3=utable_AVG_EX2;
vtable_AVG_EX3=vtable_AVG_EX2;

utable_AVG_EX3(find(binary2==0))=NaN;
vtable_AVG_EX3(find(binary2==0))=NaN;


%%% BLACK - after third exclusion rule
hold on
quiver(xtable_EX,ytable_EX,utable_AVG_EX3,vtable_AVG_EX3,0,'LineWidth',1.5,'Color','k');
axis equal

h=figure (1);
savefig([ROI_folder,'Velocity Field ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),'].fig']);
saveas(h,[ROI_folder,'Velocity Field ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),'].tif']);

save([ROI_folder,'utable_AVG_EX1.mat'],'utable_AVG_EX1');
save([ROI_folder,'vtable_AVG_EX1.mat'],'vtable_AVG_EX1');
save([ROI_folder,'utable_AVG_EX2.mat'],'utable_AVG_EX2');
save([ROI_folder,'vtable_AVG_EX2.mat'],'vtable_AVG_EX2');
save([ROI_folder,'utable_AVG_EX3.mat'],'utable_AVG_EX3');
save([ROI_folder,'vtable_AVG_EX3.mat'],'vtable_AVG_EX3');

end
