%%%% This GUI is based on the fanction PlotMain15_1.m


function varargout = CenteredNetworsAnalysisPLOTS(varargin)
% CENTEREDNETWORSANALYSISPLOTS MATLAB code for CenteredNetworsAnalysisPLOTS.fig
%      CENTEREDNETWORSANALYSISPLOTS, by itself, creates a new CENTEREDNETWORSANALYSISPLOTS or raises the existing
%      singleton*.
%
%      H = CENTEREDNETWORSANALYSISPLOTS returns the handle to a new CENTEREDNETWORSANALYSISPLOTS or the handle to
%      the existing singleton*.
%
%      CENTEREDNETWORSANALYSISPLOTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CENTEREDNETWORSANALYSISPLOTS.M with the given input arguments.
%
%      CENTEREDNETWORSANALYSISPLOTS('Property','Value',...) creates a new CENTEREDNETWORSANALYSISPLOTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CenteredNetworsAnalysisPLOTS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CenteredNetworsAnalysisPLOTS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CenteredNetworsAnalysisPLOTS

% Last Modified by GUIDE v2.5 02-Dec-2018 11:19:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CenteredNetworsAnalysisPLOTS_OpeningFcn, ...
                   'gui_OutputFcn',  @CenteredNetworsAnalysisPLOTS_OutputFcn, ...
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


% --- Executes just before CenteredNetworsAnalysisPLOTS is made visible.
function CenteredNetworsAnalysisPLOTS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CenteredNetworsAnalysisPLOTS (see VARARGIN)

% Choose default command line output for CenteredNetworsAnalysisPLOTS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CenteredNetworsAnalysisPLOTS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CenteredNetworsAnalysisPLOTS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%% Those part are copied from CenteredNetworsAnalysis

% --- Executes on button press in loadxlsFileButton.
function loadxlsFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadxlsFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[xls_file]=uigetfile('*.xlsx');
handles.xls_folder = xls_file;
handles.xlsfile = xls_file;
guidata(hObject, handles);


function cond1_indices_Callback(hObject, eventdata, handles)
% hObject    handle to cond1_indices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond1_indices as text
%        str2double(get(hObject,'String')) returns contents of cond1_indices as a double


% --- Executes during object creation, after setting all properties.
function cond1_indices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond1_indices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond2_indices_Callback(hObject, eventdata, handles)
% hObject    handle to cond2_indices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond2_indices as text
%        str2double(get(hObject,'String')) returns contents of cond2_indices as a double


% --- Executes during object creation, after setting all properties.
function cond2_indices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond2_indices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond2_name_Callback(hObject, eventdata, handles)
% hObject    handle to cond2_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond2_name as text
%        str2double(get(hObject,'String')) returns contents of cond2_name as a double


% --- Executes during object creation, after setting all properties.
function cond2_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond2_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in oneCondCheckbox.
function oneCondCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to oneCondCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of oneCondCheckbox


% --- Executes on button press in CondVsControlCheckbox.
function CondVsControlCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to CondVsControlCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of CondVsControlCheckbox


% --- Executes on button press in AveragesCheckbox.
function AveragesCheckbox_Callback(hObject, eventdata, handles)
% hObject    handle to AveragesCheckbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of AveragesCheckbox




% --- Executes on button press in startPlotButton.
function startPlotButton_Callback(hObject, eventdata, handles)
% hObject    handle to startPlotButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exp_indices1 = str2num(handles.cond1_indices.String{1});
exp_indices2 = str2num(handles.cond2_indices.String{1});
exp_indices3 = str2num(handles.cond3_indices.String{1});
exp_indices = [exp_indices1, exp_indices2, exp_indices3];
plotFlags(1) = handles.oneCondCheckbox.Value;
plotFlags(2) = handles.CondVsControlCheckbox.Value;
plotFlags(3) = handles.AveragesCheckbox.Value;

DropsForPlotForV=exp_indices;
DropsForPlotForRho=DropsForPlotForV;

filename=handles.xlsfile;
save_to_file=handles.SaveFolder;


if (plotFlags(1)  ||  plotFlags(2) )
    DROPSforV=GenerateDropsStractureToKKforVforGUI(filename,DropsForPlotForV);
    save(fullfile(save_to_file,'DROPSforV.mat'),'DROPSforV')
    save_to_fileAllV=fullfile(save_to_file,'All V\');
    mkdir(save_to_fileAllV)   
    XtranslationByLinearFit='yes';
    DROPSafterVtranslation=PlotDiffConditionsToKKonlyV(DROPSforV,save_to_fileAllV,XtranslationByLinearFit);
    %%%% Rho
    %%%% For rambam 5 extract
    DROPSforRho=GenerateDropsStractureToKKforGUI(filename,DropsForPlotForRho);
    save(fullfile(save_to_file,'DROPSforRho.mat'),'DROPSforRho')
    PlotDiffConditionsToKKgray(DROPSforRho,DROPSafterVtranslation,save_to_file)
%     close all  
end



%%%% Only Average values

if plotFlags(3)
   
   XtranslationByLinearFit='yes';
   DROPSforV=GenerateDropsStractureToKKforVforGUI(filename,DropsForPlotForV);
   save(fullfile(save_to_file,'DROPSforV.mat'),'DROPSforV')
   PlotDiffConditionsToKKonlyV_AVGvalues(DROPSforV,save_to_file,XtranslationByLinearFit)

   DROPSforRho=GenerateDropsStractureToKKforGUI(filename,DropsForPlotForRho);
   save(fullfile(save_to_file,'DROPSforRho.mat'),'DROPSforRho')
   DROPSafterVtranslation=importdata(fullfile(save_to_file,'DROPSafterVtranslation.mat'));
   PlotDiffConditionsToKK_DivJ_AVGvalues(DROPSforRho,DROPSafterVtranslation,save_to_file)
  
end


function cond3_indices_Callback(hObject, eventdata, handles)
% hObject    handle to cond3_indices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond3_indices as text
%        str2double(get(hObject,'String')) returns contents of cond3_indices as a double


% --- Executes during object creation, after setting all properties.
function cond3_indices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond3_indices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond1_name_Callback(hObject, eventdata, handles)
% hObject    handle to cond1_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond1_name as text
%        str2double(get(hObject,'String')) returns contents of cond1_name as a double


% --- Executes during object creation, after setting all properties.
function cond1_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond1_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cond3_name_Callback(hObject, eventdata, handles)
% hObject    handle to cond3_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond3_name as text
%        str2double(get(hObject,'String')) returns contents of cond3_name as a double


% --- Executes during object creation, after setting all properties.
function cond3_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond3_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SaveToFile1.
function SaveToFile1_Callback(hObject, eventdata, handles)
% hObject    handle to SaveToFile1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[SaveToFile]=uigetdir();
handles.SaveFolder = SaveToFile;
handles.SaveToFile1.String = SaveToFile;
guidata(hObject, handles);



function cond1_index_Callback(hObject, eventdata, handles)
% hObject    handle to cond1_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cond1_index as text
%        str2double(get(hObject,'String')) returns contents of cond1_index as a double


% --- Executes during object creation, after setting all properties.
function cond1_index_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cond1_index (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
