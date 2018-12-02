
   DROPStemp=struct; 

% RhoAllData=[AverageValues.LinearFit];
% RrAllData=[AverageValues.xval3];
%  [avgV,VlowerLineRho,VupperLineRho,R] = meanGaussianMM(RrAllData,RhoAllData, 1);
figure 
for i=1:length(AverageValues)
    plot(AverageValues(i).xval3,AverageValues(i).LinearFit,'Color',AverageValues(i).color,'LineWidth',1)
    hold on
end




figure
for i=1:length(AverageValues)
    d(i)=AverageValues(i).p(2)+abs(AverageValues(1).p(2));
    plot(AverageValues(i).xval3-d(i),AverageValues(i).LinearFit,'Color',AverageValues(i).color,'LineWidth',1)
    hold on
end


figure
for i=1:length(AverageValues)
    plot(AverageValues(i).xval3-d(i),AverageValues(i).meany3,'Color',AverageValues(i).color,'LineWidth',1)
    hold on
end

figure
for i=1:length(AverageValues)
    plot(AverageValues(i).xval3,AverageValues(i).meany3,'Color',AverageValues(i).color,'LineWidth',1)
    hold on
end






figure 
for i=1:length(AverageValues)
    AverageValues(i).norm=AverageValues(i).meany3./(-AverageValues(i).p(1));
    plot(AverageValues(i).xval3,AverageValues(i).meany3./(-AverageValues(i).p(1)),'Color',AverageValues(i).color,'LineWidth',1)
    hold on
end

 avgV=AverageValues(1).LinearFit;
 R=AverageValues(1).norm;
  %%%% Aligne the profiles
    maxNumber=-7;
    minimumNumber=-15;
    
    place=find(avgV>maxNumber);
    avgV(place)=[];
    R(place)=[];
    place=find(avgV<minimumNumber);
    avgV(place)=[];
    R(place)=[];
    
    % for i=1:length(DROPS)
    
    figure
    for i=1:length(AverageValues)
        Rnorm=AverageValues(i).xval3;
        AvgVlinear=AverageValues(i).norm;
        
        place=find(AvgVlinear>maxNumber);
        RnormTemp=Rnorm;
        RnormTemp(place)=[];
        AvgVlinear(place)=[];
        place=find(AvgVlinear<minimumNumber);
        RnormTemp(place)=[];
        AvgVlinear(place)=[];
        
        interpRnorm=interp1(AvgVlinear,RnormTemp,avgV);
        interpRnormWithoutNan=interpRnorm;
        AVGyWithoutNan=avgV;
        AVGxWithoutNan=R;
        interpRnormWithoutNan(isnan(interpRnorm))=[];
        AVGyWithoutNan(isnan(interpRnorm))=[];
        AVGxWithoutNan(isnan(interpRnorm))=[];
        %     figure
        %     plot(AVGxWithoutNan,AVGyWithoutNan,'r')
        %     hold on
        %     plot(interpRnormWithoutNan,AVGyWithoutNan,'g')
        dx=AVGxWithoutNan-interpRnormWithoutNan;
        [Min_dx,Min_dx_place]=min(dx.^2);
        DROPStemp(i).dr=dx(Min_dx_place);
        
        if (length(DROPStemp(i).dr)==0)
            DROPStemp(i).dr=0;
        end
        
        DROPStemp(i).RrAfterSift=Rnorm+DROPStemp(i).dr;
        
        plot(AverageValues(i).xval3+DROPStemp(i).dr,AverageValues(i).norm*(-AverageValues(i).p(1)))
        hold on
    end
   
    
    