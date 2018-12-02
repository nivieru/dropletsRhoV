%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,SelectedDropdIndices

function DROPS=GenerateDropsStractureToRho(directory,filename,DropsForPlot);

%%%%% Read capture names from excel
[num,txt]= xlsread(filename);
place=strfind(txt,'File name');
emptyCells = cellfun(@isempty,place);
[place_file_nameROW,place_file_nameCOLUMN]=find(emptyCells==0);
files_name=txt(:,place_file_nameCOLUMN);

Col=zeros(120,3);
TypeOfExp{100}='80% extract buffer';
Col(100,:)=[128/255 128/255 128/255]; %%% Gray 

% TypeOfExp{38}='+ CCA';
% Col(38,:)=[0 1 0]; %%% Green
 
TypeOfExp{103}='+ 1.5uM ActA';
Col(103,:)=[1 0 0]; %%% red

TypeOfExp{101}='+ 5uM alfa actinin';
Col(101,:)=[0 1 1]; %%% cayn 

% TypeOfExp{58}='+ 10uM alfa actinin';
% Col(58,:)=[0 0 1]; %%% blue

TypeOfExp{102}='+ 0.5uM mDia';
Col(102,:)=[1 0 1] ; %%% megenta


%%%% Generate Drops structure
DROPS=struct;
j=1;

for i=DropsForPlot
    i
    DROPS(j).xslxIndex=i;
    DROPS(j).FileName=[directory,files_name{i}];
    Capture_folder=DROPS(j).FileName;
   
    DROPS(j).typeOfExp=num(i-place_file_nameROW,place_file_nameCOLUMN-1);
    DROPS(j).typeOfExpString=TypeOfExp{DROPS(j).typeOfExp};
    DROPS(j).Color=Col((DROPS(j).typeOfExp),:);
    
    DROPS(j).RhcalibrationNum=num(i-place_file_nameROW,place_file_nameCOLUMN+1);
    DROPS(j).LAcalibrationNum=num(i-place_file_nameROW,place_file_nameCOLUMN+2);
    
    DROPS(j).DropSize=importdata([DROPS(j).FileName,'Analysis parameters\DROP_radius.mat']);
    DROPS(j).ActinNetworkRadius=importdata([DROPS(j).FileName,'Analysis parameters\ACTIN_NETWORK_radius.mat']);
    DROPS(j).CHUNK_radius=importdata([DROPS(j).FileName,'Analysis parameters\CHUNK_radius.mat']);
    
    DROPS(j).LA_Rho=importdata([Capture_folder,'LA\Rho\CorrectedAvgRho.mat']);
    DROPS(j).LA_Rrho=importdata([Capture_folder,'LA\Rho\CorrectedAvgRrho.mat']);
    NetPlace=max(find(DROPS(j).LA_Rrho<DROPS(j).ActinNetworkRadius));
    Rho=DROPS(j).LA_Rho;
    DROPS(j).LA_background=mean(Rho(NetPlace:end));
    
    DROPS(j).Rh_Rho=importdata([Capture_folder,'Rh\Rho\CorrectedAvgRho.mat']);
    DROPS(j).Rh_Rrho=importdata([Capture_folder,'Rh\Rho\CorrectedAvgRrho.mat']);
    NetPlace=max(find(DROPS(j).Rh_Rrho<DROPS(j).ActinNetworkRadius));
    Rho=DROPS(j).Rh_Rho;
    DROPS(j).Rh_background=mean(Rho(NetPlace:end));
     
    j=j+1;
    
end

end
