function varargout = DELTA_2_HYPNO_START(varargin)
% DELTA_2_HYPNO_START MATLAB code for DELTA_2_HYPNO_START.fig
%      DELTA_2_HYPNO_START, by itself, creates a new DELTA_2_HYPNO_START or raises the existing
%      singleton*.
%
%      H = DELTA_2_HYPNO_START returns the handle to a new DELTA_2_HYPNO_START or the handle to
%      the existing singleton*.
%
%      DELTA_2_HYPNO_START('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_2_HYPNO_START.M with the given input arguments.
%
%      DELTA_2_HYPNO_START('Property','Value',...) creates a new DELTA_2_HYPNO_START or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_2_HYPNO_START_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_2_HYPNO_START_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_2_HYPNO_START

% Last Modified by GUIDE v2.5 28-May-2018 10:18:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_2_HYPNO_START_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_2_HYPNO_START_OutputFcn, ...
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


% --- Executes just before DELTA_2_HYPNO_START is made visible.
function DELTA_2_HYPNO_START_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_2_HYPNO_START (see VARARGIN)

% Choose default command line output for DELTA_2_HYPNO_START
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DELTA_2_HYPNO_START wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_2_HYPNO_START_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;







% --- Browse folder
function pushbutton1_Callback(hObject, eventdata, handles)

global main_path ;

main_path=uigetdir;

if (path==0)
    return;
end

set(handles.edit1,'String',main_path);



% --- Load data
function pushbutton2_Callback(hObject, eventdata, handles)

global main_path;
global EEG_load;
global ECG_load;
global SIEZ_load;
%global RESP_load;

h=waitbar(0,'Loading'); 
waitbar(1/2,h);

dir=main_path;

SIEZ=fullfile(dir,'Event.mat');
EEG=fullfile(dir,'EEG.mat');
ECG=fullfile(dir,'ECG.mat');
%RESP=fullfile(dir,'RESP.mat');

%load(RESP);
load(SIEZ)
load(EEG);
load(ECG);

SIEZ_load=event_time;
EEG_load=EEG;
ECG_load=ECG;
%RESP_load=RESP;
%calcolo subito il delta dai due soli canali dell'EEG

run(['DELTA_2_HYPNO.m']);
waitbar(2/2,h);
close(h);




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
