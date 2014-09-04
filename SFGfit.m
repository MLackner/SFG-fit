function varargout = SFGfit(varargin)
% SFGFIT MATLAB code for SFGfit.fig
%      SFGFIT, by itself, creates a new SFGFIT or raises the existing
%      singleton*.
%
%      H = SFGFIT returns the handle to a new SFGFIT or the handle to
%      the existing singleton*.
%
%      SFGFIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SFGFIT.M with the given input arguments.
%
%      SFGFIT('Property','Value',...) creates a new SFGFIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SFGfit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SFGfit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SFGfit

% Last Modified by GUIDE v2.5 03-Sep-2014 17:03:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SFGfit_OpeningFcn, ...
                   'gui_OutputFcn',  @SFGfit_OutputFcn, ...
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


% --- Executes just before SFGfit is made visible.
function SFGfit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SFGfit (see VARARGIN)

% Choose default command line output for SFGfit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SFGfit wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Insert 'Ready' status
axes(handles.axes_status);
imshow('icons\ready.gif')

% Play random animation in plot window
fcn_rndPlot(handles);


% --- Outputs from this function are returned to the command line.
function varargout = SFGfit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_loadDataSet.
function file = push_loadDataSet_Callback(hObject, eventdata, handles)
% hObject    handle to push_loadDataSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,fileName] = fcn_loadFile('*.mat','Select Data Set');
% Store Data
h = handles.figure1;
fileFldName = fieldnames(file);
dataSet = file.(fileFldName{1});
setappdata(h,'dataSet',dataSet)
setappdata(h,'fileName',fileName)
% Change data name
set(handles.text_dataSet,'String',fileName);
% Write Data Names in popup menu
dataNames = fieldnames(dataSet);
set(handles.popup_data,'String',dataNames)
%
popup_data_Callback(hObject, eventdata, handles)

function edit_numPeaks_Callback(hObject, eventdata, handles)
% hObject    handle to edit_numPeaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_numPeaks as text
%        str2double(get(hObject,'String')) returns contents of edit_numPeaks as a double


% --- Executes during object creation, after setting all properties.
function edit_numPeaks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_numPeaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_peakPos_Callback(hObject, eventdata, handles)
% hObject    handle to edit_peakPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_peakPos as text
%        str2double(get(hObject,'String')) returns contents of edit_peakPos as a double


% --- Executes during object creation, after setting all properties.
function edit_peakPos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_peakPos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_saveSettings.
function push_saveSettings_Callback(hObject, eventdata, handles)
% hObject    handle to push_saveSettings (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Save settings
% Determine data that shall be saved
Data{1} = get(handles.edit_peakPos,'String');
Data{2} = get(handles.edit_dampCoeff,'String');
% Call save function
fcn_saveFile(Data)


function edit_dampCoeff_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dampCoeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dampCoeff as text
%        str2double(get(hObject,'String')) returns contents of edit_dampCoeff as a double


% --- Executes during object creation, after setting all properties.
function edit_dampCoeff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dampCoeff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_load.
function push_load_Callback(hObject, eventdata, handles)
% hObject    handle to push_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% Load settings
% Call load function
Settings = fcn_loadFile('*.mat','Load Settings');
fldnames = fieldnames(Settings);
Data = Settings.(fldnames{1});
% Insert Peak Positions
peakPos = Data{1};
set(handles.edit_peakPos,'String',peakPos)
% Insert Damping Coefficients
dampC = Data{2};
set(handles.edit_dampCoeff,'String',dampC)


% --- Executes on button press in check_logFile.
function check_logFile_Callback(hObject, eventdata, handles)
% hObject    handle to check_logFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_logFile


% --- Executes on button press in check_dataTable.
function check_dataTable_Callback(hObject, eventdata, handles)
% hObject    handle to check_dataTable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_dataTable


% --- Executes on button press in push_startFit.
function push_startFit_Callback(hObject, eventdata, handles)
% hObject    handle to push_startFit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Change to busy status
axes(handles.axes_status);
imshow('icons\busy.gif')
% Start Log
if get(handles.check_logFile) == 1
    fcn_logFile(1)
end
% Start Fitting
if get(handles.check_runOptim,'Value') == 1
    while get(handles.check_runOptim,'Value') == 1
        fitData = fcn_batchFit(handles);
    end
else
    fitData = fcn_batchFit(handles);
end
% End Log
if get(handles.check_logFile) == 1
    fcn_logFile(0)
end
% Send fitData to workspace
assignin('base','prData',fitData);
% Store Fit Data
h = handles.figure1;
setappdata(h,'dataSet',fitData)
% Change text to processed Data
set(handles.text_dataSet,'String',['processed (',...
    getappdata(h,'fileName'),')'])
% Change to ready status
axes(handles.axes_status);
imshow('icons\ready.gif')



function edit_dw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dw as text
%        str2double(get(hObject,'String')) returns contents of edit_dw as a double


% --- Executes during object creation, after setting all properties.
function edit_dw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dG_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dG as text
%        str2double(get(hObject,'String')) returns contents of edit_dG as a double


% --- Executes during object creation, after setting all properties.
function edit_dG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_loadModel.
function push_loadModel_Callback(hObject, eventdata, handles)
% hObject    handle to push_loadModel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[file,fileName] = fcn_loadFile('*.txt','Open Fit Model');
% Get file id
fileID = fopen(file);
% Scan the text file
modelStringCell = textscan(fileID,'%s');
modelString = modelStringCell{1};
% Close file
fclose(fileID);
% Store Data
h = handles.figure1;
setappdata(h,'fitModel',modelString)
% Change data name
set(handles.text_model,'String',fileName);


% --- Executes during object creation, after setting all properties.
function axes_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_status


% --- Executes on selection change in popup_data.
function popup_data_Callback(hObject, eventdata, handles)
% hObject    handle to popup_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_data contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_data

fcn_plotSelected(handles)

% --- Executes during object creation, after setting all properties.
function popup_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_runOptim.
function check_runOptim_Callback(hObject, eventdata, handles)
% hObject    handle to check_runOptim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_runOptim
