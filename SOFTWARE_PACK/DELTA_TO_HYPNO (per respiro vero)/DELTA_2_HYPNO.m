function varargout = DELTA_2_HYPNO(varargin)
% DELTA_2_HYPNO MATLAB code for DELTA_2_HYPNO.fig
%      DELTA_2_HYPNO, by itself, creates a new DELTA_2_HYPNO or raises the existing
%      singleton*.
%
%      H = DELTA_2_HYPNO returns the handle to a new DELTA_2_HYPNO or the handle to
%      the existing singleton*.
%
%      DELTA_2_HYPNO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DELTA_2_HYPNO.M with the given input arguments.
%
%      DELTA_2_HYPNO('Property','Value',...) creates a new DELTA_2_HYPNO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DELTA_2_HYPNO_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DELTA_2_HYPNO_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DELTA_2_HYPNO

% Last Modified by GUIDE v2.5 04-Jun-2018 11:00:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DELTA_2_HYPNO_OpeningFcn, ...
                   'gui_OutputFcn',  @DELTA_2_HYPNO_OutputFcn, ...
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


% --- Executes just before DELTA_2_HYPNO is made visible.
function DELTA_2_HYPNO_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DELTA_2_HYPNO (see VARARGIN)

% Choose default command line output for DELTA_2_HYPNO
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%global main_path; %vedere se va lasciato fino alla fine
global EEG_load;
%global ECG_load;
global HYPNO_DEEP;
%global events;

global N3_HYPNO;
global N2_HYPNO;
global REM_HYPNO;
global HYPNO_PRINT;


CHN1=1; %ci sono solo due canali che prendo per l'EEG
CHN2=2;

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
%global SIEZ_load;

delta_lim=length(Delta_con);

%GUI=fullfile(main_path,'Export_ECG_gui.mat');
%load(GUI);


[Delta_r,y1]=resample(Delta_con,linspace(1,length(Delta_con),length(Delta_con)),0.0004);
[times_r,y2]=resample(times,linspace(1,length(times),length(times)),0.0004);

Delta_s=smooth(Delta_r,0.02,'rloess');



%% CALCOLO AL SECONDO MODO PER SOGLIE


s=EEG_load(:,CHN1); %%%%%%canale migliore
fs=250;

order=30; 
[delta,DELTA, theta,alpha,beta, BETA,Y,sigma]=filter_eeg_paper3(s,order,fs);
epoch=30*fs;
delta2=zeros(floor(length(delta)/epoch),1);
DELTA2=zeros(size(delta2));
theta2=zeros(size(delta2));
alpha2=zeros(size(delta2));
beta2=zeros(size(delta2));
BETA2=zeros(size(delta2));
sigma2=zeros(size(delta2));
s2=zeros(size(delta2));
S=zeros(size(delta2));
flag=zeros(size(delta2));
for j=1:length(delta2)
    delta2(j,1)=sum(delta((j-1)*epoch+1:j*epoch).^2);
    DELTA2(j,1)=sum(DELTA((j-1)*epoch+1:j*epoch).^2);
    theta2(j,1)=sum(theta((j-1)*epoch+1:j*epoch).^2);
    alpha2(j,1)=sum(alpha((j-1)*epoch+1:j*epoch).^2);
    beta2(j,1)=sum(beta((j-1)*epoch+1:j*epoch).^2);
    BETA2(j,1)=sum(BETA((j-1)*epoch+1:j*epoch).^2);
    sigma2(j,1)=sum(sigma((j-1)*epoch+1:j*epoch).^2);
    s2(j,1)=sum(s((j-1)*epoch+1:j*epoch).^2);
    S(j,1)=mean(abs(s((j-1)*epoch+1:j*epoch)));
    if (mode(abs(s((j-1)*epoch+1:j*epoch)))>max(s)-2) 
        flag(j,1)=1;
    end
          
end

flag2=flag; 
flag=num2str(flag');  
flag=strrep(flag,num2str([1 0 1]),num2str([1 1 1]));    
flag=strrep(flag,num2str([1 0 0 1]),num2str([1 1 1 1]));   
flag=str2num(flag);   
flag=flag';

%% remove epochs that are saturated/corrupted at the beginning    
if flag(1)==1        
    x=1;        
    while flag(x)==1            
        x=x+1;        
    end    
    start=x;    
else    
    start=1;    
end
%% remove epochs that are saturated/corrupted at the end   
if flag(end)==1 %we have noise at the end: we go back until we do not have artifacts      
    x=length(flag);  
    while flag(x)==1  
       x=x-1;
    end
    endp=x;     % the end of our signal is the point where artifact is over
else 
    endp=length(flag);  %if not, we set the endpoint at the end of the signal 
end

flag=flag2;

%% remove consecutive epochs that are saturated corrupted and all that

%% preceeds

g=0;
start1=start;
for k=start:endp    %we look for 10 consecutive artifacted epochs: we eliminate all that is before that
    if flag(k)==1
        g=g+1;
    else
        if g>=10
            
          % check that the artifact is not at the end of the
            
            % signal
            
            if k<(endp-start)/2+start            
                start1=k;
            end 
        end        
        g=0;        
    end    
end
start=start1;
%% remove consecutive epochs that are saturated corrupted and all that

%% follows

g=0;
endp1=endp;
for k=endp:-1:start1    %we look for 5 consecutive artifacted epochs: we eliminate all that is after that
    if flag(k)==1   
        g=g+1;      
    else        
        if g>=5                    
            
            % check that the artifact is not at the beginning of the            
            % signal            
            if k>(endp-start1)/2+start1           
                endp1=k;                
            end            
        end       
        g=0;        
    end    
end

endp=endp1;


delta2=delta2(start:endp);
DELTA2=DELTA2(start:endp);
theta2=theta2(start:endp);
alpha2=alpha2(start:endp);
beta2=beta2(start:endp);
BETA2=BETA2(start:endp);
sigma2=sigma2(start:endp);
s2=s2(start:endp);
S=S(start:endp);
flag=flag(start:endp);
delta=delta2./s2;
DELTA=DELTA2./s2;
theta=theta2./s2;
alpha=alpha2./s2;
beta=beta2./s2;
sigma=sigma2./s2;
BETA=BETA2./s2;

if numel(find(flag))/numel(flag)>0.1 %if more than 10% of the signal is degraded, the signal cannot be classified
    display('degraded signal') 
    return 
end

[delta nd]=outlier(delta);
[DELTA nD]=outlier(DELTA);
[theta nt]=outlier(theta);
[alpha na]=outlier(alpha);
[beta nb]=outlier(beta);
[BETA nB]=outlier(BETA);
[sigma ns]=outlier(sigma);
[S nS]=outlier(S);
cw=alpha.*beta./(delta+DELTA)*2;
cr=theta.*BETA./(delta+DELTA)*2;

% 
%     if max(hyp)>40
%         hyp=hyp-48;
%     end
%     hyp=hyp(start:endp);

% % 2-stage
%     hyp(hyp==5 | hyp==7)=0;
%     hyp(find(hyp==1 | hyp==2 | hyp==3 | hyp==4))=1;

sample=[delta DELTA alpha theta sigma beta BETA S cw cr];


net_path='NET_N3';
%numero pazienti per classify
n_net=21;
training_tmp=[];
%training_delta_tmp=[];
group_tmp=[];
k=1;

controllo=8;

for(i=1:n_net)
    if (i~=controllo)
        file=fullfile(net_path,['NET_' num2str(i) '.mat']);
        load(file);
    
        %training_delta_tmp=vertcat(training_delta_tmp,training(:,1));
        training_tmp=vertcat(training_tmp,training);
        group_tmp=vertcat(group_tmp,group);
        
        length(training)
        length(group)
    end
end


training=training_tmp;
group=group_tmp;
%training_delta=training_delta_tmp;

length(training)
length(group)

%trainisng=[training(:,1);t];
%t=[delta DELTA theta alpha sigma beta BETA S cw cr];
%training=[training;t];
%group=[group;HYP];

class=classify(sample,training,group','mahalanobis');
class2=postprocessing(class);


%%per percentuali
[C,err]=classify(sample,training,group','mahalanobis');
err

%%------------------------------------------------GRAFICO 3: CLASS N3

xx=linspace(1,length(delta),length(delta));
axes(handles.axes3);
plot(xx,class2.*-1,'color','b','linewidth',2);
hold on;
plot(xx,class.*-2,'color',[0.8 0.8 0.8]);
ylim([-3 3]);
xlim([0 length(delta)]);

axes(handles.axes6);
plot(xx,class2.*-3,'color',[0.8 0.8 0.8]);
hold on;
N3_HYPNO=class2.*-3;

%%------------------------------------------------GRAFICO 3: CLASS N2

net_path='NET_N2';
%numero pazienti per classify
n_net=21;
training_tmp=[];
%training_delta_tmp=[];
group_tmp=[];
k=1;

for(i=1:n_net)
    if (i~=controllo)
    file=fullfile(net_path,['NET_' num2str(i) '.mat']);
    load(file);
    
    %training_delta_tmp=vertcat(training_delta_tmp,training(:,1));
    training_tmp=vertcat(training_tmp,training);
    group_tmp=vertcat(group_tmp,group);
    
    length(training)
    length(group)
    end
end


training=training_tmp;
group=group_tmp;
%training_delta=training_delta_tmp;

length(training)
length(group)

%trainisng=[training(:,1);t];
%t=[delta DELTA theta alpha sigma beta BETA S cw cr];
%training=[training;t];
%group=[group;HYP];

class=classify(sample,training,group','mahalanobis');
class2=postprocessing(class);


xx=linspace(1,length(delta),length(delta));
axes(handles.axes5);
plot(xx,class2.*-1,'color','r','linewidth',2);
hold on;
plot(xx,class.*-2,'color',[0.8 0.8 0.8]);
ylim([-3 3]);
xlim([0 length(delta)]);

axes(handles.axes6);
plot(xx,class2.*-2,'color',[0.8 0.8 0.8]);
hold on;
N2_HYPNO=class2.*-2;

%%------------------------------------------------GRAFICO 3: CLASS REM

net_path='NET_REM';
%numero pazienti per classify
n_net=21;
training_tmp=[];
%training_delta_tmp=[];
group_tmp=[];
k=1;

for(i=1:n_net)
    if (i~=controllo)
    file=fullfile(net_path,['NET_' num2str(i) '.mat']);
    load(file);
    
    %training_delta_tmp=vertcat(training_delta_tmp,training(:,1));
    training_tmp=vertcat(training_tmp,training);
    group_tmp=vertcat(group_tmp,group);
    
    length(training)
    length(group)
    end
end


training=training_tmp;
group=group_tmp;
%training_delta=training_delta_tmp;

length(training)
length(group)

%trainisng=[training(:,1);t];
%t=[delta DELTA theta alpha sigma beta BETA S cw cr];
%training=[training;t];
%group=[group;HYP];

class=classify(sample,training,group','mahalanobis');
class2=postprocessing(class);


xx=linspace(1,length(delta),length(delta));
axes(handles.axes4);
plot(xx,class2.*-1,'color','y','linewidth',2);
hold on;
plot(xx,class.*-2,'color',[0.8 0.8 0.8]);
ylim([-3 3]);
xlim([0 length(delta)]);



axes(handles.axes6);
plot(xx,class2.*-1,'color',[0.8 0.8 0.8]);
ylim([-4 1]);
xlim([0 length(delta)]);
hold on;
REM_HYPNO=class2.*-1;

%%---------------------------------------------------GRAFICO 2: DELTA
axes(handles.axes1);
plot(times_r,Delta_r,'color',[0.8 0.8 0.8]);
hold on; plot(times_r,Delta_s,'color',[1 0 1],'linewidth',2); grid on;
hold on; area(times_r,Delta_s);
%fs=length(Delta_r)/0.1;
xlim([0 delta_lim/250]);
ylim([0 max(Delta_s)]);

%y=0:1:500;
%for(t=1:length(SIEZ_load))
%    if(SIEZ_load(t)==1)
%        x=t/250
%        line([x x],[0 500],'color','g','LineWidth',2);
%    end
%end

%figure();
%plot(linspace(1,length(SIEZ_load),length(SIEZ_load)),SIEZ_load);

%axes(handles.axes1);
%hold on;

%for(i=1:length(SIEZ_load))
%    
%    if(SIEZ_load(i)==1)
%        y=0:0.001:100;
%        siez=i/250;
%        %axes(handles.axes1); 
%        figure();
%        a=i
%        hold on;
%        plot(siez,y);
%    end
%end

      

%%calcolo dell'hypnogramma

%tempo_hypno=times_r;
tetto=max(Delta_s);
SOGLIA=0.3;  % proviamo a modificarla a buffo
limite=tetto*SOGLIA;

lu=round(delta_lim/250*0.1);
HYPNO_DEEP=zeros(1,lu);

for(i=1:lu)
    if(Delta_s(i)>limite)
        HYPNO_DEEP(i)=1;
    end
end


axes(handles.axes2);

i=0;
X=times_r(1:lu);
Y=HYPNO_DEEP;
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
xlim([0 delta_lim/250]);
ylim([-2 1]);


%%---------------------- [BETA] GRAFIO HYPNO TOTAL;

lung=length(REM_HYPNO);
TOT_HYPNO=zeros(lung,1);

for(i=1:lung);
    if(REM_HYPNO(i)==-1) TOT_HYPNO(i)=1; end
    if(N2_HYPNO(i)==-2) TOT_HYPNO(i)=2; end
    if(N3_HYPNO(i)==-3) TOT_HYPNO(i)=3; end
end

axes(handles.axes6);
hold on;
HYPNO_PRINT=TOT_HYPNO;


i=0;
X=xx;
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

    






% UIWAIT makes DELTA_2_HYPNO wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DELTA_2_HYPNO_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;






% --- Calculate Resp (HRV Version)
function pushbutton3_Callback(hObject, eventdata, handles)

global EEG_load;
global ECG_load;
global HYPNO_DEEP;
global RESP_load;

[exit_path]=uigetdir;

h=waitbar(0,'Loading','Name','Export'); 
waitbar(1/2,h);


lu=length(HYPNO_DEEP);
s_3=1;
FUU=0;
i=1;
k=1;
fs_ecg=250;

while(i~=lu)
    j=i;
    if(HYPNO_DEEP(i)==1)
        exp_start=i*2500;      
        j=i;
        while(HYPNO_DEEP(j)==1)
            j=j+1;        
        end;
        
        j=j-1;
        tempo_finestra=((j-1)*10)-(i*10);   
        if(tempo_finestra>300)
            exp_stop=(j)*2500;
            
            sig_ECG=ECG_load(exp_start:exp_stop);
            
            [pks,locs]=pan_tompkin(sig_ECG,250,0); %deve essere nella cartella
            start_time = 4.8828e-04;
            tempo_auto = linspace(start_time,length(sig_ECG)/250,length(sig_ECG));
            sig_respirogramma(:,1) = tempo_auto(locs(2:end));
            respirogramma = pks(2:end);
            [b,a]=butter(2,0.5/(250/2),'high');
            f_data=filtfilt(b,a,respirogramma);
            sig_respirogramma(:,2)=f_data;

            %%interpolazione

            x=sig_respirogramma(:,1).*250;
            y=f_data';
            xq=linspace(1,length(sig_ECG),length(sig_ECG));
            yq1 = interp1(x,y,xq);
            sig_respiro=yq1';

            figure();
            %plot(sig_respirogramma(:,1),respirogramma,'linewidth',2,'color','k');
            %hold on;
            sig_respirogramma_2(:,1)=sig_respirogramma(:,1).*250;
            subplot(2,1,1);
            plot(sig_respirogramma_2(:,1),f_data,'-r'); grid on; xlim([0 length(sig_ECG)]);
            hold on; plot(sig_respiro); 
            %hold on; plot(xq,yq1,':.');
            subplot(2,1,2);plot(sig_ECG); grid on; xlim([0 length(sig_ECG)]);

            
            
            
            file_name=sprintf('S3_%d',s_3);
            file=fullfile(exit_path,file_name);
            
            sig_ecg=sig_ECG';
            tempo_auto=tempo_auto';
            sig_respiro(isnan(sig_respiro))=0;

            save(file,'sig_ECG','sig_respiro','fs_ecg','tempo_auto');
            
            clear sig_respirogramma;
            clear tempo_auto;
            clear sig_respirogramma_2;
            clear tempo_auto;
            
            FUU(k,1)=i;
            FUU(k,2)=j;
            k=k+1;
            s_3=s_3+1;
        end  
        
    end
    i=j+1;
end
FUU %in secondi

waitbar(2/2,h);
close(h);











% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
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


% --- Save (DELTA version)
function pushbutton1_Callback(hObject, eventdata, handles)

global ECG_exp;
global EEG_exp;
global RESP_exp;
global lables;

ECG=ECG_exp';
EEG=EEG_exp;
RESP=RESP_exp;

[path]=uigetdir('*.mat','Export');

if (path==0)
    return;
end
        
file_ECG=fullfile(path,'ECG.mat');
file_EEG=fullfile(path,'EEG.mat');
file_RESP=fullfile(path,'RESP.mat');
file_events=fullfile(path,'events.mat');

save(file_ECG,'ECG');
save(file_EEG,'EEG');
save(file_RESP,'RESP');
save(file_events,'lables');


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Calculate RESP (DELTA VERSION)
function pushbutton2_Callback(hObject, eventdata, handles)

global EEG_load;
global ECG_load;
global RESP_load;
global EEG_exp;
global ECG_exp;
global RESP_exp;
global HYPNO_DEEP;
global HYPNO_DEEP_exp;
global lables;

global REM_HYPNO;
global N2_HYPNO;
global N3_HYPNO;
global HYPNO_PRINT;



%clear delta_start;
%clear delta_stop;
%clear start;
%clear stop;
%clear start_2;
%clear stop_2;
%clear EEG_exp;
%clear ECG_exp;
%clear RESP_exp;

%global HYPNO_DEEP;

delta_start=str2num(char(get(handles.edit1,'String')));
delta_stop=str2num(char(get(handles.edit2,'String')));

start=delta_start*250e04;
stop=delta_stop*250e04;

start_2=delta_start*10e02;
stop_2=delta_stop*10e02;

EEG_exp(:,1)=EEG_load(start:stop,1);
EEG_exp(:,2)=EEG_load(start:stop,2);
ECG_exp=ECG_load(start:stop);
RESP_real=RESP_load(start:stop);
HYPNO_DEEP_exp=HYPNO_DEEP(start_2:stop_2);


[pks,locs]=pan_tompkin(ECG_exp,250,0); %deve essere nella cartella
start_time = 4.8828e-04;
tempo_auto = linspace(start_time,length(ECG_exp)/250,length(ECG_exp));
sig_respirogramma(:,1) = tempo_auto(locs(2:end));
respirogramma = pks(2:end);
[b,a]=butter(2,0.5/(250/2),'high');
f_data=filtfilt(b,a,respirogramma);
sig_respirogramma(:,2)=f_data;

%%interpolazione

x=sig_respirogramma(:,1).*250;
y=f_data';
xq=linspace(1,length(ECG_exp),length(ECG_exp));
yq1 = interp1(x,y,xq);
RESP_exp=yq1';

figure();
%plot(sig_respirogramma(:,1),respirogramma,'linewidth',2,'color','k');
%hold on;
sig_respirogramma_2(:,1)=sig_respirogramma(:,1).*250;
subplot(2,1,1);
plot(sig_respirogramma_2(:,1),f_data,'-r'); grid on; xlim([0 length(ECG_exp)]);
hold on; plot(RESP_exp); 
hold on; plot(RESP_real);
%hold on; plot(xq,yq1,':.');
subplot(2,1,2);plot(ECG_exp); grid on; xlim([0 length(ECG_exp)]);


%estrai lables

if(HYPNO_DEEP_exp(1)==0) lables(1,1)=1; end
if(HYPNO_DEEP_exp(1)==1) lables(1,1)=5; end
lables(1,2)=1;
k=2;

str1=HYPNO_DEEP_exp(1);
prova=length(HYPNO_DEEP_exp);

for(i=2:prova)
    
    str_now=HYPNO_DEEP_exp(i);
    
    
    if(str1~=str_now)
        
        lables(k,2)=i*2500;
        str1=str_now;
        
        if(str_now==0)
          lables(k,1)=1;
        end
        if(str_now==1)
            lables(k,1)=5;
        end
        k=k+1;
    end
end

pippuzzo=length(lables(:,2));

for(i=i:pippuzzo)
    lables(i,2)=lables(i,2)+start;
end

cicciuzzo=pippuzzo+1;

lables(cicciuzzo,1)=1;
lables(cicciuzzo,2)=(delta_stop-delta_start)*10e03*250;

cia=1;

figure();
lung=length(REM_HYPNO);
xx=linspace(1,lung,lung);
plot(xx,REM_HYPNO);
hold on; plot(xx, N2_HYPNO);
hold on; plot(xx, N3_HYPNO);
hold on; plot(xx, HYPNO_PRINT,'linewidth',2);

delta_lim=length(EEG_load);

fss=lung/delta_lim*250;

start=(delta_start*fss)*10e03;
stop=(delta_stop*fss)*10e03;


xlim([start stop]);
ylim([-4 1]);

clear start
clear stop
clear delta_start
clear delta_stop
clear EEG_exp
clear EEG_load


% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Focus export
function pushbutton5_Callback(hObject, eventdata, handles)


run(['DELTA_2_HYPNOEXPORT.m']);







% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
