%%%% Maya Malik Garbi - 9/10/17
%%%% Niv Ierushalmi - 3/12/18
%%%%% This function generate drops structure for the selected drops
%%%%% Need to get: ExcelSheetFilename,experiment type indeces, colors for
%%%%% different experiment types

function DROPS=GenerateDropsStractureToKKforGUICommon_Niv(XLSfilename,expTypeInd, expTypeStrings)
    
    %%%%% Read data from excel
    T = readtable(XLSfilename, 'Range','A1:BF2000');
    
%     Col=zeros(200,3);
%     
%     TypeOfExp{1}='5uM las17';
%     Col(1,:)=[128/255 128/255 128/255]; %%% Gray
    
    %%%% Generate Drops structure
    DROPS=struct;
    j=1;
%     for expIndC=expTypeInd
%         expInd = expIndC{:};
    for Ind=1:length(expTypeInd)
        expInd = expTypeInd{Ind};
        dropIndices = find(ismember(T.ExperimentType, expInd));
%         dropIndices = find(T.ExperimentType == expInd);
        for dropInd = dropIndices'
            DROPS(j).xslxIndex = dropInd + 1; % index in xls is 1 + index in table due to header column in xls
            DROPS(j).name = T.FileName{dropInd};
            if startsWith(DROPS(j).name, '\Maya Analysis after GRC\')
                DROPS(j).name = ['W:\phkinnerets\storage\analysis\Maya\PhD Analysis',DROPS(j).name];
            end
            Capture_folder=DROPS(j).name;
            
            DROPS(j).typeOfExp = expInd(1);
            if exist('expTypeStrings', 'var') && numel(expTypeStrings) >= Ind && ~isempty(expTypeStrings(Ind))
            	DROPS(j).typeOfExpString=expTypeStrings{Ind};
            else
                DROPS(j).typeOfExpString=T.TypeOfExperiment_text_{dropInd};
            end
%             DROPS(j).Color=Col(expInd,:);
            DROPS(j).Color=getcolorfromindex(gca, Ind);%getColorForExpType(expInd(1));
            DROPS(j).DropSize=importdata(fullfile(Capture_folder,'Analysis parameters\DROP_radius.m'));
            DROPS(j).ActinNetworkRadius=importdata(fullfile(Capture_folder,'Analysis parameters\ACTIN_NETWORK_radius.m'));
            DROPS(j).CHUNK_radius=importdata(fullfile(Capture_folder,'Analysis parameters\CHUNK_radius.m'));
                        
            j=j+1;
        end
    end
end
