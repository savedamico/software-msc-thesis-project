function varargout = DELTA_ANALYSIS_START(varargin)
% DELTA_ANALYSIS_START MATLAB code for DELTA_ANALYSIS_START.fig
%      DELTA_ANALYSIS_START, by itself, creates a new DELTA_ANALYSIS_START or raises the existing
%      singleton*.
%
%      H = DELTA_ANALYSIS_START returns the handle to a new DELTA_ANALYSIS_START or the handle to
%      the existing singleton*.
%
%      DELTA_ANALYSIS_START('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_ANALYSIS_START.M with the given input arguments.
%
%      DELTA_ANALYSIS_START('Property','Value',...) creates a new DELTA_ANALYSIS_START or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_ANALYSIS_START_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_ANALYSIS_START_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_ANALYSIS_START

% Last Modified by GUIDE v2.5 09-May-2018 17:39:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_ANALYSIS_START_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_ANALYSIS_START_OutputFcn, ...
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


% --- Executes just before DELTA_ANALYSIS_START is made visible.
function DELTA_ANALYSIS_START_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_ANALYSIS_START (see VARARGIN)

% Choose default command line output for DELTA_ANALYSIS_START
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



% UIWAIT makes DELTA_ANALYSIS_START wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_ANALYSIS_START_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)


global val;
global main_path ;
val=0;

main_path=uigetdir;

if (path==0)
    return;
end

set(handles.edit1,'String',main_path);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.

function pushbutton2_Callback(hObject, eventdata, handles)



%run(['DELTA_ANALYSIS.m']);

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






% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Calculate Delta Button
function pushbutton3_Callback(hObject, eventdata, handles)

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

run(['DELTA_ANALYSIS_PPP.m']);

waitbar(2/2,h);
close(h);

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

global EEG_load;

for s = 1:num_signals
    % get signal
    signal =  signalCell{s};
    samplingRate = signalHeader(s).samples_in_record;
    record_duration = header.data_record_duration;
    t = [0:length(signal)-1]/samplingRate';

    % Identify first 30 seconds
    indexes = find(t<=tmax);
    signal = signal(indexes);
    t = t(indexes);

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
    plot(t(indexes), signal(indexes));
    hold on
end

% Set axis limits
v = axis();
v(1:2) = [0 tmax];
v(3:4) = [-0.5 num_signals+1.5];
axis(v);

% Set x axis
xlabel('Time(sec)');

% Set yaxis labels
signalLabels = cell(1,num_signals);
prova=linspace(1,num_signals,num_signals);
for s = 1:num_signals
    signalLabels{num_signals-s+1} = prova(s) %signalHeader(s).signal_labels;
end
set(gca, 'YTick', [1:1:num_signals]);
set(gca, 'YTickLabel', signalLabels);




% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
