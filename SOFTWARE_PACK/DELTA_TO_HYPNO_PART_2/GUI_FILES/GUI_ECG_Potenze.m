function varargout = GUI_ECG_Potenze(varargin)
% GUI_ECG_POTENZE MATLAB code for GUI_ECG_Potenze.fig
%      GUI_ECG_POTENZE, by itself, creates a new GUI_ECG_POTENZE or raises the existing
%      singleton*.
%
%      H = GUI_ECG_POTENZE returns the handle to a new GUI_ECG_POTENZE or the handle to
%      the existing singleton*.
%
%      GUI_ECG_POTENZE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ECG_POTENZE.M with the given input arguments.
%
%      GUI_ECG_POTENZE('Property','Value',...) creates a new GUI_ECG_POTENZE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_ECG_Potenze_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_ECG_Potenze_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_ECG_Potenze

% Last Modified by GUIDE v2.5 01-Nov-2017 11:53:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_ECG_Potenze_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_ECG_Potenze_OutputFcn, ...
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


% --- Executes just before GUI_ECG_Potenze is made visible.
function GUI_ECG_Potenze_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_ECG_Potenze (see VARARGIN)

% Choose default command line output for GUI_ECG_Potenze
handles.output = hObject;

global T_Windows;
oldList = handles.winChooser.String;
if iscell(oldList)
	titleString = oldList{1};
else
	titleString = oldList;
end
newList = cell(size(T_Windows, 1)+1, 1);
newList{1} = titleString;
if size(T_Windows, 1) > 0
	for lIdx = 2:size(T_Windows, 1)+1
		newList{lIdx} = ['Finestra ',int2str(lIdx-1)];
	end
end
handles.winChooser.Value = 1;
winChooser_Callback(handles.winChooser, [], handles);
handles.winChooser.String = newList;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_ECG_Potenze wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_ECG_Potenze_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in FullScreenGains.
function FullScreenGains_Callback(hObject, eventdata, handles)
% hObject    handle to FullScreenGains (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_gain_alpha;
global VG_gain_F;

global T_Windows;
global VG_HF;
global VG_gain_finestra;
global VG_S1
global VG_LF
global VG_tempo_generale;
global VG_fr_dec;
global VG_fullscreenStruct;
global VG_projectPath;

nWin = handles.winChooser.Value-1;%la prima riga è il titolo
if nWin == 0
	msgbox('Seleziona una finestra');
	return;
else
	S = find( VG_tempo_generale >= T_Windows(nWin,1), 1, 'first');
	E = find( VG_tempo_generale <= T_Windows(nWin,2), 1, 'last');
	
	%calcolo i risultati
	VG_gain_F = VG_gain_alpha(S:E,VG_HF);
	VG_gain_finestra = mean (VG_gain_F,1);
	VG_Potenza_HF_F = VG_S1(S:E, VG_HF);
	VG_Potenza_HF_Finestra = mean (VG_Potenza_HF_F,1);
	
	VG_Potenza_LF_F = VG_S1(S:E, VG_LF);
	VG_Potenza_LF_Finestra = mean (VG_Potenza_LF_F,1);
	
	%mostro i risultati
	myTime = VG_fr_dec(unique([VG_LF, VG_HF]));
	%%% GAIN %%%
	myPlot = newFullscreenStruct();
	myPlot.data(1).signal = [NaN(1, length(myTime)-length(VG_HF)), VG_gain_finestra];
	myPlot.data(1).time = myTime;
	myPlot.data(1).info = 'b';
	myPlot.data(1).prop = {'LineWidth'; 2};
	myPlot.fs = 0; %serve solo per polottare gli eventi
	myPlot.title = ['Guadagno (HF) Respirogramma ',char(8594), ' Tacogramma Finestra ', int2str(nWin)];
	myPlot.xlabel = 'Hz';
	myPlot.ylabel = 'Guadagno';
	myPlot.events = false;
	myPlot.nParts = 1;
	VG_fullscreenStruct(1) = myPlot;
	
	%%% POTENZA HF %%%
	myPlot = newFullscreenStruct();
	myPlot.data(1).signal = [NaN(1, length(myTime)-length(VG_HF)), VG_Potenza_HF_Finestra];
	myPlot.data(1).time = myTime;
	myPlot.data(1).info = 'g';
	myPlot.data(1).prop = {'LineWidth'; 2};
	myPlot.fs = 0; %serve solo per polottare gli eventi
	myPlot.title = ['Potenza HF Finestra ', int2str(nWin)];
	myPlot.xlabel = 'Hz';
	myPlot.ylabel = 'Potenza [mV^2/Hz]';
	myPlot.events = false;
	myPlot.nParts = 1;
	VG_fullscreenStruct(2) = myPlot;
	
	%%% POTENZA LF %%%
	myPlot = newFullscreenStruct();
	myPlot.data(1).signal = [VG_Potenza_LF_Finestra, NaN(1, length(myTime)-length(VG_LF))];
	myPlot.data(1).time = myTime;
	myPlot.data(1).info = 'r';
	myPlot.data(1).prop = {'LineWidth'; 2};
	myPlot.fs = 0; %serve solo per polottare gli eventi
	myPlot.title = ['Potenza LF Finestra ', int2str(nWin)];
	myPlot.xlabel = 'Hz';
	myPlot.ylabel = 'Potenza [mV^2/Hz]';
	myPlot.events = false;
	myPlot.nParts = 1;
	VG_fullscreenStruct(3) = myPlot;
	
	run([VG_projectPath, '/GUI_FullScreen']);
end


% --- Executes on selection change in winChooser.
function winChooser_Callback(hObject, eventdata, handles)
% hObject    handle to winChooser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winChooser contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winChooser
setWinTacoInfo(handles);
setWinPotNUInfo(handles);
setWinPotInfo(handles);


% --- Executes during object creation, after setting all properties.
function winChooser_CreateFcn(hObject, eventdata, handles)
% hObject    handle to winChooser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function setWinTacoInfo(handles)
global T_Windows;
global VG_taco;

nWin = handles.winChooser.Value-1;%la prima riga è il titolo
if nWin == 0
	%reset
	handles.tacoInfoStart.String = '';
	handles.tacoInfoEnd.String = '';
	handles.tacoInfoMean.String = '';
	handles.tacoInfoStd.String = '';
else
	%set
	handles.tacoInfoStart.String = num2str(T_Windows(nWin, 1));
	handles.tacoInfoEnd.String = num2str(T_Windows(nWin, 2));
	
	fattoreUdM = 1000;
	S = find( VG_taco(:,1) >= T_Windows(nWin, 1) , 1 );
	E = find( VG_taco(:,1) <= T_Windows(nWin, 2) , 1 , 'last');
	Taco_new = VG_taco(S:E, 2);
	TacoMean = mean(Taco_new);
	TacoStd = std(Taco_new);
	
	handles.tacoInfoMean.String = num2str(TacoMean*fattoreUdM);
	handles.tacoInfoStd.String = num2str(TacoStd*fattoreUdM);
end


function setWinPotNUInfo(handles)
global P_VLF_NU_Taco
global P_LF_NU_Taco
global P_HF_NU_Taco
global P_Rapp
global VG_taco
global T_Windows

nWin = handles.winChooser.Value-1;%la prima riga è il titolo
if nWin == 0
	%reset
	for colIdx = 2:size(handles.PotNuTable.Data, 2)
		for rowIdx = 1:size(handles.PotNuTable.Data, 1)
			handles.PotNuTable.Data{rowIdx,colIdx} = [];
		end
	end
else
	%set
	%NB all the arrays have the same time reference
	t_start = find(VG_taco(:,1) >= T_Windows(nWin,1), 1, 'first');
	t_end = find(VG_taco(:,1) <= T_Windows(nWin,2), 1, 'last');
	
	handles.PotNuTable.Data{1,2} = round(P_VLF_NU_Taco(t_start,1), 3);
	handles.PotNuTable.Data{1,3} = round(P_LF_NU_Taco(t_start,1), 3);
	handles.PotNuTable.Data{1,4} = round(P_HF_NU_Taco(t_start,1), 3);
	handles.PotNuTable.Data{1,5} = round(P_Rapp(t_start,1), 3);
	
	handles.PotNuTable.Data{2,2} = round(P_VLF_NU_Taco(t_end,1), 3);
	handles.PotNuTable.Data{2,3} = round(P_LF_NU_Taco(t_end,1), 3);
	handles.PotNuTable.Data{2,4} = round(P_HF_NU_Taco(t_end,1), 3);
	handles.PotNuTable.Data{2,5} = round(P_Rapp(t_end,1), 3);
	
	handles.PotNuTable.Data{3,2} = round(mean(P_VLF_NU_Taco(t_start:t_end,1)), 3);
	handles.PotNuTable.Data{3,3} = round(mean(P_LF_NU_Taco(t_start:t_end,1)), 3);
	handles.PotNuTable.Data{3,4} = round(mean(P_HF_NU_Taco(t_start:t_end,1)), 3);
	handles.PotNuTable.Data{3,5} = round(mean(P_Rapp(t_start:t_end,1)), 3);
end


function setWinPotInfo(handles)
global P_VLF_Taco
global P_LF_Taco
global P_HF_Taco
global P_TOT_Taco

global VG_taco
global T_Windows

nWin = handles.winChooser.Value-1;%la prima riga è il titolo
if nWin == 0
	%reset
	for colIdx = 2:size(handles.PotTable.Data, 2)
		for rowIdx = 1:size(handles.PotTable.Data, 1)
			handles.PotTable.Data{rowIdx,colIdx} = [];
		end
	end
else
	%set
	%NB all the arrays have the same time reference
	t_start = find(VG_taco(:,1) >= T_Windows(nWin,1), 1, 'first');
	t_end = find(VG_taco(:,1) <= T_Windows(nWin,2), 1, 'last');
	P = (10^6);
	
	handles.PotTable.Data{1,2} = round(P_VLF_Taco(t_start,1)*P, 3);
	handles.PotTable.Data{1,3} = round(P_LF_Taco(t_start,1)*P, 3);
	handles.PotTable.Data{1,4} = round(P_HF_Taco(t_start,1)*P, 3);
	handles.PotTable.Data{1,5} = round(P_TOT_Taco(t_start,1)*P, 3);
	
	handles.PotTable.Data{2,2} = round(P_VLF_Taco(t_end,1)*P, 3);
	handles.PotTable.Data{2,3} = round(P_LF_Taco(t_end,1)*P, 3);
	handles.PotTable.Data{2,4} = round(P_HF_Taco(t_end,1)*P, 3);
	handles.PotTable.Data{2,5} = round(P_TOT_Taco(t_end,1)*P, 3);
	
	handles.PotTable.Data{3,2} = round(mean(P_VLF_Taco(t_start:t_end,1))*P, 3);
	handles.PotTable.Data{3,3} = round(mean(P_LF_Taco(t_start:t_end,1))*P, 3);
	handles.PotTable.Data{3,4} = round(mean(P_HF_Taco(t_start:t_end,1))*P, 3);
	handles.PotTable.Data{3,5} = round(mean(P_TOT_Taco(t_start:t_end,1))*P, 3);
end
