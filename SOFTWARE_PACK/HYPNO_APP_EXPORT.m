function varargout = HYPNO_APP_EXPORT(varargin)
% HYPNO_APP_EXPORT MATLAB code for HYPNO_APP_EXPORT.fig
%      HYPNO_APP_EXPORT, by itself, creates a new HYPNO_APP_EXPORT or raises the existing
%      singleton*.
%
%      H = HYPNO_APP_EXPORT returns the handle to a new HYPNO_APP_EXPORT or the handle to
%      the existing singleton*.
%
%      HYPNO_APP_EXPORT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HYPNO_APP_EXPORT.M with the given input arguments.
%
%      HYPNO_APP_EXPORT('Property','Value',...) creates a new HYPNO_APP_EXPORT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HYPNO_APP_EXPORT_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HYPNO_APP_EXPORT_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HYPNO_APP_EXPORT

% Last Modified by GUIDE v2.5 09-Jan-2018 09:37:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HYPNO_APP_EXPORT_OpeningFcn, ...
                   'gui_OutputFcn',  @HYPNO_APP_EXPORT_OutputFcn, ...
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

%uiwait;


% --- Executes just before HYPNO_APP_EXPORT is made visible.
function HYPNO_APP_EXPORT_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HYPNO_APP_EXPORT (see VARARGIN)

% Choose default command line output for HYPNO_APP_EXPORT
handles.output = hObject;




% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HYPNO_APP_EXPORT wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HYPNO_APP_EXPORT_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
HYPNO_APP



function edit1_Callback(hObject, eventdata, handles)

input=str2num(get(hObject,'String'));


%-----------------------------------controllo per numero inserito
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);


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


input=str2num(get(hObject,'String'));

%-----------------------------------controllo per numero inserito
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);



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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

axes(handles.axes1);
cla;

ECG=getappdata(0,'ECG_EXPORT');

start=get(handles.edit1,'String');
stop=get(handles.edit2,'String');
start=str2num(start);
stop=str2num(stop);

start=start*(10e5);
stop=stop*(10e5);


ECG_exp=ECG(start:stop);

axes(handles.axes1);
plot(ECG_exp,'color','b');
lim=length(ECG_exp);
xlim([0 lim]);
set(gca,'Color',[1 1 1]);
set(gca,'ytick',[]);
set(gca,'xtick',[]);
grid on;


%----------------------RESP

axes(handles.axes2);
cla;

RESP=getappdata(0,'RESP_EXPORT');
RESP_exp=RESP(start:stop);

plot(RESP_exp,'color','b');

lim2=length(RESP_exp);
xlim([0 lim2]);
set(gca,'Color',[1 1 1])
set(gca,'ytick',[]);
set(gca,'xtick',[]);
grid on;




%----------------------IPNOGRAMMA

axes(handles.axes3);
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
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',5) ;
hold on
hv = plot(xv,yv,'k') ;

ylim([-6 0]);
xlim([start stop]);
set(gca,'Color',[1 1 1])
grid on;


%-----------------------------plotta eventi
evex=getappdata(0,'evex');
leo=length(evex);
axes(handles.axes3);
hold on;

for(i=1:leo)
    
axes(handles.axes3);
hold on;   

inizio=evex(i,1);
fine=evex(i,2);


plot([inizio inizio],[-10 2],'--g','linewidth',2);
plot([fine fine],[-10 2],'--g','linewidth',2);
hold on;

end

%--------------------visulizza durata finestra

tempo=length(ECG_exp);
tempo=tempo/250;
tempo=datestr(seconds(tempo),'HH:MM:SS');

set(handles.edit4,'String',tempo);


%--------------------DEFINE VARIABLE TO EXPORT


fs_ecg=250;  % definisco manualmente la frequenza 
sig_ECG=ECG_exp;
sig_respiro=RESP_exp;

le=length(ECG_exp);
le1=le/250;
asd=4.8828e-4; %prima era 1
tempo_auto=linspace(asd,le1,le);
tempo_auto=tempo_auto';



handles.sig_ECG=sig_ECG;
handles.sig_respiro=sig_respiro;
handles.fs_ecg=fs_ecg;
handles.tempo_auto=tempo_auto;


handles.evex=evex;


guidata(hObject,handles);



% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3._______---------------MOSTRA
function pushbutton3_Callback(hObject, eventdata, handles)

sig_ECG=handles.sig_ECG;
sig_respiro=handles.sig_respiro;
fs_ecg=handles.fs_ecg;
tempo_auto=handles.tempo_auto;
%evex=handles.evex;

[file,path]=uiputfile('*.mat','Export');

if (file==0)
    return;
end
        
file=fullfile(path,file);
save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');







% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
