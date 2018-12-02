function interp_V_Rho(Capture_folder,ROI_folder)

Vr=importdata([ROI_folder,'Vr.m']);
Rr=importdata([ROI_folder,'Rr.m']);
RrhoDilute=importdata([Capture_folder,'RhoFromFirstFrame\RrhoDilute.mat']);
Rrho=RrhoDilute;
mkdir([ROI_folder,'figures\'])

%%%Interpulate V with Rrho
new_Vr=interp1(Rr,Vr,Rrho);
h=figure
plot(Rrho,new_Vr)

%%%Option to smooth Vr
Vr_smooth=new_Vr;
% V_smooth = smooth(Rrho,new_Vr,0.2,'rloess');
% hold on
% plot(Rrho,V_smooth,'r')
% title('<Vr(R)>','FontSize',16)
% xlabel('R[\mum]','FontSize',16)
% ylabel('<Vr>[\mum/min]','FontSize',16)
% xlim([Minx,MAXx])
% savefig([save_smooth_V,'Smooth V(R).fig']);
% saveas(h,[save_smooth_V,'Smooth V(R).tif']);

interp_Vr=Vr_smooth;

title('interp <Vr(R)>','FontSize',16)
xlabel('R[\mum]','FontSize',16)
ylabel('interp <Vr>[\mum/min]','FontSize',16)
savefig([ROI_folder,'figures\','interp averageVr Vs R.fig']);
saveas(h,[ROI_folder,'figures\','interp averageVr Vs R.tif']);

save([ROI_folder,'interp_Vr.m'],'interp_Vr');

end




