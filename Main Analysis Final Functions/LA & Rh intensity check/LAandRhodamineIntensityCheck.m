%%%%% This function calculate the network and monomers intensity

slide_folder='C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_02_13\80% extract Rhodamine actin & LA GFP\Mix1 13_40\';
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
    
    if (length(Dir(CurrentMovie).name)==30)
    MontageMovie(k)=i;
    k=k+1;
    Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9),'\'];
    end
    
    %%%% Montage movies name's are longer
    
    if (length(Dir(CurrentMovie).name)==31)
    MontageMovie(k)=i;
    k=k+1;
    Capture(i).name=[slide_folder,'Capture ',Dir(CurrentMovie).name(9:10),'\'];
    end
    
    mkdir(Capture(i).name)    
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'LA.tiff']);
    CurrentMovie=locations_of_RhActin_movies(i);
    copyfile([slide_folder Dir(CurrentMovie).name],[Capture(i).name,'Rhodamine.tiff']);
    
end

save([slide_folder,'\Capture.mat'],'Capture');

%%%% Run over all monage movies to build the monage 

for i=1:length(MontageMovie)
    
    info=imfinfo([Capture(MontageMovie(i)).name,'LA.tiff']);
    Size_info=size(info);
    NumberOfFrames=Size_info(1,1);
    
    for k=1:NumberOfFrames
        imagesLA{k}=imread([Capture(MontageMovie(i)).name,'LA.tiff'],k);
        imagesRh{k}=imread([Capture(MontageMovie(i)).name,'Rhodamine.tiff'],k);
    end
%     [ montage ] = generate_montage( images ,N, M, lineOverlap, colOverlap, lineOffX, colOffY)
     if (NumberOfFrames==4)
         N=2;
         M=2;
     end     

     if (NumberOfFrames==6)
         N=3;
         M=2;
     end

     if (NumberOfFrames==9)
         N=3;
         M=3;
     end
     
     if (NumberOfFrames==12)
         N=4;
         M=3;
     end
     
     if (NumberOfFrames==16)
         N=4;
         M=4;
     end


%       N=3;
%       M=NumberOfFrames/N;
%       
%       if (M==4);
%           N=4;
%           M=3;
%       end

      [ montageLA ] = generate_montage( imagesLA ,N, M, 30, 30, -5, 10);
      montageLA=uint16(montageLA);
      imshow(montageLA,[])
      imwrite(montageLA,[Capture(MontageMovie(i)).name,'LA.tiff']);
      
      [ montageRh ] = generate_montage( imagesRh ,N, M, 30, 30, -5, 10);
      montageRh=uint16(montageRh);
      imshow(montageRh,[])
      imwrite(montageRh,[Capture(MontageMovie(i)).name,'Rhodamine.tiff']);    
end

%%%% Run over all the moveis and calculate Rho(R)

for i=1:length(Capture)  
    Capture_folder=Capture(i).name;
%     MeasureDropSizeLAandActinV(Capture_folder,calibration);
    pix_LA=double(imread([Capture_folder ,'LA.tiff']));
    CalculateAverageRhoLAandActinV(Capture_folder,calibration,pix_LA,'LA\')  
    pix_Rh=double(imread([Capture_folder ,'Rhodamine.tiff']));
    CalculateAverageRhoLAandActinV(Capture_folder,calibration,pix_Rh,'Rh\')    
end

for i=2:length(Capture)
Capture_folder=Capture(i).name;
NoLabelBack=1109;
AverageProfileX=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\AverageProfileX.mat');
AverageProfileY=importdata('C:\Users\Maya\Desktop\Maya analysis\Bulk\copy yo server\Actin & LA labeling\2017_06_21\80% extract CP actin and LA\AverageProfileY.mat');
close all
rmdir ([Capture_folder,'Rho\'],'s')
IntensityCorrectionNearDropEdgeLAandActinV(Capture_folder,AverageProfileX,AverageProfileY,NoLabelBack)
end
       
%%%%PLOTS

% % for i=1:length(Capture)
% % % for i=1:11
% %     Capture_folder=Capture(i).name;
% %     RhoLA=importdata([Capture_folder,'LA\Rho\Rho.mat']);
% %     RhoBachgroungLA=importdata([Capture_folder,'LA\Rho\Rho_background.mat']);
% %     RrhoLA=importdata([Capture_folder,'LA\Rho\Rrho.mat']);
% %     
% %     RhoRh=importdata([Capture_folder,'Rh\Rho\Rho.mat']);
% %     RhoBachgroungRh=importdata([Capture_folder,'Rh\Rho\Rho_background.mat']);
% %     RrhoRh=importdata([Capture_folder,'Rh\Rho\Rrho.mat']);
% %     
% %     DROP_radius=importdata([Capture_folder,'Analysis parameters\','DROP_radius.mat']);
% %     ACTIN_NETWORK_radius=importdata([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_radius.mat']);
% %     CHUNK_radius=importdata([Capture_folder,'Analysis parameters\','CHUNK_radius.mat']);
% %     r=ones(1,12);
% %     y=[0:0.1:1.1];
% %     
% %     h=figure (1)
% %     %plot(RrhoLA,RhoLA/max(max(RhoLA)),'r')
% %     plot(RrhoLA,RhoLA,'r')
% %     hold on
% %     %plot(RrhoRh,RhoRh/max(max(RhoRh)),'g')
% %     plot(RrhoRh,RhoRh,'g')
% %     hold on
% %     plot(r*DROP_radius,y,'-')
% %     hold on
% %     plot(r*ACTIN_NETWORK_radius,y,'-')
% %     hold on
% %     plot(r*CHUNK_radius,y,'-')
% %     title('No background subtraction')
% %     
% %     savefig([Capture_folder,'AverageRho No back-subtraction.fig']);
% %     saveas(h,[Capture_folder,'AverageRho No back-subtraction.tiff']);
% %     
% %     r=ones(1,22);
% %     y=[-1:0.1:1.1];
% %     
% %     h=figure (2)
% %     %plot(RrhoLA,RhoBachgroungLA/max(max(RhoBachgroungLA)),'r')
% %     plot(RrhoLA,RhoBachgroungLA,'r')
% %     hold on
% %     %plot(RrhoRh,RhoBachgroungRh/max(max(RhoBachgroungRh)),'g')
% %     plot(RrhoRh,RhoBachgroungRh,'g')
% %     hold on
% %     plot(r*DROP_radius,y,'-')
% %     hold on
% %     plot(r*ACTIN_NETWORK_radius,y,'-')
% %     hold on
% %     plot(r*CHUNK_radius,y,'-')
% %     title('Include background subtraction')
% %     
% %     savefig([Capture_folder,'AverageRho include back-subtraction.fig']);
% %     saveas(h,[Capture_folder,'AverageRho include back-subtraction.tiff']);
% %     
% %     close all
% %    
% % end


%%%%Calculate F/G for rhodamine


for i=1:length(Capture)
    close all
    Capture_folder=Capture(i).name;
    
    DROP_radius=importdata([Capture_folder,'Analysis parameters\','DROP_radius.mat']);
    ACTIN_NETWORK_radius=importdata([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_radius.mat']);
    CHUNK_radius=importdata([Capture_folder,'Analysis parameters\','CHUNK_radius.mat']);
    MinRr=importdata([Capture_folder,'Analysis parameters\','MinRr.mat']);
%     internal_BeckgroundRh(i)=importdata([Capture_folder,'Rh\Rho\','internal_Beckground.mat']);
    
    RhoRh=importdata([Capture_folder,'Rh\Rho\Rho.mat']);
%     RhoRh=RhoRh-1327;
    au_gauge=37483;
%     RhoBackgroungRh=importdata([Capture_folder,'Rh\Rho\Rho_background.mat']);
    RrhoRh=importdata([Capture_folder,'Rh\Rho\Rrho.mat']);
    
    
    %     DROP_radius=importdata([Capture_folder,'Analysis parameters\','DROP_radius.m']);
    %     ACTIN_NETWORK_radius=importdata([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_radius.m']);
    %     CHUNK_radius=importdata([Capture_folder,'Analysis parameters\','CHUNK_radius.m']);
    %     MinRr=importdata([Capture_folder,'Analysis parameters\','MinRr.m']);
    %     internal_BeckgroundRh(i)=importdata([Capture_folder,'Rh\Rho\','internal_Beckground.mat']);
    %
    %     G(i)=internal_BeckgroundRh(i)*( (4/3)*pi*(ACTIN_NETWORK_radius^3-CHUNK_radius^3));
    %
    %     %%%Total F
    %     RhoRh=importdata([Capture_folder,'Rh\Rho\Rho.m']);
    %     RhoRh=RhoRh-1327;
    %     RhoBackgroungRh=importdata([Capture_folder,'Rh\Rho\Rho_background.m']);
    %     RrhoRh=importdata([Capture_folder,'Rh\Rho\Rrho.m']);
    %
    
    MaxRr= DROP_radius;
    
    range=[MinRr MaxRr];
    
    small=find(RrhoRh<MinRr);
    RrhoRh(small)=[];
    RhoRh(small)=[];
%     RhoBackgroungRh(small)=[];
    big=find(RrhoRh>MaxRr);
    RrhoRh(big)=[];
    RhoRh(big)=[];
%     RhoBackgroungRh(big)=[];
    
%     Irr=RhoBackgroungRh.*(RrhoRh.^2)*4*pi;
%     
    %%% V(r) for 5uM data - V(r)=-1.2*r+6
    Vr=zeros(1,length(RhoRh));
    for t=1:length(RhoRh)
        Vr(t)=-1.2*RrhoRh(t)+6;
    end
    dRhoRh=diff(RhoRh);
    dRrhoRh=diff(RrhoRh);
    dRho_dR=diff(RhoRh)./diff(RrhoRh);
    
    S=length(dRho_dR);
    RhoN=zeros(1,S);
    alfa=0;
    dr=RrhoRh(2)-RrhoRh(1);
    
    for i=1:S
        k=S-i+1;
        C=( (Vr(k)*dr)/(15*60) )-1;
        RhoN(k)= ( dRhoRh(k) - alfa )/C;
        alfa=RhoN(k);
    end
    
    RhoD=RhoRh(1:end-1)-RhoN;
    dg=diff(RhoD);
    
    h=figure
    plot(RrhoRh,RhoRh/au_gauge,'b','LineWidth',3)
    hold on
    plot(RrhoRh(1:end-1),RhoN/au_gauge,'r','LineWidth',3)
    hold on
    plot(RrhoRh(1:end-1),RhoD/au_gauge,'y','LineWidth',3)
    hold on
    legend('Total Rho','RhoN','RhoD')
    xlabel('R[\mum]','FontSize',18)
    ylabel('\rho[a.u]','FontSize',18)
    
    mkdir([Capture_folder,'Rh figures/'])
    savefig([Capture_folder,'Rh figures/F G & vs R.fig']);
    saveas(h,[Capture_folder,'Rh figures/F G & vs R.tiff']);
    
    save([Capture_folder,'Analysis parameters\RhoN_Rh.mat'],'RhoN');
    save([Capture_folder,'Analysis parameters\RhoD_Rh.mat'],'RhoD');
    
    
%     %%%%% I will calcuate RhoN if we will consider some boundary condition on
%     %%%%% the blob edge
%     
%     InitialGaussForBeta=ceil(max(max(RhoRh)));
%     NoOfBetaPoint=ceil(InitialGaussForBeta/10000)-1;
%     
%     RhoN_BoundaryAtTheBlob=zeros(1,S);
%     RhoForDiffBeta=zeros(NoOfBetaPoint,S);
%     %beta=0;
%     index=1;
%     
%     for beta=(InitialGaussForBeta/10):10000:InitialGaussForBeta;
%         
%         %beta=3000;
%         RhoN_BoundaryAtTheBlob(1)=beta;
%         
%         for i=2:S
%             C=( (Vr(i)*dr)/(15*60) )-1;
%             RhoN_BoundaryAtTheBlob(i)=dRhoRh(i)-C*beta ;
%             beta=RhoN_BoundaryAtTheBlob(i);
%         end
%         
%         plot(RrhoRh(1:end-1),RhoN_BoundaryAtTheBlob/au_gauge)
%         
%         BETA(index)=beta;
%         RhoForDiffBeta(index,:)=RhoN_BoundaryAtTheBlob;
%         index=index+1;
%         
%     end
%     
%     h=figure
%     plot(RrhoRh,RhoRh/au_gauge,'b','LineWidth',3)
%     hold on
%     plot(RrhoRh(1:end-1),RhoForDiffBeta/au_gauge)
%     legend('Total Rho')
%     xlabel('R[\mum]','FontSize',18)
%     ylabel('\rho[a.u]','FontSize',18)
%     
%     savefig([Capture_folder,'Rh figures/F for b_c & vs R.fig']);
%     saveas(h,[Capture_folder,'Rh figures/F for b_c & vs R.tiff']);
%     
%     save([Capture_folder,'Analysis parameters\RhoForDiffBeta_Rh.mat'],'RhoForDiffBeta');
%     close all
end


%%%%Calculate F/G for LA
%%%% 13/7/17 change - read the corrected files

for i=2:length(Capture)
    close all
    Capture_folder=Capture(i).name;
    
    DROP_radius=importdata([Capture_folder,'Analysis parameters\','DROP_radius.mat']);
    ACTIN_NETWORK_radius=importdata([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_radius.mat']);
    CHUNK_radius=importdata([Capture_folder,'Analysis parameters\','CHUNK_radius.mat']);
    MinRr=importdata([Capture_folder,'Analysis parameters\','MinRr.mat']);
%     internal_BeckgroundLA(i)=importdata([Capture_folder,'LA\Rho\','internal_Beckground.mat']);
    
    RhoLA=importdata([Capture_folder,'LA\Rho\CorrectedRho.mat']);
    
    %au_gauge=1;
    au_gauge=5432;
%     RhoBackgroungLA=importdata([Capture_folder,'LA\Rho\Rho_background.mat']);
    RrhoLA=importdata([Capture_folder,'LA\Rho\RrhoDilute.mat']);
    
    
    %     DROP_radius=importdata([Capture_folder,'Analysis parameters\','DROP_radius.m']);
    %     ACTIN_NETWORK_radius=importdata([Capture_folder,'Analysis parameters\','ACTIN_NETWORK_radius.m']);
    %     CHUNK_radius=importdata([Capture_folder,'Analysis parameters\','CHUNK_radius.m']);
    %     MinRr=importdata([Capture_folder,'Analysis parameters\','MinRr.m']);
    %     internal_BeckgroundRh(i)=importdata([Capture_folder,'Rh\Rho\','internal_Beckground.mat']);
    %
    %     G(i)=internal_BeckgroundRh(i)*( (4/3)*pi*(ACTIN_NETWORK_radius^3-CHUNK_radius^3));
    %
    %     %%%Total F
    %     RhoRh=importdata([Capture_folder,'Rh\Rho\Rho.m']);
    %     RhoRh=RhoRh-1327;
    %     RhoBackgroungRh=importdata([Capture_folder,'Rh\Rho\Rho_background.m']);
    %     RrhoRh=importdata([Capture_folder,'Rh\Rho\Rrho.m']);
    %
    
    MaxRr= DROP_radius;
    
    range=[MinRr MaxRr];
    
    small=find(RrhoLA<MinRr);
    RrhoLA(small)=[];
    RhoLA(small)=[];
%     RhoBackgroungLA(small)=[];
    big=find(RrhoLA>MaxRr);
    RrhoLA(big)=[];
    RhoLA(big)=[];
%     RhoBackgroungLA(big)=[];
    
%     Irr=RhoBackgroungLA.*(RrhoLA.^2)*4*pi;
    
    %%% V(r) for 5uM data - V(r)=-1.2*r+6
    Vr=zeros(1,length(RhoLA));
    for t=1:length(RhoLA)
        Vr(t)=-1.2*RrhoLA(t)+6;
    end
    
    dRhoLA=diff(RhoLA);
    
    S=length(dRhoLA);
    RhoN=zeros(1,S);
    alfa=0;
    dr=RrhoLA(2)-RrhoLA(1);
    
    for i=1:S
        k=S-i+1;
        C=( (Vr(k)*dr)/(15*60) )-1;
        RhoN(k)= ( dRhoLA(k) - alfa )/C;
        alfa=RhoN(k);
    end
    
    RhoD=RhoLA(1:end-1)-RhoN;
    dg=diff(RhoD);
    
    h=figure
    plot(RrhoLA,RhoLA/au_gauge,'b','LineWidth',3)
    hold on
    plot(RrhoLA(1:end-1),RhoN/au_gauge,'r','LineWidth',3)
    hold on
    plot(RrhoLA(1:end-1),RhoD/au_gauge,'y','LineWidth',3)
    hold on
    legend('Total Rho','RhoN','RhoD')
    xlabel('R[\mum]','FontSize',18)
    ylabel('\rho[a.u]','FontSize',18)
    
    mkdir([Capture_folder,'LA figures/'])
    savefig([Capture_folder,'LA figures/F G & vs R.fig']);
    saveas(h,[Capture_folder,'LA figures/F G & vs R.tiff']);
    
    save([Capture_folder,'Analysis parameters\RhoN_LA.mat'],'RhoN');
    save([Capture_folder,'Analysis parameters\RhoD_LA.mat'],'RhoD');
    
    
%     %%%%% I will calcuate RhoN if we will consider some boundary condition on
%     %%%%% the blob edge
%     
%     InitialGaussForBeta=ceil(max(max(RhoLA)));
%     NoOfBetaPoint=ceil(InitialGaussForBeta/1000)-1;
%     
%     RhoN_BoundaryAtTheBlob=zeros(1,S);
%     RhoForDiffBeta=zeros(NoOfBetaPoint,S);
%     %beta=0;
%     index=1;
%     
%     for beta=(InitialGaussForBeta/10):1000:InitialGaussForBeta;
%         
%         %beta=3000;
%         RhoN_BoundaryAtTheBlob(1)=beta;
%         
%         for i=2:S
%             C=( (Vr(i)*dr)/(15*60) )-1;
%             RhoN_BoundaryAtTheBlob(i)=dRhoLA(i)-C*beta ;
%             beta=RhoN_BoundaryAtTheBlob(i);
%         end
%         
%         plot(RrhoLA(1:end-1),RhoN_BoundaryAtTheBlob/au_gauge)
%         
%         BETA(index)=beta;
%         RhoForDiffBeta(index,:)=RhoN_BoundaryAtTheBlob;
%         index=index+1;
%         
%     end
%     
%     h=figure
%     plot(RrhoLA,RhoLA/au_gauge,'b','LineWidth',3)
%     hold on
%     plot(RrhoLA(1:end-1),RhoForDiffBeta/au_gauge)
%     legend('Total Rho')
%     xlabel('R[\mum]','FontSize',18)
%     ylabel('\rho[a.u]','FontSize',18)
%     
%     savefig([Capture_folder,'LA figures/F for b_c & vs R.fig']);
%     saveas(h,[Capture_folder,'LA figures/F for b_c & vs R.tiff']);
%     
%     save([Capture_folder,'Analysis parameters\RhoForDiffBeta_LA.mat'],'RhoForDiffBeta');
%     close all
end




% % RhoFinitial(1)=max(max(RhoRh));
% RhoFinitial(1)=RhoRh(1);
% 
% AllR=0;
% AllRhoF=0;
% 
%     for i=1:length(RrhoRh)-1
%         
%         [ r, RhoF]=ode45(@(r, RhoF) myODE( r, RhoF,dRho_dR(i),Vr(i)),[ RrhoRh(i) RrhoRh(i+1) ], RhoFinitial(i));
%         RhoFinitial(i+1)= RhoF(length(RhoF),1);
% 
%         AllR=[AllR;r];
%         AllRhoF=[AllRhoF;RhoF];
%            
%     end
%     
% plot(AllR(:),AllRhoF(:),'*')
% xlim(range)
% hold on
% plot(RrhoRh,RhoRh)
% 
% interp_RhoRh=interp1(RrhoRh,RhoRh,AllR);
% hold on
% plot(AllR,interp_RhoRh-AllRhoF)
% 
% 
% interp_dRho_dR=interp1(RrhoRh(1:end-1),dRho_dR,AllR);
% interp_Vr=interp1(RrhoRh(1:end-1),Vr(1:end-1),AllR);
% dAllRhoF=diff(AllRhoF);
% dr=RrhoRh(2)-RrhoRh(1);
% 
% ZERO=dAllRhoF/dr-interp_dRho_dR(1:end-1)-interp_Vr(1:end-1).*AllRhoF(1:end-1)/(15*60);

