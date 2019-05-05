%%%%%INDICI DA VALUTARE%%%%%%
% (1.1) average, (1.2) variance & (1.3) standard deviation
%	along specific time periods under analysis (stimuli)(1)
% -> individuare gli stimoli, usare gli eventi?
% (2.1) number of local maxima and (2.2) minima
% (2.3) mean conductivity difference (GF - GB) 
% (2.4) 'derivata media picchi' = mean((max-min)/(t(max) - t(min)))
%	for each consecutive pair of local minimum-maximum (2)
% (3.1) global maximum GSRmax and (3.2) minimum GSRmin
% (3.3) difference of globals (GSRmax - GSRmin)
% (3.4) the ratio between the number of maxima and stimuli duration (peaks/time)
%	for each stimulus (3)


function varargout = GUI_EDA(varargin)
% GUI_EDA MATLAB code for GUI_EDA.fig
%      GUI_EDA, by itself, creates a new GUI_EDA or raises the existing
%      singleton*.
%
%      H = GUI_EDA returns the handle to a new GUI_EDA or the handle to
%      the existing singleton*.
%
%      GUI_EDA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EDA.M with the given input arguments.
%
%      GUI_EDA('Property','Value',...) creates a new GUI_EDA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_EDA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_EDA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_EDA

% Last Modified by GUIDE v2.5 08-Nov-2017 16:40:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_EDA_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_EDA_OutputFcn, ...
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


% --- Outputs from this function are returned to the command line.
function varargout = GUI_EDA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes just before GUI_EDA is made visible.
function GUI_EDA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_EDA (see VARARGIN)

% Choose default command line output for GUI_EDA
handles.output = hObject;

global VG_sig_EDA;
% % global VG_tempo_auto;
% % global VG_eventi;
% % global etichette_ev;
% % global VG_fs;

% Filtraggio e Sottocampionamento, andrebbero fatti in preelaborazione
%VG_sig_EDA = Filtraggio();

% individua i picchi
[pksMax,locsMax]=findpeaks(VG_sig_EDA);
[pksMin,locsMin]=findpeaks(-VG_sig_EDA);
pksMin = -pksMin;
handles.pksMax.pks = pksMax;
handles.pksMax.locs = locsMax;
handles.pksMin.pks = pksMin;
handles.pksMin.locs = locsMin;
guidata(hObject,handles);

%handles = checkPeaks(handles);
guidata(hObject, handles);

% inizializza variabili interne
handles.legend_flag = false;% flag per la legenda degli eventi

handles.statWindows = [];% finestrature
handles.statistica_flag = true;% richiesta statistica precedente
handles.showStatistica = true;% mostrare sul grafico

guidata(hObject, handles);

% inizializza il grafico EDA
handles.EDAgraphInfo.title = 'EDA';
handles.EDAgraphInfo.xLabel = 'T [s]';
handles.EDAgraphInfo.yLabel = 'Skin Conductance [\muS]';%udm da confermare
guidata(hObject, handles);

UpdateWindows(handles);
PlotEDA(handles);

% % % calcola il segnale Idx
% % sig_Idx = zeros(size(VG_tempo_auto));
% % wb = waitbar(0, 'Calcolo Indici...');
% % wbStep = length(VG_tempo_auto)/10;
% % wbIdx = 0;
% % for sgIdx = 1:length(VG_tempo_auto)
% % 	[~, ~, ~, ~, ~, ~, ~, ~, ~, newIdx] = peaksIndexes(1,sgIdx,handles);
% % 	if ~isnan(newIdx)
% % 		sig_Idx(sgIdx) = newIdx;
% % 	end
% % 	if sgIdx > wbIdx*wbStep
% % 		wbIdx = wbIdx +1;
% % 		waitbar(wbIdx/10,wb);
% % 	end
% % end
% % handles.sig_Idx = sig_Idx;
% % delete(wb);
% % 
% % % inizializza il grafico Idx (DA ELIMINARE IN RELEASE)
% % handles.IdxGraphInfo.title = 'Variazione Media';
% % handles.IdxGraphInfo.xLabel = 'T [s]';
% % handles.IdxGraphInfo.yLabel = 'Variazione [\Delta\muS]';
% % guidata(hObject, handles);
% % 
% % axes(handles.IdxGraph);
% % plot(VG_tempo_auto, handles.sig_Idx, 'k');
% % title(handles.IdxGraphInfo.title);
% % xlabel(handles.IdxGraphInfo.xLabel);
% % ylabel(handles.IdxGraphInfo.yLabel);
% % yDisplayMin = floor(min(handles.sig_Idx));
% % yDisplayMax = ceil(max(handles.sig_Idx));
% % xDisplayMax = ceil(VG_tempo_auto(end)/10)*10;
% % axis([0 xDisplayMax yDisplayMin yDisplayMax]);
% % pan off;%the graph shows all the signal already
% % guidata(hObject, handles);
% % % mostra gli eventi di Idx
% % handles.legend_flag = plot_eventi(handles.legend_panel,handles.IdxGraph,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);

% abilita fullscreen
handles.fullScreenEDA.Enable = 'on';
% % handles.fullScreenIdx.Enable = 'on';

% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in fullScreenEDA.
function fullScreenEDA_Callback(hObject, eventdata, handles)
% hObject    handle to fullScreenEDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_projectPath;
global VG_tempo_auto;
global VG_sig_EDA;
global VG_fs;
global VG_fullscreenStruct;
myPlot = newFullscreenStruct();
myPlot.data(1).signal = VG_sig_EDA;
myPlot.data(1).time = VG_tempo_auto;
myPlot.data(1).info = 'k';
if handles.ckbPeaks.Value
	myPlot.data(2).signal = handles.pksMax.pks;
	myPlot.data(2).time = VG_tempo_auto(handles.pksMax.locs);
    myPlot.data(2).info = 'o';
	myPlot.data(3).signal = handles.pksMin.pks;
	myPlot.data(3).time = VG_tempo_auto(handles.pksMin.locs);
    myPlot.data(3).info = '*';
end
myPlot.fs = VG_fs;
myPlot.title = handles.EDAgraphInfo.title;
myPlot.xlabel = handles.EDAgraphInfo.xLabel;
myPlot.ylabel = handles.EDAgraphInfo.yLabel;
myPlot.events = true;
VG_fullscreenStruct(1) = myPlot;

% %%% Prova %%%
% myPlot = newFullscreenStruct();
% myPlot.data(1).signal = handles.sig_Idx(1500:2000);
% myPlot.data(1).time = VG_tempo_auto(1500:2000);
% myPlot.data(1).info = '--';
% myPlot.data(1).prop = {'LineWidth', 'Color'; 3, [1 1 0]};
% myPlot.fs = VG_fs;
% myPlot.events = true;
% myPlot.title = handles.IdxGraphInfo.title;
% myPlot.xlabel = handles.IdxGraphInfo.xLabel;
% myPlot.ylabel = handles.IdxGraphInfo.yLabel;
% myPlot.events = true;
% VG_fullscreenStruct(2) = myPlot;
% %%% fine prova %%%
run([VG_projectPath, '/GUI_FullScreen']);


% --- Executes on button press in fullScreenIdx.
% % function fullScreenIdx_Callback(hObject, eventdata, handles)
% % % hObject    handle to fullScreenIdx (see GCBO)
% % % eventdata  reserved - to be defined in a future version of MATLAB
% % % handles    structure with handles and user data (see GUIDATA)
% % global VG_projectPath;
% % global VG_tempo_auto;
% % global VG_fs;
% % global VG_fullscreenStruct;
% % myPlot = newFullscreenStruct();
% % myPlot.data(1).signal = handles.sig_Idx;
% % myPlot.data(1).time = VG_tempo_auto;
% % myPlot.data(1).info = 'k';
% % myPlot.fs = VG_fs;
% % myPlot.events = true;
% % myPlot.title = handles.IdxGraphInfo.title;
% % myPlot.xlabel = handles.IdxGraphInfo.xLabel;
% % myPlot.ylabel = handles.IdxGraphInfo.yLabel;
% % myPlot.events = true;
% % VG_fullscreenStruct(1) = myPlot;
% % run([VG_projectPath, '/GUI_FullScreen']);


function PlotEDA(handles)
global VG_sig_EDA;
global VG_tempo_auto;
global VG_eventi;
global etichette_ev;
global VG_fs;
global T_Windows;

% calcolo variabili utili
yDisplayMin = floor(min(VG_sig_EDA));
yDisplayMax = ceil(max(VG_sig_EDA));
xDisplayMax = ceil(VG_tempo_auto(end)/10)*10;

% plotting
axes(handles.EDAgraph);
cla(handles.EDAgraph);
% mostra finestrature (da fare prima per evitare di coprire il grafico)
hold on;
finestraColor = [0.73 0.83 0.96];
finestraSelectedColor = [0.60 0.70 1];
if handles.showStatistica
    for xIdx = 1:size(T_Windows,1)
        % T_Windows contiene le finestre in unità temporali già ordinate

        % mostra la finestra sul grafico
        area(T_Windows(xIdx,:), yDisplayMax*ones(1,2), yDisplayMin, 'FaceColor', finestraColor, 'EdgeColor', finestraColor);
    end
    
    %evidenzia finestra selezionata
    if isfield(handles, 'winChooser')
        nWin = handles.winChooser.Value-1;%la prima riga è il titolo
        if nWin > 0
            
            % mostra la finestra sul grafico
            area(T_Windows(nWin,:), yDisplayMax*ones(1,2), yDisplayMin, 'FaceColor', finestraSelectedColor, 'EdgeColor', finestraSelectedColor);
        end
    end
end

% mostra il segnale
plot(VG_tempo_auto, VG_sig_EDA, 'k');

% mostra i picchi
if handles.ckbPeaks.Value
	plot(VG_tempo_auto(handles.pksMax.locs),handles.pksMax.pks,'o');
	plot(VG_tempo_auto(handles.pksMin.locs),handles.pksMin.pks,'*');
end
hold off;

% settings
xlabel(handles.EDAgraphInfo.xLabel);
ylabel(handles.EDAgraphInfo.yLabel);
axis([0 xDisplayMax yDisplayMin yDisplayMax]);
pan off;%the graph shows all the signal already

% mostra eventi sul grafico EDA
handles.legend_flag = plot_eventi(handles.legend_panel,handles.EDAgraph,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
guidata(handles.EDAgraph,handles);


function DisplayIndexes(handles)
% mostra le statistiche della finestra
global T_Windows;
global VG_tempo_auto;

global VG_EDA_indici;

infoFig = findall(0, 'Tag', 'EDAInfo');

nWin = handles.winChooser.Value-1;
if nWin > 0
    
	Window = T_Windows(nWin,:);
	% T_Windows contiene le finestre in unità temporali già ordinate
	% estrae gli indici corrispondenti sul vettore dei tempi
	idxStart = find(VG_tempo_auto <= Window(1),1,'last');
	idxEnd = find(VG_tempo_auto >= Window(2),1,'first');
    if isempty(idxStart)
        idxStart = 1;
    end
    if isempty(idxEnd)
        idxEnd = length(VG_tempo_auto);
    end
	
	% calcola gli indici
	[media, ~, devStd] = analisiStatistica(idxStart,idxEnd);
	[mediaVar, mediaVarSalita, mediaVarDiscesa, absMax, absMin, maxDiff, derivata, derivataSalita, derivataDiscesa, picchiNormalizzati] = peaksIndexes(idxStart, idxEnd, handles);
    [derivataMedia, derivataStd] = continousIndexes(idxStart, idxEnd);
    
    VG_EDA_indici = {
        'Average', media;
        'Standart Deviation', devStd;
        'Average Variation', mediaVar;
        'Ascending Variation', mediaVarSalita;
        'Descending Variation', mediaVarDiscesa;
        'Absolute Maximum', absMax;
        'Absolute Minimum', absMin;
        'Maximum Excursion', maxDiff;
        'Average Peak Derivative', derivata;
        'Ascending Peak Derivative', derivataSalita;
        'Descending Peak Derivative', derivataDiscesa;
        'Average Derivative', derivataMedia;
        'Derivative Standard Deviation', derivataStd;
        'Peaks per Time Unit', picchiNormalizzati
        };
    
% 	% per ora fa solo l'output a schermo
% 	fprintf('\nTra gli istanti %.2fs e %.2fs:\n',VG_tempo_auto(idxStart),VG_tempo_auto(idxEnd));
% 	fprintf(' Media: %.3f\n Varianza: %.3f\n Deviazione Standard: %.3f\n\n', media, varianza, devStd);
% 	fprintf(' Variazione Media: %.3f\n Variazione Crescente: %.3f\n Variazione Decrescente: %.3f\n\n', mediaVar, mediaVarSalita, mediaVarDiscesa);
% 	fprintf(' Derivata: %.3f\n Derivata Crescente: %.3f\n Derivata Decrescente: %.3f\n\n', derivata, derivataSalita, derivataDiscesa);
% 	fprintf(' Derivata Media: %.3f\n Derivata Std: %.3f\n\n', derivataMedia, derivataStd);
% 	fprintf(' Massimo Globale: %.3f\n Minimo Golbale: %.3f\n Escursione Massima: %.3f\n\n', absMax, absMin, maxDiff);
%     fprintf([' Numero di picchi nell''unit', char(224), ' di tempo: %.3f\n\n'], picchiNormalizzati);

    if isempty(infoFig)
        infoFig = GUI_EDA_info;
    end
    PosizionaInfo(handles);
    
    aggiornaBtn = findall(infoFig, 'Tag', 'reloadBtn');
    aggiornaBtn.Callback(aggiornaBtn, []);
else
    if ~isempty(infoFig)
        close(infoFig);
    end
end


function UpdateWindows(handles)
global T_Windows;
%aggiorna la tendina
newList = cell(size(T_Windows, 1)+1, 1);
oldList = cellstr(handles.winChooser.String);
newList{1} = oldList{1};
for winIdx = 1:size(T_Windows, 1)
    newList{winIdx+1} = ['Finestra ',num2str(winIdx)];
end
handles.winChooser.String = newList;
handles.winChooser.Value = 1;
handles.winChooser.Callback(handles.winChooser, []);
handles.winChooser.String = newList;


% --- Executes on button press in StatisticaBtn.
function StatisticaBtn_Callback(hObject, eventdata, handles)
% hObject    handle to StatisticaBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_editWindowsStruct;
global VG_tempo_auto;
global VG_sig_EDA;
global VG_fs;
global VG_eventi;
global etichette_ev;
global pfGUIEDA;
global VG_projectPath;

% set window editor
resetEditWindowsStruct();
VG_editWindowsStruct.tempo = VG_tempo_auto;
VG_editWindowsStruct.signal = VG_sig_EDA;
VG_editWindowsStruct.fs = VG_fs;
VG_editWindowsStruct.eventi = VG_eventi;
VG_editWindowsStruct.labelEventi = etichette_ev;
VG_editWindowsStruct.file = pfGUIEDA;
VG_editWindowsStruct.btnHandle = handles.reloadBtnEDA;
run([VG_projectPath, '/GUI_EditWindows']);


% --- Executes on button press in ckbPeaks.
function ckbPeaks_Callback(hObject, eventdata, handles)
% hObject    handle to ckbPeaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ckbPeaks

PlotEDA(handles);


% --- Executes on button press in saveBtn.
function saveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to saveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T_Windows;
global VG_tempo_auto;
global VG_eventi;
global etichette_ev;

if isempty(T_Windows)
    msgbox('Nessuna finestra selezionata!');
    return;
end

TableEDA_Values = table();
for winIdx = 1:size(T_Windows, 1)
	idxStart = find(VG_tempo_auto <= T_Windows(winIdx, 1),1,'last');
	idxEnd = find(VG_tempo_auto >= T_Windows(winIdx, 2),1,'first');
	
    %individua gli eventi più vicini a idxStart e idxEnd
    [~, evtStartIdx] = min(abs(VG_eventi(:,2) - idxStart));
    evtStartCode = VG_eventi(evtStartIdx, 1);
    [~, evtEndIdx] = min(abs(VG_eventi(:,2) - idxEnd));
    evtEndCode = VG_eventi(evtEndIdx, 1);
    
	% calcola gli indici
	[media, ~, devStd] = analisiStatistica(idxStart,idxEnd);
	[mediaVar, madiaVarSalita, mediaVarDiscesa, absMax, absMin, maxDiff, derivata, derivataSalita, derivataDiscesa, picchiNormalizzati] = peaksIndexes(idxStart, idxEnd, handles);
    [derivataMedia, derivataStd] = continousIndexes(idxStart, idxEnd);

    TableEDA_Values(winIdx, :) = {...
        T_Windows(winIdx, 1), T_Windows(winIdx, 2),...
        evtStartCode, evtEndCode,...
        media, devStd,...
        mediaVar, madiaVarSalita, mediaVarDiscesa,...
        absMax, absMin, maxDiff,...
        derivata, derivataSalita, derivataDiscesa,...
        picchiNormalizzati,...
        derivataMedia, derivataStd};
end

TableEDA_Values.Properties.VariableNames = {...
    'WinStart', 'WinEnd',...
    'EventStart', 'EventEnd',...
    'EDA_Mean','EDA_Std',...
    'VariationMean','VariationAscending','VariationDescending',...
    'AbsoluteMax','AbsoluteMin','MaximumExcursion',...
    'DerivativePksMean','DerivativePksAscending','DerivativePksDescending',...
    'PeaksPerTimeUnit',...
    'DerivativeMean','DerivativeStd'};
    
event_labels = etichette_ev; %#ok<NASGU>

%salva
[fileName, pathName] = uiputfile('*.mat','Salva con Nome','EDA_Features');
if ischar(fileName)
	save([pathName, fileName],'TableEDA_Values','event_labels');
	%disp(['File ', fileName, ' salvato']);
end


function handles = checkPeaks(handles)
%funzione che elimina i picchi individuati erroneamente, ovvero quelli
%dovuti alle oscillazioni introdotte dal filtro
global VG_fs;

limT = 0.9; %numero di secondi di differenza minmimo per accettare il picco
limCamp = limT*VG_fs;

%%%% tentativo 2
% myMinPks = handles.pksMin.pks;
% myMinLocs = handles.pksMin.locs;
% 
% pksDiff = diff(myMinLocs);
% newPos = [];
% for pksIdx = 1:length(pksDiff)
%     if pksDiff(pksIdx) >= limCamp
%         newPos(length(newPos)+1) = pksIdx;
%     end
% end
% 
% handles.pksMin.pks = myMinPks([newPos, end]);
% handles.pksMin.locs = myMinLocs([newPos, end]);

%%%% tentativo 1
% myMinPks = handles.pksMin.pks;
% myMinLocs = handles.pksMin.locs;
% 
% baseIdx = 1;
% while baseIdx < length(myMinLocs) %myMinLocs cambia durante le iterazioni
%     pksDiff = diff(myMinLocs);
%     
%     auxIdx = baseIdx;
%     while (pksDiff(auxIdx) < limCamp) && (auxIdx <= length(pksDiff))
%         auxIdx = auxIdx +1;
%         if auxIdx >= length(pksDiff)
%             break;
%         end
%     end
%     l = length(myMinLocs);
%     myMinLocs = myMinLocs([1:baseIdx-1, auxIdx:l]);
%     myMinPks = myMinPks([1:baseIdx-1, auxIdx:l]);
%     
%     baseIdx = baseIdx+1;
% end
% 
% handles.pksMin.pks = myMinPks;
% handles.pksMin.locs = myMinLocs;

myMaxPks = handles.pksMax.pks;
myMaxLocs = handles.pksMax.locs;
myMinPks = handles.pksMin.pks;
myMinLocs = handles.pksMin.locs;

lMax = length(myMaxLocs);
lMin = length(myMinLocs);

if lMax < lMin
    myMinLocs = myMinLocs(1:lMin-1);
    myMinPks = myMinPks(1:lMin-1);
else
    if lMax > lMin
        myMaxLocs = myMaxLocs(2:lMax);
        myMaxPks = myMaxPks(2:lMax);
    end
end

pksDiff = abs(myMaxLocs - myMinLocs);
newPos = [];
for pksIdx = 1:length(pksDiff)
    if pksDiff(pksIdx) >= limCamp
        newPos(length(newPos)+1) = pksIdx; %#ok<AGROW>
    end
end

handles.pksMax.pks = myMaxPks(newPos);
handles.pksMax.locs = myMaxLocs(newPos);
handles.pksMin.pks = myMinPks(newPos);
handles.pksMin.locs = myMinLocs(newPos);


% --- Executes on selection change in winChooser.
function winChooser_Callback(hObject, eventdata, handles)
% hObject    handle to winChooser (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns winChooser contents as cell array
%        contents{get(hObject,'Value')} returns selected item from winChooser
DisplayIndexes(handles);
PlotEDA(handles);


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


% --- Executes on button press in reloadBtnEDA.
function reloadBtnEDA_Callback(hObject, eventdata, handles)
% hObject    handle to reloadBtnEDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
UpdateWindows(handles);
PlotEDA(handles);


%%%%%%% PREELABORAZIONE %%%%%%%
function [sigFilt] = Filtraggio()
%%%% TUTTO SPOSTATO IN PREELABORAZIONE %%%%
%Filtraggio segnale  5Hz con passabasso basato sulla frequenza di
%campionamento (funzione fir2(n,f,m) che restituisce un filtro FIR)
global VG_sig_EDA;
% global VG_fs;

% n = ordine filtro FIR
% f = vettore delle frequenze [x y z w] dove y e z sono la frequenza di
% cut-off, x e w sono rispettivamente lo 0 e 1.
% m = indica il tipo di filtro
% n=41;
% f=[0 (5.5/VG_fs) (5.5/VG_fs) 1];%5.5 poichè il filtro non è molto responsivo
% 
% m=[1 1 0 0];	%da quello che ho capito il filtro restituisce un segnale 
%                 %con guadagno 1 da 0Hz fino a 5.5Hz per poi crollare
%                 %a guadagno 0 dai 5.5Hz fino alla Fmax
% coeff_filtro=fir2(n,f,m);
% sigFilt=filter(coeff_filtro, 1, VG_sig_EDA); 

% lpfilt = designfilt('lowpassfir','PassbandFrequency',2*5/VG_fs, 'StopbandFrequency',2*5.1/VG_fs, 'StopbandAttenuation', 80, 'DesignMethod', 'equiripple');
% sigFilt = filtfilt(lpfilt, VG_sig_EDA);

% [myCoeffB, myCoeffA, N] = FilterEDA();    
% if length(VG_sig_EDA) <= 3*N
%     [myCoeffB, myCoeffA, N] = BackUp_Filter();
%     if length (VG_sig_EDA) <= N/2
%         warning('filtraggio non applicabile: registrazione troppo corta');
%         sigFilt=VG_sig_EDA;
%     else
%         warning('applicato filtro di ordine %d',N);
%         sigFilt = filtfilt(myCoeffB, myCoeffA, VG_sig_EDA);
%     end
% else
%     % filtro ideale applicato
% 	sigFilt = filtfilt(myCoeffB, myCoeffA, VG_sig_EDA);
% end
% 
% % costruisco un filtro a media mobile per regolarizzare l'andamento del
% % segnale EDA. 
% 
% Campioni_media_mobile = VG_fs;
% N = Campioni_media_mobile;
% H(1:N)=1/N;
% sigFilt = filtfilt(H,1,sigFilt);
% sigFilt=sigFilt./max(sigFilt);

sigFilt = VG_sig_EDA;


%%%%%%% FUNZIONI PER GLI INDICI %%%%%%%
function [average, variance, standDev] = analisiStatistica(t_startIdx, t_endIdx)
average = NaN;
variance = NaN;
standDev = NaN;
global VG_sig_EDA;
if t_startIdx < 1 || t_endIdx > length(VG_sig_EDA)
	return;
end

average = mean(VG_sig_EDA(t_startIdx:t_endIdx));
variance = var(VG_sig_EDA(t_startIdx:t_endIdx));
standDev = sqrt(variance);


function [diffTot, diffMinMax, diffMaxMin, MaxGlobale, MinGlobale, diffMaxMinGlob, derTot, derMinMax, derMaxMin, normalizedPksFreq] = peaksIndexes(t_startIdx, t_endIdx, handles)
%t_startIdx is assumed to be < t_endIdx
diffTot = NaN; %media delle escursioni tra massimi e minimi e viceversa
diffMinMax = NaN; %media delle escursioni da minimo a massimo
diffMaxMin = NaN; %media delle escursioni da massimo a minimo
MaxGlobale = NaN; %massimo assoluto nella finestra
MinGlobale = NaN; %minimo assoluto nella finestra
diffMaxMinGlob = NaN; %massima escursione nella finestra
derTot = NaN; %media dei rapporti incrementali tra massimi e minimi e viceversa
derMinMax = NaN; %media dei rapporti incrementali da minimi a massimi
derMaxMin = NaN; %media dei rapporti incrementali da massimi a minimi
normalizedPksFreq = NaN; %numero di picchi normalizzato sul tempo

global VG_tempo_auto;
if t_startIdx < 1 || t_endIdx > length(VG_tempo_auto)
	return;
end
%findpeaks needs at least 3 samples
if t_endIdx-t_startIdx < 2
	return;
end
locStart = find(handles.pksMax.locs >= t_startIdx, 1, 'first');
locEnd = find(handles.pksMax.locs <= t_endIdx, 1, 'last');
if isempty(locStart) || isempty(locEnd)
    %disp('window too small (max)');
    return;
end
myLocsMax = handles.pksMax.locs(locStart:locEnd);
myPksMax = handles.pksMax.pks(locStart:locEnd);

locStart = find(handles.pksMin.locs >= t_startIdx, 1, 'first');
locEnd = find(handles.pksMin.locs <= t_endIdx, 1, 'last');
if isempty(locStart) || isempty(locEnd)
    %disp('window too small (min)');
    return;
end
myLocsMin = handles.pksMin.locs(locStart:locEnd);
myPksMin = handles.pksMin.pks(locStart:locEnd);

if isempty(myPksMax) || isempty(myPksMin) || isempty(myLocsMin) || isempty(myLocsMax)
    %disp('no peaks');
	return;
end

%elimino il primo massimo se non ha il minimo corrispondente
if myLocsMax(1) < myLocsMin(1)
    if length(myLocsMax)>=2
        myLocsMax = myLocsMax(2:end);
        myPksMax = myPksMax(2:end);
    else
        %disp('two points in the wrong order');
        return
    end
end
if isempty(myPksMax) || isempty(myPksMin)
    %disp('no couple, one max');
	return;
end

%elimino l'ultimo minimo se non ha il massimo corrispondente
if myLocsMax(end) < myLocsMin(end)
    if length(myLocsMin)>=2
        myLocsMin = myLocsMin(1:end-1);
        myPksMin = myPksMin(1:end-1);
    else
        %disp('three points in the wrong order');
        return;
    end
end
if isempty(myPksMax) || isempty(myPksMin)
    %disp('no couple, one min');
	return;
end

if length(myLocsMin) ~= length(myLocsMax)
	%errore grave, non dovrebbe succedere mai in teoria
    %disp('wrong!');
	return;
end

nCouples = length(myLocsMin);% == length(locsMax)
if nCouples==0
    %disp('no couples');
	return;
end

diffMinMax = (sum(myPksMax) - sum(myPksMin));
diffMaxMin = sum(myPksMax(1:end-1)) - sum(myPksMin(2:end));

diffTot = (diffMinMax + diffMaxMin) / (2*nCouples -1);
diffMinMax = diffMinMax / nCouples;
diffMaxMin = diffMaxMin / (nCouples-1);% se nCouples == 1 torna NaN

derMinMax = zeros(nCouples, 1);
derMaxMin = zeros(nCouples-1, 1);
timeMax = VG_tempo_auto(myLocsMax);
timeMin = VG_tempo_auto(myLocsMin);
for pksIdx = 1:nCouples
    derMinMax(pksIdx) = (myPksMax(pksIdx) - myPksMin(pksIdx))/(timeMax(pksIdx) - timeMin(pksIdx));
    if pksIdx == 1
        continue;
    end
    derMaxMin(pksIdx-1) = (myPksMax(pksIdx-1) - myPksMin(pksIdx))/(timeMax(pksIdx-1) - timeMin(pksIdx));
end
derTot = (sum(derMaxMin) + sum(derMinMax))/(2*nCouples -1);
derMinMax = mean(derMinMax);
derMaxMin = mean(derMaxMin);
MaxGlobale = max(myPksMax);
MinGlobale = min(myPksMin);
diffMaxMinGlob = MaxGlobale - MinGlobale;
normalizedPksFreq = nCouples/(VG_tempo_auto(t_endIdx) - VG_tempo_auto(t_startIdx));


function [derivataMedia, derivataStd] = continousIndexes(t_startIdx, t_endIdx)
global VG_tempo_auto;
global VG_sig_EDA;
global VG_fs;

derivataMedia = NaN;
derivataStd = NaN;

if t_startIdx < 1 || t_endIdx > length(VG_tempo_auto)
	return;
end
if t_endIdx-t_startIdx < 2
    return;
end

windowSig = VG_sig_EDA(t_startIdx:t_endIdx);
windowDer = diff(windowSig) * VG_fs;

derivataMedia = mean(windowDer);
derivataStd = std(windowDer);


% --- Executes during object deletion, before destroying properties.
function GUI_EDA_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to GUI_EDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
infoFig = findall(0, 'Tag', 'EDAInfo');
if ~isempty(infoFig)
    close(infoFig);
end


% --- Executes when GUI_EDA is resized.
function GUI_EDA_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to GUI_EDA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
PosizionaInfo(handles);


function PosizionaInfo(handles)

infoFig = findall(0, 'Tag', 'EDAInfo');
if isempty(infoFig)
    return;
end
xPadding = 0.01;

infoFig.Position(2) = sum(handles.GUI_EDA.Position([2 4])) - infoFig.Position(4);
newX = handles.GUI_EDA.Position(1) - infoFig.Position(3)-xPadding;
if newX < 0
    newX = xPadding + sum(handles.GUI_EDA.Position([1 3]));
end
infoFig.Position(1) = newX;
figure(infoFig); %porta in primo piano
figure(handles.GUI_EDA); %restituisce il focus
