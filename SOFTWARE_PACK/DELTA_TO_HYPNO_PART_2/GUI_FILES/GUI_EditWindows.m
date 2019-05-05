function varargout = GUI_EditWindows(varargin)
% GUI_EDITWINDOWS MATLAB code for GUI_EditWindows.fig
%      GUI_EDITWINDOWS, by itself, creates a new GUI_EDITWINDOWS or raises the existing
%      singleton*.
%
%      H = GUI_EDITWINDOWS returns the handle to a new GUI_EDITWINDOWS or the handle to
%      the existing singleton*.
%
%      GUI_EDITWINDOWS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EDITWINDOWS.M with the given input arguments.
%
%      GUI_EDITWINDOWS('Property','Value',...) creates a new GUI_EDITWINDOWS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_EditWindows_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_EditWindows_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_EditWindows

% Last Modified by GUIDE v2.5 07-Dec-2017 13:47:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_EditWindows_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_EditWindows_OutputFcn, ...
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


% --- Executes just before GUI_EditWindows is made visible.
function GUI_EditWindows_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_EditWindows (see VARARGIN)

% Choose default command line output for GUI_EditWindows
handles.output = hObject;

handles.legend_flag = false;
% Update handles structure
guidata(hObject, handles);

showWindowsList(handles);
plotWindows(handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_EditWindows_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function showWindowsList(handles)
global T_Windows;
handles.WinList.Value = 1;
stringhe = cell(size(T_Windows, 1)+1, 1);
oldList = cellstr(handles.WinList.String);
stringhe{1} = oldList{1};
for winIdx = 1:size(T_Windows, 1)
    stringhe{winIdx+1} = ['Finestra ',num2str(winIdx)];
end
handles.WinList.String = stringhe;
guidata(handles.WinList, handles);


function plotWindows(handles)
global VG_editWindowsStruct;
global T_Windows;

axes(handles.eventAx);
cla(handles.eventAx, 'reset');
hold on;

finestraColor = [0.73 0.83 0.96];
finestraSelectedColor = [0.60 0.70 1];
if isempty(VG_editWindowsStruct.signal)
    y_max = 1;
    y_min = 0;
else
    y_max = max(max(VG_editWindowsStruct.signal)); %in case of multiple signals
    y_min = min(min(VG_editWindowsStruct.signal)); %in case of multiple signals
end

for idx=1:size(T_Windows, 1)
    x_area = T_Windows(idx, :);
    area(x_area, y_max*ones(size(x_area)), y_min, 'FaceColor', finestraColor, 'EdgeColor', finestraColor);
end

nWin = handles.WinList.Value-1;%il primo è il titolo
if nWin > 0
    x_area = T_Windows(nWin, :);
    area(x_area, y_max*ones(size(x_area)), y_min, 'FaceColor', finestraSelectedColor, 'EdgeColor', finestraSelectedColor);
end

if ~isempty(VG_editWindowsStruct.signal)
    plot(VG_editWindowsStruct.tempo, VG_editWindowsStruct.signal);
end

hold off;
axis([VG_editWindowsStruct.tempo(1) VG_editWindowsStruct.tempo(end) y_min y_max]);

handles.legend_flag = plot_eventi(handles.legendPanel, handles.eventAx, VG_editWindowsStruct.eventi, VG_editWindowsStruct.labelEventi, VG_editWindowsStruct.fs, handles.legend_flag);
guidata(handles.WinList, handles);


% --- Executes on selection change in WinList.
function WinList_Callback(hObject, eventdata, handles)
% hObject    handle to WinList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns WinList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WinList
plotWindows(handles);


% --- Executes during object creation, after setting all properties.
function WinList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WinList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in newBtn.
function newBtn_Callback(hObject, eventdata, handles)
% hObject    handle to newBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
run(['GUI_NewWindow.m']); %modificato


% --- Executes on button press in mouseBtn.
function mouseBtn_Callback(hObject, eventdata, handles)
% hObject    handle to mouseBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
run(['GUI_NewWindowPointer.m']); %modificato


% --- Executes on button press in autoBtn.
function autoBtn_Callback(hObject, eventdata, handles)
% hObject    handle to autoBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_editWindowsStruct;
global T_Windows;
originalLen = size(T_Windows, 1);
fs = VG_editWindowsStruct.fs;
evtLen = size(VG_editWindowsStruct.eventi, 1);
if evtLen > 2
    for evtIdx = 2:evtLen
        T_Windows(originalLen+evtIdx, 1) =  VG_editWindowsStruct.eventi(evtIdx-1, 2)/fs;
        T_Windows(originalLen+evtIdx, 2) =  VG_editWindowsStruct.eventi(evtIdx, 2)/fs;
    end
    T_Windows(originalLen+1, 1) = min(VG_editWindowsStruct.tempo);
    T_Windows(originalLen+1, 2) = VG_editWindowsStruct.eventi(1, 2)/fs;
    T_Windows(originalLen+evtLen+1, 1) = VG_editWindowsStruct.eventi(evtLen, 2)/fs;
    T_Windows(originalLen+evtLen+1, 2) = max(VG_editWindowsStruct.tempo);
end

showWindowsList(handles);
plotWindows(handles);


% --- Executes on button press in editBtn.
function editBtn_Callback(hObject, eventdata, handles)
% hObject    handle to editBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
run([VG_projectPath, '/GUI_NewWindow(',num2str(handles.WinList.Value-1),')']);


% --- Executes on button press in removeBtn.
function removeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to removeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T_Windows;

nWin = handles.WinList.Value-1;%il primo è il titolo
if nWin > 0
    T_Windows = [T_Windows(1:nWin-1,:); T_Windows(nWin+1:end, :)];
end
showWindowsList(handles);
plotWindows(handles);


% --- Executes on button press in clearBtn.
function clearBtn_Callback(hObject, eventdata, handles)
% hObject    handle to clearBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T_Windows;

if ~isempty(T_Windows)
    Choice = questdlg('Le finestrature attuali verranno cancellate. Continuare?', ...
        'Reset', ...
        'Si','No','Cancel',...
        'No');
    switch Choice
        case 'Cancel'
            % nothing happens
            return;
        case 'No'
            % nothing happens
            return;
    end
end

T_Windows = [];
showWindowsList(handles);
plotWindows(handles);


% --- Executes on button press in reloadBtnWinEdit.
function reloadBtnWinEdit_Callback(hObject, eventdata, handles)
% hObject    handle to reloadBtnWinEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
showWindowsList(handles);
plotWindows(handles);


% --- Executes during object deletion, before destroying properties.
function GUI_WindowEditor_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to GUI_WindowEditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_editWindowsStruct;%.btnHandle
if ~isempty(VG_editWindowsStruct.btnHandle)
    VG_editWindowsStruct.btnHandle.Callback(VG_editWindowsStruct.btnHandle, []);
end
