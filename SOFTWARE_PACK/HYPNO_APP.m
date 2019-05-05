function varargout = HYPNO_APP(varargin)
% HYPNO_APP MATLAB code for HYPNO_APP.fig
%      HYPNO_APP, by itself, creates a new HYPNO_APP or raises the existing
%      singleton*.
%
%      H = HYPNO_APP returns the handle to a new HYPNO_APP or the handle to
%      the existing singleton*.
%
%      HYPNO_APP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HYPNO_APP.M with the given input arguments.
%
%      HYPNO_APP('Property','Value',...) creates a new HYPNO_APP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before HYPNO_APP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to HYPNO_APP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help HYPNO_APP

% Last Modified by GUIDE v2.5 05-May-2018 18:24:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @HYPNO_APP_OpeningFcn, ...
                   'gui_OutputFcn',  @HYPNO_APP_OutputFcn, ...
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







% --- Executes just before HYPNO_APP is made visible.
function HYPNO_APP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to HYPNO_APP (see VARARGIN)

% Choose default command line output for HYPNO_APP
handles.output = hObject;



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes HYPNO_APP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = HYPNO_APP_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- BROWSE FOLDER
function pushbutton1_Callback(hObject, eventdata, handles)


axes(handles.axes1); cla;
axes(handles.axes3); cla;
axes(handles.axes4); cla;


dir=uigetdir;

set(handles.text2,'String',dir);

ECG=fullfile(dir,'ECG.mat');
RESP=fullfile(dir,'RESP.mat');
sleep=fullfile(dir,'events.mat');
events=fullfile(dir,'events.txt');

handles.ECG=ECG;
handles.RESP=RESP;
handles.sleep=sleep;
handles.events=events;

set(handles.edit2,'String','Press Load to starts');

guidata(hObject,handles);



% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% -------------- LOAD
function pushbutton2_Callback(hObject, eventdata, handles)

ECG=handles.ECG;
load(ECG);
lim=length(ECG);

% load and plot hypnogram
set(handles.edit2,'String','Loading...');
set(handles.edit2,'BackgroundColor','red');

axes(handles.axes1);
sleep=handles.sleep;

load(sleep);
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

xlim([0 lim]);
ylim([-6 0]);
set(gca,'Color',[1 1 1]);

xticks;

grid on;

setappdata(0,'SLEEP_EXPORT',sleep);



%---------------------------plot ECG

axes(handles.axes3);
%quello sopra dovrebbe essere qui

plot(ECG,'color','b');
xlim([0 lim]);
set(gca,'Color',[1 1 1]);
set(gca,'ytick',[]);
grid on;

setappdata(0,'ECG_EXPORT',ECG);


%---------------------------plot RESP

axes(handles.axes4);
RESP=handles.RESP;

load(RESP);

plot(RESP,'color','b');
xlim([0 lim]);

set(gca,'Color',[1 1 1]);
set(gca,'ytick',[]);
grid on;

setappdata(0,'RESP_EXPORT',RESP);


set(handles.edit2,'String','Load complete');
set(handles.edit2,'BackgroundColor',[0.3 0.75 0.93]);


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% -------------LOAD EVENTS
% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)

%-----------------------------loads events
events=handles.events;
events=fopen(events);

[data]= textscan(events, '%s %s');
le=length(data{1,1});

lex=le-1;
evex=zeros(lex,2);

for(i=2:le)

T1=data{1,1}(1,1);
T2=data{1,1}(i,1);
T3=data{1,2}(1,1);
T4=data{1,2}(i,1);
TC=clock;

T1=cell2mat(T1);
T2=cell2mat(T2);
T3=cell2mat(T3);
T4=cell2mat(T4);

str1=[num2str(TC(1:3)),' ',T1];
str2=[num2str(TC(1:3)),' ',T2];
str3=[num2str(TC(1:3)),' ',T3];
str4=[num2str(TC(1:3)),' ',T4];

t1=datevec(str1,'yyyy mm dd HH:MM:SS');
t2=datevec(str2,'yyyy mm dd HH:MM:SS');
t3=datevec(str3,'yyyy mm dd HH:MM:SS');
t4=datevec(str4,'yyyy mm dd HH:MM:SS');


inizio=etime(t1,t2);

if(inizio>0)
    inizio=(24*60*60)-inizio;
    inizio=inizio*250;

    fine=etime(t3,t4);
    fine=(24*60*60)-fine;
    fine=fine*250;
else
    inizio=etime(t2,t1);
    inizio=inizio*250;
    
    fine=etime(t4,t3);
    fine=fine*250;
end



%-----------------------------plots events
axes(handles.axes1);
hold on;
plot([inizio inizio],[-10 2],'--g','linewidth',2);
plot([fine fine],[-10 2],'--g','linewidth',2);

axes(handles.axes3);
hold on;
plot([inizio inizio],[-4000 4000],'--g','linewidth',2);
plot([fine fine],[-4000 4000],'--g','linewidth',2);

axes(handles.axes4);
hold on;
plot([inizio inizio],[-4000 4000],'--g','linewidth',2);
plot([fine fine],[-4000 4000],'--g','linewidth',2);


evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end



setappdata(0,'evex',evex);




% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)

run(['HYPNO_APP_EXPORT.m']);

% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function text2_Callback(hObject, eventdata, handles)
% hObject    handle to text2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text2 as text
%        str2double(get(hObject,'String')) returns contents of text2 as a double



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


% --- Executes on button press in pushbutton15.-------- EXPORT ALL BUTTON
function pushbutton15_Callback(hObject, eventdata, handles)

path=uigetdir;

if (path==0)
    return;
end

h=waitbar(0,'Loading','Name','Export'); 
waitbar(1/2,h);

sleep=handles.sleep;
RESP=handles.RESP;
ECG=handles.ECG;

load(ECG);
load(RESP);
load(sleep);
l=length(lables);
w=1;
r=1;
s_1=1;
s_2=1;
s_3=1;
fs_ecg=250;

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


for(i=1:l-1)  
    
    state=lables(i,1);
    start=lables(i,2);
    stop=lables(i+1,2);
    
    if((stop-start)>=75000)
   
        if(state==1) %WAKE
        
            sig_ECG=ECG(start:stop,1);
            sig_respiro=RESP(start:stop,1);
        
            le=length(sig_ECG);
            le1=le/250;
            asd=4.8828e-4; %prima era 1
            tempo_auto=linspace(asd,le1,le);
            tempo_auto=tempo_auto';
        
            file_name=sprintf('WAKE_%d',w);
            file=fullfile(path,file_name);
        
            save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
            w=w+1;      
        end
    
        if(state==2) %REM
        
              
            sig_ECG=ECG(start:stop,1);
            sig_respiro=RESP(start:stop,1);
        
            le=length(sig_ECG);
            le1=le/250;
            asd=4.8828e-4; %prima era 1
            tempo_auto=linspace(asd,le1,le);
            tempo_auto=tempo_auto';
        
            file_name=sprintf('REM_%d',r);
            file=fullfile(path,file_name);
        
            save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
            r=r+1;      
        end    
    
        if(state==3) %S1
            
        
            sig_ECG=ECG(start:stop,1);
            sig_respiro=RESP(start:stop,1);
        
            le=length(sig_ECG);
            le1=le/250;
            asd=4.8828e-4; %prima era 1
            tempo_auto=linspace(asd,le1,le);;
            tempo_auto=tempo_auto';
        
            file_name=sprintf('S1_%d',s_1);
            file=fullfile(path,file_name);
        
            save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
            s_1=s_1+1;      
        end
    
        if(state==4) %S2
          
        
            sig_ECG=ECG(start:stop,1);
            sig_respiro=RESP(start:stop,1);
        
            le=length(sig_ECG);
            le1=le/250;
            asd=4.8828e-4; %prima era 1
            tempo_auto=linspace(asd,le1,le);
            tempo_auto=tempo_auto';
        
            file_name=sprintf('S2_%d',s_2);
            file=fullfile(path,file_name);
        
            save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
            s_2=s_2+1;      
        end
    
        if(state==5) %S3
           
        
            sig_ECG=ECG(start:stop,1);
            sig_respiro=RESP(start:stop,1);
        
            le=length(sig_ECG);
            le1=le/250;
            asd=4.8828e-4; %prima era 1
            tempo_auto=linspace(asd,le1,le);
            tempo_auto=tempo_auto';
        
            file_name=sprintf('S3_%d',s_3);
            file=fullfile(path,file_name);
        
            save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
            s_3=s_3+1;      
        end
    end
       
end

w=w-1;
r=r-1;
s_1=s_1-1;
s_2=s_2-1;
s_3=s_3-1;

waitbar(2/2,h);
close(h);

% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton16.-------DELTA ANALYSIS
function pushbutton16_Callback(hObject, eventdata, handles)

run(['HYPNO_APP_DELTA.m']);

% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when figure1 is resized.
function figure1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
