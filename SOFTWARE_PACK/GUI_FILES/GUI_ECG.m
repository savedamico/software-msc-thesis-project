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

% Last Modified by GUIDE v2.5 09-May-2018 10:58:18

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

% Legenda eventi:
set(handles.legend_panel,'Visible','off');
% set flags
handles.legend_flag = false;
handles.showStatistica = true;
guidata(hObject, handles);

UpdateWindows(handles);
PlotTacoResp(handles);

global VG_p;
global VG_lambda;
handles.modelOrderText.String = num2str(VG_p);
handles.modelLambdaText.String = num2str(VG_lambda);

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

run(['GUI_FullScreen']); %modificato


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

%assegno un valore aggiornato a VG_tempo_generale
VG_tempo_generale = VG_taco(:,1);

nWin = handles.WindowsMenu.Value-1;%la prima riga è il titolo
if nWin <= 0
    msgbox('Selezionare una finestra da esaminare');
    return;
end

run(['GUI_ECG_Windows(', num2str(nWin), ')']); %modificato


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
run(['GUI_EditWindows']); %modificato


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
Choice = questdlg(['La finestra verr', char(224),' chiusa. Continuare?'], ...
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
run(['GUI_TacoEditor']); %modificato


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
global VG_taco;
global VG_resp;
global VG_p;
global VG_lambda;
myOrder = str2double(handles.modelOrderText.String);
myLambda = str2double(handles.modelLambdaText.String);
if VG_p ~= myOrder || VG_lambda ~= myLambda
    wb = waitbar(0, 'Loading...');
    postTacoActivity(VG_taco, VG_resp, myOrder, myLambda, wb);
    delete(wb);
end
run(['GUI_ECG_Spectra']); %modificato


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
global P_LF_NU_Taco; %#ok<NUSED>
global P_HF_NU_Taco; %#ok<NUSED>
global VG_S1;
global VG_S2;
global VG_S1_coer;
global VG_S2_coer;
global VG_PSD11;
global VG_PSD12;
global VG_PSD21;
global VG_PSD22;
global P_Coer;
global P_Incoer;
global P_RappCoer;
global PSD_parz_LF;
global PSD_parz_HF;
global PSD_parz_LF_NU;
global PSD_parz_HF_NU;
global rapp_PSD_parz;
%global shift_val;
global export_start;
global export_stop;


tacogramma = VG_taco; %#ok<NASGU>
respirogramma = VG_resp; %#ok<NASGU>
coerenza = VG_MSC; %#ok<NASGU>
asseFrequenze = VG_fr_dec; %#ok<NASGU>
potenzaCoerenteTaco = VG_S1_coer; %#ok<NASGU>
potenzaCoerenteResp = VG_S2_coer; %#ok<NASGU>
potenzaIncoerenteTaco = VG_S1-VG_S1_coer; %#ok<NASGU>
potenzaIncoerenteResp = VG_S2-VG_S2_coer; %#ok<NASGU>
psd_tacoresp=VG_PSD12;
psd_tacotaco=VG_PSD11;


%modificato con shift val e il nome
[fileName, pathName] = uiputfile('*.mat','Salva con Nome','export_ECG_GUI');
if ischar(fileName)
	save([pathName, fileName],...
		'tacogramma','respirogramma',... 
		'potenzaCoerenteTaco','potenzaCoerenteResp',...
		'potenzaIncoerenteTaco','potenzaIncoerenteResp',...
		'coerenza','asseFrequenze',...
        'psd_tacoresp','psd_tacotaco',...
		'P_LF_Taco','P_LF_NU_Taco',...
		'P_HF_Taco','P_HF_NU_Taco',...
        'PSD_parz_LF','PSD_parz_HF',...
        'PSD_parz_LF_NU','PSD_parz_HF_NU',...
        'P_Coer','P_Incoer','export_start','export_stop');
else
	return;
end


% --- Executes on button press in SaveBtn.
function SaveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SaveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global T_Windows;
global VG_eventi;
global etichette_ev;
global VG_fs;

global P_LF_Taco;
global P_HF_Taco;
global P_LF_NU_Taco;
global P_HF_NU_Taco;


global VG_S1;
global VG_S1_coer;
global VG_fr_dec;
global VG_HF;

global VG_taco;
global P_Coer;
global P_Incoer;
global PSD_parz_LF;
global PSD_parz_HF;
global PSD_parz_LF_NU;
global PSD_parz_HF_NU;


if isempty(T_Windows)
	msgbox('Nessuna finestra selezionata!');
	return;
end

dataSize = [size(T_Windows, 1), 1];
Taco_Mean = zeros(dataSize);
P_LF_Mean = zeros(dataSize);
P_HF_Mean = zeros(dataSize);
P_LF_Norm_Mean = zeros(dataSize);
P_HF_Norm_Mean = zeros(dataSize);
Pot_Coer_tot_Mean = zeros(dataSize);
Pot_Incoer_tot_Mean = zeros(dataSize);
LF_parz_NU_Mean=zeros(dataSize);
LF_parz_Mean=zeros(dataSize);
HF_parz_NU_Mean=zeros(dataSize);
HF_parz_Mean=zeros(dataSize);
SD_Taco = zeros(dataSize);
SD_LF = zeros(dataSize);
SD_HF = zeros(dataSize);
SD_LF_Norm = zeros(dataSize);
SD_HF_Norm = zeros(dataSize);
SD_Pot_Coer_tot = zeros(dataSize);
SD_Pot_Incoer_tot = zeros(dataSize);
SD_LF_parz_NU=zeros(dataSize);
SD_HF_parz_NU=zeros(dataSize);
SD_LF_parz=zeros(dataSize);
SD_HF_parz=zeros(dataSize);

evtStartCode = zeros(dataSize);
evtEndCode = zeros(dataSize);
for winIdx = 1:size(T_Windows,1)
	winS = find( VG_taco(:,1) >= T_Windows(winIdx, 1), 1);
	winE = find( VG_taco(:,1) <= T_Windows(winIdx, 2), 1, 'last');
	
	%individua gli eventi più vicini a Start ed End
	[~, evtStartIdx] = min(abs(VG_eventi(:,2)/VG_fs - T_Windows(winIdx, 1)));
	evtStartCode(winIdx) = VG_eventi(evtStartIdx, 1);
	[~, evtEndIdx] = min(abs(VG_eventi(:,2)/VG_fs - T_Windows(winIdx, 2)));
	evtEndCode(winIdx) = VG_eventi(evtEndIdx, 1);
	
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CALCOLO MEDIA E STD
    % Tacogramma nel tempo
    Taco_Mean(winIdx) = mean(VG_taco(winS:winE,2));
    SD_Taco(winIdx) = std(VG_taco(winS:winE,2));

	% Potenza LF
	P_LF_Mean(winIdx) = mean(P_LF_Taco(winS:winE,1));
	SD_LF(winIdx) = std(P_LF_Taco(winS:winE,1));
    P_LF_Norm_Mean(winIdx) = mean(P_LF_NU_Taco(winS:winE,1));
	SD_LF_Norm(winIdx) = std(P_LF_NU_Taco(winS:winE,1));
	
	% Potenza HF
	P_HF_Mean(winIdx) = mean(P_HF_Taco(winS:winE,1));
	SD_HF(winIdx) = std(P_HF_Taco(winS:winE,1));
    P_HF_Norm_Mean(winIdx) = mean(P_HF_NU_Taco(winS:winE,1));
	SD_HF_Norm(winIdx) = std(P_HF_NU_Taco(winS:winE,1));
    
    % Potenza Coerente Totale
	Pot_Coer_tot_Mean(winIdx) = mean(P_Coer(winS:winE,1));
	SD_Pot_Coer_tot(winIdx) = std(P_Coer(winS:winE,1));
	HF_parz_Mean(winIdx)=mean(PSD_parz_HF(winS:winE,1));
    SD_HF_parz(winIdx)=std(PSD_parz_HF(winS:winE,1));
    HF_parz_NU_Mean(winIdx)=mean(PSD_parz_HF_NU(winS:winE,1));
    SD_HF_parz_NU(winIdx)=std(PSD_parz_HF_NU(winS:winE,1));
    
	% Potenza Incoerente Totale
	Pot_Incoer_tot_Mean(winIdx) = mean(P_Incoer(winS:winE,1));
	SD_Pot_Incoer_tot(winIdx) = std(P_Incoer(winS:winE,1));
	LF_parz_Mean(winIdx)=mean(PSD_parz_LF(winS:winE,1));
    SD_LF_parz(winIdx)=std(PSD_parz_LF(winS:winE,1));
    LF_parz_NU_Mean(winIdx)=mean(PSD_parz_LF_NU(winS:winE,1));
    SD_LF_parz_NU(winIdx)=std(PSD_parz_LF_NU(winS:winE,1));
    
	% Rapporto SimpatoVagale Bande
	Ratio_LF_HF_Mean(winIdx) = mean(P_LF_Taco(winS:winE,1)./P_HF_Taco(winS:winE,1));
	SD_Ratio_LF_HF(winIdx) = std(P_LF_Taco(winS:winE,1)./P_HF_Taco(winS:winE,1));
	
	% Rapporto SimpatoVagale Coerenza
	Ratio_Inc_Coer_Mean(winIdx) = mean(P_Incoer(winS:winE,1)./P_Coer(winS:winE,1));
	SD_Ratio_Inc_Coer(winIdx) = std(P_Incoer(winS:winE,1)./P_Coer(winS:winE,1));
    
    % Rapporto SimpatoVagale spettri parziali
	Ratio_PSDparz_Mean(winIdx) = mean(PSD_parz_LF(winS:winE,1)./PSD_parz_HF(winS:winE,1));
	SD_Ratio_PSDparz(winIdx) = std(PSD_parz_LF(winS:winE,1)./PSD_parz_HF(winS:winE,1));
	

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% CALCOLO MEDIANA E IQR
%     % Tacogramma nel tempo
%     Taco_Mean(winIdx) = median(VG_taco(winS:winE,2));
%     SD_Taco(winIdx) = iqr(VG_taco(winS:winE,2));
% 
% 	% Potenza LF
% 	P_LF_Mean(winIdx) = median(P_LF_Taco(winS:winE,1));
% 	SD_LF(winIdx) = iqr(P_LF_Taco(winS:winE,1));
%     P_LF_Norm_Mean(winIdx) = median(P_LF_NU_Taco(winS:winE,1));
% 	SD_LF_Norm(winIdx) = iqr(P_LF_NU_Taco(winS:winE,1));
% 	
% 	% Potenza HF
% 	P_HF_Mean(winIdx) = median(P_HF_Taco(winS:winE,1));
% 	SD_HF(winIdx) = iqr(P_HF_Taco(winS:winE,1));
%     P_HF_Norm_Mean(winIdx) = median(P_HF_NU_Taco(winS:winE,1));
% 	SD_HF_Norm(winIdx) = iqr(P_HF_NU_Taco(winS:winE,1));
%     
%     % Potenza Coerente Totale
% 	Pot_Coer_tot_Mean(winIdx) = median(P_Coer(winS:winE,1));
% 	SD_Pot_Coer_tot(winIdx) = iqr(P_Coer(winS:winE,1));
% 	HF_parz_Mean(winIdx)=median(PSD_parz_HF(winS:winE,1));
%     SD_HF_parz(winIdx)=iqr(PSD_parz_HF(winS:winE,1));
%     HF_parz_NU_Mean(winIdx)=median(PSD_parz_HF_NU(winS:winE,1));
%     SD_HF_parz_NU(winIdx)=iqr(PSD_parz_HF_NU(winS:winE,1));
%     
% 	% Potenza Incoerente Totale
% 	Pot_Incoer_tot_Mean(winIdx) = median(P_Incoer(winS:winE,1));
% 	SD_Pot_Incoer_tot(winIdx) = iqr(P_Incoer(winS:winE,1));
% 	LF_parz_Mean(winIdx)=median(PSD_parz_LF(winS:winE,1));
%     SD_LF_parz(winIdx)=iqr(PSD_parz_LF(winS:winE,1));
%     LF_parz_NU_Mean(winIdx)=median(PSD_parz_LF_NU(winS:winE,1));
%     SD_LF_parz_NU(winIdx)=iqr(PSD_parz_LF_NU(winS:winE,1));
%     
% 	% Rapporto SimpatoVagale Bande
% 	Ratio_LF_HF_Mean(winIdx) = median(P_LF_Taco(winS:winE,1)./P_HF_Taco(winS:winE,1));
% 	SD_Ratio_LF_HF(winIdx) = iqr(P_LF_Taco(winS:winE,1)./P_HF_Taco(winS:winE,1));
% 	
% 	% Rapporto SimpatoVagale Coerenza
% 	Ratio_Inc_Coer_Mean(winIdx) = median(P_Incoer(winS:winE,1)./P_Coer(winS:winE,1));
% 	SD_Ratio_Inc_Coer(winIdx) = iqr(P_Incoer(winS:winE,1)./P_Coer(winS:winE,1));
%     
%     % Rapporto SimpatoVagale spettri parziali
% 	Ratio_PSDparz_Mean(winIdx) = median(PSD_parz_LF(winS:winE,1)./PSD_parz_HF(winS:winE,1));
% 	SD_Ratio_PSDparz(winIdx) = iqr(PSD_parz_LF(winS:winE,1)./PSD_parz_HF(winS:winE,1));
% 	
end

% folder_name = uigetdir;
% classinfo_1 = {'tacoInfoStart','tacoInfoEnd','','Media','Dev_Std.';T_Start_I_NUM, T_End_I_NUM,'P_VLF',VG_P_VLF_Mean_1,DS_1;'','','P_LF',VG_P_LF_Mean_5,DS_5;'','','P_HF',VG_P_HF_Mean_9,DS_9;'','','Res-Taco',VG_gain_alpha_Mean_1,DS_13;'','','Taco-Res',VG_gain_beta_Mean_1,DS_17;'T_Start_2','T_End_2','','','';T_Start_II_NUM, T_End_II_NUM,'P_VLF',VG_P_VLF_Mean_2,DS_2;'','','P_LF',VG_P_LF_Mean_6,DS_6;'','','P_HF',VG_P_HF_Mean_10,DS_10;'','','Res-Taco',VG_gain_alpha_Mean_2,DS_14;'','','Taco-Res',VG_gain_beta_Mean_2,DS_18;'T_Start_3','T_End_3','','','';T_Start_III_NUM, T_End_III_NUM,'P_VLF',VG_P_VLF_Mean_3,DS_3;'','','P_LF',VG_P_LF_Mean_7,DS_7;'','','P_HF',VG_P_HF_Mean_11,DS_11;'','','Res-Taco',VG_gain_alpha_Mean_3,DS_15;'','','Taco-Res',VG_gain_beta_Mean_3,DS_19;'T_Start_4','T_End_4','','','';T_Start_IV_NUM, T_End_IV_NUM,'P_VLF',VG_P_VLF_Mean_4,DS_4;'','','P_LF',VG_P_LF_Mean_8,DS_8;'','','P_HF',VG_P_HF_Mean_12,DS_12;'','','Res-Taco',VG_gain_alpha_Mean_4,DS_16;'','','Taco-Res',VG_gain_beta_Mean_4,DS_17};
% xlswrite([folder_name '/Finestre.xls'],classinfo_1)

%impagina i dati da salvare
fattoreUdM = 10.^6;
TableECG_Values = table();
for winIdx = 1:size(T_Windows, 1)
	TableECG_Values(winIdx, :) = {...
		T_Windows(winIdx, 1), T_Windows(winIdx, 2),...
		evtStartCode(winIdx), evtEndCode(winIdx),...
        Taco_Mean(winIdx), SD_Taco(winIdx),...
		P_LF_Mean(winIdx)*fattoreUdM, SD_LF(winIdx)*fattoreUdM,...
		P_LF_Norm_Mean(winIdx), SD_LF_Norm(winIdx),...
        P_HF_Mean(winIdx)*fattoreUdM, SD_HF(winIdx)*fattoreUdM,...
        P_HF_Norm_Mean(winIdx), SD_HF_Norm(winIdx),...
        Pot_Coer_tot_Mean(winIdx)*fattoreUdM, SD_Pot_Coer_tot(winIdx)*fattoreUdM,...
        HF_parz_Mean(winIdx)*fattoreUdM,SD_HF_parz(winIdx)*fattoreUdM,...
        HF_parz_NU_Mean(winIdx),SD_HF_parz_NU(winIdx),...
		Pot_Incoer_tot_Mean(winIdx)*fattoreUdM, SD_Pot_Incoer_tot(winIdx)*fattoreUdM,...
        LF_parz_Mean(winIdx)*fattoreUdM,SD_LF_parz(winIdx)*fattoreUdM,...
        LF_parz_NU_Mean(winIdx),SD_LF_parz_NU(winIdx),...
		Ratio_LF_HF_Mean(winIdx), SD_Ratio_LF_HF(winIdx),...
		Ratio_Inc_Coer_Mean(winIdx), SD_Ratio_Inc_Coer(winIdx)...,
        Ratio_PSDparz_Mean(winIdx),SD_Ratio_PSDparz(winIdx),...
		};
end

TableECG_Values.Properties.VariableNames = {...
	'WinStart', 'WinEnd',...
	'EventStart', 'EventEnd',...
    'TacoMean','TacoStd',...
	'Taco_LF_Mean','Taco_LF_Std',...
    'Taco_LF_Norm_Mean','Taco_LF_Norm_Std',...
	'Taco_HF_Mean','Taco_HF_Std',...
    'Taco_HF_Norm_Mean','Taco_HF_Norm_Std',...
	'Pot_Coer_tot_Mean','Pot_Coer_tot_Std',...
    'Pot_Coer_PSDparz_Mean','Pot_Coer_PSDparz_Std',...
    'Pot_Coer_PSDparz_Mean_NU','Pot_Coer_PSDparz_Std_NU',...
	'Pot_Incoer_tot_Mean','Pot_Incoer_tot_Std',...
    'Pot_Incoer_PSDparz_Mean','Pot_Incoer_PSDparz_Std',...
    'Pot_Incoer_PSDparz_Mean_NU','Pot_Incoer_PSDparz_Std_NU',...
	'Ratio_Band_Based_Mean','Ratio_Band_Based_Std',...
	'Ratio_Coherence_Based_Mean','Ratio_Coherence_Based_Std'...,
    'Ratio_PSDparz_Mean','Ratio_PSDparz_Std',...
	};

event_labels = etichette_ev; %#ok<NASGU>
note = ['IT: tutti i valori degli indici (eccetto i rapporti SimpatoVagali e quelli espressi in NU) sono espressi in ms\n',...
'EN: all the index values (except the ratios and those reported in NU) are expressed in ms']; %#ok<NASGU>

% % Get the table in string form.
% TString = evalc('disp(TableECG_Values)');
% % Use TeX Markup for bold formatting and underscores.
% TString = strrep(TString,'<strong>','\bf');
% TString = strrep(TString,'</strong>','\rm');
% TString = strrep(TString,'_','\_');
% % Get a fixed-width font.
% FixedWidth = get(0,'FixedWidthFontName');
% % Output the table using the annotation command.
% tab = figure('units','normalized','outerposition',[0.05 0.05 0.9 0.9]);
% annotation(tab,'Textbox','String',TString,'Interpreter','Tex',...
%     'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);

%salva
[fileName, pathName] = uiputfile('*.mat','Salva con Nome','ECG_Features');
if ischar(fileName)
	save([pathName, fileName],'TableECG_Values', 'event_labels', 'note');
else
	return;
end


% --- Executes on button press in statBtn.
function statBtn_Callback(hObject, eventdata, handles)
% hObject    handle to statBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.showStatistica
    handles.showStatistica = false;
    hObject.String = 'Show Windows';
else
    handles.showStatistica = true;
    hObject.String = 'Hide Windows';
end
guidata(hObject, handles);
PlotTacoResp(handles);


% --- Executes during object creation, after setting all properties.
function uibuttongroup4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
