function varargout = DELTA_2_HYPNOEXPORT(varargin)
% DELTA_2_HYPNOEXPORT MATLAB code for DELTA_2_HYPNOEXPORT.fig
%      DELTA_2_HYPNOEXPORT, by itself, creates a new DELTA_2_HYPNOEXPORT or raises the existing
%      singleton*.
%
%      H = DELTA_2_HYPNOEXPORT returns the handle to a new DELTA_2_HYPNOEXPORT or the handle to
%      the existing singleton*.
%
%      DELTA_2_HYPNOEXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_2_HYPNOEXPORT.M with the given input arguments.
%
%      DELTA_2_HYPNOEXPORT('Property','Value',...) creates a new DELTA_2_HYPNOEXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_2_HYPNOEXPORT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_2_HYPNOEXPORT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_2_HYPNOEXPORT

% Last Modified by GUIDE v2.5 24-Feb-2019 20:55:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_2_HYPNOEXPORT_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_2_HYPNOEXPORT_OutputFcn, ...
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


% --- Executes just before DELTA_2_HYPNOEXPORT is made visible.
function DELTA_2_HYPNOEXPORT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_2_HYPNOEXPORT (see VARARGIN)

% Choose default command line output for DELTA_2_HYPNOEXPORT
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

















% UIWAIT makes DELTA_2_HYPNOEXPORT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_2_HYPNOEXPORT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)


global EEG_load;
global ECG_load;
%global RESP_load;
%global EEG_exp;
%global ECG_exp;
%global RESP_exp;
global HYPNO_DEEP;
%global HYPNO_DEEP_exp;
global lables;

global REM_HYPNO;
global N2_HYPNO;
global N3_HYPNO;
global HYPNO_PRINT;
global SIEZ_load;

exp_start=str2num(char(get(handles.edit1,'String')));
exp_stop=str2num(char(get(handles.edit2,'String')));

%clear delta_start;
%clear delta_stop;
%clear start;
%clear stop;
%clear start_2;
%clear stop_2;
%clear EEG_exp;
%clear ECG_exp;
%clear RESP_exp;

%global HYPNO_DEEP;


delta_start=exp_start;
delta_stop=exp_stop;

start=delta_start*250e04;
stop=delta_stop*250e04;

start_2=delta_start*10e02;
stop_2=delta_stop*10e02;

EEG_exp(:,1)=EEG_load(start:stop,1);
EEG_exp(:,2)=EEG_load(start:stop,2);
ECG_exp=ECG_load(start:stop);
%RESP_real=RESP_load(start:stop);
HYPNO_DEEP_exp=HYPNO_DEEP(start_2:stop_2);

[RESP_exp]=maling_respiro_beta1(ECG_exp);

axes(handles.axes3); cla;
plot(RESP_exp); grid on; 
ylim([min(RESP_exp) max(RESP_exp)]); 
xlim([0 length(ECG_exp)]);
%plot(sig_respirogramma(:,1),respirogramma,'linewidth',2,'color','k');
%hold on;
%sig_respirogramma_2(:,1)=sig_respirogramma(:,1).*250;
%subplot(2,1,1);
%plot(sig_respirogramma_2(:,1),f_data,'-r'); grid on; xlim([0 length(ECG_exp)]);
%hold on; plot(RESP_exp); 
%hold on; plot(RESP_real);
%hold on; plot(xq,yq1,':.');



axes(handles.axes2); cla;
plot(ECG_exp); grid on; xlim([0 length(ECG_exp)]); ylim([min(ECG_exp) max(ECG_exp)]);


length(ECG_exp)
length(RESP_exp)
length(HYPNO_PRINT)


%estrai lables
if(HYPNO_DEEP_exp(1)==0) lables(1,1)=1; end
if(HYPNO_DEEP_exp(1)==1) lables(1,1)=5; end
lables(1,2)=1;
k=2;

str1=HYPNO_DEEP_exp(1);
prova=length(HYPNO_DEEP_exp);

for(i=2:prova)
    
    str_now=HYPNO_DEEP_exp(i);
    
    
    if(str1~=str_now)
        
        lables(k,2)=i*2500;
        str1=str_now;
        
        if(str_now==0)
          lables(k,1)=1;
        end
        if(str_now==1)
            lables(k,1)=5;
        end
        k=k+1;
    end
end

pippuzzo=length(lables(:,2));

for(i=i:pippuzzo)
    lables(i,2)=lables(i,2)+start;
end

cicciuzzo=pippuzzo+1;

lables(cicciuzzo,1)=1;
lables(cicciuzzo,2)=(delta_stop-delta_start)*10e03*250;

cia=1;

axes(handles.axes1); cla;
lung=length(REM_HYPNO);
xx=linspace(1,lung,lung);
plot(xx,REM_HYPNO,'color',[0.8 0.8 0.8]);
hold on; plot(xx, N2_HYPNO,'color',[0.8 0.8 0.8]);
hold on; plot(xx, N3_HYPNO,'color',[0.8 0.8 0.8]);
%hold on; plot(xx, HYPNO_PRINT,'linewidth',2);

y=0:1:500;
for(t=1:length(SIEZ_load))
    if(SIEZ_load(t)==1)
        x=t/250;
        line([x x],[0 500],'color','g','LineWidth',2);
    end
end




i=0;
X=xx;
Y=HYPNO_PRINT';
%X=X'; Y=Y';
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
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',4) ;
hold on
hv = plot(xv,yv,':k') ;
grid on;
%plot(times_r,hypno_deep);
xlim([0 length(HYPNO_PRINT)]);
ylim([-4 2]);



delta_lim=length(EEG_load);

fss=lung/delta_lim*250;

start=(delta_start*fss)*10e03;
stop=(delta_stop*fss)*10e03;


xlim([start stop]);
ylim([-4 1]);



%%---------- print delta
global Delta_s;
global times_r;

axes(handles.axes4); cla;
%plot(times_r,Delta_r,'color',[0.8 0.8 0.8]);
hold on; plot(times_r,Delta_s,'color',[1 0 1],'linewidth',2); grid on;
hold on; area(times_r,Delta_s);
%fs=length(Delta_r)/0.1;

xlim([exp_start*10e03 exp_stop*10e03]);
ylim([0 max(Delta_s)]);

y=0:1:500;
for(t=1:length(SIEZ_load))
    if(SIEZ_load(t)==1)
        x=t/250
        line([x x],[0 500],'color','g','LineWidth',2);
    end
end



%% -------ready for export
global save_ECG;
global save_respiro;
global save_tempo_auto;


le=length(ECG_exp);
le1=le/250;
asd=4.8828e-4; %prima era 1
save_tempo_auto=linspace(asd,le1,le);
save_tempo_auto=save_tempo_auto';

save_ECG=ECG_exp;
save_respiro=RESP_exp;

clear ECG_exp
clear RESP_exp
clear start
clear stop


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------- SAVE
function pushbutton3_Callback(hObject, eventdata, handles)

global save_ECG;
global save_respiro;
global save_tempo_auto;

sig_ECG=save_ECG;
sig_respiro=save_respiro;
tempo_auto=save_tempo_auto;
fs_ecg=250;

[file,path]=uiputfile('*.mat','Export');

if (file==0)
    return;
end
        
file=fullfile(path,file);
save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');


% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)


%global main_path;
global sig_ECG;
global sig_respiro;
global fs_ecg;
global tempo_auto;
global shift_val;


%SELEZIONARE FINESTRA CON HYPNO APP
%start=str2num(get(handles.edit1,'String'));
%stop=str2num(get(handles.edit2,'String'));


%ECG=fullfile(main_path,'Export_ECG_hypno.mat'); %solo per provare adesso dopo adr� fatto con hypno app
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



% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
