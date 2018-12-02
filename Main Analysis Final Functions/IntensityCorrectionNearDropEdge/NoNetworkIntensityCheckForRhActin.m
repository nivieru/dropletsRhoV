% slide_folder='C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_03_09\80% extract CP actin and LA\Mix1 15_15\z stack\';
% slide_folder='C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_03_23\80% extract CP actin and LA\Mix1 12_50\Montage images\';
% slide_folder='C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\Mix 2 15_20\';

slide_folder='C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\';

calibration=0.2054;

Dir=dir([slide_folder,'*tiff']);  %%% The movies here need to be 16bit
Size_Dir=size(Dir);
names_array={Dir.name};
movies_LA_channels=strfind(names_array,'_C1');
emptyCells_LA = cellfun(@isempty,movies_LA_channels);
Number_of_LA_movies=size(find(emptyCells_LA==0));
locations_of_LA_movies=find(emptyCells_LA==0);
% CaptureLA=struct;

movies_RhActin_channels=strfind(names_array,'_C2');
emptyCells_RhActin = cellfun(@isempty,movies_RhActin_channels);
Number_of_RhActin_movies=size(find(emptyCells_RhActin==0));
locations_of_RhActin_movies=find(emptyCells_RhActin==0);
% CaptureRhActin=struct;

movies_BF_channels=strfind(names_array,'_C0');
emptyCells_BF = cellfun(@isempty,movies_BF_channels);
Number_of_BF_movies=size(find(emptyCells_BF==0));
locations_of_BF_movies=find(emptyCells_BF==0);


k=1;
for i=1:Number_of_RhActin_movies(1,2)    

    CurrentMovie=locations_of_LA_movies(i);
    
    if (length(Dir(CurrentMovie).name)==17)
    Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9),'\'];
%     else Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    if (length(Dir(CurrentMovie).name)==18)
    Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    %%%% Long movie names are monatge movies
    
    if (length(Dir(CurrentMovie).name)==30)
    MontageMovie(k)=i;
    k=k+1;
    Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9),'\'];
    end
    
    if (length(Dir(CurrentMovie).name)==31)
    MontageMovie(k)=i;
    k=k+1;
    Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    mkdir(Capture(i).name)    
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'LA.tiff']);
    CurrentMovie=locations_of_RhActin_movies(i);
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'Rhodamine.tiff']);
    
    CurrentMovie=locations_of_BF_movies(i);
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'BF.tiff']);
    
end

save([slide_folder,'\Capture.mat'],'Capture');


% for i=1:length(MontageMovie)
%     
%     info=imfinfo([Capture(MontageMovie(i)).name,'LA.tiff']);
%     Size_info=size(info);
%     NumberOfFrames=Size_info(1,1);
%     
%     for k=1:NumberOfFrames
%         imagesLA{k}=imread([Capture(MontageMovie(i)).name,'LA.tiff'],k);
%         imagesRh{k}=imread([Capture(MontageMovie(i)).name,'Rhodamine.tiff'],k);
%         imagesBF{k}=imread([Capture(MontageMovie(i)).name,'BF.tiff'],k);
%     end
% %     [ montage ] = generate_montage( images ,N, M, lineOverlap, colOverlap, lineOffX, colOffY)
%      if (NumberOfFrames==4)
%          N=2;
%          M=2;
%      end     
% 
%      if (NumberOfFrames==6)
%          N=3;
%          M=2;
%      end
% 
%      if (NumberOfFrames==9)
%          N=3;
%          M=3;
%      end
%      
%      if (NumberOfFrames==12)
%          N=4;
%          M=3;
%      end
%      
%      if (NumberOfFrames==16)
%          N=4;
%          M=4;
%      end
%      
%      if (NumberOfFrames==20)
%          N=5;
%          M=4;
%      end
% 
% 
% %       N=3;
% %       M=NumberOfFrames/N;
% %       
% %       if (M==4);
% %           N=4;
% %           M=3;
% %       end
% 
%       [ montageLA ] = generate_montage( imagesLA ,N, M, 30, 30, -5, 10);
%       montageLA=uint16(montageLA);
%       imshow(montageLA,[])
%       imwrite(montageLA,[Capture(MontageMovie(i)).name,'LA.tiff']);
%       
%       [ montageRh ] = generate_montage( imagesRh ,N, M, 30, 30, -5, 10);
%       montageRh=uint16(montageRh);
%       imshow(montageRh,[])
%       imwrite(montageRh,[Capture(MontageMovie(i)).name,'Rhodamine.tiff']);
%       
%       [ montageBF ] = generate_montage( imagesBF ,N, M, 30, 30, -5, 10);
%       montageBF=uint16(montageBF);
%       imshow(montageBF,[])
%       imwrite(montageBF,[Capture(MontageMovie(i)).name,'BF.tiff']); 
% end

for i=1:length(Capture)  
    Capture_folder=Capture(i).name;
    MeasureDropSizeLAandActinV2(Capture_folder,calibration);
end

for i=1:length(Capture)  
    i
    Capture_folder=Capture(i).name;
%     MeasureDropSizeLAandActinV2(Capture_folder,calibration);
     pix_LA=double(imread([Capture_folder ,'LA.tiff'],15));
%    pix_LA=double(imread([Capture_folder ,'LA.tiff']));
    CalculateAverageRhoLAandActinV2(Capture_folder,calibration,pix_LA,'LA\')  
     pix_Rh=double(imread([Capture_folder ,'Rhodamine.tiff'],15));
%    pix_Rh=double(imread([Capture_folder ,'Rhodamine.tiff']));
    CalculateAverageRhoLAandActinV2(Capture_folder,calibration,pix_Rh,'Rh\')    
end

   
    
%     Capture1=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_22\80% extract CP actin and LA\Mix1 11_25\Capture.mat');
%     Capture2=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_22\80% extract CP actin and LA\Mix1 11_50\Capture.mat');
%     Capture3=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_22\80% extract CP actin and LA\Mix1 12_40\Capture.mat');
%     Capture4=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\Mix 2 15_20\Capture.mat');

    Capture1=importdata('C:\Users\Maya\Documents\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_22\80% extract CP actin and LA\Mix1 11_25\Capture.mat');
    Capture2=importdata('C:\Users\Maya\Documents\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_22\80% extract CP actin and LA\Mix1 11_50\Capture.mat');
    Capture3=importdata('C:\Users\Maya\Documents\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_22\80% extract CP actin and LA\Mix1 12_40\Capture.mat');
    Capture4=importdata('C:\Users\Maya\Documents\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\Mix 2 15_20\Capture.mat');


    Capture=[Capture1,Capture2,Capture3,Capture4];

%%%%% 
Capture=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\Capture.mat');

h=figure    
figure
     for i=1:length(Capture)
    %Capture_folder=Capture(i).name;
    Capture_folder=[Capture(i).name(1:14),'Documents\',Capture(i).name(23:end)];
    
    Capture(i).Rho=importdata([Capture_folder,'Rh\Rho\Rho.mat']);
    MaxRho=max(max(Capture(i).Rho));
    Capture(i).Rrho=importdata([Capture_folder,'Rh\Rho\Rrho.mat']);
    Capture(i).Rdrop=importdata([Capture_folder,'Analysis parameters\DROP_radius.mat']);
    place=find(Capture(i).Rrho<Capture(i).Rdrop+10);
    Rho_Rdrop10=Capture(i).Rho(end);
    Rho=Capture(i).Rho-Rho_Rdrop10;
    Capture(i).RhoNorm=Rho/mean(Rho(1:40));
    Capture(i).MeanRho=mean(Capture(i).Rho(1:40));
%     plot(Capture(i).Rrho,Capture(i).Rho)
%     hold on
    
%   place=max(find(Capture(i).RhoNorm>0.5));
%   place2=min(find(Capture(i).Rrho>Capture(i).Rdrop+10));
%   plot(Capture(i).Rrho-Capture(i).Rrho(place),Capture(i).RhoNorm)
     
    Capture(i).RforCorr=[Capture(i).Rrho(1):0.5:Capture(i).Rrho(end)];
    Capture(i).RhoforCorr=interp1(Capture(i).Rrho,Capture(i).RhoNorm,Capture(i).RforCorr);  
    plot(Capture(i).RforCorr,Capture(i).RhoforCorr)
    hold on
   end
    
xlabel('R/R_d_r_o_p','FontSize',16)
ylabel('<\rho>/\rho_m_a_x','FontSize',16)
% savefig([slide_folder,'All Average Rho profiles.fig']);
% saveas(h,[slide_folder,'All Average Rho profiles.tiff']);

figure

for i=1:length(Capture)   
Capture(i).RrhoTran=Capture(i).RforCorr-Capture(i).Rdrop;
plot(Capture(i).RrhoTran,Capture(i).RhoforCorr)
% Capture(i).RrhoTran=Capture(i).Rrho-Capture(i).Rdrop;
% plot(Capture(i).RrhoTran,Capture(i).RhoNorm)
hold on
end
% close all

figure
[meany,lowerLine,upperLine,xval] = meanGaussianMM([Capture.RrhoTran],[Capture.RhoforCorr], 1);
close

hold on
plot(xval,meany,'Color','k','LineWidth',3)
place1=max(find(xval<-40));
place2=min(find(xval>30));
xvalForCorr=xval(place1):0.5:xval(place2);
meanyForCorr=interp1(xval,meany,xvalForCorr);
figure
hold on
plot(xvalForCorr,meanyForCorr,'Linewidth',3,'Color','k')


%%%%Calculate the cross-correlation function

figure

for i=1:length(Capture)
    
C=xcorr(meanyForCorr-mean(meanyForCorr),[ones(1,100),Capture(i).RhoforCorr,zeros(1,100)]-mean(Capture(i).RhoforCorr));
plot(C)
hold on
MAX_Corr_place(i)=find(C==max(C));
Length_Corr(i)=length(C);
dr(i)=(Length_Corr(i)/2-MAX_Corr_place(i))*0.5;

end


%%% Plot the original profiles
figure
for i=1:length(Capture) 
plot(Capture(i).RforCorr,Capture(i).RhoforCorr);
hold on
end

%%% Plot the profiles after translation
h=figure
for i=1:length(Capture)
Capture(i).RtransAfterCorr=Capture(i).Rrho-dr(i);
plot(Capture(i).Rrho-dr(i),Capture(i).RhoNorm)
hold on
end

%%% Calculating the average profile after the translation by
%%% cross-correlation function

figure
[meanyAftherCorr,lowerLineAftherCorr,upperLineAftherCorr,xvalAftherCorr] = meanGaussianMM([Capture.RtransAfterCorr],[Capture.RhoNorm], 1);
close

% hold on
% figure
% plot(xval,meany,'Color','r','LineWidth',3)
hold on
plot(xvalAftherCorr,meanyAftherCorr,'Color','k','LineWidth',3)


%%%% SAVE THE AVERAGE PROFILE
folder=[slide_folder(1:14),'Documents\',slide_folder(23:end),'Actin Correction'];
mkdir(folder)

save([slide_folder,'Actin Correction\AverageProfileX.mat'],'xvalAftherCorr');
save([slide_folder,'Actin Correction\AverageProfileY.mat'],'meanyAftherCorr');

% save([slide_folder,'Actin Correction\AverageProfileX.mat'],'xvalAftherCorr');
% save([slide_folder,'Actin Correction\AverageProfileY.mat'],'meanyAftherCorr');
 

%%%% Divide the profiles by the average profile. 

for i=1:length(Capture)

DropRadius=Capture(i).Rdrop;
Rrho=Capture(i).Rrho;
RhoNorm=Capture(i).RhoNorm;

placeStart=max(find(xvalAftherCorr+dr(i)<Rrho(1)));
placeEnd=max(find(xvalAftherCorr+dr(i)<Rrho(end)));
new=interp1(xvalAftherCorr(placeStart:placeEnd)+dr(i),meanyAftherCorr(placeStart:placeEnd),Rrho);

figure
plot(Rrho,RhoNorm./new,'g')
hold on
plot(Rrho,RhoNorm,'r')
hold on 
plot(DropRadius*ones(21),[0:0.05:1],'b')
grid on
plot(xvalAftherCorr+dr(i),meanyAftherCorr,'Color','k','LineWidth',3)

Capture(i).IatR=RhoNorm(max(find(Rrho<DropRadius)));

end

close all

save([slide_folder,'\Capture.mat'],'Capture');


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Rho=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 15\Rho\Rho.m');
% Rrho=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 15\Rho\Rrho.m');
% DropRadius=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 15\Analysis parameters\DROP_radius.m');
% NetworkRadius=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 15\Analysis parameters\ACTIN_NETWORK_radius.m');
% 
% Rho=Rho-1028;
% 
% 
% % RhoNorm=Rho-Rho(end);
% % RhoNorm=RhoNorm/max(max(RhoNorm));
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BY MEAN
% 
% placeEnd=min(find(meanyAftherCorr<0.25));
% ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-DropRadius);
% ProfileY=meanyAftherCorr(1:placeEnd);
% removeRbiggerThanRdrop=find(Rrho>DropRadius);
% RhoDilute=Rho;
% RrhoDilute=Rrho;
% RhoDilute(removeRbiggerThanRdrop)=[];
% RrhoDilute(removeRbiggerThanRdrop)=[];
% 
% % figure
% % plot(RrhoDilute,RhoDilute)
% % hold on
% % plot(ProfileX,ProfileY)
% 
% newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
% 
% h=figure
% plot(RrhoDilute,(RhoDilute./newProfileY),'g')
% hold on
% plot(RrhoDilute,RhoDilute,'r')
% title('MEAN')
% savefig([slide_folder,'Drop15 MEAN.fig']);
% saveas(h,[slide_folder,'Drop15 MEAN.tif']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BY MIN
% 
% placeEnd=min(find(meanyAftherCorr<0.11));
% ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-DropRadius);
% ProfileY=meanyAftherCorr(1:placeEnd);
% removeRbiggerThanRdrop=find(Rrho>DropRadius);
% RhoDilute=Rho;
% RrhoDilute=Rrho;
% RhoDilute(removeRbiggerThanRdrop)=[];
% RrhoDilute(removeRbiggerThanRdrop)=[];
% 
% % figure
% % plot(RrhoDilute,RhoDilute)
% % hold on
% % plot(ProfileX,ProfileY)
% 
% newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
% 
% h=figure
% plot(RrhoDilute,(RhoDilute./newProfileY),'g')
% hold on
% plot(RrhoDilute,RhoDilute,'r')
% title('MIN')
% savefig([slide_folder,'Drop15 MIN.fig']);
% saveas(h,[slide_folder,'Drop15 MIN.tif']);
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BY MAX
% 
% placeEnd=min(find(meanyAftherCorr<0.49));
% ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-DropRadius);
% ProfileY=meanyAftherCorr(1:placeEnd);
% removeRbiggerThanRdrop=find(Rrho>DropRadius);
% RhoDilute=Rho;
% RrhoDilute=Rrho;
% RhoDilute(removeRbiggerThanRdrop)=[];
% RrhoDilute(removeRbiggerThanRdrop)=[];
% 
% % figure
% % plot(RrhoDilute,RhoDilute)
% % hold on
% % plot(ProfileX,ProfileY)
% 
% newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
% 
% h=figure
% plot(RrhoDilute,(RhoDilute./newProfileY),'g')
% hold on
% plot(RrhoDilute,RhoDilute,'r')
% title('MAX')
% savefig([slide_folder,'Drop15 MAX.fig']);
% saveas(h,[slide_folder,'Drop15 MAX.tif']);
% 
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Determine the best starting point with a loop 

Rho=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 10\Rho\Rho.m');
Rrho=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 10\Rho\Rrho.m');
DropRadius=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 10\Analysis parameters\DROP_radius.m');
NetworkRadius=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Silvia visit\2016_10_26\80per_buffer\Sample time 11_40\Capture 10\Analysis parameters\ACTIN_NETWORK_radius.m');

Rho=Rho-1028;

placeMIN=min(find(meanyAftherCorr<0.1));
placeMAX=min(find(meanyAftherCorr<0.6));
k=placeMAX;

for i=1:(placeMIN-placeMAX)

RhoDilute=Rho;
RrhoDilute=Rrho;
    
placeEnd=k;
ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-DropRadius);
ProfileY=meanyAftherCorr(1:placeEnd);
removeRbiggerThanRdrop=find(Rrho>DropRadius);
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
newRho=RhoDilute./newProfileY;

RnetworkPlace=max(find(RrhoDilute<NetworkRadius));
p=polyfit(RrhoDilute(RnetworkPlace:end)',newRho(RnetworkPlace:end)',1);
SlopeVrVSr=p(1);
d(i)=abs(SlopeVrVSr);
LinearFit=p(1)*RrhoDilute(RnetworkPlace:end)'+p(2);
d2(i)=abs(LinearFit(end)-newRho(end))
% d(i)=abs(newRho(end)-newRho(RnetworkPlace));

h=figure
plot(RrhoDilute,(RhoDilute./newProfileY),'g')
hold on
plot(RrhoDilute,RhoDilute,'r')
hold on
plot(RrhoDilute(RnetworkPlace:end)',p(1)*RrhoDilute(RnetworkPlace:end)'+p(2),'k')
% title('Best')
% savefig([slide_folder,'Drop15 MIN.fig']);
% saveas(h,[slide_folder,'Drop15 MIN.tif']);

k=k+1;

end

% BestPlace=placeMAX+find(d==min(d))-1;
BestPlace=placeMAX+find(d2==min(d2))-1;
placeEnd=BestPlace;

RhoDilute=Rho;
RrhoDilute=Rrho;
    
ProfileX=xvalAftherCorr(1:placeEnd)-(xvalAftherCorr(placeEnd)-DropRadius);
ProfileY=meanyAftherCorr(1:placeEnd);
removeRbiggerThanRdrop=find(Rrho>DropRadius);
RhoDilute(removeRbiggerThanRdrop)=[];
RrhoDilute(removeRbiggerThanRdrop)=[];
newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
newRho=RhoDilute./newProfileY;
RnetworkPlace=max(find(RrhoDilute<NetworkRadius));

MonomersBackground=mean(newRho(RnetworkPlace:end));
newRhoNetwork=newRho-MonomersBackground;

h=figure
% plot(RrhoDilute,newRhoNetwork,'g')
plot(RrhoDilute,newRho,'g')
hold on
plot(RrhoDilute,RhoDilute,'r')
title('Best')
savefig([slide_folder,'Drop15 BEST Network.fig']);
saveas(h,[slide_folder,'Drop15 BEST Network.tif']);




% %%%%%%%%%%%%%%%% MY COMMENTS
% 
% up=[1,2,3,5,6,23,24,30,40,43,44,46,47];
% CaptureR=[Capture.Rdrop];
% UpR=CaptureR(up);
% down=[9,12,14,15,16,17,32,33,34,35];
% DownR=CaptureR(down);
% 
% figure (51)
% plot(UpR,'*','Color','r')
% hold on
% plot(DownR,'*','Color','b')