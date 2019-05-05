function varargout = DELTA_ANALYSIS_DERIVATE(varargin)
% DELTA_ANALYSIS_DERIVATE MATLAB code for DELTA_ANALYSIS_DERIVATE.fig
%      DELTA_ANALYSIS_DERIVATE, by itself, creates a new DELTA_ANALYSIS_DERIVATE or raises the existing
%      singleton*.
%
%      H = DELTA_ANALYSIS_DERIVATE returns the handle to a new DELTA_ANALYSIS_DERIVATE or the handle to
%      the existing singleton*.
%
%      DELTA_ANALYSIS_DERIVATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_ANALYSIS_DERIVATE.M with the given input arguments.
%
%      DELTA_ANALYSIS_DERIVATE('Property','Value',...) creates a new DELTA_ANALYSIS_DERIVATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_ANALYSIS_DERIVATE_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_ANALYSIS_DERIVATE_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_ANALYSIS_DERIVATE

% Last Modified by GUIDE v2.5 11-May-2018 16:40:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_ANALYSIS_DERIVATE_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_ANALYSIS_DERIVATE_OutputFcn, ...
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


% --- Executes just before DELTA_ANALYSIS_DERIVATE is made visible.
function DELTA_ANALYSIS_DERIVATE_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_ANALYSIS_DERIVATE (see VARARGIN)

% Choose default command line output for DELTA_ANALYSIS_DERIVATE
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global popVal;
global main_path;
%global D_START;
%global D_END;
global delta_lim;
global times_r;
global tacogramma_shift;
global LFHF_n;
global export_start;
global export_stop;
global Delta_n;
global start_event;
global val_EVENT;

val_EVENT=0;
popVal=0;

start=(export_start*10e05)/250;
stop=(export_stop*10e05)/250;



%GRAFICO 1: HYPNOGRAMMA TOT
axes(handles.axes3);
PSG=fullfile(main_path,'events.mat');
load(PSG);
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
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',4) ;
hold on
hv = plot(xv,yv,':k') ;
xlim([0 delta_lim]);
ylim([-6 0]);
set(gca,'xtick',[]);
grid on;

ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);
[data]= textscan(EVENT, '%s %s');
lee=length(data{1,1});

lex=lee-1;
evex=zeros(lex,2);

for(i=2:lee)

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

if(i==2)
    %inizio
    start_event=inizio;
end


axes(handles.axes3);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end



%GRAFICO 2: cose normalizzate
axes(handles.axes4);
plot(times_r,Delta_n,'color',[1 0 1],'linewidth',2); grid on; hold on;
plot(tacogramma_shift(:,1),LFHF_n,'color',[0 1 1],'linewidth',2); grid on;
ylim([-0.7 1.7]);
xlim([0 delta_lim/250]);


%GRAFICO 3: HYPNO ZOOM
axes(handles.axes1);
hp = patch(xp,yp,cd,'EdgeColor','flat','LineWidth',4) ;
hold on
hv = plot(xv,yv,':k') ;
xlim([start*250 stop*250]);
ylim([-6 0]);
set(gca,'xtick',[]);
grid on;

ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);

[data]= textscan(EVENT, '%s %s');
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
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

inizio=inizio/250;
fine=fine/250;

%eventi per cose normalizzate
axes(handles.axes4);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end


%GRAFICO 4:
axes(handles.axes2);
plot(times_r,Delta_n,'color',[1 0 1],'linewidth',2); grid on; hold on;
plot(tacogramma_shift(:,1),LFHF_n,'color',[0 1 1],'linewidth',2); grid on;
ylim([-0.2 1.2]);
xlim([start stop]);

ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);

[data]= textscan(EVENT, '%s %s');
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

inizio=inizio/250;
fine=fine/250;

axes(handles.axes2);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end





% UIWAIT makes DELTA_ANALYSIS_DERIVATE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_ANALYSIS_DERIVATE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Calculate derivate
function pushbutton3_Callback(hObject, eventdata, handles)

global popVal;
global times_r;
global Delta_n;
global tacogramma_shift;
global LFHF_n;
global export_start;
global export_stop;
global main_path;
global start_event;
global val_EVENT;


if(popVal==1) %start popVal=1

start=(export_start*10e05)/250;
stop=(export_stop*10e05)/250;

axes(handles.axes2);cla;
plot(times_r,Delta_n,'color',[1 0 1],'linewidth',2); grid on; hold on;
plot(tacogramma_shift(:,1),LFHF_n,'color',[0 1 1],'linewidth',2); grid on;
ylim([-0.2 1.2]);
xlim([start stop]);


start=str2num(char(get(handles.edit3,'String')));
stop=str2num(char(get(handles.edit4,'String')));

len1 = length(times_r);
k1 = 0;
Delta_2 = zeros(stop - start,1);

%% delta
for i=1 : len1
    if (times_r(i)>=start && k1==0)
        start_D = i;
        k1 = 1;
    end
    if (times_r(i) > stop)
        stop_D = i;
        break;
    end
end


[y_maxD,x_maxD] = max(Delta_n(start_D:stop_D));
[y_minD,x_minD] = min(Delta_n(start_D:stop_D));
x_timesmaxD = times_r(x_maxD + start_D);
x_timesminD = times_r(x_minD + start_D);

Deriv_D = (y_maxD - y_minD) / ((x_timesmaxD - x_timesminD)/10000);

%% lfhf
len2 = length(tacogramma_shift);
k2 = 0;

for i=1 : len2
    if (tacogramma_shift(i)>=start && k2==0)
        start_L = i;
        k2 = 1;
    end
    
    if (tacogramma_shift(i) > stop)
        
        stop_L = i;
        
        break;
    end
end

[y_maxL,x_maxL] = max(LFHF_n(start_L:stop_L));
[y_minL,x_minL] = min(LFHF_n(start_L:stop_L));
x_timesmaxL = tacogramma_shift(x_maxL + start_L);
x_timesminL = tacogramma_shift(x_minL + start_L);

Deriv_L = (y_maxL - y_minL) / ((x_timesmaxL - x_timesminL)/10000);
rapporto_der = Deriv_D / Deriv_L;
%% punto intersezione
[x_int,y_int] = intersections(times_r(start_D:stop_D),Delta_n(start_D:stop_D),tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L),1);
k3=0;
for i=start_D : stop_D
    
    if (times_r(i)>=x_int)
        start_int_D = i;
        break;
    end
end

for i=start_L : stop_L
    
    if (tacogramma_shift(i)>= x_int)
        start_int_L = i;
        break;
    end
end
[y_maxiD,x_maxiD] = max(Delta_n(start_int_D:stop_D));
x_timesmaxiD = times_r(x_maxiD + start_int_D);

Deriv_int_D = (y_maxiD - y_int) / ((x_timesmaxiD - x_int)/10000); %moltiplicato per diecimila per una migliore visualizzazione

[y_miniL,x_miniL] = min(LFHF_n(start_int_L:stop_L));
x_timesminiL = tacogramma_shift(x_miniL + start_int_L);

Deriv_int_L = (y_int - y_miniL) / ((x_int - x_timesminiL)/10000); %moltiplicato per diecimila per una migliore visualizzazione
rapporto_der_int = Deriv_int_D / Deriv_int_L;
Diff_fase = x_timesmaxD - x_timesminL; 

if(Diff_fase<0) val_shift=1; txt_shift='Delta'; end
if(Diff_fase>0) val_shift=0; txt_shift='Lf/Hf'; end

axes(handles.axes2)
plot(tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L),'color',[0 1 1],'linewidth',1);
hold on; 
plot(times_r(start_D:stop_D),Delta_n(start_D:stop_D),'color',[1 0 1],'linewidth',1);
grid on; hold on;

%plot([x_timesmaxL x_timesminL], [y_maxL y_minL],'linewidth',2,'color','k','linestyle','--');
%plot([x_timesminD x_timesmaxD], [y_minD y_maxD],'linewidth',2,'color','k','linestyle','--');
plot([x_int x_timesminiL], [y_int y_miniL],'linewidth',1,'color','k','linestyle','--');
plot([x_int x_timesmaxiD], [y_int y_maxiD],'linewidth',1,'color','k','linestyle','--');
plot(x_int,y_int,'*r','linewidth',2);
plot(x_timesmaxiD,y_maxiD,'r*','linewidth',2);
plot(x_timesminiL,y_miniL,'r*','linewidth',2);
hold on;


ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);

[data]= textscan(EVENT, '%s %s');
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

inizio=inizio/250;
fine=fine/250;

axes(handles.axes2);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end

%metodo1 minmax
%handles.uitable1.Data{1,1} = abs(Deriv_D);
%handles.uitable1.Data{1,2} = abs(Deriv_L);
%handles.uitable1.Data{1,3} = abs(Deriv_D/Deriv_L);
%metodo2 inter
handles.uitable1.Data{1,1} = abs(Deriv_int_D);
handles.uitable1.Data{1,2} = abs(Deriv_int_L);
handles.uitable1.Data{1,3} = abs(Deriv_int_D/Deriv_int_L);

set(handles.edit1,'String',txt_shift);





elseif (popVal==3) %popVal=======3 distanza eventi
    
        
if(val_EVENT)
ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))
    
start=(export_start*10e05)/250;
stop=(export_stop*10e05)/250;

axes(handles.axes2);cla;
plot(times_r,Delta_n,'color',[1 0 1],'linewidth',2); grid on; hold on;
plot(tacogramma_shift(:,1),LFHF_n,'color',[0 1 1],'linewidth',2); grid on;
ylim([-0.2 1.2]);
xlim([start stop]);


start=str2num(char(get(handles.edit3,'String')));
stop=str2num(char(get(handles.edit4,'String')));



len1 = length(times_r);
k1 = 0;
Delta_2 = zeros(stop - start,1);

for i=1 : len1
    if (times_r(i)>=start && k1==0)
        start_D = i;
        k1 = 1;
    end
    if (times_r(i) > stop)
        stop_D = i;
        break;
    end
end
 
len2 = length(tacogramma_shift);
k2 = 0;

for i=1 : len2
    if (tacogramma_shift(i)>=start && k2==0)
        start_L = i;
        k2 = 1;
    end
    
    if (tacogramma_shift(i) > stop)
        
        stop_L = i;
        
        break;
    end
end

x_event=start_event;
x_event=x_event/250;
[y_maxD,x_maxD] = max(Delta_n(start_D:stop_D));
x_maxD = times_r(x_maxD + start_D);

[y_minL,x_minL] = min(LFHF_n(start_L:stop_L));
x_minL = tacogramma_shift(x_minL + start_L);

axes(handles.axes2)
%plot(tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L),'color',[0 0.45 0.74],'linewidth',1);
hold on; 
%plot(times_r(start_D:stop_D),Delta_n(start_D:stop_D),'color',[1 0 1],'linewidth',1);
grid on; hold on;
plot(x_maxD,y_maxD,'*r','linewidth',1)
plot(x_event,y_maxD,'*r','linewidth',1);
plot(x_minL,y_minL,'*r','linewidth',1);
plot(x_event,y_minL,'*r','linewidth',1);
plot([x_maxD x_event],[y_maxD y_maxD,],'color','k','linewidth',1,'linestyle','--');
plot([x_minL x_event],[y_minL y_minL],'color','k','linewidth',1,'linestyle','--');

ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);

[data]= textscan(EVENT, '%s %s');
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

%----plots events
inizio=inizio/250;
fine=fine/250;

axes(handles.axes2);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end

dist_D=x_event-x_maxD; %in seconds
dist_L=x_event-x_minL; %in seconds
handles.uitable4.Data{1,1} = dist_D;
handles.uitable4.Data{1,2} = dist_L;
handles.uitable4.Data{1,3} = dist_D/dist_L;

else 
    run(['DELTA_ANALYSIS_ERROR_3.m']);
end

else %senza eventi (controlli)
start=(export_start*10e05)/250;
stop=(export_stop*10e05)/250;

axes(handles.axes2);cla;
plot(times_r,Delta_n,'color',[1 0 1],'linewidth',2); grid on; hold on;
plot(tacogramma_shift(:,1),LFHF_n,'color',[0 1 1],'linewidth',2); grid on;
ylim([-0.2 1.2]);
xlim([start stop]);

start=str2num(char(get(handles.edit3,'String')));
stop=str2num(char(get(handles.edit4,'String')));

len1 = length(times_r);
k1 = 0;
Delta_2 = zeros(stop - start,1);

%% delta
for i=1 : len1
    if (times_r(i)>=start && k1==0)
        start_D = i;
        k1 = 1;
    end
    if (times_r(i) > stop)
        stop_D = i;
        break;
    end
end

[y_maxD,x_maxD] = max(Delta_n(start_D:stop_D));
[y_minD,x_minD] = min(Delta_n(start_D:stop_D));
x_timesmaxD = times_r(x_maxD + start_D);
x_timesminD = times_r(x_minD + start_D);
Deriv_D = (y_maxD - y_minD) / ((x_timesmaxD - x_timesminD)/10000);
%% lfhf
len2 = length(tacogramma_shift);
k2 = 0;

for i=1 : len2
    if (tacogramma_shift(i)>=start && k2==0)
        start_L = i;
        k2 = 1;
    end
    
    if (tacogramma_shift(i) > stop)
        
        stop_L = i;
        
        break;
    end
end

[y_maxL,x_maxL] = max(LFHF_n(start_L:stop_L));
[y_minL,x_minL] = min(LFHF_n(start_L:stop_L));
x_timesmaxL = tacogramma_shift(x_maxL + start_L);
x_timesminL = tacogramma_shift(x_minL + start_L);
Deriv_L = (y_maxL - y_minL) / ((x_timesmaxL - x_timesminL)/10000);
rapporto_der = Deriv_D / Deriv_L;   

axes(handles.axes2);
plot(x_timesmaxD,y_maxD,'*r');
plot(x_timesminL,y_minL,'*r');
plot(x_timesminD,y_maxD,'*r');
plot(x_timesmaxL,y_minL,'*r');
plot([x_timesmaxD x_timesminD],[y_maxD y_maxD],'color','k','linestyle','--','linewidth',1);
plot([x_timesminL x_timesmaxL],[y_minL y_minL],'color','k','linestyle','--','linewidth',1);

dist_D=x_timesminD-x_timesmaxD;
dist_L=x_timesmaxL-x_timesminL;

handles.uitable4.Data{1,1}=dist_D;
handles.uitable4.Data{1,2}=dist_L;
handles.uitable4.Data{1,3}=abs(dist_D/dist_L);
end
    
    

elseif(popVal==2) %%slope doWN

%caso in cui sia un patologico con un evento    
if(val_EVENT)
start=(export_start*10e05)/250;
stop=(export_stop*10e05)/250;

axes(handles.axes2);cla;
plot(times_r,Delta_n,'color',[1 0 1],'linewidth',2); grid on; hold on;
plot(tacogramma_shift(:,1),LFHF_n,'color',[0 1 1],'linewidth',2); grid on;
ylim([-0.2 1.2]);
xlim([start stop]);

start=str2num(char(get(handles.edit3,'String')));
stop=str2num(char(get(handles.edit4,'String')));

len1 = length(times_r);
k1 = 0;
Delta_2 = zeros(stop - start,1);

for i=1 : len1
    if (times_r(i)>=start && k1==0)
        start_D = i;
        k1 = 1;
    end
    if (times_r(i) > stop)
        stop_D = i;
        break;
    end
end
 
len2 = length(tacogramma_shift);
k2 = 0;

for i=1 : len2
    if (tacogramma_shift(i)>=start && k2==0)
        start_L = i;
        k2 = 1;
    end
    
    if (tacogramma_shift(i) > stop)
        
        stop_L = i;
        
        break;
    end
end

x_event=start_event;
x_event=x_event/250;
[y_maxD,x_maxD] = max(Delta_n(start_D:stop_D));
x_maxD = times_r(x_maxD + start_D);

[y_minL,x_minL] = min(LFHF_n(start_L:stop_L));
x_minL = tacogramma_shift(x_minL + start_L);   

%per y evento
for(i=1:length(times_r))
    if(times_r(i)>=x_event)
        y_eventD=Delta_n(i);
        break
    end
end

for(i=1:length(tacogramma_shift))
    if(tacogramma_shift(i)>=x_event)
        y_eventL=LFHF_n(i);
        break
    end
end

plot([x_maxD x_event], [y_maxD y_eventD],'linewidth',1,'color','k','linestyle','--');
plot([x_minL x_event], [y_minL y_eventL],'linewidth',1,'color','k','linestyle','--');
plot([x_maxD x_event], [y_maxD y_eventD],'*r');
plot([x_minL x_event], [y_minL y_eventL],'*r');

ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);

[data]= textscan(EVENT, '%s %s');
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

%----plots events
inizio=inizio/250;
fine=fine/250;

axes(handles.axes2);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end

deriv_D = (y_maxD-y_eventD)/((x_maxD-x_event)/10000);
deriv_L = (y_eventL-y_minL)/((x_event-x_minL)/10000);

handles.uitable5.Data{1,1}=abs(deriv_D);
handles.uitable5.Data{1,2}=abs(deriv_L);
handles.uitable5.Data{1,3}=abs(deriv_D/deriv_L);





else %caso slope down   SENZA EVENTI
    
start=(export_start*10e05)/250;
stop=(export_stop*10e05)/250;

axes(handles.axes2);cla;
plot(times_r,Delta_n,'color',[1 0 1],'linewidth',2); grid on; hold on;
plot(tacogramma_shift(:,1),LFHF_n,'color',[0 1 1],'linewidth',2); grid on;
ylim([-0.2 1.2]);
xlim([start stop]);

start=str2num(char(get(handles.edit3,'String')));
stop=str2num(char(get(handles.edit4,'String')));

len1 = length(times_r);
k1 = 0;
Delta_2 = zeros(stop - start,1);

%% delta
for i=1 : len1
    if (times_r(i)>=start && k1==0)
        start_D = i;
        k1 = 1;
    end
    if (times_r(i) > stop)
        stop_D = i;
        break;
    end
end

[y_maxD,x_maxD] = max(Delta_n(start_D:stop_D));
%[y_minD,x_minD] = min(Delta_n(start_D:stop_D));
x_timesmaxD = times_r(x_maxD + start_D);
%x_timesminD = times_r(x_minD + start_D);
%Deriv_D = (y_maxD - y_minD) / ((x_timesmaxD - x_timesminD)/10000);

%% lfhf
len2 = length(tacogramma_shift);
k2 = 0;

for i=1 : len2
    if (tacogramma_shift(i)>=start && k2==0)
        start_L = i;
        k2 = 1;
    end
    
    if (tacogramma_shift(i) > stop)
        
        stop_L = i;
        
        break;
    end
end

%[y_maxL,x_maxL] = max(LFHF_n(start_L:stop_L));
[y_minL,x_minL] = min(LFHF_n(start_L:stop_L));
%x_timesmaxL = tacogramma_shift(x_maxL + start_L);
x_timesminL = tacogramma_shift(x_minL + start_L);
%Deriv_L = (y_maxL - y_minL) / ((x_timesmaxL - x_timesminL)/10000);
%rapporto_der = Deriv_D / Deriv_L;

%% punto intersezione
[x_int,y_int] = intersections(times_r(start_D:stop_D),Delta_n(start_D:stop_D),tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L),1);
k3=0;
for i=start_D : stop_D
    
    if (times_r(i)>=x_int)
        start_int_D = i;
        break;
    end
end

for i=start_L : stop_L
    
    if (tacogramma_shift(i)>= x_int)
        start_int_L = i;
        break;
    end
end

[y_maxiD,x_maxiD] = max(Delta_n(start_int_D:stop_D));
x_timesmaxiD = times_r(x_maxiD + start_int_D);
Deriv_int_D = (y_maxiD - y_int) / ((x_timesmaxiD - x_int)/10000); %moltiplicato per diecimila per una migliore visualizzazione

[y_miniL,x_miniL] = min(LFHF_n(start_int_L:stop_L));
x_timesminiL = tacogramma_shift(x_miniL + start_int_L);

Deriv_int_L = (y_int - y_miniL) / ((x_int - x_timesminiL)/10000); %moltiplicato per diecimila per una migliore visualizzazione
rapporto_der_int = Deriv_int_D / Deriv_int_L;
Diff_fase = x_timesmaxD - x_timesminL; 

if(Diff_fase<0) val_shift=1; txt_shift='Delta'; end
if(Diff_fase>0) val_shift=0; txt_shift='Lf/Hf'; end

axes(handles.axes2)
plot(tacogramma_shift(start_L:stop_L),LFHF_n(start_L:stop_L),'color',[0 1 1],'linewidth',1);
hold on; 
plot(times_r(start_D:stop_D),Delta_n(start_D:stop_D),'color',[1 0 1],'linewidth',1);
grid on; hold on;

plot(x_timesmaxD,y_maxD,'*r');
plot(x_int,y_int,'*r');
plot(x_timesminL,y_minL,'*r');
plot([x_timesmaxD x_int], [y_maxD y_int],'color','k','linewidth',1,'linestyle','--');
plot([x_timesminL x_int], [y_minL y_int],'color','k','linewidth',1,'linestyle','--');
hold on;


deriv_L = (y_int - y_minL)/((x_int - x_timesminL)/10000);
deriv_D = (y_maxD - y_int)/((x_timesmaxD - x_int)/10000);

%metodo2 inter
handles.uitable5.Data{1,1} = abs(deriv_D);
handles.uitable5.Data{1,2} = abs(deriv_L);
handles.uitable5.Data{1,3} = abs(deriv_D/deriv_L);  


ck_events=fullfile(main_path,'events.txt');
if(exist(ck_events,'file'))

EVENT=fullfile(main_path,'events.txt');
EVENT=fopen(EVENT);

[data]= textscan(EVENT, '%s %s');
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
inizio=inizio/250;
fine=fine/250;

axes(handles.axes2);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end

end
    
    

elseif (popVal==0)%end popVal==========0
    
    run(['DELTA_ANALYSIS_ERROR_2.m']);
    
end

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)

global popVal;

contents = cellstr(get(hObject,'String'));
popChoice = contents(get(hObject,'Value'));

if (strcmp(popChoice,'Up slope'))
    popVal=1;
elseif (strcmp(popChoice,'Down slope'))
    popVal=2;
elseif (strcmp(popChoice,'Event prev time'))
    popVal=3;
end
%assignin('base','popVal',popVal);




% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)

global val_EVENT;
val_EVENT=get(handles.radiobutton1,'value');

% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
