%%%%%% Maya Malik Garbi 3.7.2017
%%%%%% General description: this function take original intensity profile
%%%%%% (Rho) and divide it by average intensity profile(AverageProfileX,AverageProfileY) to corrected
%%%%%% optical decrese in the intensity near the drop adge.
%%%%%% The average intensity profile was computed in function 'NoNetworkIntensityCheck.m'
%%%%%% based on experiments were done on 21/22.2017. In the experiments I imaged the
%%%%%% intensity of approx. 50 droplets. The energy mix was done with Life act and Rhodamine actin without
%%%%%% energy mix and Capping Protein for preventing the network formation.


function IntensityCorrectionNearDropEdgeBySectors(Capture_folder,AverageProfileX,AverageProfileY)

% AverageRhoVsRbySectors=importdata([Capture_folder,'Rho\AverageRhoVsRbySectors.mat']);
% DropRadius=importdata([Capture_folder,'Analysis parameters\DROP_radius.m']);
% NetworkRadius=importdata([Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m']);

 for i=1:length(Capture)
    
    Capture_folder=Capture(i).name;
    Capture(i).Rho=importdata([Capture_folder,'LA\Rho\Rho.mat']);
    MaxRho=max(max(Capture(i).Rho));
    Capture(i).Rrho=importdata([Capture_folder,'LA\Rho\Rrho.mat']);
    Capture(i).Rdrop=importdata([Capture_folder,'Analysis parameters\DROP_radius.mat']);
    Capture(i).Rnetwork=importdata([Capture_folder,'Analysis parameters\DROP_radius.mat']);




xvalAftherCorr=AverageProfileX;
meanyAftherCorr=AverageProfileY;

placeMIN=min(find(meanyAftherCorr<0.25));
placeMAX=min(find(meanyAftherCorr<0.6));
placeMEAN=min(find(meanyAftherCorr<0.25));   %%%%% I=0.25 is the mean intensity value at Rdrop averged over 50 drops.
placeMINx=xvalAftherCorr(placeMIN);
placeMAXx=xvalAftherCorr(placeMAX);
pleaceMEANx=xvalAftherCorr(placeMEAN);


% for index=1:length(AverageRhoVsRbySectors)
    
    Rho=Capture(i).Rho;
    Rrho=Capture(i).Rrho;
    DropRadius=Capture(i).Rdrop;
    
%     Rho=AverageRhoVsRbySectors(index).AvgRho;
%     Rrho=AverageRhoVsRbySectors(index).AvgRrho;
    
    RhoDilute=Rho;
    RrhoDilute=Rrho;
    
    %%%% charch the maximum of d_RhoDilute (minimum of negative function) and
    %%%% define it as the edge of the drop.
    DropRdiusPlace=max(find(RrhoDilute<DropRadius));
    d_RhoDilute=diff(RhoDilute);
    Min_d_RhoDilutePlace=find(d_RhoDilute==min(d_RhoDilute((DropRdiusPlace-40):end)));
%     effectiveRplace=Min_d_RhoDilutePlace;
%     effectiveR=RrhoDilute(effectiveRplace);

effectiveRplace=max(find(RrhoDilute<DropRadius));
effectiveR=RrhoDilute(effectiveRplace);
    
    dr=10;
    h=figure
    
    
        for i=1:(dr/0.25)
            
            RhoDilute=Rho;
            RrhoDilute=Rrho;
            Rpoint=effectiveR-(dr/2)+i*0.25;
            ProfileX=xvalAftherCorr(1:placeMIN)-(xvalAftherCorr(placeMIN)-Rpoint);
            ProfileY=meanyAftherCorr(1:placeMIN);
            removeRbiggerThanRdrop=find(Rrho>Rpoint);
            RhoDilute(removeRbiggerThanRdrop)=[];
            RrhoDilute(removeRbiggerThanRdrop)=[];
            newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
            newRho=RhoDilute./newProfileY;
            
%             RnetworkPlace=max(find(RrhoDilute<NetworkRadius));
%             RdropPlace=max(find(RrhoDilute<DropRadius));
%             FindMonotonicDecreasingFunction=diff(newRho(RnetworkPlace:end));
%             
%             if (length(find(FindMonotonicDecreasingFunction<0))==length(newRho(RnetworkPlace:end))-1)
%                 BoolDecrease(i)=1;
%             else BoolDecrease(i)=0;
%             end
            
%             p=polyfit(RrhoDilute(RnetworkPlace:RdropPlace)',newRho(RnetworkPlace:RdropPlace)',1);
%             SlopeVrVSr=p(1);
            % d(i)=abs(SlopeVrVSr);
            % LinearFit=p(1)*RrhoDilute(RnetworkPlace:end)'+p(2);
            % d2(i)=abs(LinearFit(end)-newRho(end));
            % % d(i)=abs(newRho(end)-newRho(RnetworkPlace));
            % d3(i)=sum(abs(LinearFit'-newRho(RnetworkPlace:end)));
            
            plot(RrhoDilute,(RhoDilute./newProfileY),'g')
            hold on
%             plot(RrhoDilute,RhoDilute,'r')
%             hold on
%             plot(RrhoDilute(RnetworkPlace:RdropPlace)',p(1)*RrhoDilute(RnetworkPlace:RdropPlace)'+p(2),'k')
            
        end
        
        
        hold on
        plot(RrhoDilute,RhoDilute,'r')
        hold on
        plot(ones(size(RrhoDilute))*DropRadius,RhoDilute)
%         
%         BestPlace=min(find(BoolDecrease==1));
%         Rpoint=effectiveR-(dr/2)+BestPlace*0.25;
%         
%         % BestPlace=placeMAX+find(d==min(d))-1;
%         % BestPlace=placeMAX+find(d3==min(d3))-1;
%         %BestPlace=placeMAX+find(d2==min(d2))-1;
%         placeEnd=BestPlace;
%         
%         RhoDilute=Rho;
%         RrhoDilute=Rrho;
%         
%        
%         ProfileX=xvalAftherCorr(1:placeMIN)-(xvalAftherCorr(placeMIN)-Rpoint);
%         
%         ProfileY=meanyAftherCorr(1:placeMIN);

%         removeRbiggerThanRdrop=find(Rrho>Rpoint);
%         RhoDilute(removeRbiggerThanRdrop)=[];
%         RrhoDilute(removeRbiggerThanRdrop)=[];
%         newProfileY=interp1(ProfileX,ProfileY,RrhoDilute);
%         CorrectedRho=RhoDilute./newProfileY;
%         
%         % d_CorrectedRho2=diff(CorrectedRho(RnetworkPlace:RdropPlace));
%         %
%         % for t=RnetworkPlace:(length(d_CorrectedRho)-5)
%         %     b_left=sum(abs(d_CorrectedRho(t)));
%         %     b_right=sum(abs(d_CorrectedRho(t+2:t+5)));
%         %     if (abs (d_CorrectedRho(t+2))>b)
%         %         endPlace=t;
%         %         break
%         %     end
%         % end
%         
%         RightRplace=find(CorrectedRho==(max(CorrectedRho(RnetworkPlace:RdropPlace))));
%         RightR=RrhoDilute(RightRplace);
%         
%         AverageRhoVsRbySectors(index).dDropRadius=abs(pleaceMEANx-xvalAftherCorr(BestPlace));
%         
%         AverageRhoVsRbySectors(index).CorrectedRho=CorrectedRho;
%         AverageRhoVsRbySectors(index).RrhoDilute=RrhoDilute;
%         
%         % plot(RrhoDilute,newRhoNetwork,'g')
%         hold on
%         plot(RrhoDilute,CorrectedRho,'b')
%         % hold on
%         % plot(RrhoDilute,RhoDilute,'r')
%         xlabel('R [\mum]','FontSize',16)
%         ylabel('<\rho>','FontSize',16)
%         
        % savefig([Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde.fig']);
        % saveas(h,[Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde.tif']);
        % saveas(h,[Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde..eps']);
    end 
    
    end
    
    % close all
    
    [OriginalAvgRho,OriginalAvgRhoUpSTD,OriginalAvgRhoDownSTD,OriginalAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors.AvgRrho],[AverageRhoVsRbySectors.AvgRho], 1);
    [CorrectedAvgRho,CorrectedAvgRhoUpSTD,CorrectedAvgRhoDownSTD,CorrectedAvgRrho] = meanGaussianMM([AverageRhoVsRbySectors.RrhoDilute],[AverageRhoVsRbySectors.CorrectedRho], 1);
    
    h=figure
    plot(OriginalAvgRrho,OriginalAvgRho,'r')
    hold on
    plot(CorrectedAvgRrho,CorrectedAvgRho,'g')
    
    savefig([Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde.fig']);
    saveas(h,[Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde.tif']);
    saveas(h,[Capture_folder,'Rho\figures\Average Rho after intensity correction near drop egde..eps']);
    
    save([Capture_folder,'Rho\AverageRhoVsRbySectorsAfterCorr.mat'],'AverageRhoVsRbySectors');
    
    save([Capture_folder,'Rho\CorrectedAvgRho.mat'],'CorrectedAvgRho');
    save([Capture_folder,'Rho\CorrectedAvgRrho.mat'],'CorrectedAvgRrho');
    save([Capture_folder,'Rho\CorrectedAvgRhoUpSTD.mat'],'CorrectedAvgRhoUpSTD');
    save([Capture_folder,'Rho\CorrectedAvgRhoDownSTD.mat'],'CorrectedAvgRhoDownSTD');
    
    
end
