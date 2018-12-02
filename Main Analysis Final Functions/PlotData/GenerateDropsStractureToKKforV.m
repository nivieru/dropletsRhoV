%%%% Maya Malik Garbi - last modified 9/10/17
%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,SelectedDropdIndices

function DROPS=GenerateDropsStractureToKKforV(directory,filename,DropsForPlot)

%%%%% Read capture names from excel
[num,txt]= xlsread(filename);
place=strfind(txt,'File name');
emptyCells = cellfun(@isempty,place);
[place_file_nameROW,place_file_nameCOLUMN]=find(emptyCells==0);
files_name=txt(:,place_file_nameCOLUMN);


Col=zeros(200,3);

TypeOfExp{16}='without';
TypeOfExp{17}='+1.5uM CP';
TypeOfExp{18}='+2uM CP';
TypeOfExp{19}='+ beads';
TypeOfExp{50}='extract HEK buffer';

% TypeOfExp{37}='80% extract buffer';
% Col(37,:)=[128/255 128/255 128/255]; %%% Gray 

TypeOfExp{37}='80% extract cof buffer';
Col(37,:)=[128/255 128/255 128/255]; %%% Gray 

TypeOfExp{64}='80% extract xb buffer';
Col(64,:)=[1 0 1] ; %%% megenta

TypeOfExp{50}='80% extract HEK buffer';
Col(50,:)=[0 0 1]; %%% cayn 

TypeOfExp{73}='80% extract xb buffer 30deg';
Col(73,:)=[1 0 0]; %%% red 

%%% Differnt extracts

TypeOfExp{104}='rambam 6';
Col(104,:)=[250/255 173/255 64/255] ; %%% yellow

TypeOfExp{105}='rambam 7';
Col(105,:)=[247/255 102/255 18/255]; %% orange


TypeOfExp{38}='+ CCA';
% Col(38,:)=[0 1 0]; %%% Green
Col(38,:)=[250/255 173/255 64/255]; %%% Green

TypeOfExp{98}='+ cofilin';
Col(98,:)=[195/255 105/255 165/255]; 

TypeOfExp{135}='+ Aip1';
Col(135,:)=[235/255 127/255 255/255]; 

TypeOfExp{39}='+ Coronin';
Col(39,:)=[250/255 173/255 64/255] ; 


TypeOfExp{63}='+ CCA 2nd shippment'; %%%% new proteins
Col(63,:)=[0 0 1]; %%% blue

TypeOfExp{40}='+ 1.5uM ActA';
% Col(40,:)=[1 0 0]; %%% red
Col(40,:)=[115/255 89/255 145/255]; 

TypeOfExp{92}='+ 2.5uM alfa actinin';
Col(92,:)=[250/255 173/255 64/255] ; %%% yellow

TypeOfExp{91}='+ 4uM alfa actinin';
Col(91,:)=[247/255 102/255 18/255]; %% orange

TypeOfExp{57}='+ 5uM alfa actinin';
Col(57,:)=[195/255 105/255 165/255]; %%% magenta
TypeOfExp{58}='+ 10uM alfa actinin';
% Col(58,:)=[0 0 1]; %%% blue
Col(58,:)=[115/255 89/255 145/255]; %% parpel


TypeOfExp{59}='+2.6uM fascin';
Col(59,:)=[195/255 105/255 165/255]; %%% dark purpal

TypeOfExp{95}='+5uM fascin';
Col(95,:)=[0 1 1]; %%% cayn 
TypeOfExp{96}='+8uM fascin';
Col(96,:)=[1 0 1]; %%% megenta
TypeOfExp{97}='+11uM fascin';
Col(97,:)=[0 1 0]; %%% Green

TypeOfExp{60}='+ 0.5uM mDia';
Col(60,:)=[1 0 1] ; %%% megenta

TypeOfExp{94}='+ 1uM mDia';
Col(94,:)=[0 1 0]; %%% Green

TypeOfExp{99}='+ 1.5uM mDia';
Col(99,:)=[0 153/255 0]; %%% Purpal

TypeOfExp{90}='+ Palloidin';
Col(90,:)=[0 0 0]; %%% black


TypeOfExp{61}='+ Abp1 Srv2';
Col(61,:)=[0 153/255 0]; %%% Purpal

TypeOfExp{65}='+ 30mM KCL';
Col(65,:)=[1 153/255 0]; %%% Orange

% TypeOfExp{64}='+ 80% extract with XB';
% Col(64,:)=[0 153/255 51/255]; %%% brown

TypeOfExp{66}='+ 80% extract with CCA & PFN';
Col(66,:)=[0 153/255 51/255]; %%% brown

TypeOfExp{67}='+ 80% extract with CCA & Tpm3.1';
Col(67,:)=[1 0 1]; %%% magenta

TypeOfExp{69}='+ 0.75uM ActA';
Col(69,:)=[247/255 102/255 18/255]; %% orange

TypeOfExp{70}='+ 0.75uM ActA GMF';
Col(70,:)=[195/255 105/255 165/255]; %%% magenta

TypeOfExp{71}='+ GMFb';
Col(71,:)=[250/255 173/255 64/255] ; %%% yellow

TypeOfExp{72}='+ GMFyeast';
Col(72,:)=[115/255 89/255 145/255]; %% parpel

TypeOfExp{100}='+Tpm 3.1';

%%%% Differnet ActA concentrations
TypeOfExp{16}='80% extract buffer';
% Col(16,:)=[128/255 128/255 128/255]; %%% Gray 
Col(16,:)=[195/255 105/255 165/255]; %%% magenta 

TypeOfExp{19}='+ 1um Silica beads';
Col(19,:)=[1 0 1] ; %%% megenta

TypeOfExp{20}='10um spacer';
Col(20,:)=[0 1 1]; %%% cayn

TypeOfExp{214}='+ 15uM cofilin';
Col(214,:)=[1 0 0]; %%% red

TypeOfExp{117}='+ 0.5uM CP';
Col(117,:)=[1 0 1];

TypeOfExp{18}='+ 2uM CP';
Col(18,:)=[0 1 1]; %%% cayn


TypeOfExp{201}='+ 0.1uM ActA';
Col(201,:)=[250/255 173/255 64/255] ; %%% yellow

TypeOfExp{202}='+ 0.3uM ActA';
Col(202,:)=[0 0 1]; %%% blue
TypeOfExp{203}='+ 0.5uM ActA';
Col(203,:)=[195/255 105/255 165/255]; %%% magenta
TypeOfExp{204}='+ 0.7uM ActA';
Col(204,:)=[0 1 0]; %%% Green
TypeOfExp{205}='+ 1uM ActA';
Col(205,:)=[0 1 1]; %%% cayn
TypeOfExp{206}='+ 1.5uM ActA';
Col(206,:)=[115/255 89/255 145/255]; %% parpel


%%% Long TL experiments

%%% Drop 1
TypeOfExp{75}='+ 2Long TL Drop1';
Col(75,:)=[0 1 1]; %%% cayn
%%% Drop 1
TypeOfExp{77}='+ 2Long TL Drop1';
Col(77,:)=[0 1 1]; %%% cayn

%%% Myosin Labeling

TypeOfExp{300}='+ F-actin Labeling';
Col(300,:)=[195/255 105/255 165/255]; %%% magenta

TypeOfExp{301}='+ Myosin Labeling';
Col(301,:)=[115/255 89/255 145/255]; %% parpel


%%%% Generate Drops structure

DROPS=struct;
j=1;

for i=DropsForPlot
    i
    DROPS(j).xslxIndex=i;
    DROPS(j).name=[directory,files_name{i}];
    Capture_folder=DROPS(j).name;
    
    if (i>700)
    DROPS(j).name=[directory,files_name{i}];
% if (i>362)
%     DROPS(j).name=[directory,files_name{i}];
    else
    temp=files_name{i};
   DROPS(j).name=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',temp(21:end)];  %%% for ActA data
 %  DROPS(j).name=['C:\Users\Maya\Documents\Maya Analysis after GRC\Data Analysis\',temp(36:end)];

    end
    
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
%     DivJtoKK(Capture_folder,ROI_folder);


%      DROPS(j).Rrho=importdata(fullfile(DROPS(j).name,'Rho\CorrectedAvgRrho.mat'));
% %     DROPS(j).Rho=importdata(fullfile(Capture_folder,'Rho\CorrectedAvgRho.mat'));
%      DROPS(j).RhoMinusMonomers=importdata(fullfile(DROPS(j).name,'Rho\RhoMinusMonomers.mat'));


%     DROPS(j).MinRr=importdata(fullfile(ROI_folder,'FinalVectors\MinRr.mat'));
% %     DROPS(j).RhoTForKymograph=importdata([DROPS(j).name,'Rho\RhoT.m']);   
%     DROPS(j).VectorFieldXtable=importdata(fullfile(ROI_folder,'xtable.mat'));
%     DROPS(j).VectorFieldYtable=importdata(fullfile(ROI_folder,'ytable.mat'));
%     DROPS(j).VectorFieldVtable_AVG_EX=importdata(fullfile(ROI_folder,'vtable_AVG_EX3.mat'));
%     DROPS(j).VectorFieldUtable_AVG_EX=importdata(fullfile(ROI_folder,'utable_AVG_EX3.mat'));
     

%  %%%% change made only for 10um data
%     DROPS(j).Vr=importdata(fullfile(ROI_folder,'FinalVectors\Vr.mat'));
%     DROPS(j).Rr=importdata(fullfile(ROI_folder,'FinalVectors\Rr.mat'));
%     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% %     


    DROPS(j).Vr=real(importdata([ROI_folder,'Vr.m']));
    DROPS(j).VrlowerLine=real(importdata([ROI_folder,'lowerLine.m']));
    DROPS(j).VrupperLine=real(importdata([ROI_folder,'upperLine.m']));
    DROPS(j).Rr=importdata([ROI_folder,'Rr.m']);
    DROPS(j).RrMinusR0=DROPS(j).Rr-DROPS(j).CHUNK_radius;
%     DROPS(j).Jr=importdata(fullfile(ROI_folder,'FinalVectors\Jr.mat'));
%     DROPS(j).Div_Jr=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr.mat'));
%     DROPS(j).Div_Jr_Rrho=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rrho.mat'));
%     DROPS(j).Div_Jr_Rho=importdata(fullfile(ROI_folder,'FinalVectors\Div_Jr_Rho.mat'));
%      
    j=j+1;
    
end

end
