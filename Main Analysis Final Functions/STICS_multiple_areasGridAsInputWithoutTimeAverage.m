function ROI_folder=STICS_multiple_areasGridAsInputWithoutTimeAverage(Capture_folder,EdgeLimit,t)

% READ MOVIE AFTER PREFLITER
interrogationarea=importdata([Capture_folder,'Analysis parameters\interrogationarea.m']);
SecondCorrWindowSize=importdata([Capture_folder,'Analysis parameters\SecondCorrWindowSize.m']);
step=importdata([Capture_folder,'Analysis parameters\step.m']);
subpixfinder=importdata([Capture_folder,'Analysis parameters\subpixfinder.m']);
roi=importdata([Capture_folder,'Analysis parameters\roi.m']);

GridPointsX=importdata([Capture_folder,'Analysis parameters\GridPointsX.mat']);
GridPointsY=importdata([Capture_folder,'Analysis parameters\GridPointsY.mat']);

% Dir=dir([Capture_folder,'Velocity\CLAHE_HP prefilter\*.tiff']);
Dir=dir([Capture_folder,'Velocity\CLAHE_HP prefilter\*.tiff']);


if (rem(interrogationarea,2) == 0) %for the subpixel displacement measurement
    SubPixOffset=1;
else
    SubPixOffset=0.5;
end


%%% create the folder in which the new images will be save in
ROI_folder=[Capture_folder,'Velocity\STICS\ROI[',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),']','DCC',int2str(interrogationarea),'_',int2str(step),'\',int2str(t),'\'];
mkdir(ROI_folder)

%%%%%remove grid points from edges 
image1_roi=imread([Capture_folder,'Velocity\CLAHE_HP prefilter\' ,Dir(1).name]);
S=size(image1_roi);

%%%Remove grid point that will be out of range
L=(SecondCorrWindowSize-interrogationarea)/2;

GridPointsXmod=GridPointsX;
GridPointsXmod(GridPointsX<(1+L))=[];
GridPointsXmod(GridPointsXmod>(S(2)-(interrogationarea+L)))=[];

GridPointsYmod=GridPointsY;
GridPointsYmod(GridPointsY<(1+L))=[];
GridPointsYmod(GridPointsYmod>(S(1)-(interrogationarea+L)))=[];

% xtable=zeros(numelementsy,numelementsx);
xtable=zeros(length(GridPointsYmod),length(GridPointsXmod));
ytable=xtable;
utable=xtable;
vtable=xtable;
typevector=ones(length(GridPointsYmod),length(GridPointsXmod));
nrx=0;
nrxreal=0;
nry=0;



%%%Calculation of correlation for each area for the first two frames
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% for j_index = 1:length(GridPointsXmod) %vertical loop
%     j=GridPointsXmod(j_index);
%     %   j = miniy; %vertical loop
%     j_index
%         image1_roi=imread([Capture_folder,'Velocity\CLAHE_HP prefilter\' ,Dir(1).name]);
%         image2_roi=imread([Capture_folder,'Velocity\CLAHE_HP prefilter\' ,Dir(1).name]);
%    
%     for i_index = 1:length(GridPointsYmod) % horizontal loop
%         i=GridPointsYmod(i_index);
%         i_index
%             
%         image1_crop=image1_roi(j:j+interrogationarea-1, i:i+interrogationarea-1);
%         image2_crop=image2_roi(ceil(j-L):ceil(j+interrogationarea+L-1), ceil(i-L):ceil(i+interrogationarea+L-1));
%         %image2_crop=image2_roi(ceil(j-20):ceil(j+40-1), ceil(i-20):ceil(i+40-1));
%         
%         %improves the clarity of the correlation peak.
%         image1_crop=double(image1_crop)-double(mean(mean(image1_crop)));   %%???need to check if we need this
%         image2_crop=double(image2_crop)-double(mean(mean(image2_crop)));   %%???need to check if we need this
%         
%         result_conv= conv2(image2_crop,rot90(conj(image1_crop),2),'valid');
%         OutoCorrTable(:,:)=result_conv;
%         allOutoCorrTable(i_index,j_index,:,:)=result_conv;
%         OutoCorrelationPeak(i_index,j_index)=max(max(result_conv));
%         
%         save([ROI_folder,'allOutoCorrTable.mat'],'allOutoCorrTable');
%         save([ROI_folder,'OutoCorrelationPeak.mat'],'OutoCorrelationPeak');
%         
%     end
% end
% 

%%%This loop run on each area for all the time points and calculate the
%%%average correlation function STICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%Those indicies are for plotting the correlation function in subplot
k=0;


removeCorr=zeros(length(GridPointsYmod),length(GridPointsXmod)); %%% logical matrix, values=1/2/3 places will become NaN at the end.

% Dir_ROI=dir([ROI_folder,'images\*.tiff']);

for j_index = 1:length(GridPointsXmod) %vertical loop
    j=round(GridPointsXmod(j_index));
    %   j = miniy; %vertical loop
%    j_index
    
    for i_index = 1:length(GridPointsYmod) % horizontal loop
        i=round(GridPointsYmod(i_index));
%        i_index
        
%         xtable(i_index,j_index)=i+interrogationarea/2;
%         ytable(i_index,j_index)=j+interrogationarea/2;
        
        xtable(i_index,j_index)=i;
        ytable(i_index,j_index)=j;
        
%          for t=1:length(Dir)-1

            
            image1_roi=imread([Capture_folder,'Velocity\CLAHE_HP prefilter\' ,Dir(t).name]);
            image2_roi=imread([Capture_folder,'Velocity\CLAHE_HP prefilter\' ,Dir(t+1).name]);
            
            image1_crop=image1_roi(j:j+interrogationarea-1, i:i+interrogationarea-1);
            image2_crop=image2_roi(ceil(j-L):ceil(j+interrogationarea+L-1), ceil(i-L):ceil(i+interrogationarea+L-1));
            
            %improves the clarity of the correlation peak.
            image1_crop=double(image1_crop)-double(mean(mean(image1_crop)));   %%???need to check if we need this
            image2_crop=double(image2_crop)-double(mean(mean(image2_crop)));   %%???need to check if we need this
            
            %             result_conv= conv2(image2_crop,rot90(conj(image1_crop),2),'valid');
            %             corrTable(1,1,:,:)=result_conv;
            %             allCorrTable(t,:,:,:,:)=corrTable;
            
            result_conv= conv2(image2_crop,rot90(conj(image1_crop),2),'valid');
            corrTable(:,:)=result_conv;
            allCorrTable(t,:,:)=result_conv;
            
%          end
        
        average_correlation=mean(allCorrTable,1); % time avarage
        STD_correlation=squeeze(std(allCorrTable,1));
        allAverage_correlation(i_index,j_index,:,:)=average_correlation;
        allSTD_correlation(i_index,j_index,:,:)=STD_correlation;
        
        %%%END OF CALCULATION OF TIME AVERAGE CORRELATION IN EACH BOX
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
        %         %%%PLOT AVERAGE CORRELATION FUNCTION - ONLY IF NEEDED
        %
        %         figure (1)
        %         k=k+1;
        %         subplot(sizei,sizej, k)
        %         imshow( squeeze(average_correlation),[1e+05 2e+06]); colormap('jet');
        %         grid on
        %
        %         %%%%%%%%%
        
        
        %%%Calculate the velocity for each average correlation
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        result_conv=squeeze(average_correlation);
        Corr=result_conv;
        
        %%%%Estimate the gaussian width
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        MaxCorr=max(max(Corr));
        MinCorr=min(min(Corr));
        delta=MaxCorr-MinCorr;
        temp1=(Corr-(delta*0.7+MinCorr));
        [w1]=find(temp1<0);
        Corr2=Corr;
        temp1(w1)=0;
        
        B=bwboundaries(temp1);
        SizeB=size(B);
        
        
        if SizeB(1,1)>1
            SS=zeros(SizeB);
            for i=1:SizeB(1,1)
                S=size(B{i,1});
                SS(i)=S(1);
            end
            
            LargeShapePlace=find(SS==max(SS));
            B1=B{LargeShapePlace(1),1};
            
            LargePeaks=find(SS>20);
            noPeaks=length(LargePeaks);
            
            if (noPeaks>1)
                removeCorr(i_index,j_index)=1;
            end
            
            
        else B1=B{1,1};
        end
        
        
        %%%% OPTION TO FIND THE PEAK THAT CLOSEST TO
        %%%% (interrogationarea/2+1,interrogationarea/2+1)
        
        %         if SizeB(1,1)>1
        %             SS=zeros(SizeB);
        %             for i=1:SizeB(1,1)
        %                 S=size(B{i,1});
        %                 SS(i)=S(1);
        %             end
        %             LargePeaks=find(SS>20);
        %             noPeaks=size(LargePeaks);
        %
        %
        %             %%%% find the distance of the peak from the center
        %             Distance=zeros(1,noPeaks(1));
        %             for c=1:noPeaks(1)
        %                 Btemp=B{LargePeaks(c),1};
        %                 Btemp_x=Btemp(:,1);
        %                 Btemp_y=Btemp(:,2);
        %                 MeanBtemp_x=ceil(mean(Btemp_x));
        %                 MeanBtemp_y=ceil(mean(Btemp_y));
        %                 Distance(c)=sqrt( ( MeanBtemp_x - (interrogationarea/2 + 1) )^2  +  (MeanBtemp_y -(interrogationarea/2 + 1))^2 ) ;
        %             end
        %
        %             MinDistancePlace=find(Distance==min(min(Distance)))
        %             RealPeakPlace=LargePeaks(MinDistancePlace)
        %             B1=B{RealPeakPlace(1,1),1};
        %             s1=size(RealPeakPlace);
        %
        %             if (s1(1)==0)
        %                 B1=B{1,1};
        %             end
        %
        %         else B1=B{1,1};
        %         end
        %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        low1=min(B1(:,1));
        high1=max(B1(:,1));
        width1=high1-low1;
        
        low2=min(B1(:,2));
        high2=max(B1(:,2));
        width2=high2-low2;
        
        GaussianWidth1(i_index,j_index)=width1;
        GaussianWidth2(i_index,j_index)=width2;
        
        
        %%% OPTION -  Find the maximum of the real peak
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         
        %         DD=poly2mask(B1(:,1),B1(:,2),interrogationarea+1,interrogationarea+1);
        %         remove=find(DD==0);
        %         Corr2=Corr;
        %         Corr2(remove)=0;
        
        %%% find the correct peak place
        %        [y,x]=find( Corr2==max(max(Corr2)) );
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        %%%%COPIED FROM piv_DCC
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        CorrelationPeak(i_index,j_index)=max(max(result_conv));
        %CorrelationPeak(nry,nrxreal)=max(max(Corr2));
        result_conv=result_conv/max(max(result_conv))*255; %normalize, peak=always 255   ???? need to check if we need it
        corrresults{i_index,j_index}=result_conv;
        
        %Find the 255 peak
        [y,x] = find(result_conv==255);
        
        NoOfPeaks=size(x,1);
%         if size(x,1)>size(y,1)
%             NoOfPeaks=size(x,1);
%         else NoOfPeaks=size(y,1);
%         end
        
        AllNoOfPeaks(i_index,j_index)=NoOfPeaks;
        
        
        %%% modefied by Maya Malik @ 8.1.17
        %%% If there is more than 1 peak take the one that close to
        %%% [(interrogationarea/2)+1,(interrogationarea/2_+1]
        
        if size(x,1)>1
            dx=abs(x-(interrogationarea/2)+1);
            dy=abs(y-(interrogationarea/2)+1);
            r=sqrt(dx.^2+dy.^2);
            PlaceMin=find(min(r));
            x=x(PlaceMin);
            y=y(PlaceMin);
        end
        
           %         if size(x,1)>1 %if there are more than 1 peaks just take the first
        %             x=x(1:1);
        %         end
        %         if size(y,1)>1 %if there are more than 1 peaks just take the first
        %             y=y(1:1);
        %         end
        
        
        
        
        %%%%% Those lins are for removing correlations that located at the
        %%%%% boundries.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
         limit=EdgeLimit;
        
        if (x<1+limit)
            removeCorr(i_index,j_index)=2;
        end
        
        if (y<1+limit)
            removeCorr(i_index,j_index)=2;
        end
        
        %%%Corrlation window is [1,31]
        if (y>interrogationarea+1-limit)
            removeCorr(i_index,j_index)=2;
        end
        
        if (x>interrogationarea+1-limit)
            removeCorr(i_index,j_index)=2;
        end
        

%         %%%%Those lines are for finding the STD in the peak location
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         STDatPeak=STD_correlation(y,x);
%         AllSTDatPeak(i_index,j_index)=STDatPeak;
%         
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%RETURN TO THE ORIGINAL PIV_DCC CODE
        
        
        if isnan(y)==0 & isnan(x)==0
            try
                if subpixfinder==1
                    [vector] = SUBPIXGAUSS (result_conv,interrogationarea,x,y,SubPixOffset);
                elseif subpixfinder==2
                    [vector] = SUBPIX2DGAUSS (result_conv,interrogationarea,x,y,SubPixOffset);
                end
            catch
                vector=[NaN NaN]; %if something goes wrong with cross correlation.....
            end
        else
            vector=[NaN NaN]; %if something goes wrong with cross correlation.....
        end
        
        utable_AVG(i_index,j_index)=vector(1);
        vtable_AVG(i_index,j_index)=vector(2);
        
%         removeCorr((abs(utable_AVG))>interrogationarea/1.5)=3;
%         removeCorr((abs(vtable_AVG))>interrogationarea/1.5)=3;

        %%% remove large velocities that can't be measured in this interrogation area. The maxsimum velocity is interrogation area/sqrt(2)    
        removeCorr((abs(utable_AVG))>interrogationarea/1.5)=3;
        removeCorr((abs(vtable_AVG))>interrogationarea/1.5)=3;
        
        
%         utable_AVG((abs(utable_AVG))>interrogationarea/1.5)=NaN;
%         vtable_AVG((abs(utable_AVG))>interrogationarea/1.5)=NaN;
%         vtable_AVG((abs(vtable_AVG))>interrogationarea/1.5)=NaN;
%         utable_AVG((abs(vtable_AVG))>interrogationarea/1.5)=NaN;
        
        
        clear corrTable
        clear allCorrTable
        clear average_corrlation
        
    end
end


%%%PLOT ORIGINAL VELOCITY FIELD 
% figure (2)
% quiver(xtable,ytable,utable_AVG,vtable_AVG,0,'LineWidth',1.5,'Color','b');
% axis equal
% h=figure(2);

%%%% Save the desired vectors and figures

% savefig([ROI_folder,'Velocity Field before vector exclusion ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),'].fig']);
% saveas(h,[ROI_folder,'Velocity Field before vector exclusion ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),'].tif']);

save([ROI_folder,'xtable.mat'],'xtable');
save([ROI_folder,'ytable.mat'],'ytable');
save([ROI_folder,'utable_AVG.mat'],'utable_AVG');
save([ROI_folder,'vtable_AVG.mat'],'vtable_AVG');
save([ROI_folder,'CorrelationPeak.mat'],'CorrelationPeak');
save([ROI_folder,'allAverage_correlation.mat'],'allAverage_correlation');
save([ROI_folder,'STD_correlation.mat'],'STD_correlation');
save([ROI_folder,'allSTD_correlation.mat'],'allSTD_correlation');
% save([ROI_folder,'AllSTDatPeak.mat'],'AllSTDatPeak');
save([ROI_folder,'GaussianWidth2.mat'],'GaussianWidth2');
save([ROI_folder,'GaussianWidth1.mat'],'GaussianWidth1');
save([ROI_folder,'removeCorr.mat'],'removeCorr');

close all

% %%%LOOP THAT EXCLUDE WRONG VECTORS MANUALLY - OLD
% utable_AVG_EX=utable_AVG; %VAECTORS AFTER EXCLUSION
% vtable_AVG_EX=vtable_AVG;
%
% [exclude]=ceil(ginput);
% s=size(exclude);
% 
% for i=1:s(1)
%     x_place=find(xtable <= exclude(i,1) & xtable > exclude(i,1)-step);
%     y_place=find(ytable <= exclude(i,2) & ytable > exclude(i,2)-step);
% 
% 
%     t=true;
%     k=1;
% 
%     while (t==true)
% 
%         g=find(y_place==x_place(k));
%         k=k+1;
% 
%         if (length(g)>0) %% that is mean you find meatch
%             t=false;
%         end
% 
%     end
% 
%     utable_AVG_EX(y_place(g))=NaN;
%     vtable_AVG_EX(y_place(g))=NaN;
% 
% end
% %
% %%%PLOT VELOCITY FIELD AFTER VECTOR EXCUSION
% figure (3)
% quiver(xtable,ytable,utable_AVG_EX,vtable_AVG_EX,6,'LineWidth',1.5,'Color','b');
% axis equal
%
% %SAVE STICS CORRELATION PLOT AND VELOCITY FIELD PLOT
% %mkdir([ROI_folder,'Velocity Field STICS\'])
% h=figure(3);
% savefig([ROI_folder,'Velocity Field after vector exclusion ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),'].fig']);
% saveas(h,[ROI_folder,'Velocity Field after vector exclusion ROI [',int2str(roi(1)),' ',int2str(roi(2)),' ',int2str(roi(3)),' ',int2str(roi(4)),'].tif']);
% %SAVE THE RELEVENT VECTORS
%
% save([ROI_folder,'utable_AVG_EX.m'],'utable_AVG_EX');
% save([ROI_folder,'vtable_AVG_EX.m'],'vtable_AVG_EX');

%close all

end

