function varargout = HYPNO_APP_DELTA(varargin)
% HYPNO_APP_DELTA MATLAB code for HYPNO_APP_DELTA.fig
%      HYPNO_APP_DELTA, by itself, creates a new HYPNO_APP_DELTA or raises the existing
%      singleton*.
%
%      H = HYPNO_APP_DELTA returns the handle to a new HYPNO_APP_DELTA or the handle to
%      the existing singleton*.
%
%      HYPNO_APP_DELTA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HYPNO_APP_DELTA.M with the given input arguments.
%
%      HYPNO_APP_DELTA('Property','Value',...) creates a new HYPNO_APP_DELTA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HYPNO_APP_DELTA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HYPNO_APP_DELTA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HYPNO_APP_DELTA

% Last Modified by GUIDE v2.5 18-Apr-2018 09:07:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HYPNO_APP_DELTA_OpeningFcn, ...
                   'gui_OutputFcn',  @HYPNO_APP_DELTA_OutputFcn, ...
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


% --- Executes just before HYPNO_APP_DELTA is made visible.
function HYPNO_APP_DELTA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HYPNO_APP_DELTA (see VARARGIN)

% Choose default command line output for HYPNO_APP_DELTA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);




EEG=getappdata(0,'EEG');
load(EEG);

temp(:,1)=EEG(:,1);
temp(:,2)=EEG(:,2);
DATA_FDS=temp';
lim=length(EEG);

%plot HYPNOGRAM
axes(handles.axes1);
cla;

SLEEP=getappdata(0,'SLEEP_EXPORT');
load(SLEEP);

slim=length(lables);
i=1;

%omologa lables (format 1,2,3,4,5)
while((lables(i,1)~=6) && (i~=slim))
    i=i+1; 
end

if(lables(i,1)==6) 
    for(i=1:slim)
        if((lables(i,1)==3)||(lables(i,1)==4)) lables(i,1)=2; end
        if(lables(i,1)==5) lables(i,1)=3; end
        if(lables(i,1)==6) lables(i,1)=4; end
        if(lables(i,1)==7) lables(i,1)=5; end
        
    end
end

i=0;

X=lables(:,2);
Y=lables(:,1);
X=X'; Y=Y';
Y=Y*(-1);

x = reshape( [X;X], 2,[] ); x(2) = [];
y = reshape( [Y;Y], 2,[] ); y(end) = [];

vnan = NaN(size(X)) ;
xp = reshape([X;vnan;X],1,[]); xp([1:2 end]) = [] ;
yp = reshape([Y;Y;vnan],1,[]); yp(end-2:end) = [] ;

xv = reshape([X;X;vnan],1,[]); xv([1:3 end]) = [] ;
yv = reshape([Y;vnan;Y],1,[]); yv([1:2 end-1:end]) = [] ;

[uy,~,colidx] = unique(Y) ;
ncolor = length(uy) ;
colormap(cool(ncolor))

cd = reshape([colidx.';colidx.';vnan],1,[]); cd(end-2:end) = [] ;
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',2) ;
hold on
hv = plot(xv,yv,':k') ;

xlim([0 lim]);
ylim([-6 0]);

xticks;
grid on;





% UIWAIT makes HYPNO_APP_DELTA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HYPNO_APP_DELTA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
