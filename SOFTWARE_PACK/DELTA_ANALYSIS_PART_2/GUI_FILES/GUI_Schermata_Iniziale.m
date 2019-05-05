function varargout = GUI_Schermata_Iniziale(varargin)
% GUI_SCHERMATA_INIZIALE MATLAB code for GUI_Schermata_Iniziale.fig
%      GUI_SCHERMATA_INIZIALE, by itself, creates a new GUI_SCHERMATA_INIZIALE or raises the existing
%      singleton*.
%
%      H = GUI_SCHERMATA_INIZIALE returns the handle to a new GUI_SCHERMATA_INIZIALE or the handle to
%      the existing singleton*.
%
%      GUI_SCHERMATA_INIZIALE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SCHERMATA_INIZIALE.M with the given input arguments.
%
%      GUI_SCHERMATA_INIZIALE('Property','Value',...) creates a new GUI_SCHERMATA_INIZIALE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Schermata_Iniziale_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Schermata_Iniziale_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Schermata_Iniziale

% Last Modified by GUIDE v2.5 14-Jun-2017 13:56:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_Schermata_Iniziale_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_Schermata_Iniziale_OutputFcn, ...
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


% --- Executes just before GUI_Schermata_Iniziale is made visible.
function GUI_Schermata_Iniziale_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Schermata_Iniziale (see VARARGIN)

% Choose default command line output for GUI_Schermata_Iniziale
handles.output = hObject;

% Inizializzazione del path di progetto, tutti i riferimenti a file vanno
% fatti rispetto a questo path assoluto
global VG_projectPath;
%path di backup
%VG_projectPath = [fileparts(which(mfilename)), '/bkp'];
%path ultima versione
VG_projectPath = fileparts(which(mfilename));

% Inizializzazione stringhe che riporteranno [percorso,filename] del file
% processato con le GUI.
% NB: All'apertura di una nuova sessione di GUI_Schermata_Iniziale tali
%     stringhe vengono re-inizializzate (così non corriamo rischi legati a
%     variabili globali tra sessioni consecutive).
global pfGUIECG;
global pfGUI_ECG_Windows;
global pfGUIEEG;
global pfGUIEDA;
pfGUIECG = [];
pfGUI_ECG_Windows = [];
pfGUIEEG = [];
pfGUIEDA = [];

% Riorganizzazione grafica dinamica
FixPosition(hObject, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Schermata_Iniziale wait for user response (see UIRESUME)
% uiwait(handles.GUI_Schermata_Iniziale);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Schermata_Iniziale_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function FixPosition(myFigure, handles)
% la proprietà Position è un array nella forma [x y width height] riferiti all'oggetto parent
paddingX = 2;
paddingY = 0.5;
baseSize = [50 4];%[width height]
btnSize = [22.2 2.5];
editHeight = 4;

%Sezione segnali
numRadio = 4;
signalsHeight = numRadio*baseSize(2)+(numRadio+1)*paddingY +1;%il +1 è per distanziare il testo del titolo
signalsWidth = 2*paddingX + baseSize(1);
handles.SignalSelection.Position = [paddingX, paddingY, signalsWidth, signalsHeight];
handles.ECG.Position = [paddingX, numRadio*paddingY + (numRadio-1)*baseSize(2), baseSize];
handles.EEG.Position = [paddingX, (numRadio-1)*paddingY + (numRadio-2)*baseSize(2), baseSize];
handles.EDA.Position = [paddingX, (numRadio-2)*paddingY + (numRadio-3)*baseSize(2), baseSize];
handles.Multi.Position = [paddingX, (numRadio-3)*paddingY + (numRadio-4)*baseSize(2), baseSize];

%Sezione processing
handles.LoadButtonGroup.Position([2 3 4]) = handles.SignalSelection.Position([2 3 4]);
handles.LoadButtonGroup.Position(1) = sum(handles.SignalSelection.Position([1 3])) + paddingX;
%handles.LoadButtonGroup.Position(3) = btnSize(1) + 10*paddingX;
handles.Load.Position([3 4]) = btnSize;
handles.Load.Position(1) = handles.LoadButtonGroup.Position(3)/2 - btnSize(1)/2;
handles.Close.Position([1 3 4]) = handles.Load.Position([1 3 4]);
handles.Load.Position(2) = handles.LoadButtonGroup.Position(4)/2 + paddingY;
handles.Close.Position(2) = handles.LoadButtonGroup.Position(4)/2 - btnSize(2) - paddingY;

%Sezione caricamento
handles.FilePathName.Position([1 2 4]) = [paddingX, paddingY, editHeight];
handles.BrowsePanel.Position(1) = paddingX;
handles.BrowsePanel.Position(2) = sum(handles.LoadButtonGroup.Position([2 4])) + paddingY;
handles.BrowsePanel.Position(3) = sum(handles.LoadButtonGroup.Position([1 3])) - paddingX;
handles.BrowsePanel.Position(4) = sum(handles.FilePathName.Position([2 4])) + paddingY +2;
handles.Browse.Position([3 4]) = btnSize;
handles.Browse.Position(1) = handles.BrowsePanel.Position(3) - btnSize(1) - paddingX;
handles.Browse.Position(2) = handles.FilePathName.Position(4)/2 - btnSize(2)/2 + paddingY;
handles.FilePathName.Position(3) = handles.Browse.Position(1) - 2*paddingX;

%Contenitore
handles.MainButtonGroup.Position(1) = paddingX;
handles.MainButtonGroup.Position(2) = paddingY;
handles.MainButtonGroup.Position(3) = sum(handles.LoadButtonGroup.Position([1 3])) + paddingX;
handles.MainButtonGroup.Position(4) = sum(handles.BrowsePanel.Position([2 4])) + paddingY +2;
myFigure.Position([3 4]) = handles.MainButtonGroup.Position([3 4]) + 2*[paddingX paddingY];


% --- Executes on button press in Browse.
function Browse_Callback(hObject, eventdata, handles)
% hObject    handle to Browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename,pathname] = uigetfile('*.mat', 'File Selector');

if filename==0, return; end % PierMOD: Miglioramento leggibilitï¿½

filepathname = [pathname, filename];
if strcmp(handles.FilePathName.String, filepathname)
    % se non è cambiato il path non fare nulla
    return;
end

set(handles.FilePathName, 'String', filepathname);
set(handles.Load, 'Enable', 'On'); %Attiva il PushButton
set(handles.ECG, 'Enable', 'On');
set(handles.EEG, 'Enable', 'On');
set(handles.EDA, 'Enable', 'On');
set(handles.Multi, 'Enable', 'On');

%%% reset finestratura %%%
global T_Windows;
T_Windows = [];
%%% reset load eventi %%%
global VG_loadedEvents;
VG_loadedEvents = false;


% --- Executes on button press in Load.
function Load_Callback(hObject, eventdata, handles)
% hObject    handle to Load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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

SelectedObject = handles.SignalSelection.SelectedObject;
SelectedObjectTag = SelectedObject.Tag;
load (handles.FilePathName.String);

switch SelectedObjectTag
	case 'ECG'
		
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
		pfGUIECG = get(handles.FilePathName,'String');
		
		run([VG_projectPath, '/GUI_ECG']);
		
	case 'EEG'
		
		%%% load mandatory variables %%%
		if exist('sig_EEG', 'var')
			dati = sig_EEG;
		else
			msgbox('Variable sig_EEG is missing','Fatal Error','error','modal');
			return;
		end
		
		if exist('tempo_eeg', 'var')
			tempo = tempo_eeg;
			if length(tempo) > 2
				fsg = round(1/(tempo(2) - tempo(1)));
			else
				msgbox('Variable tempo_eeg is too short','Fatal Error','error','modal');
				return;
			end
		else
			msgbox('Variable tempo_eeg is missing','Fatal Error','error','modal');
			return;
		end
		
		if size(dati, 2) ~= length(tempo)
			msgbox('Signals and Time lengths don''t match','Fatal Error','error','modal');
			return;
		end
		
		if exist('canali', 'var')
			elettrodi = canali';
		else
			msgbox('Variable canali is missing','Fatal Error','error','modal');
			return;
		end
		
		if size(dati, 1) > length(elettrodi)
			msgbox(['Too few channels in variable canali\nExpected ',num2str(size(dati,1))],'Fatal Error','error','modal');
			return;
		elseif size(dati, 1) < length(elettrodi)
			msgbox(['Too many channels in variable canali\nOnly the first ',num2str(size(dati,1)),' used'],'Warinig','warning','modal');
		end
		
		%%% load optional variables %%%
		if exist('eventi_eeg','var') % PierMOD
			% Usata quando, a causa di reject sulle tracce EEG, gli eventi
			% valutati sui segnali del ProComp e quelli valutati sull'EEG
			% NON coincidono.
			eventig = eventi_eeg;
			VG_loadedEvents = true;
		elseif exist('eventi','var')
			eventig = eventi;
			VG_loadedEvents = true;
		elseif ~VG_loadedEvents
			eventig = [];
		end
		
		if exist('eventi_reject','var')
			eventiReject = eventi_reject;
		else
			eventiReject = [];
		end
		
		if exist('events_label','var')
			etichette_ev = events_label; %PierMOD: aggiunta
		elseif ~VG_loadedEvents
			etichette_ev = [];
		end
		
		% Teniamo traccia del file processato con GUI EEG
		pfGUIEEG = get(handles.FilePathName,'String');
		
		run([VG_projectPath, '/GUI_EEG']); % PierMOD: GUI rinominata da "GUI3" a "GUI_EEG".
		
	case 'EDA'
		
		%%% load mandatory variables %%%
		if exist('sig_EDA', 'var')
			VG_sig_EDA = sig_EDA;
		else
			msgbox('Variable sig_EDA is missing','Fatal Error','error','modal');
			return;
		end
		
		if exist('tempo_eda', 'var')
			VG_tempo_auto = tempo_eda;
			if length(VG_tempo_auto) > 2
				VG_fs = round(1/(VG_tempo_auto(2) - VG_tempo_auto(1)));
			else
				msgbox('Variable tempo_eda is too short','Fatal Error','error','modal');
				return;
			end
		else
			msgbox('Variable tempo_eda is missing','Fatal Error','error','modal');
			return;
		end
		
		if length(VG_sig_EDA) ~= length(VG_tempo_auto)
			msgbox('Signal and Time lengths don''t match','Fatal Error','error','modal');
			return;
		end
		
		%%% load optional variables %%%
		if exist('eventi_eda','var') % PierMOD
			% Usata quando, a causa di reject sulle tracce EEG, gli eventi
			% valutati sui segnali del ProComp e quelli valutati sull'EEG
			% NON coincidono.
			VG_eventi = eventi_eda;
			VG_loadedEvents = true;
		elseif exist('eventi','var')
			VG_eventi = eventi;
			VG_loadedEvents = true;
		elseif ~VG_loadedEvents
			VG_eventi = [];
		end
		
		if exist('events_label','var')
			etichette_ev=events_label; %PierMOD: aggiunta
		elseif ~VG_loadedEvents
			etichette_ev = [];
		end
		
		% Teniamo traccia del file processato con GUI EDA
		pfGUIEDA = get(handles.FilePathName,'String');
		
		run([VG_projectPath, '/GUI_EDA']);
		
	case 'Multi'
		run([VG_projectPath, '/GUI_MULTI']);
end

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in ECG.
function ECG_Callback(hObject, eventdata, handles)
% hObject    handle to ECG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ECG


% --- Executes on button press in EEG.
function EEG_Callback(hObject, eventdata, handles)
% hObject    handle to EEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of EEG


% --- Executes on button press in EDA.
function EDA_Callback(hObject, eventdata, handles)
% hObject    handle to EDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of EDA


% --- Executes on button press in Multi.
function Multi_Callback(hObject, eventdata, handles)
% hObject    handle to Multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Multi

function FilePathName_Callback(hObject, eventdata, handles)
% hObject    handle to FilePathName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of FilePathName as text
%        str2double(get(hObject,'String')) returns contents of FilePathName as a double


% --- Executes during object creation, after setting all properties.
function FilePathName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FilePathName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function SignalSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SignalSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Choice = questdlg('Sicuro?', ...
    'Chiudi', ...
    'Si','No','Cancel','Si');

switch Choice
    case 'Si'
        h = findall(0, 'tag', 'GUI_Schermata_Iniziale');
        delete(h);
    case 'No'
        
end


% --- Executes during object deletion, before destroying properties.
function GUI_Schermata_Iniziale_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to GUI_Schermata_Iniziale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global VG_projectPath;
if exist([VG_projectPath, '/temp'],'dir')
    delete([VG_projectPath, '/temp/*.mat']);
    clear all;
end
