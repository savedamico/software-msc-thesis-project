function varargout = GUI_ECG(varargin)
% GUI_ECG MATLAB code for GUI_ECG.fig
%      GUI_ECG, by itself, creates a new GUI_ECG or raises the existing
%      singleton*.
%
%      H = GUI_ECG returns the handle to a new GUI_ECG or the handle to
%      the existing singleton*.
%
%      GUI_ECG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ECG.M with the given input arguments.
%
%      GUI_ECG('Property','Value',...) creates a new GUI_ECG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_ECG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_ECG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_ECG

% Last Modified by GUIDE v2.5 01-Dec-2017 11:13:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_ECG_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_ECG_OutputFcn, ...
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


% --- Executes just before GUI_ECG is made visible.
function GUI_ECG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_ECG (see VARARGIN)

% Choose default command line output for GUI_ECG
handles.output = hObject;

%##########################################################################
% INIZIALIZZAZIONI ASPETTO GRAFICO

% Legenda eventi:
set(handles.legend_panel,'Visible','off');
% set flags
handles.legend_flag = false;
handles.statistica_flag = true;
handles.showStatistica = true;
guidata(hObject, handles);

% mostra i grafici all'apertura
handles.ckbECG.Callback(handles.ckbECG, []);
%##########################################################################

UpdateWindows(handles);
PlotTacoResp(handles);

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_ECG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function UpdateWindows(handles)
global T_Windows;
%aggiorno il menu a tendina
newList = cell(size(T_Windows, 1)+1, 1);
oldList = cellstr(handles.WindowsMenu.String);
newList{1} = oldList{1};
for winIdx = 1:size(T_Windows, 1)
    newList{winIdx+1} = ['Finestra ',num2str(winIdx)];
end
handles.WindowsMenu.String = newList;
handles.WindowsMenu.Value = 1;
handles.WindowsMenu.Callback(handles.WindowsMenu, []);
handles.WindowsMenu.String = newList;

if size(T_Windows, 1) > 0
    handles.SigProcessBtn.Enable = 'On';
else
    handles.SigProcessBtn.Enable = 'Off';
end


% --- Executes on button press in ckbECG.
function ckbECG_Callback(hObject, eventdata, handles)
% hObject    handle to ckbECG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ckbECG

global VG_tempo_auto;
global VG_sig_ECG;

global VG_eventi;
global etichette_ev;
global VG_fs;

if ~(hObject.Value) %unchecked
    set(handles.FullScreenECG, 'Enable', 'Off');
    cla(handles.ECGgraph, 'reset')
else
    axes(handles.ECGgraph);
    plot(VG_tempo_auto, VG_sig_ECG, 'k');
    axis([VG_tempo_auto(1) VG_tempo_auto(1)+10 min(VG_sig_ECG) max(VG_sig_ECG)]);
    title('ECG');
    xlabel('T [s]');
    ylabel('Potenziale [mV]');
    grid on;
	pan xon;
    
    %--------------- LEGENDA EVENTI GENERALIZZATA ------------------
    % NB: Richiede struct array "events_label" nei file .MAT caricati
    %     attraverso "GUI_Schermata_Iniziale"
    
    handles.legend_flag = ...
        plot_eventi(handles.legend_panel,handles.ECGgraph,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
    
    %--------------------------------------------------------------
    
    
    set(handles.FullScreenECG, 'Enable', 'On');
    
end
handles.ECGgraph.ButtonDownFcn = @ECGgraph_ButtonDownFcn;

% Update handles structure
guidata(hObject, handles);


% --- Executes on mouse press over axes background.
function ECGgraph_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to ECGgraph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(hObject);
pan xon;


% --- Executes on button press in ckbTACO.
function ckbTACO_Callback(hObject, eventdata, handles)
% hObject    handle to ckbTACO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ckbTACO

if handles.ckbTACO.Value || handles.ckbRESP.Value
    handles.FullScreenTaco.Enable = 'on';
else
    handles.FullScreenTaco.Enable = 'off';
end
PlotTacoResp(handles);


% --- Executes on button press in ckbRESP.
function ckbRESP_Callback(hObject, eventdata, handles)
% hObject    handle to ckbRESP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ckbRESP

if handles.ckbTACO.Value || handles.ckbRESP.Value
    handles.FullScreenTaco.Enable = 'on';
else
    handles.FullScreenTaco.Enable = 'off';
end
PlotTacoResp(handles);


% --- Executes on button press in FullScreenECG.
function FullScreenECG_Callback(hObject, eventdata, handles)
% hObject    handle to FullScreenECG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global VG_tempo_auto;
global VG_sig_ECG;
global VG_fs;

% uso la fig FullScreen
global VG_fullscreenStruct;
global VG_projectPath;
myPlotStruct = newFullscreenStruct();
myPlotStruct.data(1).signal = VG_sig_ECG;
myPlotStruct.data(1).time = VG_tempo_auto;
myPlotStruct.fs = VG_fs;
myPlotStruct.nParts = round((length(VG_sig_ECG)/VG_fs)/10);
myPlotStruct.title = 'ECG';
myPlotStruct.xlabel = 'T [s]';
myPlotStruct.ylabel = 'Potenziale [mV]';
myPlotStruct.events = true;
VG_fullscreenStruct(1) = myPlotStruct;
run([VG_projectPath, '/GUI_FullScreen']);


% --- Executes on button press in FullScreenTaco.
function FullScreenTaco_Callback(hObject, eventdata, handles)
% hObject    handle to FullScreenTaco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global VG_taco;
global VG_resp;
global VG_fs;

% uso la fig FullScreen
global VG_fullscreenStruct;
global VG_projectPath;
if handles.ckbTACO.Value
    myPlotStruct = newFullscreenStruct();
    myPlotStruct.data(1).signal = VG_taco(:,2);
    myPlotStruct.data(1).time = VG_taco(:,1);
    myPlotStruct.fs = VG_fs;
    myPlotStruct.nParts = 10;
    myPlotStruct.title = 'Tacogramma';
    myPlotStruct.xlabel = 'T [s]';
    myPlotStruct.ylabel = 'R-R [s]';
    myPlotStruct.events = true;
    VG_fullscreenStruct(1) = myPlotStruct;
end
if handles.ckbRESP.Value
    myPlotStruct = newFullscreenStruct();
    myPlotStruct.data(1).signal = VG_resp(:,2);
    myPlotStruct.data(1).time = VG_resp(:,1);
    myPlotStruct.fs = VG_fs;
    myPlotStruct.nParts = 10;
    myPlotStruct.title = 'Respirogramma';
    myPlotStruct.xlabel = 'T [s]';
    myPlotStruct.ylabel = 'A.U.';
    myPlotStruct.events = true;
    if handles.ckbTACO.Value
        respIdx = 2;
    else
        respIdx = 1;
    end
    VG_fullscreenStruct(respIdx) = myPlotStruct;
end

run([VG_projectPath, '/GUI_FullScreen']);


% --- Executes on button press in SigProcessBtn.
function SigProcessBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SigProcessBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% POTENZA:
% calcolata come l'area sottesa alla curva dell'autospettro di potenza e
% si misura in mV^2.

global VG_projectPath;
global VG_taco;
global VG_tempo_generale;


Choice = questdlg(['La Finestratura ', char(232),' quella desiderata?'], ...
    'Continuare?', ...
    'Si','No','Cancel','Si');
switch Choice
    case 'Si'
		%assegno un valore corretto a VG_tempo_generale
		VG_tempo_generale = VG_taco(:,1);
		
        run([VG_projectPath, '/GUI_ECG_Windows']);
    case 'No'
        % nothing happens
end


% --- Executes on button press in ResetBtn.
function ResetBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ResetBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Choice = questdlg('I dati attuali verranno cancellati. Continuare?', ...
    'Reset', ...
    'Si','No','Cancel','Si');
switch Choice
    case 'Si'
        h = findall(0, 'tag', 'GUI_ECG');
        delete(h);
end


% --- Executes on button press in WindowsBtn.
function WindowsBtn_Callback(hObject, eventdata, handles)
% hObject    handle to WindowsBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global VG_taco;
global VG_resp;

global VG_eventi;
global etichette_ev;
global VG_fs;

global VG_editWindowsStruct;
global pfGUIECG;
global VG_projectPath;

% set window editor
resetEditWindowsStruct();
scala = (max(VG_taco(:,2)) - min(VG_taco(:,2))) / (max(VG_resp(:,2)) - min(VG_resp(:,2)));
shift = mean(VG_taco(:,2), 1) - scala * mean(VG_resp(:,2), 1);
VG_editWindowsStruct.tempo = VG_taco(:,1);
VG_editWindowsStruct.signal = [VG_taco(:,2), scala .* VG_resp(:,2) + shift];
VG_editWindowsStruct.fs = VG_fs;
VG_editWindowsStruct.eventi = VG_eventi;
VG_editWindowsStruct.labelEventi = etichette_ev;
VG_editWindowsStruct.file = pfGUIECG;
VG_editWindowsStruct.btnHandle = handles.reloadBtnECG;
run([VG_projectPath, '/GUI_EditWindows']);


function PlotTacoResp(handles)
% ToDo dividere in due funzioni per rendere la funzione applicabile in
% altri ambiti (checkbox in particolare)
global VG_taco;
global VG_resp;
global VG_eventi;
global etichette_ev;
global VG_fs;
global T_Windows;

finestraColor = [0.73 0.83 0.96];
finestraSelectedColor = [0.60 0.70 1];

axes(handles.TACOgraph)
cla(handles.TACOgraph, 'reset');
pan off;
if handles.ckbTACO.Value
    hold on;
    if handles.showStatistica
        yArea = max(VG_taco(:, 2))*ones(1, 2);
        yMin = min(VG_taco(:, 2));

        %Aree Tacogramma
        for wIdx = 1:size(T_Windows,1)
            area(T_Windows(wIdx,:), yArea , yMin, 'FaceColor', finestraColor, 'EdgeColor', finestraColor);
        end

        %evidenzia finestra selezionata
        if isfield(handles, 'WindowsMenu')
            nWin = handles.WindowsMenu.Value-1;%la prima riga è il titolo
            if nWin > 0
                % mostra la finestra sul grafico
                area(T_Windows(nWin,:), yArea, yMin, 'FaceColor', finestraSelectedColor, 'EdgeColor', finestraSelectedColor);
            end
        end
    end
    % plot tacogramma
    plot(VG_taco(:, 1), VG_taco(:, 2), 'k');
    axis([0 max(VG_taco(:,1)) min(VG_taco(:, 2)) max(VG_taco(:, 2))]);
    hold off;
	title('Tacogramma');
	ylabel('R-R [s]');
    handles.legend_flag = plot_eventi(handles.legend_panel,handles.TACOgraph,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
    guidata(handles.ckbTACO, handles);
end

axes(handles.RESPgraph)
cla(handles.RESPgraph, 'reset');
pan off;
if handles.ckbRESP.Value
    hold on;
    if handles.showStatistica
        yArea = max(VG_resp(:, 2))*ones(1, 2);
        yMin = min(VG_resp(:, 2));

        %Aree Respirogramma
        for wIdx = 1:size(T_Windows,1)
            area(T_Windows(wIdx,:), yArea, yMin, 'FaceColor', finestraColor, 'EdgeColor', finestraColor);
        end

        %evidenzia finestra selezionata
        if isfield(handles, 'WindowsMenu')
            nWin = handles.WindowsMenu.Value-1;%la prima riga è il titolo
            if nWin > 0
                % mostra la finestra sul grafico
                area(T_Windows(nWin,:), yArea, yMin, 'FaceColor', finestraSelectedColor, 'EdgeColor', finestraSelectedColor);
            end
        end
    end
    %plot respirogramma
    plot(VG_resp(:, 1), VG_resp(:, 2), 'k');
    axis([0 max(VG_resp(:,1)) min(VG_resp(:, 2)) max(VG_resp(:, 2))]);
    hold off;
	title('Respirogramma');
	xlabel('Time [s]');
	ylabel('N.A.');
    handles.legend_flag = plot_eventi(handles.legend_panel,handles.RESPgraph,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
    guidata(handles.ckbRESP, handles);
end

guidata(handles.ckbRESP, handles);


% --- Executes on button press in CloseBtn.
function CloseBtn_Callback(hObject, eventdata, handles)
% hObject    handle to CloseBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Choice = questdlg(['Il Programma verr', char(224),' chiuso. Continuare?'], ...
	'Chiudi', ...
	'Si','No','Cancel','Si');

switch Choice
    case 'Si'
        h = findall(0, 'tag', 'GUI_ECG');
        delete(h);
    case 'No'
end


% --- Executes on selection change in WindowsMenu.
function WindowsMenu_Callback(hObject, eventdata, handles)
% hObject    handle to WindowsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns WindowsMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from WindowsMenu
global T_Windows;

wIdx=hObject.Value-1;
if wIdx>0
    set(handles.WindowStartText,'String',T_Windows(wIdx,1));
    set(handles.WindowEndText,'String',T_Windows(wIdx,2));
end
if hObject.Value == 1
    set(handles.WindowStartText,'String','');
    set(handles.WindowEndText,'String','');
end
PlotTacoResp(handles);


% --- Executes during object creation, after setting all properties.
function WindowsMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to WindowsMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TacoEditBtn.
function TacoEditBtn_Callback(hObject, eventdata, handles)
% hObject    handle to TacoEditBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
run([VG_projectPath, '/GUI_TacoEditor']);


% --- Executes on button press in reloadBtnECG.
function reloadBtnECG_Callback(hObject, eventdata, handles)
% hObject    handle to reloadBtnECG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindows(handles);
PlotTacoResp(handles);


% --- Executes on button press in ViewSpectraBtn.
function ViewSpectraBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ViewSpectraBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
run([VG_projectPath, '/GUI_ECG_Spectra']);


% --- Executes on button press in ExportBtn.
function ExportBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ExportBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_taco;
global VG_resp;
global VG_MSC;
global VG_fr_dec;
global P_VLF_Taco; %#ok<NUSED>
global P_LF_Taco; %#ok<NUSED>
global P_HF_Taco; %#ok<NUSED>
global P_VLF_Resp; %#ok<NUSED>
global P_LF_Resp; %#ok<NUSED>
global P_HF_Resp; %#ok<NUSED>
global VG_S1;
global VG_S2;
global VG_S1_coer;
global VG_S2_coer;

tacogramma = VG_taco; %#ok<NASGU>
respirogramma = VG_resp; %#ok<NASGU>
coerenza = VG_MSC; %#ok<NASGU>
asseFrequenze = VG_fr_dec; %#ok<NASGU>
potenzaCoerenteTaco = VG_S1_coer; %#ok<NASGU>
potenzaCoerenteResp = VG_S2_coer; %#ok<NASGU>
potenzaIncoerenteTaco = VG_S1-VG_S1_coer; %#ok<NASGU>
potenzaIncoerenteResp = VG_S2-VG_S2_coer; %#ok<NASGU>

[fileName, pathName] = uiputfile('*.mat','Salva con Nome','export_ECG');
if ischar(fileName)
	save([pathName, fileName],...
		'tacogramma','respirogramma',...
		'potenzaCoerenteTaco','potenzaCoerenteResp',...
		'potenzaIncoerenteTaco','potenzaIncoerenteResp',...
		'coerenza','asseFrequenze',...
		'P_VLF_Taco','P_VLF_Resp',...
		'P_LF_Taco','P_LF_Resp',...
		'P_HF_Taco','P_HF_Resp');
else
	return;
end
