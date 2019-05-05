function varargout = LFHF_ALPHA(varargin)
% LFHF_ALPHA MATLAB code for LFHF_ALPHA.fig
%      LFHF_ALPHA, by itself, creates a new LFHF_ALPHA or raises the existing
%      singleton*.
%
%      H = LFHF_ALPHA returns the handle to a new LFHF_ALPHA or the handle to
%      the existing singleton*.
%
%      LFHF_ALPHA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LFHF_ALPHA.M with the given input arguments.
%
%      LFHF_ALPHA('Property','Value',...) creates a new LFHF_ALPHA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LFHF_ALPHA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LFHF_ALPHA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LFHF_ALPHA

% Last Modified by GUIDE v2.5 09-May-2018 10:27:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LFHF_ALPHA_OpeningFcn, ...
                   'gui_OutputFcn',  @LFHF_ALPHA_OutputFcn, ...
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


% --- Executes just before LFHF_ALPHA is made visible.
function LFHF_ALPHA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LFHF_ALPHA (see VARARGIN)

% Choose default command line output for LFHF_ALPHA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LFHF_ALPHA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LFHF_ALPHA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

global main_path;

%SELEZIONARE FINESTRA CON HYPNO APP
%start=str2num(get(handles.edit1,'String'));
%stop=str2num(get(handles.edit2,'String'));


ECG=fullfile(main_path,'Export_ECG_hypno.mat'); %solo per provare adesso dopo adrà fatto con hypno app
load(ECG);


%cambio path
cd 'GUI_FILES';

%%GUI_SCHERMATA INIZIALe

global VG_projectPath;
global VG_fullscreenStruct; %#ok<NUSED>
resetFullscreenStruct();
global VG_editWindowsStruct; %#ok<NUSED>
resetEditWindowsStruct();
global VG_loadedEvents;

%%%%%%%%%%%%%%%%%%%%%%%%% VARIABILI GLOBALI ECG %%%%%%%%%%%%%%%%%%%%%%%%%%%
global VG_eventi;
global VG_fs;
global VG_sig_ECG;
global VG_sig_respiro;
global VG_tempo_auto;
global VG_BandLimits;
global VG_defaultBandLimits;

%%%%%%%%%%%%%%%%%%%%%%%%% VARIABILI GLOBALI EEG %%%%%%%%%%%%%%%%%%%%%%%%%%%
global dati;
global tempo;
global elettrodi;
global eventig;
global fsg;
global etichette_ev;
global pfGUIECG;
global pfGUIEEG;
global eventiReject;

%%%%%%%%%%%%%%%%%%%%%%%%% VARIABILI GLOBALI EDA %%%%%%%%%%%%%%%%%%%%%%%%%%%
global VG_sig_EDA;
global pfGUIEDA;
%le altre sono state definite in precedenza in ECG

%%%%%%%%%%%%%%%% OPERAZIONI ESEGUITE CLICCANDO "LOAD" %%%%%%%%%%%%%%%%%%%%%

%SelectedObject = handles.SignalSelection.SelectedObject;
%SelectedObjectTag = SelectedObject.Tag;
%load (handles.FilePathName.String);

		wb = waitbar(0,'Loading...');
		
		%%% load mandatory variables %%%
		if exist('sig_ECG', 'var')
			VG_sig_ECG = sig_ECG;
		else
			msgbox('Variable sig_ECG is missing','Fatal Error','error','modal');
			delete(wb);
			return;
		end
		
		if exist('sig_respiro', 'var')
			VG_sig_respiro = sig_respiro;
		else
			msgbox('Variabile sig_respiro is missing','Fatal Error','error','modal');
			delete(wb);
			return;
		end
		
		if length(VG_sig_ECG) ~= length(VG_sig_respiro)
			msgbox('ECG and Breath lengths don''t match','Fatal Error','error','modal');
			delete(wb);
			return;
		end
		
		if exist('tempo_auto', 'var')
			VG_tempo_auto = tempo_auto;
			if size(VG_tempo_auto,1) > size(VG_tempo_auto,2)
				% PierMOD: Se e' un vettore colonna allora lo trasformo
				%          in vettore riga, altrimenti "pan_tompkins"
				%          non funziona.
				VG_tempo_auto = VG_tempo_auto';
			end
			if length(VG_tempo_auto) > 2
				VG_fs = round(1/(VG_tempo_auto(2) - VG_tempo_auto(1)));
			else
				msgbox('Variable tempo_auto is too short','Fatal Error','error','modal');
				delete(wb);
				return;
			end
		else
			msgbox('Variable tempo_auto is missing','Fatal Error','error','modal');
			delete(wb);
			return;
		end
		
		if length(VG_sig_ECG) ~= length(VG_tempo_auto)
			msgbox('Signals and Time lengths don''t match','Fatal Error','error','modal');
			delete(wb);
			return;
		end
		
		waitbar(1/10, wb);
		
		%%% load optional variables %%%
		if exist('eventi_ecg','var') % PierMOD
			% Usata quando, a causa di reject sulle tracce EEG, gli eventi
			% valutati sui segnali del ProComp e quelli valutati sull'EEG
			% NON coincidono.
			VG_eventi = eventi_ecg;
			VG_loadedEvents = true;
		elseif exist('eventi','var')
			VG_eventi = eventi;
			VG_loadedEvents = true;
		elseif ~VG_loadedEvents
			VG_eventi = [];
		end
		
		%---------- LEGENDA EVENTI GENERALIZZATA
		% NB: Richiede struct array "events_label" nei file .MAT caricati
		%     attraverso "GUI_Schermata_Iniziale"
		
		if exist('events_label','var')
			etichette_ev = events_label; %PierMOD: aggiunta
		elseif ~VG_loadedEvents
			etichette_ev = [];
		end
		
		%%% internal computation or info recall %%%
		% Limiti di default
		%VLF = [0-0.015] Hz
		%LF = [0.015-0.15] Hz
		%HF = [0.15-0.40] Hz
		VG_defaultBandLimits = [...
			0, 0.04;
			0.04, 0.15;
			0.15, 0.4];
		
		VG_BandLimits = VG_defaultBandLimits;
		if exist('bandLimits','var')
			if size(bandLimits) == size(VG_defaultBandLimits)
				VG_BandLimits = bandLimits;
			end
		end
		
		waitbar(2/10, wb);
		
		tacogramma = [];
		respirogramma = [];
		if exist('sig_tacogramma','var') && exist('sig_respirogramma','var')
			tacogramma = sig_tacogramma; %#ok<NODEF>
			respirogramma = sig_respirogramma; %#ok<NODEF>
		end
		
		if isempty(tacogramma) || isempty(respirogramma) || (size(tacogramma, 1) ~= size(respirogramma, 1)) || (size(tacogramma, 2) ~= 2) || (size(respirogramma, 2) ~= 2)
			
			[~, locs] = pan_tompkin(VG_sig_ECG, VG_fs, 0);
			tacogramma = [];
			respirogramma = [];
			if length(locs) >= 2
				tacogramma(:,1) = VG_tempo_auto(locs(2:end));
				tacogramma(:,2) = diff(VG_tempo_auto(locs));
				respirogramma(:,1) = tacogramma(:,1);
				respirogramma(:,2) = VG_sig_respiro(locs(2:end));
			end
			
			%%% li aggiunge al file %%%
			sig_tacogramma = tacogramma; %#ok<NASGU>
			sig_respirogramma = respirogramma; %#ok<NASGU>
			%pfGUIECG
			save(handles.FilePathName.String, 'sig_tacogramma', 'sig_respirogramma', '-append');
			%disp(['Il File  [', handles.FilePathName.String, '] ', char(232), ' stato aggiornato']);
		end
		waitbar(3/10, wb);
		
		postTacoActivity(tacogramma, respirogramma, [], [], wb, 3/10, 10/10);
		
		delete(wb);
		
		% Teniamo traccia del file processato con GUI ECG
		%pfGUIECG = get(handles.FilePathName,'String');
		
        dir
		run([VG_projectPath, 'GUI_ECG.m']);
		
	
guidata(hObject, handles);






% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
