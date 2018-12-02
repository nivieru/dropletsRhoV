function LinearFitVr(Capture_folder,ROI_folder)

Dir=dir([Capture_folder,'Velocity\STICS\']);
% ROI_folder=[Capture_folder,'Velocity\STICS\'];
mkdir([ROI_folder,'Linear Fit figures'])

Vr=importdata([Capture_folder,'Velocity\STICS\',Dir(3).name,'\Vr.m']);
Rr=importdata([Capture_folder,'Velocity\STICS\',Dir(3).name,'\Rr.m']);
Rrho=importdata([Capture_folder,'Rho\Rrho.m']);
MaxRr=importdata([Capture_folder,'Analysis parameters\MaxRr.m']);
MinRr=importdata([Capture_folder,'Analysis parameters\MinRr.m']); 

figure(1)
hold on
plot(Rr,Vr,'k')

%%%% Smooth the original data before linear fit
g=figure (2)
plot(Rr,Vr,'k')
Smooth=smooth(Rr,Vr,0.06,'sgolay');
hold on
plot(Rr,Smooth,'r')
title('<Vr(R)>','FontSize',16)
xlabel('R[\mum]','FontSize',16)
% xlim([ min(Rr) MaxRr])
ylabel('<Vr>[\mum/min]','FontSize',16)

savefig([ROI_folder,'Linear Fit figures\Smooth STICS averageVr Vs R Merge.fig'])
saveas(g,[ROI_folder,'Linear Fit figures\Smooth STICS averageVr Vs R Merge.tiff'])

Vr=Smooth;
plot(Rr,Vr)

%%%%Remove data that not in the right range
place=find(Rr<MinRr);
Rr(place)=[];
Vr(place)=[];

place=find(Rr>MaxRr);
Rr(place)=[];
Vr(place)=[];

g=figure (2)
plot(Rr',Vr,'r')
%%% Linear fit
p=polyfit(Rr',Vr,1);
SlopeVrVSr=p(1);
interp_VrLinear=p(1)*Rrho+p(2);
hold on
plot(Rrho,interp_VrLinear,'g')
title('<Vr(R)>','FontSize',16)
xlabel('R[\mum]','FontSize',16)
xlim([ 0 MaxRr])
ylabel('<Vr>[\mum/min]','FontSize',16)

save([ROI_folder,'SlopeVrVSr.mat'],'SlopeVrVSr')
savefig([ROI_folder,'Linear Fit figures\Linear STICS averageVr Vs R Merge.fig'])
saveas(g,[ROI_folder,'Linear Fit figures\Linear STICS averageVr Vs R Merge.tiff'])
save([ROI_folder,'interp_VrLinear.m'],'interp_VrLinear');

g=figure (3)
plot(Rrho,interp_VrLinear,'g')
title('<Vr(R)>','FontSize',16)
xlabel('R[\mum]','FontSize',16)
xlim([MinRr MaxRr])
ylabel('<Vr>[\mum/min]','FontSize',16)
legend(['Slope=',num2str(p(1))])

savefig([ROI_folder,'Linear Fit figures\onlyLinear STICS averageVr Vs R Merge.fig'])
saveas(g,[ROI_folder,'Linear Fit figures\onltLinear STICS averageVr Vs R Merge.tiff'])

end
