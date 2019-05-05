function varargout = GUI_NewWindowPointer(varargin)
% GUI_NEWWINDOWPOINTER M-file for GUI_NewWindowPointer.fig
%      GUI_NEWWINDOWPOINTER, by itself, creates a new GUI_NEWWINDOWPOINTER or raises the existing
%      singleton*.
%
%      H = GUI_NEWWINDOWPOINTER returns the handle to a new GUI_NEWWINDOWPOINTER or the handle to
%      the existing singleton*.
%
%      GUI_NEWWINDOWPOINTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_NEWWINDOWPOINTER.M with the given input arguments.
%
%      GUI_NEWWINDOWPOINTER('Property','Value',...) creates a new GUI_NEWWINDOWPOINTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before correction_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_NewWindowPointer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_NewWindowPointer

% Last Modified by GUIDE v2.5 11-Dec-2017 13:28:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
	'gui_Singleton',  gui_Singleton, ...
	'gui_OpeningFcn', @GUI_NewWindowPointer_OpeningFcn, ...
	'gui_OutputFcn',  @GUI_NewWindowPointer_OutputFcn, ...
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


% --- Executes just before GUI_NewWindowPointer is made visible.
function GUI_NewWindowPointer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_NewWindowPointer (see VARARGIN)

handles.signal = [];
handles.tempo = [];
handles.contador = 0;
handles.newWins = [];
handles.mode = 'addS';% mode can be 'rest', 'addS' or 'addE'

% Choose default command line output for GUI_NewWindowPointer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global VG_editWindowsStruct;

handles.signal = VG_editWindowsStruct.signal;
handles.tempo = VG_editWindowsStruct.tempo; % PierMOD: inizializzazione per funzione interna PlotSegnali
handles.contador = VG_editWindowsStruct.tempo(1);

guidata(hObject,handles);

PlotSegnali(handles);
MainActivity(handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_NewWindowPointer_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;

varargout = {};


function MainActivity(handles)
switch handles.mode
	case 'rest'
		% do nothing
	case 'addS'
		axYlim = ylim(handles.SignalGraph);
		axXlim = xlim(handles.SignalGraph);
		x = [];
		y = [];
		btn = [];
		try
			[x, y, btn] = ginput(1);
		catch ME
			return;
		end

		if btn ~= 1
			handles.mode = 'rest';
			guidata(handles.SignalGraph, handles);
			return;
		end
		if y<axYlim(1) || y>axYlim(2)
			return;
		end

		if x<axXlim(1)
			x = axXlim(1);
		elseif x>axXlim(2)
			x = axXlim(2);
		end

		handles.newWins(end+1,:) = [x, -1];
		handles.mode = 'addE';
		guidata(handles.SignalGraph,handles);

		PlotSegnali(handles);
		MainActivity(handles);
	case 'addE'
		axYlim = ylim(handles.SignalGraph);
		axXlim = xlim(handles.SignalGraph);
		x = [];
		y = [];
		btn = [];
		try
			[x, y, btn] = ginput(1);
		catch ME
			return;
		end

		if btn ~= 1
			handles.mode = 'rest';
			guidata(handles.SignalGraph, handles);
			return;
		end
		if y<axYlim(1) || y>axYlim(2)
			return;
		end

		if x<axXlim(1)
			x = axXlim(1);
		elseif x>axXlim(2)
			x = axXlim(2);
		end

		handles.newWins(end,2) = x;
		if handles.newWins(end,1) > handles.newWins(end,2)
			lastWin = handles.newWins(end,:);
			handles.newWins(end,:) = [lastWin(2) lastWin(1)];
		end
		handles.mode = 'addS';
		guidata(handles.SignalGraph,handles);

		PlotSegnali(handles);
		MainActivity(handles);
	otherwise
		handles.mode = 'rest';
		guidata(handles.SignalGraph, handles);
		MainActivity(handles);
end


% --- Executes on button press in next_pushbutton.
function next_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to next_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

jump = str2double(get(handles.window_edit,'String'));

handles.contador = handles.contador + jump;

if handles.contador + jump > handles.tempo(end)
	handles.contador = handles.tempo(end) - jump;
end

guidata(hObject, handles);
PlotSegnali(handles);
MainActivity(handles);


% --- Executes on button press in back_pushbutton.
function back_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to back_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
jump = str2double(get(handles.window_edit,'String'));
handles.contador = handles.contador - jump;
if handles.contador < handles.tempo(1)
	handles.contador = handles.tempo(1);
end

guidata(hObject,handles)
PlotSegnali(handles);
MainActivity(handles);


function PlotSegnali(handles)
jump = str2double(get(handles.window_edit,'String'));

global T_Windows;
global VG_editWindowsStruct;

axes(handles.SignalGraph);
cla(handles.SignalGraph);
maxY = max(max(handles.signal));
minY = min(min(handles.signal));

hold on;
finestraColor = [0.73 0.83 0.96];
for idx=1:size(T_Windows, 1)
    x_area = T_Windows(idx, :);
    area(x_area, maxY*ones(size(x_area)), minY, 'FaceColor', finestraColor, 'EdgeColor', finestraColor);
end

nNewWin = size(handles.newWins, 1);
if handles.mode == 'addE'
	nNewWin = nNewWin -1;
end
for idx = 1:nNewWin
    x_area = handles.newWins(idx, :);
    area(x_area, maxY*ones(size(x_area)), minY, 'FaceColor', finestraColor, 'EdgeColor', finestraColor);
end

plot(handles.tempo, handles.signal); %there may be multiple signals
xlim([handles.contador handles.contador+jump]);%contador è il primo valore in secondi che viene mostrato
ylim([minY maxY]);
xlabel('time [s]');

% plot del punto spaiato
if handles.mode == 'addE'
	punto = handles.newWins(end,1);
	ordin = (maxY + minY) / 2;
	plot(punto, ordin, '*r');
end

plot_eventi([], handles.SignalGraph, VG_editWindowsStruct.eventi, VG_editWindowsStruct.labelEventi, VG_editWindowsStruct.fs, true);
hold off


% --- Executes during object creation, after setting all properties.
function window_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
	set(hObject,'BackgroundColor','white');
else
	set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function window_edit_Callback(hObject, eventdata, handles)
PlotSegnali(handles);
MainActivity(handles);


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T_Windows;

if handles.mode == 'addE'
	handles.newWins = handles.newWins(end-1,:);
end
T_Windows = [T_Windows; handles.newWins];

h = findall(0, 'tag', 'reloadBtnWinEdit');
h.Callback(h, []);

%%% chiude la finestra di edit
h = findall(0, 'tag', 'GUI_NewWindowPointer');
close(h);

