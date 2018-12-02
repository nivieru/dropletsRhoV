%%%% Maya Malik Garbi - last modified 9/10/17
%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,SelectedDropdIndices

function DROPS=GenerateDropsStractureToKKforGUI(filename,DropsForPlot)

%%%%% Read capture names from excel
[num,txt]= xlsread(filename);
place=strfind(txt,'File name');
emptyCells = cellfun(@isempty,place);
[place_file_nameROW,place_file_nameCOLUMN]=find(emptyCells==0);
files_name=txt(:,place_file_nameCOLUMN);

Col=zeros(200,3);

% TypeOfExp{37}='80% extract buffer';
% Col(37,:)=[128/255 128/255 128/255]; %%% Gray 


%%%% Generate Drops structure

DROPS=struct;
j=1;

for i=DropsForPlot
    i
    DROPS(j).xslxIndex=i;
    DROPS(j).name=[files_name{i}];  
    Capture_folder=DROPS(j).name;
    DROPS(j).typeOfExp=num(i-place_file_nameROW,place_file_nameCOLUMN-1);
    DROPS(j).typeOfExpString=TypeOfExp{DROPS(j).typeOfExp};
    DROPS(j).Color=Col((DROPS(j).typeOfExp),:);

    find_ROI_folder=dir([DROPS(j).name,'Velocity\STICS\']);
    ROI_folder=[DROPS(j).name,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];
    
    DROPS(j).DropSize=importdata([DROPS(j).name,'Analysis parameters\DROP_radius.m']);
    DROPS(j).ActinNetworkRadius=importdata([DROPS(j).name,'Analysis parameters\ACTIN_NETWORK_radius.m']);
    DROPS(j).CHUNK_radius=importdata([DROPS(j).name,'Analysis parameters\CHUNK_radius.m']);
    
    %%%% Call to modified function of - DivJtoKK
    %%%% to generate DivJ and save it to the relevent file 
    DivJtoKK(Capture_folder,ROI_folder);
    
    DROPS(j).Rrho=importdata([Capture_folder,'Rho\CorrectedAvgRrho.mat']);
    DROPS(j).Rho=importdata([Capture_folder,'Rho\CorrectedAvgRho.mat']);
    
    DROPS(j).RhoMinusMonomers=importdata([Capture_folder,'Rho\RhoMinusMonomers.mat']);
    DROPS(j).MinRr=importdata([ROI_folder,'FinalVectors\MinRr.mat']);     
    DROPS(j).Vr=real(importdata([ROI_folder,'Vr.m']));
    DROPS(j).Rr=importdata([ROI_folder,'Rr.m']);

    DROPS(j).RrMinusR0=DROPS(j).Rr-DROPS(j).CHUNK_radius;
    DROPS(j).Jr=importdata([ROI_folder,'FinalVectors\Jr.mat']);
    DROPS(j).Div_Jr=importdata([ROI_folder,'FinalVectors\Div_Jr.mat']);
    DROPS(j).Div_Jr_Rrho=importdata([ROI_folder,'FinalVectors\Div_Jr_Rrho.mat']);
    DROPS(j).Div_Jr_Rho=importdata([ROI_folder,'FinalVectors\Div_Jr_Rho.mat']);
    DROPS(j).ForceBalanceEq=importdata([ROI_folder,'FinalVectors\ForceBalanceEq.mat']);

    DROPS(j).TurnoverRate=importdata([ROI_folder,'FinalVectors\TurnoverRate.mat']);
    DROPS(j).ContractionRate=importdata([ROI_folder,'FinalVectors\ContractionRate.mat']);
    DROPS(j).DivVvsRslope=importdata([ROI_folder,'FinalVectors\DivVvsRslope.mat']);  
     
    j=j+1;
    
end

end
