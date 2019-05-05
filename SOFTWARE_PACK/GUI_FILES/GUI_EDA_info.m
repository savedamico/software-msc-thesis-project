function varargout = GUI_EDA_info(varargin)
% GUI_EDA_INFO MATLAB code for GUI_EDA_info.fig
%      GUI_EDA_INFO, by itself, creates a new GUI_EDA_INFO or raises the existing
%      singleton*.
%
%      H = GUI_EDA_INFO returns the handle to a new GUI_EDA_INFO or the handle to
%      the existing singleton*.
%
%      GUI_EDA_INFO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_EDA_INFO.M with the given input arguments.
%
%      GUI_EDA_INFO('Property','Value',...) creates a new GUI_EDA_INFO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_EDA_info_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_EDA_info_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_EDA_info

% Last Modified by GUIDE v2.5 08-Nov-2017 15:55:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_EDA_info_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_EDA_info_OutputFcn, ...
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


% --- Executes just before GUI_EDA_info is made visible.
function GUI_EDA_info_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_EDA_info (see VARARGIN)

% Choose default command line output for GUI_EDA_info
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_EDA_info wait for user response (see UIRESUME)
% uiwait(handles.EDAInfo);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_EDA_info_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in reloadBtn.
function reloadBtn_Callback(hObject, eventdata, handles)
% hObject    handle to reloadBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DisplayIndici(handles);


function DisplayIndici(handles)
global VG_EDA_indici;

nIndici = size(VG_EDA_indici, 1);
vertPadding = 0.05;
x = 0.05;
widthText = 0.55;
widthValue = 0.35;
height = 0.9/nIndici;
delete(findall(handles.PanelEdaInfo.Children, 'Tag',''));
for idx = 1:nIndici
    y = vertPadding+(nIndici-idx)*height;
    h = uicontrol(handles.PanelEdaInfo, 'Style','text','FontSize',10,'String', [VG_EDA_indici{idx,1}, ':'],'Units','normalized','HorizontalAlignment','right');
    h.Position = [x, y, widthText, height];
    h = uicontrol(handles.PanelEdaInfo, 'Style','text','FontSize',10,'String', num2str(VG_EDA_indici{idx,2}),'Units','normalized','HorizontalAlignment','left');
    h.Position = [x+widthText, y, widthValue, height];
end
