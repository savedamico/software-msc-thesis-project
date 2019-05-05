function varargout = GUI_FullScreen(varargin)
% GUI_FULLSCREEN MATLAB code for GUI_FullScreen.fig
%      GUI_FULLSCREEN, by itself, creates a new GUI_FULLSCREEN or raises the existing
%      singleton*.
%
%      H = GUI_FULLSCREEN returns the handle to a new GUI_FULLSCREEN or the handle to
%      the existing singleton*.
%
%      GUI_FULLSCREEN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FULLSCREEN.M with the given input arguments.
%
%      GUI_FULLSCREEN('Property','Value',...) creates a new GUI_FULLSCREEN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_FullScreen_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_FullScreen_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_FullScreen

% Last Modified by GUIDE v2.5 01-Dec-2017 10:28:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 0;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_FullScreen_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_FullScreen_OutputFcn, ...
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
function varargout = GUI_FullScreen_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object deletion, before destroying properties.
function FullScreenFigure_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to FullScreenFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% stop(handles.sliderTimer);
% delete(handles.sliderTimer);
resetFullscreenStruct();


% --- Executes just before GUI_FullScreen is made visible.
function GUI_FullScreen_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_FullScreen (see VARARGIN)

% Choose default command line output for GUI_FullScreen
handles.output = hObject;

% Setting iniziali
global VG_fullscreenStruct;
handles.fullscreenData = VG_fullscreenStruct;
resetFullscreenStruct();
handles.event_label = false;

nGraph = length(handles.fullscreenData);
if nGraph > 1
    axes(handles.FullScreenGraph);
    for graphIdx = 1:nGraph
        handles.subAx(graphIdx) = subplot(nGraph, 1, graphIdx);
    end
end
guidata(hObject,handles);

if nGraph > 0
    nPartsMax = round(handles.fullscreenData(1).nParts);
    for gIdx = 1:nGraph
        if handles.fullscreenData(gIdx).nParts <= 0
            handles.fullscreenData(gIdx).nParts = 10; %default
        end
        handles.fullscreenData(gIdx).nParts = round(handles.fullscreenData(gIdx).nParts);
        nPartsMax = max(handles.fullscreenData(gIdx).nParts, nPartsMax);
    end
    if nPartsMax <= 1
        handles.graphSlider.Visible = 'off';
    else
        step = 1/nPartsMax;
        handles.graphSlider.SliderStep = [step/10 step];
        handles.graphSlider.Value = 0;
    end
else
    handles.graphSlider.Visible = 'off';
end


% Chiama il riposizionamento grafico
FixPosition(hObject, handles);
% Mostra il grafico e gli eventi
PlotGraph(hObject, handles);

% Update handles structure
guidata(hObject, handles);


% --- Executes when FullScreenFigure is resized.
function FullScreenFigure_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to FullScreenFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Chiama il riposizionamento grafico
FixPosition(hObject, handles);


% Funzione che mette in ordine i componenti in funzione della dimensione
% della finestra
function FixPosition(myFigure, handles)
paddingX = 2;
paddingY = 0.5;
xLabelSpace = 8;
yLabelSpace = 3.5;
sliderHeight = 1.5;
%legend has fixed dimensions, the graph uses all the remaining space

handles.FullScreenPanel.Position = [paddingX, paddingY, myFigure.Position([3 4])-2*[paddingX paddingY]];
% graphWidth = handles.FullScreenPanel.Position(3)*graphPerc - 1.5*paddingX;
graphWidth = handles.FullScreenPanel.Position(3) - 3*paddingX - handles.eventsPanel.Position(3);
handles.graphSlider.Position = [paddingX, paddingY, graphWidth, sliderHeight];
xGraph = paddingX; %space for y-label text
yGraph = sum(handles.graphSlider.Position([2 4])) + paddingY; %space for x-label text
wGraph = sum(handles.graphSlider.Position([1 3]))-xGraph;
hGraph = handles.FullScreenPanel.Position(4) - paddingY - yGraph -2;
handles.graphContainer.Position = [xGraph, yGraph, wGraph, hGraph];
if isfield(handles, 'FullScreenGraph')
    if isvalid(handles.FullScreenGraph)
        handles.FullScreenGraph.Position = [xLabelSpace+paddingX, yLabelSpace+paddingY, wGraph-xLabelSpace-paddingX, hGraph-yLabelSpace-2*paddingY];
    end
end
xEvents = sum(handles.graphSlider.Position([1 3])) + paddingX;
% wEvents = handles.FullScreenPanel.Position(3) - paddingX - xEvents;
% hEvents = sum(handles.FullScreenGraph.Position([2 4])) - handles.graphSlider.Position(2) +0.5;%0.5 is for the panel text
% yEvents = hEvents;
yEvents = sum(handles.graphContainer.Position([2 4])) - handles.eventsPanel.Position(4) +0.5;%0.5 is for the panel text
%handles.eventsPanel.Position = [xEvents yEvents wEvents hEvents];
handles.eventsPanel.Position([1 2]) = [xEvents yEvents];


function PlotGraph(hObject, handles)
global VG_eventi;
global etichette_ev;

if length(handles.fullscreenData) < 1
    return;
end

nGraph = length(handles.fullscreenData);
if nGraph == 1
	handles.FullScreenPanel.Title = handles.fullscreenData(1).title;
else
	handles.FullScreenPanel.Title = '';
end
for graphIdx = 1:nGraph
    if nGraph > 1
        axes(handles.subAx(graphIdx));
    else
        axes(handles.FullScreenGraph);
    end
    
    for sgIdx = 1:length(handles.fullscreenData(graphIdx).data)
        hold on;
        if ~ischar(handles.fullscreenData(graphIdx).data(sgIdx).info)
            handles.fullscreenData(graphIdx).data(sgIdx).info = '';
        end
        if isfield(handles.fullscreenData(graphIdx).data(sgIdx), 'prop')
            if ~iscell(handles.fullscreenData(graphIdx).data(sgIdx).prop)
                handles.fullscreenData(graphIdx).data(sgIdx).prop = {};
            end
        else
            handles.fullscreenData(graphIdx).data(sgIdx).prop = {};
        end
        plot(handles.fullscreenData(graphIdx).data(sgIdx).time, handles.fullscreenData(graphIdx).data(sgIdx).signal, handles.fullscreenData(graphIdx).data(sgIdx).info, handles.fullscreenData(graphIdx).data(sgIdx).prop{:});
        hold off;
    end
    if nGraph ~= 1
        title(handles.fullscreenData(graphIdx).title);
    end
    xlabel(handles.fullscreenData(graphIdx).xlabel);
    ylabel(handles.fullscreenData(graphIdx).ylabel);
    pan off;
    guidata(hObject, handles);
end
setAxis(handles);

for graphIdx = 1:nGraph
    if nGraph > 1
        subplot(handles.subAx(graphIdx));
    end
    if handles.fullscreenData(1).events
        handles.event_label = plot_eventi(handles.eventsPanel, gca, VG_eventi, etichette_ev, handles.fullscreenData(1).fs, handles.event_label);
    end
end
guidata(hObject, handles);


function setAxis(handles)
nGraph = length(handles.fullscreenData);
for plotIdx = 1:nGraph
    %find in how many parts the graph should be divided
    nParts = handles.fullscreenData(plotIdx).nParts;
    
    %set the correct current axes
    if nGraph == 1
        axes(handles.FullScreenGraph); %#ok<LAXES>
    else
        axes(handles.subAx(plotIdx)); %#ok<LAXES>
    end
    
    %trovo gli estremi lungo x e y dei dati da plottare
    dataMaxArr = zeros(length(handles.fullscreenData(plotIdx).data), 1);
    dataMinArr = zeros(length(handles.fullscreenData(plotIdx).data), 1);
    timeMaxArr = zeros(length(handles.fullscreenData(plotIdx).data), 1);
    timeMinArr = zeros(length(handles.fullscreenData(plotIdx).data), 1);
    for dataIdx = 1:length(handles.fullscreenData(plotIdx).data)
        dataMaxArr(dataIdx) = max(handles.fullscreenData(plotIdx).data(dataIdx).signal);
        dataMinArr(dataIdx) = min(handles.fullscreenData(plotIdx).data(dataIdx).signal);
        timeMaxArr(dataIdx) = max(handles.fullscreenData(plotIdx).data(dataIdx).time);
        timeMinArr(dataIdx) = min(handles.fullscreenData(plotIdx).data(dataIdx).time);
    end
    dataMax = max(dataMaxArr);
    dataMin = min(dataMinArr);
    timeMax = max(timeMaxArr);
    timeMin = min(timeMinArr);

    if dataMax == 0
        yDisplayMax = 0;
    else
        expMax = floor(log10(abs(dataMax)));
        yDisplayMax = (10^expMax) * floor(dataMax/(10^expMax) + 1);
    end

    if dataMin == 0
        yDisplayMin = 0;
    else
        expMin = floor(log10(abs(dataMin)));
        yDisplayMin = (10^expMin) * ceil(dataMin/(10^expMin) - 1);
    end

    xDisplayWidth = ((timeMax-timeMin)/nParts);%divido l'intervallo in parti uguali
    xDisplayMin = timeMin + (handles.graphSlider.Value * xDisplayWidth * (nParts-1));
    xDisplayMax = min(xDisplayMin+xDisplayWidth, timeMax);
    xDisplayMin = xDisplayMax - xDisplayWidth;%serve per quando viene cambiato il massimo
    axis([xDisplayMin xDisplayMax yDisplayMin yDisplayMax]);%graph rectangle displayed [xmin xmax ymin ymax]
    tickStep = round(xDisplayWidth/nParts);
    gca.XTick = xDisplayMin:tickStep:xDisplayMax;
end

% --- Executes on slider movement.
function graphSlider_Callback(hObject, eventdata, handles)
% hObject    handle to graphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
minStep = min(hObject.SliderStep);
hObject.Value = round(hObject.Value/minStep)*minStep;
setAxis(handles);


% --- Executes during object creation, after setting all properties.
function graphSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graphSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
