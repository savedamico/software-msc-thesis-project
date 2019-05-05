function varargout = DELTA_ANALYSIS_ERROR_2(varargin)
% DELTA_ANALYSIS_ERROR_2 MATLAB code for DELTA_ANALYSIS_ERROR_2.fig
%      DELTA_ANALYSIS_ERROR_2, by itself, creates a new DELTA_ANALYSIS_ERROR_2 or raises the existing
%      singleton*.
%
%      H = DELTA_ANALYSIS_ERROR_2 returns the handle to a new DELTA_ANALYSIS_ERROR_2 or the handle to
%      the existing singleton*.
%
%      DELTA_ANALYSIS_ERROR_2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_ANALYSIS_ERROR_2.M with the given input arguments.
%
%      DELTA_ANALYSIS_ERROR_2('Property','Value',...) creates a new DELTA_ANALYSIS_ERROR_2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_ANALYSIS_ERROR_2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_ANALYSIS_ERROR_2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_ANALYSIS_ERROR_2

% Last Modified by GUIDE v2.5 11-May-2018 14:19:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_ANALYSIS_ERROR_2_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_ANALYSIS_ERROR_2_OutputFcn, ...
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


% --- Executes just before DELTA_ANALYSIS_ERROR_2 is made visible.
function DELTA_ANALYSIS_ERROR_2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_ANALYSIS_ERROR_2 (see VARARGIN)

% Choose default command line output for DELTA_ANALYSIS_ERROR_2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DELTA_ANALYSIS_ERROR_2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_ANALYSIS_ERROR_2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
