function varargout = GUI_TacoEditor(varargin)
% GUI_TACOEDITOR M-file for GUI_TacoEditor.fig
%      GUI_TACOEDITOR, by itself, creates a new GUI_TACOEDITOR or raises the existing
%      singleton*.
%
%      H = GUI_TACOEDITOR returns the handle to a new GUI_TACOEDITOR or the handle to
%      the existing singleton*.
%
%      GUI_TACOEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_TACOEDITOR.M with the given input arguments.
%
%      GUI_TACOEDITOR('Property','Value',...) creates a new GUI_TACOEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before correction_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_TacoEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_TacoEditor

% Last Modified by GUIDE v2.5 08-Nov-2017 11:53:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @GUI_TacoEditor_OpeningFcn, ...
    'gui_OutputFcn',  @GUI_TacoEditor_OutputFcn, ...
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


% --- Executes just before GUI_TacoEditor is made visible.
function GUI_TacoEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_TacoEditor (see VARARGIN)

handles.ecgchannel = [];
handles.samplefrequency = [];
handles.window = [];
handles.signalECG = []; % ECG
handles.signalTACO = []; % TACO
handles.tStart = 0;
handles.contador = [];
handles.N = [];
handles.mode = 'rest';% mode can be 'rest', 'add' or 'remove'

% Choose default command line output for GUI_TacoEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global VG_taco;
global VG_sig_ECG;
global VG_fs;
global VG_tempo_auto;

handles.signalECG = VG_sig_ECG;
handles.signalTACO = VG_taco;
handles.tStart = VG_tempo_auto (1);

handles.contador = 0;
handles.samplefrequency_edit.String = num2str(VG_fs);

guidata(hObject,handles);

PlotSegnali(handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_TacoEditor_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function MainActivity(handles)
switch handles.mode
    case 'rest'
        % do nothing
    case 'add'
        avoidPlot = false;
        while true
            axYlim = ylim(handles.EcgGraph);
            axXlim = xlim(handles.EcgGraph);
            try
                [x,y, btn]=ginput(1);
            catch ME
                return;
            end

            if btn ~= 1
                handles.mode = 'rest';
                guidata(handles.EcgGraph, handles);
                break;
            end
            if y<axYlim(1) || y>axYlim(2) || x<axXlim(1) || x>axXlim(2)
                avoidPlot = true;
                break;
            end

            vecPeaks = GetPeaks(handles.signalTACO);

            timeBefore = find(vecPeaks<x, 1, 'last');
            timeAfter = find(vecPeaks>x, 1, 'first');

            if isempty(timeBefore) && isempty(timeAfter)
                %non esiste il tacogramma
                handles.mode = 'rest';
                guidata(handles.EcgGraph, handles);
                break;
            elseif isempty(timeBefore)
                %devo aggiungere il primo punto
                newTimesVector = [x; vecPeaks];
            elseif isempty(timeAfter)
                %devo aggiungere l'ultimo punto
                newTimesVector = [vecPeaks; x];
            else
                %aggiungo un punto intermedio
                newTimesVector = [vecPeaks(1:timeBefore); x; vecPeaks(timeAfter:end)];
            end

            handles.signalTACO = GetTaco(newTimesVector);
            guidata(handles.EcgGraph,handles);
            
            PlotSegnali(handles);
        end
        if ~avoidPlot
            PlotSegnali(handles);
        end
    case 'remove'
        avoidPlot = false;
        while true
            axYlim = ylim(handles.EcgGraph);
            axXlim = xlim(handles.EcgGraph);
            try
                [x,y, btn]=ginput(1);
            catch ME
                return;
            end

            if btn ~= 1
                handles.mode = 'rest';
                guidata(handles.EcgGraph, handles);
                break;
            end
            if y<axYlim(1) || y>axYlim(2) || x<axXlim(1) || x>axXlim(2)
                avoidPlot = true;
                break;
            end

            vecPeaks = GetPeaks(handles.signalTACO);

            timeBefore = find(vecPeaks<x, 1, 'last');
            timeAfter = find(vecPeaks>x, 1, 'first');

            if isempty(timeBefore) && isempty(timeAfter)
                %non esiste il tacogramma in pratica
                handles.mode = 'rest';
                guidata(handles.EcgGraph, handles);
                break;
            elseif isempty(timeBefore)
                %devo rimuovere il primo punto
                newPeaksVector = vecPeaks(2:end);
            elseif isempty(timeAfter)
                %è già oltre l'ultimo
                newPeaksVector = vecPeaks;
            else
                %aggiungo il punto intermedio
                newPeaksVector = [vecPeaks(1:timeBefore); vecPeaks(timeAfter+1:end)];
            end

            handles.signalTACO = GetTaco(newPeaksVector);
            guidata(handles.EcgGraph,handles);

            PlotSegnali(handles);
        end
        if ~avoidPlot
            PlotSegnali(handles);
        end
    otherwise
        handles.mode = 'rest';
        guidata(handles.EcgGraph, handles);
        MainActivity(handles);
end


% --- Executes on button press in next_pushbutton.
function next_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to next_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

jump = str2double(get(handles.window_edit,'String'));
fcamp = str2double(get(handles.samplefrequency_edit,'String'));

maxSignalTime = length(handles.signalECG)/fcamp;
handles.contador = handles.contador + jump;

if handles.contador + jump > maxSignalTime
	handles.contador = maxSignalTime - jump;
end

guidata(hObject, handles);
PlotSegnali(handles);
MainActivity(handles);


% --- Executes on button press in back_pushbutton.
function back_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to back_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
jump = str2double(get(handles.window_edit,'String'));
handles.contador = handles.contador - jump;
if handles.contador < 0
	handles.contador = 0;
end

guidata(hObject,handles)
PlotSegnali(handles);
MainActivity(handles);


function PlotSegnali(handles)

fcamp = str2double(get(handles.samplefrequency_edit,'String'));
jump = str2double(get(handles.window_edit,'String'));

%%% ECG graph %%%
axes(handles.EcgGraph);
maxY = max(handles.signalECG);
minY = min(handles.signalECG);
handles.N = handles.tStart + (1:length(handles.signalECG))/fcamp;
plot(handles.N,handles.signalECG);
xlim([handles.contador handles.contador+jump]);%contador è il primo valore in secondi che viene mostrato
ylim([minY maxY]);
xlabel('time [s]');

% plot dei picchi
hold on
puntiTempi = GetPeaks(handles.signalTACO);
ordin = ((maxY + minY) / 2) * ones(size(puntiTempi));
plot(puntiTempi, ordin, '*r');
hold off

%%% TACO graph %%%
axes(handles.TacoGraph);
maxY = max(handles.signalTACO(:,2));
minY = min(handles.signalTACO(:,2));
maxX = max(handles.signalTACO(:,1));
minX = min(handles.signalTACO(:,1));

plot(handles.signalTACO(:,1),handles.signalTACO(:,2));
axis([minX, maxX, minY, maxY]);
xlabel('seg');
line([handles.contador handles.contador],[minY maxY],'color','r');
line([handles.contador+jump handles.contador+jump],[minY maxY],'color','r');


% --- Executes during object creation, after setting all properties.
function ecgchannel_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ecgchannel_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function ecgchannel_edit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function samplefrequency_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplefrequency_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function samplefrequency_edit_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function window_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to window_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


function window_edit_Callback(hObject, eventdata, handles)
PlotSegnali(handles);
MainActivity(handles);


% --- Executes on button press in addpeak_pushbutton.
function addpeak_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to addpeak_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.mode = 'add';
guidata(handles.EcgGraph, handles);
MainActivity(handles);


% --- Executes on button press in erasepeak_pushbutton.
function erasepeak_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to erasepeak_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.mode = 'remove';
guidata(handles.EcgGraph, handles);
MainActivity(handles);


% --- Executes on button press in respiro_pushbutton.
function respiro_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to respiro_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_taco;
global VG_sig_respiro;
global VG_fs;
global VG_tempo_auto;
global VG_fullscreenStruct;
global VG_projectPath;

respirogramma =  zeros(size(VG_taco));
respirogramma(:,1) = VG_taco(:,1); % copio il vettore tempi
respirogramma(:,2) = VG_sig_respiro(round(VG_taco(:,1)*VG_fs));

myPlot = newFullscreenStruct();
myPlot.data(1).signal = VG_sig_respiro;
myPlot.data(1).time = VG_tempo_auto;
myPlot.data(1).info = '';
myPlot.data(2).signal = respirogramma(:,2);
myPlot.data(2).time = respirogramma(:,1);
myPlot.data(2).info = 'o';

myPlot.fs = VG_fs;
myPlot.title = 'Respirogramma';
myPlot.xlabel = 'Tempo [s]';
myPlot.ylabel = 'Respiro';
myPlot.events = true;
VG_fullscreenStruct(1) = myPlot;
run([VG_projectPath, '/GUI_FullScreen']);


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global VG_taco;
global VG_resp;
global VG_sig_respiro;
global VG_fs;
global pfGUIECG;

sig_tacogramma = handles.signalTACO;
sig_respirogramma = zeros(size(sig_tacogramma));
sig_respirogramma(:,1) = sig_tacogramma(:,1); % copio il vettore tempi
sig_respirogramma(:,2) = VG_sig_respiro(round(sig_tacogramma(:,1)*VG_fs));

if ~isequal(VG_taco, sig_tacogramma) || ~isequal(VG_resp, sig_respirogramma)
    VG_taco = sig_tacogramma;
    VG_resp = sig_respirogramma;

    %%% salva sul file il nuovo tacogramma
    save(pfGUIECG, 'sig_tacogramma', 'sig_respirogramma', '-append');
    %disp(['Il File [', pfGUIECG, '] ', char(232), ' stato aggiornato']);
    
    %%% calcola le potenze
    wb = waitbar(0,'Saving...');
    postTacoActivity(sig_tacogramma, sig_respirogramma, wb, 0, 1);
    delete(wb);
end
%%% chiude la finestra di edit
h = findall(0, 'tag', 'GUI_TacoEditor');
close(h);


% --- Executes on button press in AutomaticBtn.
function AutomaticBtn_Callback(hObject, eventdata, handles)
% hObject    handle to AutomaticBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_sig_ECG;
global VG_sig_respiro;
global VG_fs;
global VG_tempo_auto;

choice = questdlg('Choose the algorithm to run', ...
	'Algorithm Choice', ...
	'Pan Tompkins [Default]','Pan Tompkins [Original]','Hardware-like',...
    'Pan Tompkins [Default]');

if isempty(choice) %dialog closed
    return;
end

handles.signalTACO = [];
switch choice
    case 'Pan Tompkins [Default]'
        handles.signalTACO = pan_tompkins(VG_sig_ECG, VG_sig_respiro, VG_fs, VG_tempo_auto);% TacoHardware(VG_sig_ECG, VG_fs, VG_tempo_auto(1), 200);
    case 'Pan Tompkins [Original]'
        [taco, locs] = pan_tompkin(VG_sig_ECG, VG_fs, 0);
        handles.signalTACO(:,2) = taco;
        handles.signalTACO(:,1) = VG_tempo_auto(locs);
    case 'Hardware-like'
        handles.signalTACO = TacoHardware(VG_sig_ECG, VG_fs, VG_tempo_auto(1));
end

guidata(hObject, handles);
PlotSegnali(handles);


% --- Executes on button press in helpBtn.
function helpBtn_Callback(hObject, eventdata, handles)
% hObject    handle to helpBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox(['Scorrere le finestre con Back e Next' char(10) 'Aggiungere o rimuovere punti R con i rispettivi bottoni' char(10) 'Premere il tasto destro per terminare l''input']);
handles.mode = 'rest';
guidata(handles.EcgGraph, handles);
MainActivity(handles);


% --- Executes when user attempts to close GUI_TacoEditor.
function GUI_TacoEditor_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to GUI_TacoEditor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = findall(0, 'tag', 'reloadBtnECG');
h.Callback(h, []);

% Hint: delete(hObject) closes the figure
delete(hObject);


function TACO = GetTaco(peaks)
%funzione per ottenere il tacogramma noti i picchi R
TACO = [];
if length(peaks) < 2
    return;
end
TACO = zeros(length(peaks)-1, 2);
TACO(:,1) = peaks(2:end);
TACO(:,2) = diff(peaks);


function peaks = GetPeaks(taco)
peaks = [];
if isempty(taco)
    return;
end
peaks = [taco(1,1)-taco(1,2); taco(:,1)];


% --- Executes on button press in tacoFiltBtn.
function tacoFiltBtn_Callback(hObject, eventdata, handles)
% hObject    handle to tacoFiltBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
order = str2double(handles.filtOrder.String);
if isnan(order)
    order = 3;
    handles.filtOrder.String = '3';
elseif order<1
    order = 1;
    handles.filtOrder.String = '1';
end
filteredTaco = medfilt1(handles.signalTACO(:,2), order);
filteredPeaks = zeros(size(filteredTaco, 1)+1, 1);
filteredPeaks(1) = handles.signalTACO(1,1) - handles.signalTACO(1,2);
pIdx = 2;
while pIdx <= length(filteredTaco)+1
    if filteredTaco(pIdx-1) == 0
        continue;
    end
    filteredPeaks(pIdx) = filteredPeaks(pIdx-1)+filteredTaco(pIdx-1);
    pIdx = pIdx+1;
end
handles.signalTACO = GetTaco(filteredPeaks);

guidata(hObject,handles);
PlotSegnali(handles);
MainActivity(handles);


function filtOrder_Callback(hObject, eventdata, handles)
% hObject    handle to filtOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of filtOrder as text
%        str2double(get(hObject,'String')) returns contents of filtOrder as a double


% --- Executes during object creation, after setting all properties.
function filtOrder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filtOrder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
