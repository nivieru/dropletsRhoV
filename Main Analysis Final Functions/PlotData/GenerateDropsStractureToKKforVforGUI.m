%%%% Maya Malik Garbi - last modified 9/10/17
%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,SelectedDropdIndices

function DROPS=GenerateDropsStractureToKKforVforGUI(filename,DropsForPlot)

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

    DROPS(j).Vr=real(importdata([ROI_folder,'Vr.m']));
    DROPS(j).VrlowerLine=real(importdata([ROI_folder,'lowerLine.m']));
    DROPS(j).VrupperLine=real(importdata([ROI_folder,'upperLine.m']));
    DROPS(j).Rr=importdata([ROI_folder,'Rr.m']);
    DROPS(j).RrMinusR0=DROPS(j).Rr-DROPS(j).CHUNK_radius;
    
    j=j+1;
    
end

end
