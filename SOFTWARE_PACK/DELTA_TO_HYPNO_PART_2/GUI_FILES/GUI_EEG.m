function varargout = GUI_EEG(varargin)
% GUI_EEG MATLAB code for GUI_EEG.fig
%      GUI_EEG, by itself, creates a new GUI_EEG or raises the existing
%      singleton*.
%
%      H = GUI_EEG returns the handle to a new GUI_EEG or the handle to
%      the existing singleton*.
%
%      GUI_EEG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EEG.M with the given input arguments.
%
%      GUI_EEG('Property','Value',...) creates a new GUI_EEG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_EEG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_EEG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_EEG

% Last Modified by GUIDE v2.5 23-Feb-2018 12:07:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_EEG_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_EEG_OutputFcn, ...
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


% --- Executes just before GUI_EEG is made visible.
function GUI_EEG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_EEG (see VARARGIN)

% Choose default command line output for GUI_EEG
handles.output = hObject;

%##########################################################################
% INIZIALIZZAZIONI ASPETTO GRAFICO

% Visibilita' di alcuni handles:
set(handles.legend_panel,'Visible','off');

%##########################################################################
% INSERIMENTO STRINGHE DISPONIBILI IN MENU A TENDINA

% Variabili globali utili:
global elettrodi;

%-------------------------------------------------------------------------%
% Menu scelta canale EEG da visualizzare (popup_eeg_show):
t=get(handles.popup_eeg_show,'String'); %Titolo menu a tendina
list={ t,elettrodi{:} };  %#ok<CCAT>
set(handles.popup_eeg_show,'String',list);

%-------------------------------------------------------------------------%
% Menu scelta set di canali per calcolo EI,PI,AI,MI:
% HINT: In "set_userdef**" inserire i set di canali consentiti allo user 
%       (come stringhe separate da virgole). Lasciare immutato il resto
%       del codice!
set_userdefEI={'F3,F4,F7,F8'};
set_userdefPIsx={'F3,AF3,AF7,F5,F7', 'F3,AF3'};
set_userdefPIdx={'F4,AF4,AF8,F6,F8', 'F4,AF4'};
set_userdefAI={'F3,AF3,F4,AF4,Fz,FPz','F3,AF3,F4,AF4,Fz'};
set_userdefMI={'F3,AF3'};

% Si controlla se nel EEG caricato sono disponibili tutti i canali
% richiesti in ciascun set: se manca anche un solo canale, l'intero set
% non viene proposto all'utente.
set_validiEI = check_chset_indiciEEG(elettrodi,set_userdefEI);
set_validiPIsx = check_chset_indiciEEG(elettrodi,set_userdefPIsx);
set_validiPIdx = check_chset_indiciEEG(elettrodi,set_userdefPIdx);
set_validiAI = check_chset_indiciEEG(elettrodi,set_userdefAI);
set_validiMI = check_chset_indiciEEG(elettrodi,set_userdefMI);

% Si compongono le liste valide per ciascun popup menu.
% EI:
t=get(handles.popup_ch_EI,'String'); %Titolo menu a tendina
list={ t,set_validiEI{:} };  %#ok<CCAT>
set(handles.popup_ch_EI,'String',list);
if length(list) == 2 %se c'è una sola scelta oltre al titolo la seleziona
	handles.popup_ch_EI.Value = 2;
end

% PI sinistra:
t=get(handles.popup_ch_PIsx,'String'); %Titolo menu a tendina
list={ t,set_validiPIsx{:} };  %#ok<CCAT>
set(handles.popup_ch_PIsx,'String',list);
if length(list) == 2
	handles.popup_ch_PIsx.Value = 2;
end

% PI destra:
t=get(handles.popup_ch_PIdx,'String'); %Titolo menu a tendina
list={ t,set_validiPIdx{:} };  %#ok<CCAT>
set(handles.popup_ch_PIdx,'String',list);
if length(list) == 2
	handles.popup_ch_PIdx.Value = 2;
end

% AI:
t=get(handles.popup_ch_AI,'String'); %Titolo menu a tendina
list={ t,set_validiAI{:} };  %#ok<CCAT>
set(handles.popup_ch_AI,'String',list);
if length(list) == 2
	handles.popup_ch_AI.Value = 2;
end

% MI:
t=get(handles.popup_ch_MI,'String'); %Titolo menu a tendina
list={ t,set_validiMI{:} };  %#ok<CCAT>
set(handles.popup_ch_MI,'String',list);
if length(list) == 2
	handles.popup_ch_MI.Value = 2;
end

%##########################################################################

%valori random, verranno resettati
handles.statistica_flag = true;
handles.legend_flag = false;
handles.showStatistica = true;
handles.showEvents = true;

handles = ResetFlags(handles);

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_EEG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SaveBtn.
function SaveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SaveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T_Windows;
global eventig;
global etichette_ev;
global fsg;

if ~isfield(handles,'PI') || ~isfield(handles,'MI') || ~isfield(handles,'AI') || ~isfield(handles,'EI')
    msgbox('Devi prima calcolare gli indici!');
    return;
end

if isempty(T_Windows)
    msgbox('Nessuna finestra selezionata!');
    return;
end

eventiCommon = zeros(size(eventig, 1), 1);
for evIdx = 1:size(eventig, 1)
    eventiCommon(evIdx) = timeEEG2Common(eventig(evIdx, 2), false);
end

TableEEG_Values = table();
for winIdx = 1:size(T_Windows, 1)
	% calcola gli indici
    [mPI, dPI, mMI, dMI, mAI, dAI, mEI, dEI] = getIndici(timeCommon2EEG(T_Windows(winIdx, 1), true), timeCommon2EEG(T_Windows(winIdx, 2), true), handles);

    %individua gli eventi più vicini a Start ed End
    [~, evtStartIdx] = min(abs(eventiCommon(:)/fsg - T_Windows(winIdx, 1)));
    evtStartCode = eventig(evtStartIdx, 1);
    [~, evtEndIdx] = min(abs(eventiCommon(:)/fsg - T_Windows(winIdx, 2)));
    evtEndCode = eventig(evtEndIdx, 1);

    TableEEG_Values(winIdx, :) = {...
        T_Windows(winIdx, 1), T_Windows(winIdx, 2),... % viene salvato il tempo comune
        evtStartCode, evtEndCode,...
        mPI, dPI,...
        mMI, dMI,...
        mAI, dAI,...
        mEI, dEI};
end

TableEEG_Values.Properties.VariableNames = {...
    'WinStart', 'WinEnd',...
    'EventStart', 'EventEnd',...
    'Pleasure_Mean','Pleasure_Std',...
    'Memorization_Mean','Memorization_Std',...
    'Attention_Mean','Attention_Std',...
    'Engagement_Mean','Engagement_Std'};
    
event_labels = etichette_ev; %#ok<NASGU>

%salva
[fileName, pathName] = uiputfile('*.mat','Salva con Nome','EEG_Features');
if ischar(fileName)
	save([pathName, fileName],'TableEEG_Values', 'event_labels');
	%disp(['File ', fileName, ' salvato']);
end


% % --- Executes on button press in tabella_xls.
% function tabella_xls_Callback(hObject, eventdata, handles)
% %%% DA FINIRE %%%
% % hObject    handle to tabella_xls (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% global finestra;
% 
% % Si sceglie dove salvare il file
% [filename,pathname] = uiputfile('*.xls','Save XLS File','EEG_features.xls');
% if ~filename || ~pathname
% 	return;
% end
% % Se esiste già, lo sovrascriviamo (funzione "xlswrite" non sovrascrive i
% % file xls esistenti, ma sovrascrive soltanto le singole celle all'interno
% % del file)
% if exist([pathname,filename],'file')
%     delete([pathname,filename]);
% end
% 
% % Disattivo il warning mostrato alla creazione di un nuovo foglio (non
% % serve se non si vogliono creare nuovi fogli)
% % warning('off','MATLAB:xlswrite:AddSheet');
% 
% % Scrivo gli header delle colonne sul file Excel
% numFoglioExcel=1;
% col_header = {'inizio', 'fine', 'evento', 'media PI', 'std PI', 'media AI', 'std AI', 'media MI', 'std MI', 'media EI', 'std EI'};
% xlswrite( [pathname,filename], col_header , numFoglioExcel, 'A1');
% 
% % Scrivo i valori contenuti nella matrice "finestra" sul file Excel
% %%% FINESTRA NON VIENE AGGIORNATA ORA %%%
% xlswrite( [pathname,filename], finestra , numFoglioExcel, 'A2');
% % warning('on','MATLAB:xlswrite:AddSheet');
% 
% % Visualizziamo automaticamente il file XLS appena creato
% %winopen('EEG_features.xls');
% winopen([pathname,filename]);


% --- Executes on button press in plotindici.
function plotindici_Callback(hObject, eventdata, handles)
% hObject    handle to plotindici (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global dati;
global elettrodi;
global eventig;
global fsg;
global T_Windows;
global tempo;

canaliPI_dx = leggi_popup_indiciEEG(handles.popup_ch_PIdx,elettrodi);
canaliPI_sx = leggi_popup_indiciEEG(handles.popup_ch_PIsx,elettrodi);
canaliMI = leggi_popup_indiciEEG(handles.popup_ch_MI,elettrodi);
canaliAI = leggi_popup_indiciEEG(handles.popup_ch_AI,elettrodi);
canaliEI = leggi_popup_indiciEEG(handles.popup_ch_EI,elettrodi);

if isempty(canaliEI) || isempty(canaliPI_dx) || isempty(canaliPI_sx) || isempty(canaliMI) || isempty(canaliAI)
    % Se l'utente seleziona per sbaglio il titolo di un menu a tendina:
    cla(handles.axesPI);
    cla(handles.axesAI);
    cla(handles.axesMI);
    cla(handles.axesEI);
    msgbox('Selezionare un set di canali per ogni indice.','Set non definito','warn')
    return;
end

w=0.6;
h= waitbar(w, 'Loading...');
pause(1);

[EI] = indice_engagement_new(dati,fsg,canaliEI);
[PI,MI,AI] = indici_gfp(dati,fsg,canaliPI_dx,canaliPI_sx,canaliMI,canaliAI);

waitbar(w+0.2,h, 'Loading...');
pause(1);

bWin = handles.baselineWin.Value-1;
if bWin > 0
    baseline_camp = round(T_Windows(bWin, :)*fsg);
    % converto in indici eeg
    baseline_camp(1) = timeCommon2EEG(baseline_camp(1), false);
    baseline_camp(2) = timeCommon2EEG(baseline_camp(2), false);
else
    baseline_camp = eventig(eventig(:,1)==3, 2);
    if length(baseline_camp) ~= 2
        baseline_camp = [1, length(tempo)];
    end
end

mPI = mean(PI(baseline_camp(1): baseline_camp(2)));
dPI = std(PI(baseline_camp(1):baseline_camp(2))); 

mAI = mean(AI(baseline_camp(1):baseline_camp(2)));
dAI = std(AI(baseline_camp(1):baseline_camp(2))); 

mMI = mean(MI (baseline_camp(1):baseline_camp(2)));
dMI = std(MI(baseline_camp(1):baseline_camp(2))); 

mEI = mean(EI(baseline_camp(1):baseline_camp(2)));

PInorm = (PI - (mPI)) / (dPI) ; % indici riferiti alla baseline
AInorm = (AI - (mAI)) / (dAI) ;
MInorm = (MI - (mMI)) / (dMI) ;
EInorm = (EI - (mEI)) ;

handles.EI = EInorm;
handles.AI = AInorm;
handles.PI = PInorm;
handles.MI = MInorm;

% % media mobile solo in visualizzazione
% coeffMovAv = ones(fsg, 1) * (1/fsg);
% 
% handles.AI_smooth = filtfilt(coeffMovAv, 1, AInorm);
% handles.PI_smooth = filtfilt(coeffMovAv, 1, PInorm);
% handles.MI_smooth = filtfilt(coeffMovAv, 1, MInorm);

waitbar(w+0.2,h, 'Loading...');
%pause(1);
delete(h);

%reset delle statistiche
handles = ResetFlags(handles);

guidata(hObject, handles);
PlotSignals(handles);
% global VG_AI;
% VG_AI = handles.AI;


% % --- Executes on button press in eventiBtn.
% function eventiBtn_Callback(hObject, eventdata, handles)
% % hObject    handle to eventiBtn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% handles = ToggleEvents(handles, []);
% guidata(hObject, handles);
% 
% PlotSignals(handles);


% % --- Executes on button press in statisticaBtn.
% function statisticaBtn_Callback(hObject, eventdata, handles)
% % hObject    handle to statisticaBtn (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% handles = ToggleStatistica(handles, []);
% guidata(hObject, handles);
% 
% PlotSignals(handles);


% --- Executes on button press in windowsBtn.
function windowsBtn_Callback(hObject, eventdata, handles)
% hObject    handle to windowsBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_editWindowsStruct;
global fsg;
global pfGUIEEG;
global VG_projectPath;
global eventig;
global etichette_ev;
global sigEEGplot;
global tempo;

myEventi = zeros(size(eventig));
if ~isempty(myEventi)
    myEventi(:,1) = eventig(:,1);
    for evIdx = 1:size(eventig, 1)
        myEventi(evIdx, 2) = timeEEG2Common(eventig(evIdx, 2), false);
    end
end

% set window editor
resetEditWindowsStruct();
VG_editWindowsStruct.tempo = tempo;
VG_editWindowsStruct.signal = sigEEGplot;
VG_editWindowsStruct.fs = fsg;
VG_editWindowsStruct.eventi = myEventi;
VG_editWindowsStruct.labelEventi = etichette_ev;
VG_editWindowsStruct.file = pfGUIEEG;
VG_editWindowsStruct.btnHandle = handles.reloadBtnEEG;
run([VG_projectPath, '/GUI_EditWindows']);


% --- Executes on button press in reloadBtnEEG.
function reloadBtnEEG_Callback(hObject, eventdata, handles)
% hObject    handle to reloadBtnEEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateBaselineWin(handles);
% UpdateWinChooser(handles);
PlotSignals(handles);


% --- Executes on selection change in popup_eeg_show.
function popup_eeg_show_Callback(hObject, eventdata, handles)
% hObject    handle to popup_eeg_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popup_eeg_show contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_eeg_show

PlotSignals(handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popup_eeg_show_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_eeg_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_ch_EI.
function popup_ch_EI_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popup_ch_EI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ch_EI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_ch_MI.
function popup_ch_MI_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popup_ch_MI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ch_MI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_ch_AI.
function popup_ch_AI_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popup_ch_AI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ch_AI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_ch_PIsx.
function popup_ch_PIsx_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popup_ch_PIsx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ch_PIsx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_ch_PIdx.
function popup_ch_PIdx_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function popup_ch_PIdx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_ch_PIdx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in baselineWin.
function baselineWin_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function baselineWin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to baselineWin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% % --- Executes on selection change in winChooser.
% function winChooser_Callback(hObject, eventdata, handles)
% PlotSignals(handles);


% % --- Executes during object creation, after setting all properties.
% function winChooser_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to winChooser (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: popupmenu controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      FUNZIONI DI SERVIZIO INTERNE                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% INIZIALIZZAZIONE POPUP MENU
% La funzione controlla se tra i canali del EEG caricato ("chlist") ï¿½
% sia possibile rinvenire tutti i canali richiesti nel set "chset".
% Se manca anche un solo canale richiesto dal set, l'intero set
% non viene proposto all'utente.
function set_validi = check_chset_indiciEEG(chlist,chset)

% INPUT:
% chlist = lista dei canali disponibili nel EEG (cell array di stringhe).
% chset  = lista dei canali richiesti dai set di canali definiti (cell
%          array di stringhe).
% OUTPUT:
% set_validi = nuova lista dei set di canali, epurata dei set contenenti
%              canali non disponibili nell'EEG caricato (cell array di
%              stringhe).

setn=length(chset);
whitelist=true(1,setn);

for j=1:setn
    
    C=strsplit(chset{j},',');
    
    for k=1:length(C)
        if strcmpi(chlist,C{k}) == 0
            whitelist(j) = 0;
            break;
        end
    end
    
end

set_validi = chset(whitelist);


%%%% LETTURA POPUP PER GLI INDICI EEG
function canali = leggi_popup_indiciEEG(popup_handle,chlist)

% INPUT:
% popup_handle = handle al popup menu dell'indice EEG considerato (handle
%                Matlab).
% chlist = lista dei canali disponibili nell'EEG caricato (cell array di
%          stringhe).
% OUTPUT:
% chset_num = canali numerici (numeri di righe sulla matrice dei dati EEG)
%             associati alla lista di canali contenuta nell'handle passato.

canali = cellstr( get(popup_handle,'String') );
canali = canali{ get(popup_handle,'Value') };
canali = strsplit(canali,',');

p=0;
for j=1:length(canali)
    % Ad ogni iterazione, p assume valore "1" in corrispondenza dei canali
    % richiesti:
    p = p + strcmpi(chlist,canali{j});
end

canali = find(p==1);


function PlotSignals(handles)
global dati;
global tempo;
global elettrodi;
global eventig;
global etichette_ev;
global fsg;
global T_Windows;
global sigEEGplot;

axHandles = {handles.axesEEG, handles.axesPI, handles.axesAI, handles.axesMI, handles.axesEI};
dataNames = {'', 'PI', 'AI', 'MI', 'EI'};
dataUnits = {'\muV', 'GFP [z-score]', 'GFP [z-score]', 'GFP [z-score]', 'u.a.'};
myData = {};

canale_eeg = cellstr(handles.popup_eeg_show.String);
chosen = canale_eeg{handles.popup_eeg_show.Value};
ch = strcmpi(elettrodi, chosen);
if sum(ch)~=0
    myData{1} = dati(ch==1,:);
    sigEEGplot=dati(ch==1,:);
else
    myData{1} = [];
end

hoIndici = true;
for statIdx = 2:length(dataNames)
    hoIndici = hoIndici && isfield(handles, dataNames{statIdx});
end
if hoIndici
    myData{2} = handles.PI;
    myData{3} = handles.AI;
    myData{4} = handles.MI;
    myData{5} = handles.EI;
end

%%% RESET AXES %%%
for statIdx = 1:length(axHandles)
    cla(axHandles{statIdx}, 'reset');
end

%%% PLOT FINESTRE %%%
if handles.showStatistica
    finestraColor = [0.73 0.83 0.96];
    for axIdx = 1:length(myData)
        if length(tempo) ~= length(myData{axIdx})
            continue;
        end
        axes(axHandles{axIdx}); %#ok<LAXES>
        hold on;
        yDisplayMin = floor(min(myData{axIdx}));
        yDisplayMax = ceil(max(myData{axIdx}));
        
        for winIdx = 1:size(T_Windows,1)
            % T_Windows contiene le finestre in unità temporali già
            % ordinate, in tempo comune
            
            % converto in tempo EEG
            myWin = [timeCommon2EEG(T_Windows(winIdx, 1), true), timeCommon2EEG(T_Windows(winIdx, 2), true)];
            % mostra la finestra sul grafico
            area(myWin, yDisplayMax*ones(size(myWin)), yDisplayMin, 'FaceColor', finestraColor, 'EdgeColor', finestraColor);
        end
        hold off;
    end
end

%%% PLOT DATI %%%
for axIdx = 1:length(myData)
    if length(tempo) ~= length(myData{axIdx})
        continue;
    end
    axes(axHandles{axIdx}); %#ok<LAXES>
    hold on;
    plot(tempo, myData{axIdx});
    xlabel('Tempo [s]','FontSize',10);%,'Units','normalized','Position',[0.5,-0.3]);
    ylabel(dataUnits{axIdx},'FontSize',10);
    
    yDisplayMin = floor(min(myData{axIdx}));
    yDisplayMax = ceil(max(myData{axIdx}));
    axis([tempo(1), tempo(end), yDisplayMin, yDisplayMax]);
    hold off;
end

%%% PLOT EVENTI %%%
if handles.showEvents
	for iax = 1:length(axHandles)
		handles.legend_flag = plot_eventi(handles.legend_panel,axHandles{iax},eventig,etichette_ev,fsg,handles.legend_flag);
	end
% 	guidata(handles.winChooser, handles);
	handles.legend_panel.Visible = 'On';
else
	handles.legend_panel.Visible = 'Off';
end

% %%% PLOT WINDOW INFO %%%
% if hoIndici && handles.showStatistica
%     nWin = handles.winChooser.Value-1;%la prima riga è il titolo
%     if nWin > 0
%         [mPI, dPI, mMI, dMI, mAI, dAI, mEI, dEI] = getIndici(timeCommon2EEG(T_Windows(nWin, 1), true), timeCommon2EEG(T_Windows(nWin, 2), true), handles);
%         infoData = [mPI, dPI; mAI, dAI; mMI, dMI; mEI, dEI];
%         % converto in tempo EEG
%         xi = ceil(timeCommon2EEG(T_Windows(nWin, 1), true)*fsg);
%         xf = floor(timeCommon2EEG(T_Windows(nWin, 2), true)*fsg);
%         temp = xi:xf; % Vettore dei campioni dell'intervallo
%         
%         for infoIdx = 2:length(dataNames)
%             c = ones(size(temp)) * infoData(infoIdx-1, 1); % Valori medi da plottare.
%             
%             axes(axHandles{infoIdx}); %#ok<LAXES>
%             hold on;
%             plot(tempo(temp) , c, 'r',...
%                 tempo(temp), c-infoData(infoIdx-1, 2), 'r--',...
%                 tempo(temp), c+infoData(infoIdx-1, 2), 'r--',...
%                 tempo(xi), c(1), 'r>',...
%                 tempo(xf), c(end), 'r<', 'MarkerSize', 10,'MarkerFaceColor', 'r');
%             hold off;
%         end
%     end
% end


function [mPI, dPI, mMI, dMI, mAI, dAI, mEI, dEI] = getIndici(t_start, t_end, handles)
global tempo;
% INIZIALIZZAZIONI PER TUTTI GLI INDICI
mPI = NaN;
dPI = NaN;
mMI = NaN;
dMI = NaN;
mAI = NaN;
dAI = NaN;
mEI = NaN;
dEI = NaN;

xi = find(tempo <= t_start,1,'last');
xf = find(tempo >= t_end,1,'first');

% PI
if isfield(handles,'PI')
	mPI = mean(handles.PI(xi:xf)); % Media del segnale PI tra i due istanti
								   % selezionati
	dPI= std(handles.PI(xi:xf));   % Deviazione standard sullo stesso tratto
end

%AI
if isfield(handles,'AI')
	mAI = mean(handles.AI(xi:xf)); % Media del segnale AI tra i due istanti
								   % selezionati
	dAI = std(handles.AI(xi:xf));  % Deviazione standard sullo stesso tratto
end

%MI
if isfield(handles,'MI')
	mMI = mean(handles.MI(xi:xf)); % Media del segnale AI tra i due istanti
								   % selezionati
	dMI = std(handles.MI(xi:xf));  % Deviazione standard sullo stesso tratto
end

%EI
if isfield(handles,'EI')
	mEI = mean(handles.EI(xi:xf)); % Media del segnale AI tra i due istanti
								   % selezionati
	dEI = std(handles.EI(xi:xf));  % Deviazione standard sullo stesso tratto
end


function handles = ResetFlags(handles)

handles.statistica_flag = true; %inutile
handles.legend_flag = false;
% guidata(handles.eventiBtn, handles);

% handles = ToggleEvents(handles, true); %showEvents = true
% handles = ToggleStatistica(handles, true); %showStatistica = true

%aggiorna la tendina della baseline
UpdateBaselineWin(handles);


% function handles = ToggleEvents(handles, setShow)
% % setShow può essere un valore booleano o []
% % se vale [] la funzopne invertirà il valore di visualizzazione
% if isempty(setShow)
% 	if handles.showEvents
% 		handles.showEvents = false;
% 	else
% 		handles.showEvents = true;
% 	end
% elseif ~setShow
% 	handles.showEvents = false;
% else
% 	handles.showEvents = true;
% end
% 
% if handles.showEvents
% 	handles.eventiBtn.String = 'Nascondi Eventi';
% else
% 	handles.eventiBtn.String = 'Mostra Eventi';
% end
% 
% 
% function handles = ToggleStatistica(handles, setShow)
% % setShow può essere un valore booleano o []
% % se vale [] la funzopne invertirà il valore di visualizzazione
% if isempty(setShow)
% 	handles.showStatistica = ~handles.showStatistica;
% elseif ~setShow
% 	handles.showStatistica = false;
% else
% 	handles.showStatistica = true;
% end
% guidata(handles.winChooser, handles);
% 
% if handles.showStatistica
% 	handles.statisticaBtn.String = 'Nascondi Statistica';
% else
% 	handles.statisticaBtn.String = 'Mostra Statistica';
% end
% UpdateWinChooser(handles);
% guidata(handles.winChooser, handles);


function UpdateBaselineWin(handles)
global T_Windows;

oldList = cellstr(handles.baselineWin.String);
newList = cell(size(T_Windows, 1)+1, 1);
newList{1} = oldList{1};
if size(T_Windows, 1) > 0
    for lIdx = 2:size(T_Windows, 1)+1
        newList{lIdx} = ['Finestra ',int2str(lIdx-1)];
    end
end
oldVal = handles.baselineWin.Value;
if size(T_Windows, 1)+1 < oldVal
    oldVal = 1;
end
handles.baselineWin.Value = oldVal;
baselineWin_Callback(handles.baselineWin, [], handles);
handles.baselineWin.String = newList;


% function UpdateWinChooser(handles)
% global T_Windows;
% 
% winLength = handles.showStatistica*size(T_Windows, 1);
% newList = cell(winLength + 1, 1);
% 
% % conserva il titolo
% oldList = cellstr(handles.winChooser.String);
% newList{1} = oldList{1};
% 
% % aggiorna il contenuto
% if winLength > 0
% 	for lIdx = 2:size(T_Windows, 1)+1
% 		newList{lIdx} = ['Finestra ',int2str(lIdx-1)];
% 	end
% end
% 
% % aggiorna la tendina
% handles.winChooser.Value = 1;
% handles.winChooser.Callback(handles.winChooser, []);
% handles.winChooser.String = newList;


function eegTime = timeCommon2EEG(commonTime, isTime)
%%% converte un tempo sul tracciato comune in uno sul tracciato EEG
% isTime: valore booleano
%	true se l'input commonTime è espresso in secondi
%	false se l'input commonTime è espresso in indici del vettore tempo
% l'output conserva l'unità di misura dell'input
global eventiReject;
global fsg;
global tempo;
% if isTime
%     fprintf('tempo comune: %.2fs\n',commonTime);
% else
%     fprintf('tempo comune: %.2fs\n',commonTime/fsg);
% end
%converto tutto in indici (eventiReject è in indici)
if isTime
    commonTime = round(commonTime * fsg);
end

for rejIdx = 1:size(eventiReject, 1)
    rejStart = eventiReject(rejIdx, 1);
    rejEnd = eventiReject(rejIdx, 2);
    if commonTime < rejStart
        continue;
    elseif commonTime > rejEnd
        commonTime = commonTime - (rejEnd - rejStart);
    else
        commonTime = rejStart;
    end
end

eegTime = commonTime;

if eegTime < 1
    eegTime = 1;
end
if eegTime > length(tempo)
    eegTime = length(tempo);
end

if isTime
    eegTime = eegTime/fsg;
else
    eegTime = round(eegTime);
end
% if isTime
%     fprintf('tempo eeg: %.2fs\n',eegTime);
% else
%     fprintf('tempo eeg: %.2fs\n',eegTime/fsg);
% end


function commonTime = timeEEG2Common(eegTime, isTime)
%%% converte un tempo sul tracciato EEG in uno sul tracciato comune
% isTime: valore booleano true se l'input commonTime è espresso in secondi
% false se l'input commonTime è espresso in indici del vettore tempo
% l'output conserva l'unità di misura dell'input
global eventiReject;
global fsg;

%converto tutto in indici (eventiReject è in indici)
if isTime
    eegTime = round(eegTime * fsg);
end

for rejIdx = 1:size(eventiReject, 1)
    rejStart = eventiReject(rejIdx, 1);
    rejEnd = eventiReject(rejIdx, 2);
    if eegTime <= rejStart
        break;
    else
        eegTime = eegTime + (rejEnd - rejStart);
    end
end

commonTime = eegTime;

if commonTime < 1
    commonTime = 1;
    return;
end
% non posso fare un controllo sul tempo finale

if isTime
    commonTime = commonTime/fsg;
else
    commonTime = round(commonTime);
end


function falseCommonTime = GetFalseCommonTime()
global eventiReject;
global fsg;
global tempo;

rejLength = sum(eventiReject(:,2)-eventiReject(:,1));
falseCommonTime = 0:(length(tempo)+rejLength-1);
falseCommonTime = falseCommonTime/fsg;


% --- Executes on button press in IAFselection.
function IAFselection_Callback(hObject, eventdata, handles)
% hObject    handle to IAFselection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Choice = questdlg('Si è selezionata una opportuna finestra di baseline?', ...
    'Selezione alpha', ...
    'Si','No','Cancel','Si');

switch Choice
    case 'Si'
        figure
        %%%%%%%%%%%%%%%%%%%%%% Per Adriana da completare con la selezione
        %%%%%%%%%%%%%%%%%%%%%% banda IAF
    case 'No'
end