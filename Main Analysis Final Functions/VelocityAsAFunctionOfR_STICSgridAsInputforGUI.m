function VelocityAsAFunctionOfR_STICSgridAsInputforGUI(Capture_folder,ROI_folder,SpetialAveraging)

interrogationarea=importdata([Capture_folder,'Analysis parameters\interrogationarea.m']);

xtable=importdata([ROI_folder,'xtable.mat']);
ytable=importdata([ROI_folder,'ytable.mat']);
% utable_AVG=importdata([ROI_folder,'utable_AVG_EX.m']);
% vtable_AVG=importdata([ROI_folder,'vtable_AVG_EX.m']);
% utable_AVG=importdata([ROI_folder,'utable_AVG_EXclean.m']);
% vtable_AVG=importdata([ROI_folder,'vtable_AVG_EXclean.m']);

% utable_AVG=importdata([ROI_folder,'utable_AVG.mat']);
% vtable_AVG=importdata([ROI_folder,'vtable_AVG.mat']);

utable_AVG=importdata([ROI_folder,'utable_AVG_EX3.mat']);
vtable_AVG=importdata([ROI_folder,'vtable_AVG_EX3.mat']);

utable_AVGall=importdata([ROI_folder,'utable_AVG.mat']);
vtable_AVGall=importdata([ROI_folder,'vtable_AVG.mat']);
%

MaxRr=importdata([Capture_folder,'Analysis parameters\MaxRr.m']);
MinRr=importdata([Capture_folder,'Analysis parameters\MinRr.m']);

DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
% X0=importdata([Capture_folder,'Analysis parameters\X0.m']);
% Y0=importdata([Capture_folder,'Analysis parameters\Y0.m']);
X0=importdata([Capture_folder,'Analysis parameters\OptimizeX0.mat']);
Y0=importdata([Capture_folder,'Analysis parameters\OptimizeY0.mat']);

roi=importdata([Capture_folder,'Analysis parameters\roi.m']);
size_of_window1=importdata([Capture_folder,'Analysis parameters\interrogationarea.m']);
Time_intervale1=importdata([Capture_folder,'Analysis parameters\Time_intervale.m']);
calibration1=importdata([Capture_folder,'Analysis parameters\calibration.m']);
step=importdata([Capture_folder,'Analysis parameters\step.m']);

%%% for determine the image size;
image1_roi=imread([Capture_folder,'Velocity\CLAHE_HP prefilter\01.tiff']);
S=size(image1_roi);

if (S(1)>S(2))
    S=S(1);
else
    S=S(2);
end

 save_to_file='figures\';
% save_to_file='figures corrected\';

mkdir([ROI_folder,save_to_file])


%Find the center
% CenterX=X0-(roi(1)-(size_of_window1/2));
% CenterY=Y0-(roi(2)-(size_of_window1/2));

CenterX=X0;
CenterY=Y0;

Size=size(xtable);
Lx=Size(2);
Ly=Size(1);

%Transformation of the axes, calculating R AND Vr
for i=1:Ly
    for j=1:Lx
        
%         Y(i,j)=ytable(i,j)-CenterY;
%         X(i,j)=xtable(i,j)-CenterX;

          Y(i,j)=(ytable(i,j)+interrogationarea/2)-CenterY;
          X(i,j)=(xtable(i,j)+interrogationarea/2)-CenterX;
        
        R(i,j)=sqrt( (X(i,j)^2) + (Y(i,j)^2) );
        
        
        theta(i,j)=atan( Y(i,j)/X(i,j) );
        
        if ( X(i,j)<0)
            theta(i,j)=theta(i,j)+pi;
        end
        
        Vr(i,j)= utable_AVG(i,j)*cos(theta(i,j)) +  vtable_AVG(i,j)*sin(theta(i,j));
        Vrall(i,j)= utable_AVGall(i,j)*cos(theta(i,j)) +  vtable_AVGall(i,j)*sin(theta(i,j));
        Vtheta(i,j)= -utable_AVG(i,j)*sin(theta(i,j)) +  vtable_AVG(i,j)*cos(theta(i,j));
        
        if (theta(i,j)<0)
            theta(i,j)=2*pi+theta(i,j);
        end
        
    end
end

%%% Option for a specific spetial averaging
if (length(SpetialAveraging)>0)
    
    thetaStart=SpetialAveraging.StartAngle;
    thetaEnd=SpetialAveraging.EndAngle;
    OutOfRange1=find(theta<thetaStart);
    OutOfRange2=find(theta>thetaEnd);
    OutOfRange=[OutOfRange1;OutOfRange2];

    R(OutOfRange)=[];
    Vr(OutOfRange)=[];
    Vrall(OutOfRange)=[];

end


%%set scale:
%[V]=pixel/frame
%[R]=pixel

MatrixR=R*calibration1;
MatrixV=Vr*(calibration1/(Time_intervale1/60));

R=R(:)*calibration1;
Vr=Vr(:)*(calibration1/(Time_intervale1/60));
Vrall=Vrall(:)*(calibration1/(Time_intervale1/60));


%Rearrange V and R

[R_sort,place]=sort(R);

for i=1:length(Vr)
    Vr_sort(i)=Vr(place(i));
    Vr_sort_all(i)=Vrall(place(i));
end

Vr_sort=Vr_sort';
Vr_sort_all=Vr_sort_all';

% %Find the relevent Rmax
% Place_NaN=isnan(Vr_sort);
% N=find(Place_NaN==0);
% N=max(N);
% MaxRr=R_sort(N);

%%% Remove out of range data
place=find(R_sort<MinRr);
R_sort(place)=[];
Vr_sort(place)=[];
Vr_sort_all(place)=[];

place=find(R_sort>MaxRr);
R_sort(place)=[];
Vr_sort(place)=[];
Vr_sort_all(place)=[];


h=figure(1)
plot(R_sort,Vr_sort_all,'*','Color','r')
hold on
plot(R_sort,Vr_sort,'*','Color','b')

%%%Remove NaN values from the vector
R_sort_all=R_sort;

NaN_Place=find(isnan(Vr_sort));
Vr_sort(NaN_Place)=[];
R_sort(NaN_Place)=[];

NaN_Place=find(isnan(Vr_sort_all));
Vr_sort_all(NaN_Place)=[];
R_sort_all(NaN_Place)=[];


% %%% Exclude wrong vectors
% ii=1;
% for i=2:length(Vr_sort)-1
%     MeanNN=(Vr_sort(i-1)+Vr_sort(i+1))/2;
%
%     if (R_sort(ii)>DropRadius/3)
%
%     if Vr_sort(i)<2*MeanNN;
%         remove(ii)=i;
%         ii=ii+1;
%     else if Vr_sort(i)>0.1*MeanNN;
%             remove(ii)=i;
%             ii=ii+1;
%         end
%     end
%
%     end
%
%     if (R_sort(ii)<DropRadius/3)
%
%     if Vr_sort(i)<2*MeanNN;
%         remove(ii)=i;
%         ii=ii+1;
%         else if Vr_sort(i)>0;
% %     else if Vr_sort(i)>abs(5*MeanNN);
%             remove(ii)=i;
%             ii=ii+1;
%         end
%     end
%
%     end
%
% end
%
% %%%% For the last point in the vector
%
% i=length(Vr_sort);
% MeanNN=(Vr_sort(i-2)+Vr_sort(i-1))/2;
%
% if Vr_sort(i)<1.2*MeanNN;
%     remove(ii)=i;
%     ii=ii+1;
% else if Vr_sort(i)>0.5*MeanNN;
%         remove(ii)=i;
%         ii=ii+1;
%     end
% end
%
%
%
% R_sort(remove)=[];
% Vr_sort(remove)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


h=figure(2)
plot(R_sort_all,Vr_sort_all,'*','Color','r')
hold on
% plot(R_sort,Vr_sort,'.','Color','g')
% hold on

savefig([ROI_folder,save_to_file,'Vr Vs R after exclude.fig']);
saveas(h,[ROI_folder,save_to_file,'Vr Vs R after exclude.tif']);
% 


% %%% Option to remove vectors manually
% h=figure(1)
% plot(R_sort,Vr_sort,'*')
%
% h= imrect;
% vert=wait(h);
% P=getPosition(h);
% outliers=excludedata(R_sort,Vr_sort,'box',[P(1),P(1)+P(3),P(2),P(2)+P(4)]);
% p=find(outliers==0);
% Vr_sort(p)=[];
% R_sort(p)=[];
%
% h= imrect;
% vert=wait(h);
% P=getPosition(h);
% outliers=excludedata(R_sort,Vr_sort,'box',[P(1),P(1)+P(3),P(2),P(2)+P(4)]);
% p=find(outliers==0);
% Vr_sort(p)=[];
% R_sort(p)=[];

%Calculate the mean velocity using Gaussian averaging (Function that
%Kinneret wrote)

[meany,lowerLine,upperLine,xval] = meanGaussianMM(R_sort,Vr_sort, 1);
[Nmeany] = NmeanGaussian(R_sort,Vr_sort, 1);
dr=0.5*step*calibration1;
N_ratio=Nmeany./(pi.*(xval+dr).^2-pi.*(xval-dr).^2)*4;
MaxN_ratio=max(N_ratio);

%%%% remove data points from meany that N_ratio < 0.5 - averaging on too
%%%% small number of vectors
if (DropRadius<calibration1*S*0.75)
    N_remove=find(N_ratio<(MaxN_ratio/2)); %%% changed on 13.8 to fit to drops that imaged only 1/4 of it size
%     N_remove=find(N_ratio<0.5);
    meany(N_remove)=[];
    xval(N_remove)=[];
    lowerLine(N_remove)=[];
    upperLine(N_remove)=[];
end

h=figure (2)

title('Vr(R)','FontSize',16)
xlabel('R[\mum]','FontSize',16)
ylabel('Vr[\mum/min]','FontSize',16)
savefig([ROI_folder,save_to_file,'STICS Vr Vs R.fig']);
saveas(h,[ROI_folder,save_to_file,'STICS Vr Vs R.tif']);

Rr=xval;
Vr=meany;

h=figure (3)
plot(R_sort_all,Vr_sort_all,'*','Color','r')
hold on
plot(R_sort,Vr_sort,'*','Color','b')
hold on
plot(Rr,Vr,'Color','k','LineWidth',2)
hold on
plot(Rr,lowerLine,'Color','k','LineWidth',1)
hold on
plot(Rr,upperLine,'Color','k','LineWidth',1)


title('Vr(R)','FontSize',16)
xlabel('R[\mum]','FontSize',16)
ylabel('Vr[\mum/min]','FontSize',16)
savefig([ROI_folder,save_to_file,'STICS Vr Vs R after removing.fig']);
saveas(h,[ROI_folder,save_to_file,'STICS Vr Vs R after removing.tif']);


%Plot average V vs R and save the figures:

h=figure (4);
plot(Rr,Vr,'Color','r','LineWidth',2)
hold on
plot(Rr,lowerLine,'Color','r','LineWidth',1)
hold on
plot(Rr,upperLine,'Color','r','LineWidth',1)


title('<Vr(R)>','FontSize',16)
xlabel('R[\mum]','FontSize',16)
xlim([ min(Rr) MaxRr])
ylabel('<Vr>[\mum/min]','FontSize',16)
savefig([ROI_folder,save_to_file,'STICS averageVr Vs R.fig']);
saveas(h,[ROI_folder,save_to_file,'STICS averageVr Vs R.tif']);

save([ROI_folder,'Rr.m'],'Rr');
save([ROI_folder,'lowerLine.m'],'lowerLine');
save([ROI_folder,'upperLine.m'],'upperLine');
save([ROI_folder,'Vr.m'],'Vr');
save([ROI_folder,'MaxRr.m'],'MaxRr');
save([ROI_folder,'Vtheta.m'],'Vtheta');

save([ROI_folder,'Vr_sort.m'],'Vr_sort');
save([ROI_folder,'R_sort.m'],'R_sort');


close all

end




