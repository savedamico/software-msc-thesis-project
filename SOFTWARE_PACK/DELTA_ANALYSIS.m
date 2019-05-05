function varargout = DELTA_ANALYSIS(varargin)
% DELTA_ANALYSIS MATLAB code for DELTA_ANALYSIS.fig
%      DELTA_ANALYSIS, by itself, creates a new DELTA_ANALYSIS or raises the existing
%      singleton*.
%
%      H = DELTA_ANALYSIS returns the handle to a new DELTA_ANALYSIS or the handle to
%      the existing singleton*.
%
%      DELTA_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_ANALYSIS.M with the given input arguments.
%
%      DELTA_ANALYSIS('Property','Value',...) creates a new DELTA_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_ANALYSIS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_ANALYSIS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_ANALYSIS

% Last Modified by GUIDE v2.5 07-May-2018 10:42:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_ANALYSIS_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_ANALYSIS_OutputFcn, ...
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


% --- Executes just before DELTA_ANALYSIS is made visible.
function DELTA_ANALYSIS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_ANALYSIS (see VARARGIN)

% Choose default command line output for DELTA_ANALYSIS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global main_path;
global EEG_load;

h=waitbar(0,'Loading','Name','Export'); 
waitbar(1/2,h);

set(handles.edit1,'String',main_path);
dir=main_path;
EEG=fullfile(dir,'EEG.mat');
load(EEG);
EEG_load=EEG;
set(handles.uitable1,'Data',EEG); %tabella

waitbar(2/2,h);
close(h);



% UIWAIT makes DELTA_ANALYSIS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_ANALYSIS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.--------------CALCULATE DELTA
function pushbutton1_Callback(hObject, eventdata, handles)

global CHN1;
global CHN2;
global EEG_load;
global main_path;

CHN1 = str2num(char(get(handles.edit2,'String')));
CHN2 = str2num(char(get(handles.edit3,'String')));

temp(:,1)=EEG_load(:,CHN1);
temp(:,2)=EEG_load(:,CHN2);
DATA_FDS=temp';

h=waitbar(0,'Loading','Name','Export'); 
waitbar(1/2,h);

run(['DELTA_ANALYSIS_VIEW.m']);

waitbar(2/2,h);
close(h);


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% ------- VIEWS EEG
function pushbutton2_Callback(hObject, eventdata, handles)

global EEG_load;
num_signals=0;

fig = figure();
[m,n] = size(EEG_load);
i=1;
f=1;
for(i=1:n)
    if(EEG_load(1,i)~=0) 
        num_signals=num_signals+1;
    end;     
end;

while(EEG_load(1,f)==0) f=f+1; start=f; end;


for s = 1:num_signals
    % get signal
    now=(start-1)+s;
    signal =  EEG_load(:,now);
    %samplingRate = signalHeader(s).samples_in_record;
    %record_duration = header.data_record_duration;
    %t = [0:length(signal)-1]/250;

    % Identify first 30 seconds
    %indexes = m;
    %signal = signal(indexes);
    %t = t(indexes);

    % Normalize signal
    sigMin = min(signal);
    sigMax = max(signal);
    signalRange = sigMax - sigMin;
    signal = (signal - sigMin);
    if signalRange~= 0
        signal = signal/(sigMax-sigMin);
    end
    signal = signal -0.5*mean(signal) + num_signals - s + 1;

    % Plot signal
    plot(signal); 
    hold on
    now
end

% Set title
title('EEG Channels');

% Set axis limits
v = axis();
v(1:2) = [0 m];
v(3:4) = [-0.5 num_signals+1.5];
axis(v);

% Set x axis
xlabel('Samples');

% Set yaxis labels
signalLabels = cell(1,num_signals);
prova=linspace(1,num_signals,num_signals);
for s = 1:num_signals
    signalLabels{num_signals-s+1} = prova(s); %signalHeader(s).signal_labels;
end
set(gca, 'YTick', [1:1:num_signals]);
set(gca, 'YTickLabel', signalLabels);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
