function varargout = CenteredNetworsAnalysis(varargin)
% CenteredNetworsAnalysis MATLAB code for CenteredNetworsAnalysis.fig
%      CenteredNetworsAnalysis, by itself, creates a new CENTEREDNETWORSANALYSIS or raises the existing
%      singleton*.
%
%      H = CenteredNetworsAnalysis returns the handle to a new CENTEREDNETWORSANALYSIS or the handle to
%      the existing singleton*.
%
%      CenteredNetworsAnalysis('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CenteredNetworsAnalysis.M with the given input arguments.
%
%      CenteredNetworsAnalysis('Property','Value',...) creates a new CenteredNetworsAnalysis or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CenteredNetworsAnalysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CenteredNetworkAnalysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CenteredNetworsAnalysis

% Last Modified by GUIDE v2.5 26-Mar-2019 14:30:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CenteredNetworsAnalysis_OpeningFcn, ...
                   'gui_OutputFcn',  @CenteredNetworsAnalysis_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CenteredNetworsAnalysis is made visible.
function CenteredNetworsAnalysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CenteredNetworsAnalysis (see VARARGIN)

% Choose default command line output for CenteredNetworsAnalysis
handles.output = hObject;

handles.CorrectionFiles_folder = 'C:\Users\Niv\Documents\MATLAB\Maya code GUI - Niv\CorrectionFilesForAnalysis';
handles.CorrectionFiles.String = handles.CorrectionFiles_folder;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CenteredNetworsAnalysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CenteredNetworsAnalysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadFileButton.
function loadFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[slide_folder]=uigetdir();
handles.slide_folder = slide_folder;
handles.SlideName.String = slide_folder;
handles.index=2;
guidata(hObject, handles);


% --- Executes on button press in loadDropFileButton.
function loadDropFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadxlsFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Drop_folder]=uigetdir();
handles.Drop_folder = Drop_folder;
handles.DropName.String = Drop_folder;
handles.index=1;
guidata(hObject, handles);

% --- Executes on button press in CorrectionFilesFolder.
function CorrectionFilesFolder_Callback(hObject, eventdata, handles)
% hObject    handle to CorrectionFilesFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[CorrectionFiles_folder]=uigetdir();
handles.CorrectionFiles_folder = CorrectionFiles_folder;
handles.CorrectionFiles.String = CorrectionFiles_folder;
guidata(hObject, handles);


% --- Executes on button press in C0radiobutton.
function C0radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to C0radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of C0radiobutton

ChannelC0=handles.C0radiobutton.Value;

function C1radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to C0radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of C0radiobutton

ChannelC1=handles.C1radiobutton.Value;


% --- Executes on button press in set_folder_button_Drop.
function set_folder_button_Drop_Callback(hObject, eventdata, handles)
% hObject    handle to set_folder_button_Drop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function SlideName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SlideName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function calibration_Callback(hObject, eventdata, handles)
% hObject    handle to text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text as text
%        str2double(get(hObject,'String')) returns contents of text as a double


% --- Executes during object creation, after setting all properties.
function calibration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Time_intervale_Callback(hObject, eventdata, handles)
% hObject    handle to Time_intervale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Time_intervale as text
%        str2double(get(hObject,'String')) returns contents of Time_intervale as a double


% --- Executes during object creation, after setting all properties.
function Time_intervale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Time_intervale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interrogationarea_Callback(hObject, eventdata, handles)
% hObject    handle to interrogationarea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interrogationarea as text
%        str2double(get(hObject,'String')) returns contents of interrogationarea as a double


% --- Executes during object creation, after setting all properties.
function interrogationarea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interrogationarea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function step_Callback(hObject, eventdata, handles)
% hObject    handle to step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of step as text
%        str2double(get(hObject,'String')) returns contents of step as a double


% --- Executes during object creation, after setting all properties.
function step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pix_size_for_prefilter_Callback(hObject, eventdata, handles)
% hObject    handle to pix_size_for_prefilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pix_size_for_prefilter as text
%        str2double(get(hObject,'String')) returns contents of pix_size_for_prefilter as a double


% --- Executes during object creation, after setting all properties.
function pix_size_for_prefilter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pix_size_for_prefilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function backgroundNoFlu_Callback(hObject, eventdata, handles)
% hObject    handle to backgroundNoFlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of backgroundNoFlu as text
%        str2double(get(hObject,'String')) returns contents of backgroundNoFlu as a double


% --- Executes during object creation, after setting all properties.
function backgroundNoFlu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to backgroundNoFlu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%%%% y = str2num(get(handles.edit1,'string'));



function subpixfinder_Callback(hObject, eventdata, handles)
% hObject    handle to subpixfinder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subpixfinder as text
%        str2double(get(hObject,'String')) returns contents of subpixfinder as a double


% --- Executes during object creation, after setting all properties.
function subpixfinder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subpixfinder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function NoOfFrames_Callback(hObject, eventdata, handles)
% hObject    handle to NoOfFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoOfFrames as text
%        str2double(get(hObject,'String')) returns contents of NoOfFrames as a double


% --- Executes during object creation, after setting all properties.
function NoOfFrames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoOfFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in start_button.

function start_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

paramNames = {'calibration','Time_intervale', 'interrogationarea'...
    'step', 'subpixfinder', 'pix_size_for_prefilter', 'backgroundNoFlu'};
for i = 1:length(paramNames)
%     param.(paramNames{i}) = handles.(paramNames{i}).Value;
     param.(paramNames{i})=str2double(get(handles.(paramNames{i}), 'String'));
end
AnalysisParemeters=[param.calibration, param.Time_intervale, param.interrogationarea,...
    2*param.interrogationarea , param.step, param.subpixfinder, param.pix_size_for_prefilter,...
    param.pix_size_for_prefilter, param.backgroundNoFlu];

TimeAverageFlags(1) = handles.TimeAverageOverWholeMovie.Value;
TimeAverageFlags(2) = handles.SetNumberOfFramesToAverage.Value;

if TimeAverageFlags(1)
   NumberOfFramedToAverage=0;
end
if TimeAverageFlags(2)
    NumberOfFramedToAverage=str2double(get(handles.NoOfFrames, 'String'));
end

HomoCorrectionFlag = handles.NonHomogenuesCorrection.Value;
BleachCorrectionFlag = handles.BleachCorrection.Value;
EdgeCorrectionFlag = handles.GeometricDropletEdgeCorrection.Value;

%%% Flags for Droplet parametrs
RunFunctionsToDetermineDropParamFlag = handles.DetermineDropletParameters.Value;
UseSavedDropParamFlag = handles.RunAnalysisWithSavedDropletPramaters.Value;
ManualInputFlag =handles.RunAnalysisWithManualInput.Value;

if (RunFunctionsToDetermineDropParamFlag)
    DropletParameters=1;
elseif (UseSavedDropParamFlag)
    DropletParameters=2;
elseif (ManualInputFlag)
    DropletParameters=struct;
    DropletParameters.BlobCenterX0=str2double(get(handles.DropletBlobCenterX, 'String'));
    DropletParameters.BlobCenterY0=str2double(get(handles.DropletBlobCenterY, 'String'));
    DropletParameters.DropCenterX0=str2double(get(handles.DropletCenterX, 'String'));
    DropletParameters.DropCenterY0=str2double(get(handles.DropletCenterY, 'String'));
    DropletParameters.DropRadius=str2double(get(handles.DropletRaduis, 'String'));
    DropletParameters.NetworkRadius=str2double(get(handles.NetworkRaduis, 'String'));
    DropletParameters.BlobRadius=str2double(get(handles.BlobRaduis, 'String'));
end

%%% Flags for Spetial Averaging
SpetialAveragingFlag(1) = handles.AverageOverWholeAngle.Value;
SpetialAveragingFlag(2) = handles.SetSectionForAverage.Value;
NumberOfSectors=str2double(get(handles.NumberOfSectors, 'String'));

if (SpetialAveragingFlag(1))   
    SpetialAveraging=[];
else
    SpetialAveraging.StartAngle=str2double(get(handles.StartAngle, 'String'));
    SpetialAveraging.EndAngle=str2double(get(handles.EndAngle, 'String'));
end

%%% Flag for not symmetric network
NotSymmetricNetworkFlag=handles.NotSymmetricNetwork.Value;

if (handles.index==2)
slide_folder = handles.slide_folder;
load(fullfile(slide_folder,'Capture.mat'));
Main_bulk_3DforGUI(Capture,AnalysisParemeters,handles.index,handles.CorrectionFiles_folder,NumberOfFramedToAverage,HomoCorrectionFlag,BleachCorrectionFlag,EdgeCorrectionFlag,DropletParameters,SpetialAveraging,NumberOfSectors,NotSymmetricNetworkFlag); % index 2 for whole slide, 1 for one movie
else
    Capture_folder=[handles.Drop_folder,'\'];
    AnalysisOneMovieforGUI(Capture_folder,AnalysisParemeters,handles.index,handles.CorrectionFiles_folder,NumberOfFramedToAverage,HomoCorrectionFlag,BleachCorrectionFlag,EdgeCorrectionFlag,DropletParameters,SpetialAveraging,NumberOfSectors,NotSymmetricNetworkFlag);
end



% --- Executes on button press in set_folder_button_slide.
function set_folder_button_slide_Callback(hObject, eventdata, handles)
% hObject    handle to set_folder_button_slide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (handles.C0radiobutton.Value==1)
    channel=0;
elseif (handles.C1radiobutton.Value==1)
    channel=1;
elseif (handles.C2radiobutton.Value==1)
    channel=2;
end

slide_folder = [handles.slide_folder,'/'];
[Capture]=SetFolderToEachCaptureforGUI(slide_folder,channel);
save([slide_folder,'Capture.mat'],'Capture');



% --- Executes on button press in TimeAverageOverWholeMovie.
function TimeAverageOverWholeMovie_Callback(hObject, eventdata, handles)
% hObject    handle to TimeAverageOverWholeMovie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of TimeAverageOverWholeMovie


% --- Executes on button press in SetNumberOfFramesToAverage.
function SetNumberOfFramesToAverage_Callback(hObject, eventdata, handles)
% hObject    handle to SetNumberOfFramesToAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SetNumberOfFramesToAverage



function DropletBlobCenterX_Callback(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletBlobCenterX as text
%        str2double(get(hObject,'String')) returns contents of DropletBlobCenterX as a double


% --- Executes during object creation, after setting all properties.
function DropletBlobCenterX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropletBlobCenterY_Callback(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletBlobCenterY as text
%        str2double(get(hObject,'String')) returns contents of DropletBlobCenterY as a double


% --- Executes during object creation, after setting all properties.
function DropletBlobCenterY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropletRaduis_Callback(hObject, eventdata, handles)
% hObject    handle to DropletRaduis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletRaduis as text
%        str2double(get(hObject,'String')) returns contents of DropletRaduis as a double


% --- Executes during object creation, after setting all properties.
function DropletRaduis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletRaduis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropletCenterX_Callback(hObject, eventdata, handles)
% hObject    handle to DropletCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletCenterX as text
%        str2double(get(hObject,'String')) returns contents of DropletCenterX as a double


% --- Executes during object creation, after setting all properties.
function DropletCenterX_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function DropletCenterY_Callback(hObject, eventdata, handles)
% hObject    handle to DropletCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletCenterY as text
%        str2double(get(hObject,'String')) returns contents of DropletCenterY as a double


% --- Executes during object creation, after setting all properties.
function DropletCenterY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in RunAnalysisWithSavedDropletPramaters.
function RunAnalysisWithSavedDropletPramaters_Callback(hObject, eventdata, handles)
% hObject    handle to RunAnalysisWithSavedDropletPramaters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RunAnalysisWithSavedDropletPramaters


% --- Executes on button press in DetermineDropletParameters.
function DetermineDropletParameters_Callback(hObject, eventdata, handles)
% hObject    handle to DetermineDropletParameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DetermineDropletParameters



function edit27_Callback(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletBlobCenterX as text
%        str2double(get(hObject,'String')) returns contents of DropletBlobCenterX as a double


% --- Executes during object creation, after setting all properties.
function edit27_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletBlobCenterY as text
%        str2double(get(hObject,'String')) returns contents of DropletBlobCenterY as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletBlobCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit29_Callback(hObject, eventdata, handles)
% hObject    handle to DropletRaduis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletRaduis as text
%        str2double(get(hObject,'String')) returns contents of DropletRaduis as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletRaduis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to DropletCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletCenterX as text
%        str2double(get(hObject,'String')) returns contents of DropletCenterX as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletCenterX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to DropletCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of DropletCenterY as text
%        str2double(get(hObject,'String')) returns contents of DropletCenterY as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DropletCenterY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in AverageOverWholeAngle.
function AverageOverWholeAngle_Callback(hObject, eventdata, handles)
% hObject    handle to AverageOverWholeAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AverageOverWholeAngle


% --- Executes on button press in SetSectionForAverage.
function SetSectionForAverage_Callback(hObject, eventdata, handles)
% hObject    handle to SetSectionForAverage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SetSectionForAverage



function StartAngle_Callback(hObject, eventdata, handles)
% hObject    handle to StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of StartAngle as text
%        str2double(get(hObject,'String')) returns contents of StartAngle as a double


% --- Executes during object creation, after setting all properties.
function StartAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to StartAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EndAngle_Callback(hObject, eventdata, handles)
% hObject    handle to EndAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of EndAngle as text
%        str2double(get(hObject,'String')) returns contents of EndAngle as a double


% --- Executes during object creation, after setting all properties.
function EndAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to EndAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NonHomogenuesCorrection.
function NonHomogenuesCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to NonHomogenuesCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NonHomogenuesCorrection


% --- Executes on button press in BleachCorrection.
function BleachCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to BleachCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of BleachCorrection


% --- Executes on button press in GeometricDropletEdgeCorrection.
function GeometricDropletEdgeCorrection_Callback(hObject, eventdata, handles)
% hObject    handle to GeometricDropletEdgeCorrection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of GeometricDropletEdgeCorrection


% --- Executes on button press in start_button.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to start_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in RunAnalysisWithManualInput.
function RunAnalysisWithManualInput_Callback(hObject, eventdata, handles)
% hObject    handle to RunAnalysisWithManualInput (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of RunAnalysisWithManualInput



function BlobRadius_Callback(hObject, eventdata, handles)
% hObject    handle to BlobRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of BlobRadius as text
%        str2double(get(hObject,'String')) returns contents of BlobRadius as a double


% --- Executes during object creation, after setting all properties.
function BlobRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to BlobRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NetworkRadius_Callback(hObject, eventdata, handles)
% hObject    handle to NetworkRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NetworkRadius as text
%        str2double(get(hObject,'String')) returns contents of NetworkRadius as a double


% --- Executes during object creation, after setting all properties.
function NetworkRadius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NetworkRadius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NotSymmetricNetwork.
function NotSymmetricNetwork_Callback(hObject, eventdata, handles)
% hObject    handle to NotSymmetricNetwork (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NotSymmetricNetwork



function NumberOfSectors_Callback(hObject, eventdata, handles)
% hObject    handle to NumberOfSectors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumberOfSectors as text
%        str2double(get(hObject,'String')) returns contents of NumberOfSectors as a double


% --- Executes during object creation, after setting all properties.
function NumberOfSectors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumberOfSectors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NoOfFramesRB_Callback(hObject, eventdata, handles)
% hObject    handle to NoOfFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NoOfFrames as text
%        str2double(get(hObject,'String')) returns contents of NoOfFrames as a double


% --- Executes during object creation, after setting all properties.
function NoOfFramesRB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NoOfFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
