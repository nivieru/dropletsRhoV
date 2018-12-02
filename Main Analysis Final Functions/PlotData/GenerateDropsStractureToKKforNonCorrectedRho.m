%%%% Maya Malik Garbi - last modified 9/10/17
%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,SelectedDropdIndices

function DROPS=GenerateDropsStractureToKKforNonCorrectedRho(directory,filename,DropsForPlot);

%%%%% Read capture names from excel
[num,txt]= xlsread(filename);
place=strfind(txt,'File name');
emptyCells = cellfun(@isempty,place);
[place_file_nameROW,place_file_nameCOLUMN]=find(emptyCells==0);
files_name=txt(:,place_file_nameCOLUMN);

Col=zeros(120,3);

TypeOfExp{16}='without';
TypeOfExp{17}='+1.5uM CP';
TypeOfExp{18}='+2uM CP';
TypeOfExp{19}='+ beads';
TypeOfExp{50}='extract HEK buffer';

TypeOfExp{37}='80% extract buffer';
Col(37,:)=[128/255 128/255 128/255]; %%% Gray 
TypeOfExp{38}='+ CCA';
Col(38,:)=[0 1 0]; %%% Green

TypeOfExp{135}='+ Aip1';
Col(135,:)=[0 0 1]; %%% cayn 

TypeOfExp{39}='+ Coronin';
Col(39,:)=[1 0 1] ; %%% megenta

TypeOfExp{63}='+ CCA 2nd shippment'; %%%% new proteins
Col(63,:)=[0 0 1]; %%% blue

TypeOfExp{40}='+ 1.5uM ActA';
Col(40,:)=[1 0 0]; %%% red
TypeOfExp{57}='+ 5uM alfa actinin';
Col(57,:)=[0 1 1]; %%% cayn 
TypeOfExp{58}='+ 10uM alfa actinin';
Col(58,:)=[0 0 1]; %%% blue
TypeOfExp{59}='+ fascin';
Col(59,:)=[103/255 37/255 119/255]; %%% dark purpal
TypeOfExp{60}='+ 0.5uM mDia';
Col(60,:)=[1 0 1] ; %%% megenta
TypeOfExp{61}='+ Abp1 Srv2';
Col(61,:)=[0 153/255 0]; %%% Purpal

TypeOfExp{65}='+ 30mM KCL';
Col(65,:)=[1 153/255 0]; %%% Orange

TypeOfExp{64}='+ 80% extract with XB';
Col(64,:)=[0 153/255 51/255]; %%% brown

TypeOfExp{66}='+ 80% extract with CCA & PFN';
Col(66,:)=[0 153/255 51/255]; %%% brown

TypeOfExp{67}='+ 80% extract with CCA & Tpm3.1';
Col(67,:)=[1 0 1]; %%% magenta


TypeOfExp{100}='+Tpm 3.1';

%%%% Differnet ActA concentrations
TypeOfExp{16}='80% extract buffer';
Col(16,:)=[128/255 128/255 128/255]; %%% Gray 

TypeOfExp{19}='+ 1um Silica beads';
Col(19,:)=[1 0 1] ; %%% megenta

TypeOfExp{20}='10um spacer';
Col(20,:)=[0 1 1]; %%% cayn

TypeOfExp{214}='+ 15uM cofilin';
Col(214,:)=[1 0 0]; %%% red

TypeOfExp{17}='+ 1.5uM CP';
Col(17,:)=[1 0 1];

TypeOfExp{18}='+ 2uM CP';
Col(18,:)=[0 1 1]; %%% cayn



TypeOfExp{201}='+ 0.1uM ActA';
Col(201,:)=[1 0 1] ; %%% megenta
TypeOfExp{202}='+ 0.3uM ActA';
Col(202,:)=[0 0 1]; %%% blue
TypeOfExp{203}='+ 0.5uM ActA';
Col(203,:)=[1 153/255 0]; %%% Orange
TypeOfExp{204}='+ 0.7uM ActA';
Col(204,:)=[0 1 0]; %%% Green
TypeOfExp{205}='+ 1uM ActA';
Col(205,:)=[0 1 1]; %%% cayn
TypeOfExp{206}='+ 1.5uM ActA';
Col(206,:)=[1 0 0]; %%% red


%%%% Generate Drops structure

DROPS=struct;
j=1;

for i=DropsForPlot
    i
    DROPS(j).xslxIndex=i;
    
    if (i>700)
    DROPS(j).name=[directory,files_name{i}];
    else
    temp=files_name{i};
     DROPS(j).name=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',temp(21:end)];  %%% for ActA data
    %    DROPS(j).name=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',temp(36:end)];

    end
    
    Capture_folder=DROPS(j).name;
    
%    CalculateRhoFromFirstFrame(Capture_folder)

    DROPS(j).typeOfExp=num(i-place_file_nameROW,place_file_nameCOLUMN-1);
    DROPS(j).typeOfExpString=TypeOfExp{DROPS(j).typeOfExp};
    DROPS(j).Color=Col((DROPS(j).typeOfExp),:);
  %  DROPS(j).Color=[ 1 0 0 ];

    find_ROI_folder=dir([DROPS(j).name,'Velocity\STICS\']);
    ROI_folder=[DROPS(j).name,'Velocity\STICS\',find_ROI_folder(3,1).name,'\'];
    
    DROPS(j).DropSize=importdata([DROPS(j).name,'Analysis parameters\DROP_radius.m']);
    DROPS(j).ActinNetworkRadius=importdata([DROPS(j).name,'Analysis parameters\ACTIN_NETWORK_radius.m']);
    DROPS(j).CHUNK_radius=importdata([DROPS(j).name,'Analysis parameters\CHUNK_radius.m']);
    
    %%%% Call to modified function of - DivJtoKK
    %%%% to generate DivJ and save it to the relevent file 
    DivJtoKKforNonCorrectedRho(Capture_folder,ROI_folder);
    
%     DROPS(j).Rrho=importdata(fullfile(Capture_folder,'Rho\CorrectedAvgRrho.mat'));
%     DROPS(j).Rho=importdata(fullfile(Capture_folder,'Rho\CorrectedAvgRho.mat'));
    
    DROPS(j).Rrho=importdata(fullfile(Capture_folder,'Rho\OriginalAvgRrho.mat'));
    DROPS(j).Rho=importdata(fullfile(Capture_folder,'Rho\OriginalAvgRho.mat'));
    
    DROPS(j).RhoMinusMonomers=importdata(fullfile(Capture_folder,'Rho\RhoMinusMonomers.mat'));
    DROPS(j).MinRr=importdata(fullfile(ROI_folder,'FinalVectors\MinRr.mat'));
%     DROPS(j).RhoTForKymograph=importdata([DROPS(j).name,'Rho\RhoT.m']);   
    DROPS(j).VectorFieldXtable=importdata(fullfile(ROI_folder,'xtable.mat'));
    DROPS(j).VectorFieldYtable=importdata(fullfile(ROI_folder,'ytable.mat'));
    DROPS(j).VectorFieldVtable_AVG_EX=importdata(fullfile(ROI_folder,'vtable_AVG_EX3.mat'));
    DROPS(j).VectorFieldUtable_AVG_EX=importdata(fullfile(ROI_folder,'utable_AVG_EX3.mat'));
     
    DROPS(j).Vr=importdata([ROI_folder,'Vr.m']);
    DROPS(j).Rr=importdata([ROI_folder,'Rr.m']);

%     %%%% change made only for 10um data
%     DROPS(j).Vr=importdata(fullfile(ROI_folder,'FinalVectors\Vr.mat'));
%     DROPS(j).Rr=importdata(fullfile(ROI_folder,'FinalVectors\Rr.mat'));
%     DROPS(j).Rrho=importdata(fullfile(ROI_folder,'FinalVectors\Rrho.mat'));
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
    
    DROPS(j).RrMinusR0=DROPS(j).Rr-DROPS(j).CHUNK_radius;
    DROPS(j).Jr=importdata(fullfile(ROI_folder,'FinalVectors\Jr.mat'));
    DROPS(j).Div_Jr=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr.mat'));
    DROPS(j).Div_Jr_Rrho=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rrho.mat'));
    DROPS(j).Div_Jr_Rho=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rho.mat'));
    
    DROPS(j).TurnoverRate=importdata(fullfile(ROI_folder,'FinalVectors\TurnoverRate.mat'));
    DROPS(j).ContractionRate=importdata(fullfile(ROI_folder,'FinalVectors\ContractionRate.mat'));
     
     
    j=j+1;
    
end

end
