function [Capture]=SetFolderToEachCaptureforGUI(slide_folder,channel)

% Dir8=dir([slide_folder,'*tif']);  %%% The movies here need to be 8bit
% Size_Dir8=size(Dir8);
% names_array8={Dir8.name};
% movies_8bit=strfind(names_array8,'8bit');
% emptyCells8bit = cellfun(@isempty,movies_8bit);
% Number_of_8bit_movies=size(find(emptyCells8bit==0));
% locations_of_8bit_movies=find(emptyCells8bit==0);

if (channel==0)
    ChannelString='_C0';
elseif(channel==1)   
    ChannelString='_C1';
elseif(channel==2)   
    ChannelString='_C2';
end

Dir16=dir([slide_folder,'*tiff']);  %%% The movies here need to be 16bit
Size_Dir=size(Dir16);
names_array={Dir16.name};
movies_C0_channels=strfind(names_array,ChannelString);
emptyCells_C0 = cellfun(@isempty,movies_C0_channels);
Number_of_C0_movies=length(find(emptyCells_C0==0));
locations_of_C0_movies=find(emptyCells_C0==0);

Capture=struct;

for i=1:Number_of_C0_movies
    fprintf('Setting folder %d of %d', i, Number_of_C0_movies);
%     dir_8bit=locations_of_8bit_movies(i);
%     Capture(i).name=[slide_folder,'Capture ',Dir8(dir_8bit).name(9),'\'];
%     mkdir(Capture(i).name)
%     copyfile([slide_folder Dir8(dir_8bit).name],[Capture(i).name,'8bitC0.tif']);
%     
    dir_C0=locations_of_C0_movies(i);
    C = strsplit(Dir16(dir_C0).name,'_');
    Capture(i).name=[slide_folder,C{1},'\'];
%     if (length(Dir16(dir_C0).name)==17)
%     Capture(i).name=[slide_folder,'Capture ',Dir16(dir_C0).name(9),'\'];
%     else Capture(i).name=[slide_folder,'Capture ',Dir16(dir_C0).name(9:10),'\'];
%     end
    
    mkdir(Capture(i).name)
    filename = fullfile(slide_folder,Dir16(dir_C0).name);
    [d,n,~] = fileparts(filename);
    logfile = fullfile(d,[n, '.log']);
    movefile(filename ,fullfile(Capture(i).name,'16bitC0.tiff'));
    movefile(logfile ,fullfile(Capture(i).name,'16bitC0.log'));
    make8bitTiff(Capture(i).name);
end
fprintf('Done setting folders');
end


