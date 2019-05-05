function varargout = GUI_NewWindow(varargin)
% GUI_NEWWINDOW MATLAB code for GUI_NewWindow.fig
%      GUI_NEWWINDOW, by itself, creates a new GUI_NEWWINDOW or raises the existing
%      singleton*.
%
%      H = GUI_NEWWINDOW returns the handle to a new GUI_NEWWINDOW or the handle to
%      the existing singleton*.
%
%      GUI_NEWWINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_NEWWINDOW.M with the given input arguments.
%
%      GUI_NEWWINDOW('Property','Value',...) creates a new GUI_NEWWINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_NewWindow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_NewWindow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_NewWindow

% Last Modified by GUIDE v2.5 30-May-2017 19:31:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_NewWindow_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_NewWindow_OutputFcn, ...
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


% --- Executes just before GUI_NewWindow is made visible.
function GUI_NewWindow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_NewWindow (see VARARGIN)

% Choose default command line output for GUI_NewWindow
handles.output = hObject;

global T_Windows;
handles.winToEdit = 0;
if nargin >= 4 % i tre di default più gli eventuali varargin
	if isnumeric(varargin{1})
		handles.winToEdit = varargin{1};
	end
	if handles.winToEdit > length(T_Windows)
		handles.winToEdit = 0;
	end
end
% se winToEdit è 0 genera una nuova finestra, altrimenti modifica quella indicata

global VG_editWindowsStruct;
% riempie le liste degli eventi
listaEv = cell(size(VG_editWindowsStruct.eventi, 1), 1);
for evIdx = 1:size(VG_editWindowsStruct.eventi, 1)
    myLabelIdx = [];
    for labelIdx = 1:length(VG_editWindowsStruct.labelEventi)
        if VG_editWindowsStruct.eventi(evIdx, 1) == VG_editWindowsStruct.labelEventi(labelIdx).code
            myLabelIdx = labelIdx;
            break;
        end
    end
    if isempty(myLabelIdx)
        labelTxt = 'evento';
    else
        labelTxt = VG_editWindowsStruct.labelEventi(myLabelIdx).label;
    end
    listaEv{evIdx+1} = labelTxt;
end
handles.eventListStart.Value = 1;
handles.eventListEnd.Value = 1;
listaEv{1} = 'Inizio';
handles.eventListStart.String = listaEv;
listaEv{1} = 'Fine';
handles.eventListEnd.String = listaEv;

if handles.winToEdit > 0
	myWin = T_Windows(handles.winToEdit, :);
	handles.manualStart.String = num2str(myWin(1));
	handles.manualEnd.String = num2str(myWin(2));
	startIdx = find(VG_editWindowsStruct.eventi(:,2)/VG_editWindowsStruct.fs == myWin(1));
	endIdx = find(VG_editWindowsStruct.eventi(:,2)/VG_editWindowsStruct.fs == myWin(2));
	if ~isempty(startIdx)
		handles.eventListStart.Value = startIdx+1;
	end
	if ~isempty(endIdx)
		handles.eventListEnd.Value = endIdx+1;
	end
end

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_NewWindow_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in eventListStart.
function eventListStart_Callback(hObject, eventdata, handles)
global VG_editWindowsStruct;
fs = VG_editWindowsStruct.fs;
if hObject.Value > 1
	handles.manualStart.String = num2str(VG_editWindowsStruct.eventi(hObject.Value-1,2)/fs);
else
	handles.manualStart.String = num2str(0);
end


% --- Executes during object creation, after setting all properties.
function eventListStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventListStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function manualStart_Callback(hObject, eventdata, handles)
% hObject    handle to manualStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of manualStart as text
%        str2double(get(hObject,'String')) returns contents of manualStart as a double
handles.eventListStart.Value = 1;


% --- Executes during object creation, after setting all properties.
function manualStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to manualStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in eventListEnd.
function eventListEnd_Callback(hObject, eventdata, handles)
global VG_editWindowsStruct;
fs = VG_editWindowsStruct.fs;
if hObject.Value > 1
	handles.manualEnd.String = num2str(VG_editWindowsStruct.eventi(hObject.Value-1,2)/fs);
else
	handles.manualEnd.String = num2str(0);
end


% --- Executes during object creation, after setting all properties.
function eventListEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to eventListEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function manualEnd_Callback(hObject, eventdata, handles)
% hObject    handle to manualEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of manualEnd as text
%        str2double(get(hObject,'String')) returns contents of manualEnd as a double
handles.eventListEnd.Value = 1;


% --- Executes during object creation, after setting all properties.
function manualEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to manualEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveBtn.
function saveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to saveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T_Windows;
global VG_editWindowsStruct;

%recupero istante iniziale
startValue = handles.eventListStart.Value-1;
if startValue <= 0
    startTime = str2double(handles.manualStart.String);
    if isnan(startTime)
        msgbox('Seleziona un valore iniziale!');
        return;
    end
else
    startTime = VG_editWindowsStruct.eventi(startValue, 2)/VG_editWindowsStruct.fs;
end

% recupero istante finale
endValue = handles.eventListEnd.Value-1;
if endValue <= 0
    endTime = str2double(handles.manualEnd.String);
    if isnan(endTime)
        msgbox('Seleziona un valore finale!');
        return;
    end
else
    endTime = VG_editWindowsStruct.eventi(endValue, 2)/VG_editWindowsStruct.fs;
end

%check sui tempi
tempoMin = VG_editWindowsStruct.tempo(1);
tempoMax = VG_editWindowsStruct.tempo(end);
if startTime < tempoMin
    startTime = tempoMin;
end
if startTime > tempoMax
    startTime = tempoMax;
end
if endTime < tempoMin
    endTime = tempoMin;
end
if endTime > tempoMax
    endTime = tempoMax;
end

newWin = zeros(1,2);
newWin(1) = min(startTime, endTime);
newWin(2) = max(startTime, endTime);

if handles.winToEdit > 0
	T_Windows(handles.winToEdit, :) = newWin;
else
	T_Windows = [T_Windows; newWin];
end

h = findall(0, 'tag', 'reloadBtnWinEdit');
h.Callback(h, []);

h = findall(0, 'tag', 'GUI_newWindow');
delete(h);
