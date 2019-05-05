function varargout = DELTA_ANALYSIS_HYPNOEXPORT(varargin)
% DELTA_ANALYSIS_HYPNOEXPORT MATLAB code for DELTA_ANALYSIS_HYPNOEXPORT.fig
%      DELTA_ANALYSIS_HYPNOEXPORT, by itself, creates a new DELTA_ANALYSIS_HYPNOEXPORT or raises the existing
%      singleton*.
%
%      H = DELTA_ANALYSIS_HYPNOEXPORT returns the handle to a new DELTA_ANALYSIS_HYPNOEXPORT or the handle to
%      the existing singleton*.
%
%      DELTA_ANALYSIS_HYPNOEXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_ANALYSIS_HYPNOEXPORT.M with the given input arguments.
%
%      DELTA_ANALYSIS_HYPNOEXPORT('Property','Value',...) creates a new DELTA_ANALYSIS_HYPNOEXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_ANALYSIS_HYPNOEXPORT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_ANALYSIS_HYPNOEXPORT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_ANALYSIS_HYPNOEXPORT

% Last Modified by GUIDE v2.5 09-May-2018 20:08:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_ANALYSIS_HYPNOEXPORT_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_ANALYSIS_HYPNOEXPORT_OutputFcn, ...
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


% --- Executes just before DELTA_ANALYSIS_HYPNOEXPORT is made visible.
function DELTA_ANALYSIS_HYPNOEXPORT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_ANALYSIS_HYPNOEXPORT (see VARARGIN)

% Choose default command line output for DELTA_ANALYSIS_HYPNOEXPORT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DELTA_ANALYSIS_HYPNOEXPORT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_ANALYSIS_HYPNOEXPORT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global main_path;
global sig_ECG;
global sig_respiro;
global fs_ecg;
global tempo_auto;
global shift_val;


%SELEZIONARE FINESTRA CON HYPNO APP
%start=str2num(get(handles.edit1,'String'));
%stop=str2num(get(handles.edit2,'String'));


%ECG=fullfile(main_path,'Export_ECG_hypno.mat'); %solo per provare adesso dopo adrà fatto con hypno app
%load(ECG);


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
			%save(handles.FilePathName.String, 'sig_tacogramma', 'sig_respirogramma', '-append');
			%disp(['Il File  [', handles.FilePathName.String, '] ', char(232), ' stato aggiornato']);
		end
		waitbar(3/10, wb);
		
		postTacoActivity(tacogramma, respirogramma, [], [], wb, 3/10, 10/10);
		
		delete(wb);
		
		% Teniamo traccia del file processato con GUI ECG
		%pfGUIECG = get(handles.FilePathName,'String');
		
        dir
		run(['GUI_ECG']); %modificato
		
	
guidata(hObject, handles);




% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Show Window BUTTON
function pushbutton1_Callback(hObject, eventdata, handles)

global main_path;
global sig_ECG;
global sig_respiro;
global fs_ecg;
global tempo_auto;
global export_start;
global export_stop;


export_start = str2num(char(get(handles.edit1,'String')));
export_stop = str2num(char(get(handles.edit2,'String')));

start=export_start;
stop=export_stop;

%shift_val=(start*10e5)/250; %valore di shift rispetto al delta per stampare LF/HF

start=start*(10e5);
stop=stop*(10e5);


axes(handles.axes1); cla;
axes(handles.axes2); cla;
axes(handles.axes3); cla;

%plot HYPNOGRAM
axes(handles.axes1);
SLEEP=fullfile(main_path,'events.mat');
load(SLEEP);
slim=length(lables);
i=1;
%omologa lables (format 1,2,3,4,5)
while((lables(i,1)~=6) && (i~=slim))
    i=i+1; 
end
if(lables(i,1)==6) 
    for(i=1:slim)
        if((lables(i,1)==3)||(lables(i,1)==4)) lables(i,1)=2; end
        if(lables(i,1)==5) lables(i,1)=3; end
        if(lables(i,1)==6) lables(i,1)=4; end
        if(lables(i,1)==7) lables(i,1)=5; end
        
    end
end
i=0;
X=lables(:,2);
Y=lables(:,1);
X=X'; Y=Y';
Y=Y*(-1);
x = reshape( [X;X], 2,[] ); x(2) = [];
y = reshape( [Y;Y], 2,[] ); y(end) = [];
vnan = NaN(size(X)) ;
xp = reshape([X;vnan;X],1,[]); xp([1:2 end]) = [] ;
yp = reshape([Y;Y;vnan],1,[]); yp(end-2:end) = [] ;
xv = reshape([X;X;vnan],1,[]); xv([1:3 end]) = [] ;
yv = reshape([Y;vnan;Y],1,[]); yv([1:2 end-1:end]) = [] ;
[uy,~,colidx] = unique(Y) ;
ncolor = length(uy) ;
colormap(cool(ncolor))
cd = reshape([colidx.';colidx.';vnan],1,[]); cd(end-2:end) = [] ;
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',5) ;
hold on
hv = plot(xv,yv,'k') ;
ylim([-6 0]);
xlim([start stop]);
set(gca,'Color',[1 1 1])
grid on;

ck_events=fullfile(main_path,'events.txt');



if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);
[data]= textscan(EVENT, '%s %s');
lee=length(data{1,1});

lex=lee-1;
evex=zeros(lex,2);

for(i=2:lee)

T1=data{1,1}(1,1);
T2=data{1,1}(i,1);
T3=data{1,2}(1,1);
T4=data{1,2}(i,1);
TC=clock;

T1=cell2mat(T1);
T2=cell2mat(T2);
T3=cell2mat(T3);
T4=cell2mat(T4);

str1=[num2str(TC(1:3)),' ',T1];
str2=[num2str(TC(1:3)),' ',T2];
str3=[num2str(TC(1:3)),' ',T3];
str4=[num2str(TC(1:3)),' ',T4];

t1=datevec(str1,'yyyy mm dd HH:MM:SS');
t2=datevec(str2,'yyyy mm dd HH:MM:SS');
t3=datevec(str3,'yyyy mm dd HH:MM:SS');
t4=datevec(str4,'yyyy mm dd HH:MM:SS');


inizio=etime(t1,t2);

if(inizio>0)
    inizio=(24*60*60)-inizio;
    inizio=inizio*250;

    fine=etime(t3,t4);
    fine=(24*60*60)-fine;
    fine=fine*250;
else
    inizio=etime(t2,t1);
    inizio=inizio*250;
    
    fine=etime(t4,t3);
    fine=fine*250;
end

%-----------------------------plots events
axes(handles.axes1);
hold on;
plot([inizio inizio],[-10 2],'--g','linewidth',2);
plot([fine fine],[-10 2],'--g','linewidth',2);


evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end


%plot ECG EXPORT
axes(handles.axes2);
ECG=fullfile(main_path,'ECG.mat');
load(ECG);
ECG_exp=ECG(start:stop);
axes(handles.axes2);
plot(ECG_exp,'color','b');
lim=length(ECG_exp);
xlim([0 lim]);
set(gca,'Color',[1 1 1]);
set(gca,'ytick',[]);
set(gca,'xtick',[]);
grid on;

%plot RESP EXPORT
axes(handles.axes3);
RESP=fullfile(main_path,'RESP.mat');
load(RESP);
RESP_exp=RESP(start:stop);
plot(RESP_exp,'color','b');
lim2=length(RESP_exp);
xlim([0 lim2]);
set(gca,'Color',[1 1 1])
set(gca,'ytick',[]);
set(gca,'xtick',[]);
grid on;


%variabili esportate per GUI
fs_ecg=250;
sig_ECG=ECG_exp;
sig_respiro=RESP_exp;
le=length(ECG_exp);
le1=le/250;
asd=4.8828e-4; %prima era 1
tempo_auto=linspace(asd,le1,le);
tempo_auto=tempo_auto';


guidata(hObject,handles);


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
