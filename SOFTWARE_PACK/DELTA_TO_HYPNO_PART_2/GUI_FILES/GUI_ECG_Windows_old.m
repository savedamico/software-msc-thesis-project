function varargout = GUI_ECG_Windows_old(varargin)
% GUI_ECG_WINDOWS_OLD MATLAB code for GUI_ECG_Windows_old.fig
%      GUI_ECG_WINDOWS_OLD, by itself, creates a new GUI_ECG_WINDOWS_OLD or raises the existing
%      singleton*.
%
%      H = GUI_ECG_WINDOWS_OLD returns the handle to a new GUI_ECG_WINDOWS_OLD or the handle to
%      the existing singleton*.
%
%      GUI_ECG_WINDOWS_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ECG_WINDOWS_OLD.M with the given input arguments.
%
%      GUI_ECG_WINDOWS_OLD('Property','Value',...) creates a new GUI_ECG_WINDOWS_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_ECG_Windows_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_ECG_Windows_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_ECG_Windows_old

% Last Modified by GUIDE v2.5 23-Dec-2017 18:59:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct(...
	'gui_Name',       mfilename, ...
	'gui_Singleton',  gui_Singleton, ...
	'gui_OpeningFcn', @GUI_ECG_Windows_old_OpeningFcn, ...
	'gui_OutputFcn',  @GUI_ECG_Windows_old_OutputFcn, ...
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


% --- Executes just before GUI_ECG_Windows_old is made visible.
function GUI_ECG_Windows_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_ECG_Windows_old (see VARARGIN)

% Choose default command line output for GUI_ECG_Windows_old
handles.output = hObject;

%##########################################################################
% INIZIALIZZAZIONI VARIE

% Legenda eventi:
set(handles.events_panel,'Visible','off');
handles.legend_flag = false;

% Probabilmente non serve più
% Teniamo traccia del file sul quale è stata effettuata la finestratura
% (utile per GUI EEG):
global pfGUI_ECG_Windows;
global pfGUIECG;
pfGUI_ECG_Windows = pfGUIECG;

%##########################################################################

global T_Windows;
if ~isempty(T_Windows)
	handles.Save.Enable = 'On';
end
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
handles.winChooser.String = newList;

if nargin > 3
    handles.winChooser.Value = varargin{1}+1;
else
    %ToDo bloccare apertura
    %close(hObject); -> da errore
end

winChooser_Callback(handles.winChooser, [], handles);

plotGrafici(handles);

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_ECG_Windows_old_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Close.
function Close_Callback(hObject, eventdata, handles)
% hObject    handle to Close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Choice = questdlg(['Il Programma verr', char(224), ' chiuso. Continuare?'], ...
	'Chiudi', ...
	'Si','No','Cancel','Si');
switch Choice
	case 'Si'
		h = findall(0, 'tag', 'GUI_ECG');
		delete(h);
		h = findall(0, 'tag', 'GUI_ecgWindows');
		delete(h);
	case 'No'
end


% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
global T_Windows;
Choice = questdlg('I dati attuali verranno cancellati. Continuare?', ...
	'Reset', ...
	'Si','No','Cancel','Si');
switch Choice
	case 'Si'
		%resets windows
		T_Windows = [];
		run([VG_projectPath, '/GUI_Schermata_Iniziale.m']);
		h = findall(0, 'tag', 'GUI_ECG');
		delete(h);
		h = findall(0, 'tag', 'GUI_ecgWindows');
		delete(h);
	case 'No'
end


% --- Executes on button press in Back.
function Back_Callback(hObject, eventdata, handles)
% hObject    handle to Back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Choice = questdlg('Tornare alla schermata precedente?', ...
	'Indietro', ...
	'Si','No','Cancel','Si');
switch Choice
	case 'Si'
		close GUI_ECG_Windows;
	case 'No'
end


% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global T_Windows;
global VG_eventi;
global etichette_ev;
global VG_fs;

global P_VLF_Taco;
global P_LF_Taco;
global P_HF_Taco;

global P_LF_NU_Taco;
global P_HF_NU_Taco;

global VG_gain_alpha_tempo; % gain resp -> taco (utile)
global VG_gain_beta_tempo; % gain taco -> resp

global VG_S1;
global VG_S1_coer;
global VG_fr_dec;
global VG_HF;

global VG_taco;
global VG_gain_alpha;
global VG_gain;
global VG_gain_B;
global VG_gain_beta;

if isempty(T_Windows)
	msgbox('Nessuna finestra selezionata!');
	return;
end

VG_gain = VG_gain_alpha(1:size(VG_taco,1), VG_HF);
VG_gain_alpha_tempo = mean(VG_gain,2);
VG_gain_B = VG_gain_beta(1:size(VG_taco, 1), VG_HF);
VG_gain_beta_tempo=mean(VG_gain_B, 2);
Pot_Coer = VG_S1_coer;
Pot_Incoer = VG_S1 - VG_S1_coer;
Rapp_CoerenzaBased = Pot_Incoer./Pot_Coer;
Rapp_BandeBased = P_LF_Taco./P_HF_Taco;

dataSize = [size(T_Windows, 1), 1];
Taco_Mean = zeros(dataSize);
P_VLF_Mean = zeros(dataSize);
P_LF_Mean = zeros(dataSize);
P_HF_Mean = zeros(dataSize);
P_LF_Norm_Mean = zeros(dataSize);
P_HF_Norm_Mean = zeros(dataSize);
gain_alpha_Mean = zeros(dataSize);
gain_beta_Mean = zeros(dataSize);
Pot_Coer_tot_Mean = zeros(dataSize);
Pot_Incoer_tot_Mean = zeros(dataSize);
Ratio_LF_HF_Mean = zeros(dataSize);
Ratio_Inc_Coer_Mean = zeros(dataSize);
SD_Taco = zeros(dataSize);
SD_VLF = zeros(dataSize);
SD_LF = zeros(dataSize);
SD_HF = zeros(dataSize);
SD_LF_Norm = zeros(dataSize);
SD_HF_Norm = zeros(dataSize);
SD_gain_alpha = zeros(dataSize);
SD_gain_beta = zeros(dataSize);
SD_Pot_Coer_tot = zeros(dataSize);
SD_Pot_Incoer_tot = zeros(dataSize);
SD_Ratio_LF_HF = zeros(dataSize);
SD_Ratio_Inc_Coer = zeros(dataSize);
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
	
    % Tacogramma nel tempo
    Taco_Mean(winIdx) = mean(VG_taco(winS:winE,2));
    SD_Taco(winIdx) = std(VG_taco(winS:winE,2));
    
	% Potenza VLF
	P_VLF_Mean(winIdx) = mean(P_VLF_Taco(winS:winE,1));
	SD_VLF(winIdx) = std(P_VLF_Taco(winS:winE,1));
	
	% Potenza LF
	P_LF_Mean(winIdx) = mean(P_LF_Taco(winS:winE,1));
	SD_LF(winIdx) = std(P_LF_Taco(winS:winE,1));
	
	% Potenza HF
	P_HF_Mean(winIdx) = mean(P_HF_Taco(winS:winE,1));
	SD_HF(winIdx) = std(P_HF_Taco(winS:winE,1));
    
    % Potenza LF Normalizzata
    P_LF_Norm_Mean(winIdx) = mean(P_LF_NU_Taco(winS:winE,1));
    SD_LF_Norm(winIdx) = std(P_LF_NU_Taco(winS:winE,1));
    
    % Potenza HF Normalizzata
    P_HF_Norm_Mean(winIdx) = mean(P_HF_NU_Taco(winS:winE,1));
    SD_HF_Norm(winIdx) = std(P_HF_NU_Taco(winS:winE,1));
	
	% Resp_Taco (gain alpha)
	gain_alpha_Mean(winIdx) = mean(VG_gain_alpha_tempo(winS:winE,1));
	SD_gain_alpha(winIdx) = std(VG_gain_alpha_tempo(winS:winE,1));
	
	% Taco-Resp (gain beta)
	gain_beta_Mean(winIdx) = mean(VG_gain_beta_tempo(winS:winE,1));
	SD_gain_beta(winIdx) = std(VG_gain_beta_tempo(winS:winE,1));
	
	% Potenza Coerente Totale
	PotCoerTot = sum(Pot_Coer(winS:winE,:),2)*diff(VG_fr_dec(1:2));
	Pot_Coer_tot_Mean(winIdx) = mean(PotCoerTot);
	SD_Pot_Coer_tot(winIdx) = std(PotCoerTot);
	
	% Potenza Incoerente Totale
	PotIncoerTot = sum(Pot_Incoer(winS:winE,:),2)*diff(VG_fr_dec(1:2));
	Pot_Incoer_tot_Mean(winIdx) = mean(PotIncoerTot);
	SD_Pot_Incoer_tot(winIdx) = std(PotIncoerTot);
	
	% Rapporto SimpatoVagale Bande
	Ratio_LF_HF_Mean(winIdx) = mean(Rapp_BandeBased(winS:winE,1));
	SD_Ratio_LF_HF(winIdx) = std(Rapp_BandeBased(winS:winE,1));
	
	% Rapporto SimpatoVagale Coerenza
	Rapp_CoerenzaBasedWin = sum(Rapp_CoerenzaBased(winS:winE,:), 2)*diff(VG_fr_dec(1:2));
	Ratio_Inc_Coer_Mean(winIdx) = mean(Rapp_CoerenzaBasedWin);
	SD_Ratio_Inc_Coer(winIdx) = std(Rapp_CoerenzaBasedWin);
	
end

% folder_name = uigetdir;
% classinfo_1 = {'tacoInfoStart','tacoInfoEnd','','Media','Dev_Std.';T_Start_I_NUM, T_End_I_NUM,'P_VLF',VG_P_VLF_Mean_1,DS_1;'','','P_LF',VG_P_LF_Mean_5,DS_5;'','','P_HF',VG_P_HF_Mean_9,DS_9;'','','Res-Taco',VG_gain_alpha_Mean_1,DS_13;'','','Taco-Res',VG_gain_beta_Mean_1,DS_17;'T_Start_2','T_End_2','','','';T_Start_II_NUM, T_End_II_NUM,'P_VLF',VG_P_VLF_Mean_2,DS_2;'','','P_LF',VG_P_LF_Mean_6,DS_6;'','','P_HF',VG_P_HF_Mean_10,DS_10;'','','Res-Taco',VG_gain_alpha_Mean_2,DS_14;'','','Taco-Res',VG_gain_beta_Mean_2,DS_18;'T_Start_3','T_End_3','','','';T_Start_III_NUM, T_End_III_NUM,'P_VLF',VG_P_VLF_Mean_3,DS_3;'','','P_LF',VG_P_LF_Mean_7,DS_7;'','','P_HF',VG_P_HF_Mean_11,DS_11;'','','Res-Taco',VG_gain_alpha_Mean_3,DS_15;'','','Taco-Res',VG_gain_beta_Mean_3,DS_19;'T_Start_4','T_End_4','','','';T_Start_IV_NUM, T_End_IV_NUM,'P_VLF',VG_P_VLF_Mean_4,DS_4;'','','P_LF',VG_P_LF_Mean_8,DS_8;'','','P_HF',VG_P_HF_Mean_12,DS_12;'','','Res-Taco',VG_gain_alpha_Mean_4,DS_16;'','','Taco-Res',VG_gain_beta_Mean_4,DS_17};
% xlswrite([folder_name '/Finestre.xls'],classinfo_1)

%impagina i dati da salvare
fattoreUdM = 10.^3;
TableECG_Values = table();
for winIdx = 1:size(T_Windows, 1)
	TableECG_Values(winIdx, :) = {...
		T_Windows(winIdx, 1), T_Windows(winIdx, 2),...
		evtStartCode(winIdx), evtEndCode(winIdx),...
        Taco_Mean(winIdx)*fattoreUdM, SD_Taco(winIdx)*fattoreUdM,...
		P_VLF_Mean(winIdx)*fattoreUdM, SD_VLF(winIdx)*fattoreUdM,...
		P_LF_Mean(winIdx)*fattoreUdM, SD_LF(winIdx)*fattoreUdM,...
		P_HF_Mean(winIdx)*fattoreUdM, SD_HF(winIdx)*fattoreUdM,...
        P_LF_Norm_Mean(winIdx)*fattoreUdM, SD_LF_Norm(winIdx)*fattoreUdM,...
        P_HF_Norm_Mean(winIdx)*fattoreUdM, SD_HF_Norm(winIdx)*fattoreUdM,...
		gain_alpha_Mean(winIdx)*fattoreUdM, SD_gain_alpha(winIdx)*fattoreUdM,...
		gain_beta_Mean(winIdx)*fattoreUdM, SD_gain_beta(winIdx)*fattoreUdM,...
		Pot_Coer_tot_Mean(winIdx)*fattoreUdM, SD_Pot_Coer_tot(winIdx)*fattoreUdM,...
		Pot_Incoer_tot_Mean(winIdx)*fattoreUdM, SD_Pot_Incoer_tot(winIdx)*fattoreUdM,...
		Ratio_LF_HF_Mean(winIdx), SD_Ratio_LF_HF(winIdx),...
		Ratio_Inc_Coer_Mean(winIdx), SD_Ratio_Inc_Coer(winIdx)...
		};
end

TableECG_Values.Properties.VariableNames = {...
	'WinStart', 'WinEnd',...
	'EventStart', 'EventEnd',...
    'TacoMean','TacoStd',...
	'Taco_VLF_Mean','Taco_VLF_Std',...
	'Taco_LF_Mean','Taco_LF_Std',...
	'Taco_HF_Mean','Taco_HF_Std',...
    'Taco_LF_Norm_Mean','Taco_LF_Norm_Std',...
    'Taco_HF_Norm_Mean','Taco_HF_Norm_Std',...
	'Res2Taco_Mean','Res2Taco_Std',...%check se il nome ha senso
	'Taco2Res_Mean','Taco2Res_Std',...%check se il nome ha senso
	'Pot_Coer_tot_Mean','Pot_Coer_tot_Std',...
	'Pot_Incoer_tot_Mean','Pot_Incoer_tot_Std',...
	'Ratio_Band_Based_Mean','Ratio_Band_Based_Std',...
	'Ratio_Coherence_Based_Mean','Ratio_Coherence_Based_Std'...
	};

event_labels = etichette_ev; %#ok<NASGU>
note = ['IT: tutti i valori degli indici (eccetto i rapporti SimpatoVagali) sono moltiplicati per 1000 per maggiore leggibilità\n',...
'EN: all the index values (except the ratios) are multiplied by a factor of 1000 for better readability']; %#ok<NASGU>

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


% --- Executes on button press in Full_Screen_PSD.
function Full_Screen_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to Full_Screen_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Full Screen di tutto il segnale
global VG_taco;
global VG_S1;
global VG_S1_coer;
global P_LF_Taco;
global P_HF_Taco;
global VG_fr_dec;
global T_Windows;
global VG_fs;

global VG_fullscreenStruct;
global VG_projectPath;

nWin = handles.winChooser.Value-1;

if nWin == 0
	potWin = 1:size(VG_S1, 1);
else
	winS = find( VG_taco(:,1) >= T_Windows(nWin, 1), 1);
	winE = find( VG_taco(:,1) <= T_Windows(nWin, 2), 1, 'last');
	potWin = winS:winE;
end

potAreaCoer = sum(VG_S1_coer(potWin, :), 2)*VG_fr_dec(2);
myPlot = newFullscreenStruct();
myPlot.data(1).signal = P_HF_Taco(potWin);
myPlot.data(1).time = VG_taco(potWin, 1);
myPlot.data(1).info = '';
myPlot.data(2).signal = potAreaCoer;
myPlot.data(2).time = VG_taco(potWin, 1);
myPlot.data(2).info = '';
myPlot.fs = VG_fs;
myPlot.title = 'Componenti Respiro dipendenti';
myPlot.xlabel = '';
myPlot.ylabel = 'PSD [s^2/Hz]';
myPlot.events = true;
myPlot.nParts = 5;
VG_fullscreenStruct(1) = myPlot;

potAreaIncoer = sum(VG_S1(potWin, :)-VG_S1_coer(potWin, :), 2)*VG_fr_dec(2);
myPlot = newFullscreenStruct();
myPlot.data(1).signal = P_LF_Taco(potWin);
myPlot.data(1).time = VG_taco(potWin, 1);
myPlot.data(1).info = '';
myPlot.data(2).signal = potAreaIncoer;
myPlot.data(2).time = VG_taco(potWin, 1);
myPlot.data(2).info = '';
myPlot.fs = VG_fs;
myPlot.title = 'Componenti Respiro indipendenti';
myPlot.xlabel = '';
myPlot.ylabel = 'PSD [s^2/Hz]';
myPlot.events = true;
myPlot.nParts = 5;
VG_fullscreenStruct(2) = myPlot;

potAreaRatio = potAreaIncoer./potAreaCoer;
potBandRatio = P_LF_Taco./P_HF_Taco;
myPlot = newFullscreenStruct();
myPlot.data(1).signal = potBandRatio(potWin);
myPlot.data(1).time = VG_taco(potWin, 1);
myPlot.data(1).info = '';
myPlot.data(2).signal = potAreaRatio;
myPlot.data(2).time = VG_taco(potWin, 1);
myPlot.data(2).info = '';
myPlot.fs = VG_fs;
myPlot.title = 'Bilancia Simpato-Vagale';
myPlot.xlabel = 'Tempo [s]';
myPlot.ylabel = 'A.U.';
myPlot.events = true;
myPlot.nParts = 5;
VG_fullscreenStruct(3) = myPlot;

run([VG_projectPath, '/GUI_FullScreen']);


% --- Executes on button press in FullScreenPowers.
function FullScreenPowers_Callback(hObject, eventdata, handles)
% hObject    handle to FullScreenPowers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
run([VG_projectPath, '/GUI_ECG_Potenze']);


% --- Executes on selection change in winChooser.
function winChooser_Callback(hObject, eventdata, handles)
% hObject    handle to winChooser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winChooser contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winChooser

plotGrafici(handles);


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


function plotGrafici(handles)
global VG_taco;
global VG_S1;
global VG_S1_coer;
global P_LF_Taco;
global P_HF_Taco;
global VG_fr_dec;
global T_Windows;

global VG_eventi;
global etichette_ev;
global VG_fs;

nWin = handles.winChooser.Value-1;
if nWin == 0
	potWin = 1:size(VG_S1, 1);
else
	winS = find( VG_taco(:,1) >= T_Windows(nWin, 1), 1);
	winE = find( VG_taco(:,1) <= T_Windows(nWin, 2), 1, 'last');
	potWin = winS:winE;
end

% Componenti Respiro-dipendenti
axes(handles.RespDepAxes);
cla;
potAreaCoer = sum(VG_S1_coer(potWin, :), 2)*(VG_fr_dec(2)-VG_fr_dec(1)); %metodo dei rettangoli

% Coherent power
yyaxis right;
plot(VG_taco(potWin, 1), potAreaCoer);
ylabel('Coherent PSD [s^2/Hz]');
ylim([min(potAreaCoer) max(potAreaCoer)]);
% HF power
yyaxis left;
plot(VG_taco(potWin, 1), P_HF_Taco(potWin));
ylabel('HF PSD [s^2/Hz]');
ylim([min(P_HF_Taco(potWin)) max(P_HF_Taco(potWin))]);

if nWin == 0
	xlim([0 VG_taco(end,1)]);
else
	xlim([VG_taco(potWin(1), 1) VG_taco(potWin(end), 1)]);
end
title('Componenti Respiro dipendenti');

% Componenti Respiro-indipendenti
axes(handles.RespIndepAxes);
cla;
potAreaIncoer = sum(VG_S1(potWin, :)-VG_S1_coer(potWin, :), 2)*(VG_fr_dec(2)-VG_fr_dec(1)); %metodo dei rettangoli

% Incoherent power
yyaxis right;
plot(VG_taco(potWin, 1), potAreaIncoer);
ylabel('Incoherent PSD [s^2/Hz]');
ylim([min(potAreaIncoer) max(potAreaIncoer)]);
% LF power
yyaxis left;
plot(VG_taco(potWin, 1), P_LF_Taco(potWin));
ylabel('LF PSD [s^2/Hz]');
ylim([min(P_LF_Taco(potWin)) max(P_LF_Taco(potWin))]);

if nWin == 0
	xlim([0 VG_taco(end,1)]);
else
	xlim([VG_taco(potWin(1), 1) VG_taco(potWin(end), 1)]);
end
title('Componenti Respiro indipendenti');

% Rapporto indipendenti/dipendendti
axes(handles.RatioAxes);
cla;
potAreaRatio = potAreaIncoer./potAreaCoer;
potBandRatio = P_LF_Taco./P_HF_Taco;

% Coherence based power
yyaxis right;
plot(VG_taco(potWin, 1), potAreaRatio);
ylabel('Inc/Coher PSD [s^2/Hz]');
ylim([min(potAreaRatio) max(potAreaRatio)]);
% Band based power
yyaxis left;

plot(VG_taco(potWin, 1), potBandRatio(potWin));
ylabel('LF/HF PSD [s^2/Hz]');
ylim([min(potBandRatio(potWin)) max(potBandRatio(potWin))]);

if nWin == 0
	xlim([0 VG_taco(end,1)]);
else
	xlim([VG_taco(potWin(1), 1) VG_taco(potWin(end), 1)]);
end
title('Rapporto Simpato-Vagale');
xlabel('Time [s]');

%%% EVENTI
handles.legend_flag = plot_eventi(handles.events_panel,handles.RespDepAxes,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
%--------------------------------------------------------------
handles.legend_flag = plot_eventi(handles.events_panel,handles.RespIndepAxes,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
%--------------------------------------------------------------
handles.legend_flag = plot_eventi(handles.events_panel,handles.RatioAxes,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
%--------------------------------------------------------------
guidata(handles.winChooser, handles);

handles.Full_Screen_PSD.Enable = 'On';
