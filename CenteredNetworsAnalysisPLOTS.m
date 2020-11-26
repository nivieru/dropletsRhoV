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

% Last Modified by GUIDE v2.5 24-Nov-2020 12:54:12

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

handles.xlsFileText.String = '3D networks data.xlsx';
handles.SaveToFileText.String = [getenv('USERPROFILE'), '\Documents\plots'];
handles.cond = [];
% Update handles structure
guidata(hObject, handles);
addCond(hObject, handles);

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
handles.xlsFileText.String = xls_file;
guidata(hObject, handles);

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

for i=1:length(handles.cond)
    expTypes{i} = str2num(handles.cond(i).index.String);
    expTypeStrings{i} = handles.cond(i).name.String;
end
plotFlags(1) = handles.oneCondCheckbox.Value;
plotFlags(2) = handles.CondVsControlCheckbox.Value;
plotFlags(3) = handles.AveragesCheckbox.Value;

% DropsForPlotForV=exp_indices;
% DropsForPlotForRho=DropsForPlotForV;

filename = handles.xlsFileText.String;
save_to_file=handles.SaveToFileText.String;
doPlots(expTypes, expTypeStrings, filename, save_to_file, plotFlags);

% --- Executes on button press in SaveToFile1.
function SaveToFile1_Callback(hObject, eventdata, handles)
% hObject    handle to SaveToFile1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[SaveToFile]=uigetdir(handles.SaveToFileText.String);
% handles.SaveFolder = SaveToFile;
handles.SaveToFileText.String = SaveToFile;
guidata(hObject, handles);

% --- Executes on button press in add_cond.
function add_cond_Callback(hObject, eventdata, handles)
% hObject    handle to add_cond (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addCond(hObject, handles);

function removeCond(hObject, event, condNum)
handles = guidata(hObject);
fig = ancestor(hObject,'figure');
plusButton = findobj(fig, 'Tag', 'add_cond');
startButton = findobj(fig, 'Tag', 'startPlotButton');
optionsGroup = findobj(fig, 'Tag', 'optionsGroup');
plotsGroup = findobj(fig, 'Tag', 'plots');

h0 = 37;
yMargin = 5;
dh = h0 + yMargin;
y = 100;
if length(handles.cond) == 1
    handles.cond(1).name.String = '';
    handles.cond(1).index.String = '';
    guidata(fig,handles);
    return;
end
    
for i=(condNum+1):length(handles.cond)
    for f=fieldnames(handles.cond(i))'
        handles.cond(i).(f{:}).Position(2) = handles.cond(i).(f{:}).Position(2) + dh;
    end
    handles.cond(i).minusButton.Callback = {@removeCond, i-1};
    handles.cond(i).text.String = sprintf('Condition %d', i-1);
end
delete(struct2array(handles.cond(condNum)));
handles.cond(condNum) = [];
plusButton.Units = 'pixels';
plusButton.Position(2) = plusButton.Position(2) + dh;

startButton.Units = 'pixels';
startButton.Position(2) = startButton.Position(2) + dh;
optionsGroup.Units = 'pixels';
optionsGroup.Position(2) = optionsGroup.Position(2) + dh;
fig.Units = 'pixels';
fig.Position(4) = fig.Position(4) - dh;
fig.Position(2) = fig.Position(2) + dh;
plotsGroup.Position(4) = plotsGroup.Position(4) - dh;
children = plotsGroup.Children;
for i=1:length(children)
    children(i).Units = 'pixels';
    children(i).Position(2) = children(i).Position(2) - dh;
end
guidata(fig,handles);

function addCond(hObject, handles)
fig = ancestor(hObject,'figure');
plusButton = findobj(fig, 'Tag', 'add_cond');
startButton = findobj(fig, 'Tag', 'startPlotButton');
optionsGroup = findobj(fig, 'Tag', 'optionsGroup');
plotsGroup = findobj(fig, 'Tag', 'plots');

condNum = length(handles.cond) + 1;
x0 = 130;
y0 = 100;
h0 = 37;
textWidth = [220, 100];
xMargin = 10;
yMargin = 5;
dh = h0 + yMargin;
x = [x0, x0 + textWidth(1) + xMargin];
y = y0;
condText = uicontrol(plotsGroup, 'Style', 'text', 'Position', [x0 - 70, y-10, 60, h0], 'String', sprintf('Condition %d', condNum));
for i=1:length(textWidth)
    textFields(i) = uicontrol(plotsGroup, 'Style', 'edit', 'Position', [x(i), y, textWidth(i), h0]);
end
minusButton = uicontrol(plotsGroup, 'Style', 'pushbutton', 'Position', [x(end) + textWidth(end) + xMargin , y, h0, h0], 'String', '-', 'FontSize', 24);
minusButton.Callback = {@removeCond, condNum};

plusButton.Units = 'pixels';
plusButton.Position = minusButton.Position;
plusButton.Position(1) = plusButton.Position(1) + h0 + xMargin;

startButton.Units = 'pixels';
startButton.Position(2) = y-100;
optionsGroup.Units = 'pixels';
optionsGroup.Position(2) = y-100;
fig.Units = 'pixels';
fig.Position(4) = fig.Position(4) + dh;
fig.Position(2) = fig.Position(2) - dh;
plotsGroup.Position(4) = plotsGroup.Position(4) + dh;
children = plotsGroup.Children;
for i=1:length(children)
    children(i).Units = 'pixels';
    children(i).Position(2) = children(i).Position(2) + dh;
end
handles.cond(condNum).name = textFields(1);
handles.cond(condNum).index = textFields(2);
handles.cond(condNum).text = condText;
handles.cond(condNum).minusButton = minusButton;
guidata(hObject,handles);
