function varargout = DELTA_ANALYSIS_PPP(varargin)
% DELTA_ANALYSIS_PPP MATLAB code for DELTA_ANALYSIS_PPP.fig
%      DELTA_ANALYSIS_PPP, by itself, creates a new DELTA_ANALYSIS_PPP or raises the existing
%      singleton*.
%
%      H = DELTA_ANALYSIS_PPP returns the handle to a new DELTA_ANALYSIS_PPP or the handle to
%      the existing singleton*.
%
%      DELTA_ANALYSIS_PPP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_ANALYSIS_PPP.M with the given input arguments.
%
%      DELTA_ANALYSIS_PPP('Property','Value',...) creates a new DELTA_ANALYSIS_PPP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_ANALYSIS_PPP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_ANALYSIS_PPP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_ANALYSIS_PPP

% Last Modified by GUIDE v2.5 09-May-2018 18:20:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_ANALYSIS_PPP_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_ANALYSIS_PPP_OutputFcn, ...
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


% --- Executes just before DELTA_ANALYSIS_PPP is made visible.
function DELTA_ANALYSIS_PPP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_ANALYSIS_PPP (see VARARGIN)

% Choose default command line output for DELTA_ANALYSIS_PPP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


global main_path; 
global CHN1;
global CHN2;
global EEG_load;
global Delta_n;
%global tacogramma_shift;
%global LFHF_n;
global times_r;
%global fs;
global Delta_s;

temp(:,1)=EEG_load(:,CHN1);
temp(:,2)=EEG_load(:,CHN2);
DATA_FDS=temp';


Chname{1}='canale_1';
Chname{2}='canale_2';


%% bipolari_sonno_delta

%CHbip sono i canali 'bipolari buoni per la registrazione del delta...se possibile da scalpo
[r,c]=size(DATA_FDS);
if r==4
%estrazione dei biploari
BIP=[];
BIP(1,:)=DATA_FDS(1,:)-DATA_FDS(2,:);
BIP(2,:)=DATA_FDS(3,:)-DATA_FDS(4,:);
CHbip{1}= strcat(Chname{1},'-',Chname{2}); 
CHbip{2}= strcat(Chname{3},'-',Chname{4});
% eegplot(BIP,'srate',250);%

elseif r==6
%estrazione dei biploari
BIP=[];
BIP(1,:)=DATA_FDS(1,:)-DATA_FDS(2,:);
BIP(2,:)=DATA_FDS(3,:)-DATA_FDS(4,:);
BIP(3,:)=DATA_FDS(5,:)-DATA_FDS(6,:);
CHbip{1}= strcat(Chname{1},'-',Chname{2});
CHbip{2}= strcat(Chname{3},'-',Chname{4});
CHbip{3}= strcat(Chname{5},'-',Chname{6});

elseif r==2
BIP=[];
BIP(1,:)=DATA_FDS(1,:)-DATA_FDS(2,:);
CHbip{1}= strcat(Chname{1},'-',Chname{2});
end

%  eegplot(BIP,'srate',250);%
%% % da codice ERD-ERS di Giulia filtraggio in banda
banda_filtro=[1 5];% delta 
fc=250;
mags=[0 1 0];
devs = [0.05 0.5 0.05];
fcuts=[banda_filtro(1)-.2 banda_filtro(1) banda_filtro(2) banda_filtro(2)+.2];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fc);
n = n + rem(n,2);
coef = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
for i=1:length(CHbip)
filt_a=filtfilt(coef,1,BIP(i,:)');
filt_A(i,:)=filt_a; 
end
% eegplot(filt_A,'srate',250);%
%% % quadratura del segnale per il calcolo della potenza in banda
for i=1:length(CHbip)
        DELTA(i,:)=filt_A(i,:).*filt_A(i,:);
end

fc=250;
filename =1;
crisi_sec=0;
Delta_con=[];
Crisi_con=[];
% filtro media mobile
nsec=10;
MM=ones(1,nsec*fc);
MM=MM/length(MM);
for file=1: length(filename)
    crisi_sec=0;
     %load(filename{file})
     DELTA_mm=[];
for i=1:length(CHbip)
DELTA_mm(i,:)=(filtfilt(MM,1,DELTA(i,:)'))';
end

Delta_con=[Delta_con DELTA_mm];
len_rec(file)=length(DELTA_mm);
if crisi_sec~=0
crisi_rec= crisi_sec+((sum(len_rec)/fc) - (len_rec(file)/fc));% in secondi dall'inizio della prima registrazione
Crisi_con=[Crisi_con crisi_rec];
end
%clear Delta_mm crisi_rec
end

times=[1/fc:1/fc:length(Delta_con(1,:))/fc];% in secondi

%% mia per stampare
%resample delta e smooth dell'andamento

global delta_lim;
global times_r;

delta_lim=length(Delta_con);

%GUI=fullfile(main_path,'Export_ECG_gui.mat');
%load(GUI);


[Delta_r,y1]=resample(Delta_con,linspace(1,length(Delta_con),length(Delta_con)),0.0004);
[times_r,y2]=resample(times,linspace(1,length(times),length(times)),0.0004);

Delta_s=smooth(Delta_r,0.05,'rloess');



%% ---------------------------------------------------GRAFICO 1: HYPNO
axes(handles.axes1);





PSG=fullfile(main_path,'export_hypno.mat');
load(PSG);
%slim=length(lables);
%i=1;
%omologa lables (format 1,2,3,4,5)
%while((lables(i,1)~=6) && (i~=slim))
%    i=i+1; 
%end
%
%if(lables(i,1)==6) 
%    for(i=1:slim)
%        if((lables(i,1)==3)||(lables(i,1)==4)) lables(i,1)=2; end
%        if(lables(i,1)==5) lables(i,1)=3; end
%        if(lables(i,1)==6) lables(i,1)=4; end
%        if(lables(i,1)==7) lables(i,1)=5; end
%        
%    end
%end

i=0;
X=linspace(1,length(HYPNO_PRINT),length(HYPNO_PRINT));
Y=HYPNO_PRINT';
%X=X'; Y=Y';
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
grid on;
%plot(times_r,hypno_deep);
xlim([0 length(HYPNO_PRINT)]);
ylim([-4 2]);

%set(gca,'xtick',[]);
grid on;

%ck_events=fullfile(main_path,'events.txt');
%if(exist(ck_events,'file'))

%EVENT=fullfile(main_path,'events.txt');
%EVENT=fopen(EVENT);
%[data]= textscan(EVENT, '%s %s');
%le=length(data{1,1});

%lex=le-1;
%evex=zeros(lex,2);

%for(i=2:le)

%T1=data{1,1}(1,1);
%T2=data{1,1}(i,1);
%T3=data{1,2}(1,1);
%T4=data{1,2}(i,1);
%TC=clock;

%T1=cell2mat(T1);
%T2=cell2mat(T2);
%T3=cell2mat(T3);
%T4=cell2mat(T4);

%str1=[num2str(TC(1:3)),' ',T1];
%str2=[num2str(TC(1:3)),' ',T2];
%str3=[num2str(TC(1:3)),' ',T3];
%str4=[num2str(TC(1:3)),' ',T4];

%t1=datevec(str1,'yyyy mm dd HH:MM:SS');
%t2=datevec(str2,'yyyy mm dd HH:MM:SS');
%t3=datevec(str3,'yyyy mm dd HH:MM:SS');
%t4=datevec(str4,'yyyy mm dd HH:MM:SS');


%inizio=etime(t1,t2);

%if(inizio>0)
%    inizio=(24*60*60)-inizio;
%    inizio=inizio*250;

%    fine=etime(t3,t4);
%    fine=(24*60*60)-fine;
%   fine=fine*250;
%else
%    inizio=etime(t2,t1);
%    inizio=inizio*250;
%    
%    fine=etime(t4,t3);
%    fine=fine*250;
%end

%-----------------------------plots events
%axes(handles.axes1);
%hold on;
%plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
%plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

%evex(i-1,1)=inizio;
%evex(i-1,2)=fine;

%end
%end

%%---------------------------------------------------GRAFICO 2: DELTA
axes(handles.axes2);
plot(times_r,Delta_r,'color',[0.8 0.8 0.8]);
hold on; plot(times_r,Delta_s,'color',[1 0 1],'linewidth',2); grid on;
%fs=length(Delta_r)/0.1;
xlim([0 delta_lim/250]);
ylim([0 max(Delta_s)]);

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




% UIWAIT makes DELTA_ANALYSIS_PPP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_ANALYSIS_PPP_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

global export_start
global export_stop
global Delta_s
global LFHF_s
global Delta_n
global LFHF_n

%start_n=((export_start*(10e05))/250)*0.1;
%stop_n=((export_stop*(10e05))/250)*0.1;

start_n=export_start*10e03*0.1;
stop_n=export_stop*10e03*0.1;



%% normalizzo delta e lf/hf
%coeff_n_delta = max(Delta_s(1:end/2,1)); 
coeff_n_delta = max(Delta_s(start_n:stop_n,1));             %1-end/2 %finestrone per normalizzareeeeee si può modificare ogni voltaclc
coeff_n_lfhf = max(LFHF_s(:,1));

Delta_n(:,1) = Delta_s(:,1) ./ abs(coeff_n_delta); 
LFHF_n(:,1) = LFHF_s(:,1) ./ abs(coeff_n_lfhf);

s1=Delta_n;
s2=LFHF_n;

scorr = xcorr(s1,s2);

run(['DELTA_ANALYSIS_DERIVATE.m']);

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

run(['DELTA_ANALYSIS_HYPNOEXPORT.m']);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



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


% --- Load LFHF
function pushbutton3_Callback(hObject, eventdata, handles)

global main_path;
%global fs;
global export_start;
global export_stop;
global LFHF_n;
global tacogramma_shift;
global delta_lim;
global LFHF_s;

ck_file=fullfile(main_path,'export_ECG_GUI.mat');

if(exist(ck_file,'file'));

h=waitbar(0,'Loading','Name','Export'); 
waitbar(1/2,h);

axes(handles.axes3); cla;
GUI=fullfile(main_path,'export_ECG_GUI.mat');
load(GUI);

export_start=export_start;
export_stop=export_stop;

a=export_start*10e03%10e5)/250;

%controllo vecchio messo nella gui per evitare gli zeri al denominatore
l=length(P_HF_NU_Taco);
P_HF_Taco_new = P_HF_Taco;
P_HF_NU_Taco_new = P_HF_NU_Taco;
PSD_parz_HF_new = PSD_parz_HF;
PSD_parz_HF_NU_new = PSD_parz_HF_NU;
P_Coer_new = P_Coer;

for i=1 : l

    if ((P_HF_Taco_new(i) == 0) && (i == 1))
        for k=2 : l
            if (P_HF_Taco_new(k)~=0)
                break;
            end
        end
        P_HF_Taco_new(i)=P_HF_Taco_new(k);
    elseif ((P_HF_Taco_new(i) == 0) && (i ~= 1))
        P_HF_Taco_new(i)=P_HF_Taco_new(i-1);
    end

    if ((P_HF_NU_Taco_new(i) == 0) && (i == 1))
        for k=2 : l
            if (P_HF_NU_Taco_new(k)~=0)
                break;
            end
        end
        P_HF_NU_Taco_new(i)=P_HF_NU_Taco_new(k);
    elseif ((P_HF_NU_Taco_new(i) == 0) && (i ~= 1))
        P_HF_NU_Taco_new(i)=P_HF_NU_Taco_new(i-1);
    end

    if ((PSD_parz_HF_new(i) == 0) && (i == 1))
        for k=2 : l
            if (PSD_parz_HF_new(k)~=0)
                break;
            end
        end
        PSD_parz_HF_new(i)=PSD_parz_HF_new(k);
    elseif ((PSD_parz_HF_new(i) == 0) && (i ~= 1))
        PSD_parz_HF_new(i)=PSD_parz_HF_new(i-1);
    end

    if ((PSD_parz_HF_NU_new(i) == 0) && (i == 1))
        for k=2 : l
            if (PSD_parz_HF_NU_new(k)~=0)
                break;
            end
        end
        PSD_parz_HF_NU_new(i)=PSD_parz_HF_NU_new(k);
    elseif ((PSD_parz_HF_NU_new(i) == 0) && (i ~= 1))
        PSD_parz_HF_NU_new(i)=PSD_parz_HF_NU_new(i-1);
    end

    if ((P_Coer_new(i) == 0) && (i == 0))
        for k=2 : l
            if (P_Coer_new(k)~=0)
                break;
            end
        end
        P_Coer_new(i)=P_Coer_new(k);
    elseif ((P_Coer_new(i) == 0) && (i ~= 0))
        P_Coer_new(i)=P_Coer_new(i-1);
    end
end

LFHF=P_LF_Taco(1:end,1)./P_HF_Taco_new(1:end,1);
%LFHF = LFHF(1:13096,1); %%%%%%
LFHF_s=smooth(LFHF,0.1,'rloess');
LFHF_s=smooth(LFHF_s,0.1,'rloess');
LFHF_s=smooth(LFHF_s,0.2,'rloess');
LFHF_s=smooth(LFHF_s,0.5,'rloess');


%%------------------------------------------GRAFICO 3: LFHF (SE PRESENTE)
axes(handles.axes3);

%% shiftare lf/hf
tacogramma_shift(:,1) = tacogramma(:,1) + a;
coeff_n_lfhf = max(LFHF_s(:,1));
LFHF_n(:,1) = LFHF_s(:,1) ./ coeff_n_lfhf;


plot(tacogramma_shift(:,1),LFHF,'color',[0.8 0.8 0.8]);
hold on; plot(tacogramma_shift(:,1),LFHF_s,'color',[0 1 1],'linewidth',2); grid on;

xlim([0 delta_lim/250]);
ylim([0 max(LFHF_s)]);




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

axes(handles.axes3);
hold on;
plot([inizio inizio],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);
plot([fine fine],[-10 2],'--','color',[0.64 0.08 0.18],'linewidth',1);

evex(i-1,1)=inizio;
evex(i-1,2)=fine;

end
end



waitbar(2/2,h);
close(h);

else 
    
    run(['DELTA_ANALYSIS_ERROR_1']);
    
end

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
