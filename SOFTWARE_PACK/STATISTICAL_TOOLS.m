function varargout = STATISTICAL_TOOLS(varargin)
% STATISTICAL_TOOLS MATLAB code for STATISTICAL_TOOLS.fig
%      STATISTICAL_TOOLS, by itself, creates a new STATISTICAL_TOOLS or raises the existing
%      singleton*.
%
%      H = STATISTICAL_TOOLS returns the handle to a new STATISTICAL_TOOLS or the handle to
%      the existing singleton*.
%
%      STATISTICAL_TOOLS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICAL_TOOLS.M with the given input arguments.
%
%      STATISTICAL_TOOLS('Property','Value',...) creates a new STATISTICAL_TOOLS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before STATISTICAL_TOOLS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to STATISTICAL_TOOLS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help STATISTICAL_TOOLS

% Last Modified by GUIDE v2.5 30-Mar-2018 14:06:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @STATISTICAL_TOOLS_OpeningFcn, ...
                   'gui_OutputFcn',  @STATISTICAL_TOOLS_OutputFcn, ...
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


% --- Executes just before STATISTICAL_TOOLS is made visible.
function STATISTICAL_TOOLS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to STATISTICAL_TOOLS (see VARARGIN)

% Choose default command line output for STATISTICAL_TOOLS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global PAT_NUMBER;
global CON_NUMBER;
global main_path;

global val_LF;
global val_HF;
global val_LFHF;
global val_nLF;
global val_nHF;
global val_nLFHF;
global val_PCoer;
global val_PIncoer;
global val_IncoerCoer;
global val_WAKE;
global val_REM;
global val_N1;
global val_N2;
global val_N3;

global val1;
global val2;

val_LF=0;
val_HF=0;
val_LFHF=0;
val_nLF=0;
val_nHF=0;
val_nLFHF=0;
val_PCoer=0;
val_PIncoer=0;
val_IncoerCoer=0;
val_WAKE=0;
val_REM=0;
val_N1=0;
val_N2=0;
val_N3=0;

val1=0;
val2=0;

PAT_NUMBER
main_path
val1
val2
set(handles.edit1,'String',main_path);

% UIWAIT makes STATISTICAL_TOOLS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = STATISTICAL_TOOLS_OutputFcn(hObject, eventdata, handles) 
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


% --- BOXPLOT
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global main_path;
global PAT_NUMBER;
global CON_NUMBER;

global val_LF;
global val_HF;
global val_LFHF;
global val_nLF;
global val_nHF;
global val_nLFHF;
global val_PCoer;
global val_PIncoer;
global val_IncoerCoer;
global val_WAKE;
global val_REM;
global val_N1;
global val_N2;
global val_N3;

global val1;
global val2;


val1=0;
val2=0;

val1=val_LF+val_HF+val_LFHF+val_nLF+...
    +val_nHF+val_nLFHF+val_PCoer+val_PIncoer+...
    +val_IncoerCoer;

val2=val_WAKE+val_REM+val_N1+...
    +val_N2+val_N3;


%val1
%val2
%PAT_NUMBER
%main_path

if(val1==1) bx1=1; bx2=1; end
if(val1==2) bx1=1; bx2=2; end
if(val1==3) bx1=1; bx2=3; end
if(val1==4) bx1=2; bx2=3; end
if(val1==5) bx1=2; bx2=3; end
if(val1==6) bx1=2; bx2=3; end
if(val1==7) bx1=3; bx2=3; end
if(val1==8) bx1=3; bx2=3; end
if(val1==9) bx1=3; bx2=3; end


%per eliminare file nascosti sul mac
string_point='.';


if(val_WAKE)
    figure('Name','WAKE');
    bx3=0;
        if(val_LF)
            global LF_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LF_WAKE_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);                   
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)=0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_WAKE_mean = B(j+2,1);      
                LF_WAKE_Ready(i,1)=LF_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_WAKE_mean = B(j+2,1);      
                LF_WAKE_Ready(i,2)=LF_WAKE_mean;
            end
            S=0;
            S=[LF_WAKE_Ready(1:PAT_NUMBER,1)' LF_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('LF');
        end   
        
        
        
        if(val_HF)
            global HF_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            HF_WAKE_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_WAKE_mean = B(j+2,2);      
                HF_WAKE_Ready(i,1)=HF_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                   k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_WAKE_mean = B(j+2,2);      
                HF_WAKE_Ready(i,2)=HF_WAKE_mean;
            end
            S=0;
            S=[HF_WAKE_Ready(1:PAT_NUMBER,1)' HF_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('HF');          
        end 
        
      
        if(val_LFHF)
            global LFHF_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LFHF_WAKE_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_WAKE_mean = B(j+2,3);      
                LFHF_WAKE_Ready(i,1)=LFHF_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_WAKE_mean = B(j+2,3);      
                LFHF_WAKE_Ready(i,2)=LFHF_WAKE_mean;
            end        
            S=0;
            S=[LFHF_WAKE_Ready(1:PAT_NUMBER,1)' LFHF_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('LFHF');
        end          

        if(val_nLF)
            global nLF_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLF_WAKE_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_WAKE_mean = B(j+2,5);      
                nLF_WAKE_Ready(i,1)=nLF_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_WAKE_mean = B(j+2,5);      
                nLF_WAKE_Ready(i,2)=nLF_WAKE_mean;
            end        
            S=0;
            S=[nLF_WAKE_Ready(1:PAT_NUMBER,1)' nLF_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLF');
        end          

        if(val_nHF)
            global nHF_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nHF_WAKE_Ready=zeros(PAT_NUMBER,2);  
            
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_WAKE_mean = B(j+2,6);      
                nHF_WAKE_Ready(i,1)=nHF_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_WAKE_mean = B(j+2,6);      
                nHF_WAKE_Ready(i,2)=nHF_WAKE_mean;
            end        
            S=0;
            S=[nHF_WAKE_Ready(1:PAT_NUMBER,1)' nHF_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nHF');
        end          

        if(val_nLFHF)
            global nLFHF_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLFHF_WAKE_Ready=zeros(PAT_NUMBER,2);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_WAKE_mean = B(j+2,7);      
                nLFHF_WAKE_Ready(i,1)=nLFHF_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_WAKE_mean = B(j+2,7);      
                nLFHF_WAKE_Ready(i,2)=nLFHF_WAKE_mean;
            end       
            S=0;
            S=[nLFHF_WAKE_Ready(1:PAT_NUMBER,1)' nLFHF_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLFHF');
        end          

        if(val_PCoer)
            global PCoer_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            PCoer_WAKE_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_WAKE_mean = B(j+2,9);      
                PCoer_WAKE_Ready(i,1)=PCoer_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_WAKE_mean = B(j+2,9);      
                PCoer_WAKE_Ready(i,2)=PCoer_WAKE_mean;
            end        
            S=0;
            S=[PCoer_WAKE_Ready(1:PAT_NUMBER,1)' PCoer_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PCoer');
        end          
     
         if(val_PIncoer)
             global PIncoer_WAKE_Ready;
             bx3=bx3+1;
            %la matrice pronta per i boxplot
            PIncoer_WAKE_Ready=zeros(PAT_NUMBER,2);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_WAKE_mean = B(j+2,10);      
                PIncoer_WAKE_Ready(i,1)=PIncoer_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_WAKE_mean = B(j+2,10);      
                PIncoer_WAKE_Ready(i,2)=PIncoer_WAKE_mean;
            end        
            S=0;
            S=[PIncoer_WAKE_Ready(1:PAT_NUMBER,1)' PIncoer_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PIncoer');
         end         
 
        if(val_IncoerCoer)
            global IncoerCoer_WAKE_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            IncoerCoer_WAKE_Ready=zeros(PAT_NUMBER,2);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);

                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_WAKE_mean = B(j+2,11) 
                IncoerCoer_WAKE_Ready(i,1)=IncoerCoer_WAKE_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/WAKE');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_WAKE_mean = B(j+2,11);      
                IncoerCoer_WAKE_Ready(i,2)=IncoerCoer_WAKE_mean;
            end    
            S=0;
            S=[IncoerCoer_WAKE_Ready(1:PAT_NUMBER,1)' IncoerCoer_WAKE_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('IncoerCoer');
        end                    
end


if(val_REM)
    figure('Name','REM');
    bx3=0;
        if(val_LF)
            global LF_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LF_REM_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);                   
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)=0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_REM_mean = B(j+2,1);      
                LF_REM_Ready(i,1)=LF_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_REM_mean = B(j+2,1);      
                LF_REM_Ready(i,2)=LF_REM_mean;
            end
            S=0;
            S=[LF_REM_Ready(1:PAT_NUMBER,1)' LF_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('LF');
        end   
        
        
        
        if(val_HF)
            global HF_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            HF_REM_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_REM_mean = B(j+2,2);      
                HF_REM_Ready(i,1)=HF_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                   k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_REM_mean = B(j+2,2);      
                HF_REM_Ready(i,2)=HF_REM_mean;
            end
            S=0;
            S=[HF_REM_Ready(1:PAT_NUMBER,1)' HF_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('HF');          
        end 
        
      
        if(val_LFHF)
            global LFHF_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LFHF_REM_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_REM_mean = B(j+2,3);      
                LFHF_REM_Ready(i,1)=LFHF_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_REM_mean = B(j+2,3);      
                LFHF_REM_Ready(i,2)=LFHF_REM_mean;
            end        
            S=0;
            S=[LFHF_REM_Ready(1:PAT_NUMBER,1)' LFHF_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('LFHF');
        end          

        if(val_nLF)
            global nLF_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLF_REM_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_REM_mean = B(j+2,5);      
                nLF_REM_Ready(i,1)=nLF_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_REM_mean = B(j+2,5);      
                nLF_REM_Ready(i,2)=nLF_REM_mean;
            end        
            S=0;
            S=[nLF_REM_Ready(1:PAT_NUMBER,1)' nLF_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLF');
        end          

        if(val_nHF)
            global nHF_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nHF_REM_Ready=zeros(PAT_NUMBER,2);  
            
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_REM_mean = B(j+2,6);      
                nHF_REM_Ready(i,1)=nHF_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_REM_mean = B(j+2,6);      
                nHF_REM_Ready(i,2)=nHF_REM_mean;
            end        
            S=0;
            S=[nHF_REM_Ready(1:PAT_NUMBER,1)' nHF_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nHF');
        end          

        if(val_nLFHF)
            global nLFHF_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLFHF_REM_Ready=zeros(PAT_NUMBER,2);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_REM_mean = B(j+2,7);      
                nLFHF_REM_Ready(i,1)=nLFHF_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_REM_mean = B(j+2,7);      
                nLFHF_REM_Ready(i,2)=nLFHF_REM_mean;
            end       
            S=0;
            S=[nLFHF_REM_Ready(1:PAT_NUMBER,1)' nLFHF_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLFHF');
        end          

        if(val_PCoer)
            global PCoer_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            PCoer_REM_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_REM_mean = B(j+2,9);      
                PCoer_REM_Ready(i,1)=PCoer_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_REM_mean = B(j+2,9);      
                PCoer_REM_Ready(i,2)=PCoer_REM_mean;
            end        
            S=0;
            S=[PCoer_REM_Ready(1:PAT_NUMBER,1)' PCoer_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PCoer');
        end          
     
         if(val_PIncoer)
             global PIncoer_REM_Ready;
             bx3=bx3+1;
            %la matrice pronta per i boxplot
            PIncoer_REM_Ready=zeros(PAT_NUMBER,2);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_REM_mean = B(j+2,10);      
                PIncoer_REM_Ready(i,1)=PIncoer_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_REM_mean = B(j+2,10);      
                PIncoer_REM_Ready(i,2)=PIncoer_REM_mean;
            end        
            S=0;
            S=[PIncoer_REM_Ready(1:PAT_NUMBER,1)' PIncoer_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PIncoer');
         end         
 
        if(val_IncoerCoer)
            global IncoerCoer_REM_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            IncoerCoer_REM_Ready=zeros(PAT_NUMBER,2);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);

                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_REM_mean = B(j+2,11);      
                IncoerCoer_REM_Ready(i,1)=IncoerCoer_REM_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/REM');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_REM_mean = B(j+2,11);      
                IncoerCoer_REM_Ready(i,2)=IncoerCoer_REM_mean;
            end    
            S=0;
            S=[IncoerCoer_REM_Ready(1:PAT_NUMBER,1)' IncoerCoer_REM_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('IncoerCoer');
        end                    
end
   



if(val_N1)
%non ci sono fasi S1 rilevanti per le analisi
end


if(val_N2)
    figure('Name','N2');
    bx3=0;
        if(val_LF)
            global LF_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LF_N2_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)

                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);

                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);                   
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)=0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_N2_mean = B(j+2,1);      
                LF_N2_Ready(i,1)=LF_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_N2_mean = B(j+2,1);      
                LF_N2_Ready(i,2)=LF_N2_mean;
            end
            S=0;
            S=[LF_N2_Ready(1:PAT_NUMBER,1)' LF_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('LF');      
        end   
        
        if(val_HF)
            global HF_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            HF_N2_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)

                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);

                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_N2_mean = B(j+2,2);      
                HF_N2_Ready(i,1)=HF_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                   k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_N2_mean = B(j+2,2);      
                HF_N2_Ready(i,2)=HF_N2_mean;
            end        
            S=0;
            S=[HF_N2_Ready(1:PAT_NUMBER,1)' HF_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('HF');
        end 
        
      
        if(val_LFHF)
            global LFHF_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LFHF_N2_Ready=zeros(PAT_NUMBER,2);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_N2_mean = B(j+2,3);      
                LFHF_N2_Ready(i,1)=LFHF_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_N2_mean = B(j+2,3);      
                LFHF_N2_Ready(i,2)=LFHF_N2_mean;
            end        
            S=0;
            S=[LFHF_N2_Ready(1:PAT_NUMBER,1)' LFHF_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('LFHF');
        end          

        if(val_nLF)
            global nLF_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLF_N2_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_N2_mean = B(j+2,5);      
                nLF_N2_Ready(i,1)=nLF_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_N2_mean = B(j+2,5);      
                nLF_N2_Ready(i,2)=nLF_N2_mean;
            end        
            S=0;
            S=[nLF_N2_Ready(1:PAT_NUMBER,1)' nLF_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLF');
        end          

        if(val_nHF)
            global nHF_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nHF_N2_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_N2_mean = B(j+2,6);      
                nHF_N2_Ready(i,1)=nHF_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_N2_mean = B(j+2,6);      
                nHF_N2_Ready(i,2)=nHF_N2_mean;
            end        
            S=0;
            S=[nHF_N2_Ready(1:PAT_NUMBER,1)' nHF_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nHF');
        end          
        
        if(val_nLFHF)
            global nLFHF_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLFHF_N2_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_N2_mean = B(j+2,7);      
                nLFHF_N2_Ready(i,1)=nLFHF_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_N2_mean = B(j+2,7);      
                nLFHF_N2_Ready(i,2)=nLFHF_N2_mean;
            end        
            S=0;
            S=[nLFHF_N2_Ready(1:PAT_NUMBER,1)' nLFHF_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLFHF');
        end          

        if(val_PCoer)
            global PCoer_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            PCoer_N2_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_N2_mean = B(j+2,9);      
                PCoer_N2_Ready(i,1)=PCoer_N2_mean;
            end
            
            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_N2_mean = B(j+2,9);      
                PCoer_N2_Ready(i,2)=PCoer_N2_mean;
            end        
            S=0;
            S=[PCoer_N2_Ready(1:PAT_NUMBER,1)' PCoer_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PCoer');
        end          
     
         if(val_PIncoer)
             global PIncoer_N2_Ready;
             bx3=bx3+1;
            %la matrice pronta per i boxplot
            PIncoer_N2_Ready=zeros(PAT_NUMBER,2);                      
            
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_N2_mean = B(j+2,10);      
                PIncoer_N2_Ready(i,1)=PIncoer_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)

                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_N2_mean = B(j+2,10);      
                PIncoer_N2_Ready(i,2)=PIncoer_N2_mean;
            end        
            S=0;
            S=[PIncoer_N2_Ready(1:PAT_NUMBER,1)' PIncoer_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PIncoer');
         end         
 
        
        if(val_IncoerCoer)
            global IncoerCoer_N2_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            IncoerCoer_N2_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_N2_mean = B(j+2,11);      
                IncoerCoer_N2_Ready(i,1)=IncoerCoer_N2_mean;
            end

            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S2');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_N2_mean = B(j+2,11);      
                IncoerCoer_N2_Ready(i,2)=IncoerCoer_N2_mean;
            end        
            S=0;
            S=[IncoerCoer_N2_Ready(1:PAT_NUMBER,1)' IncoerCoer_N2_Ready(1:CON_NUMBER,2)'];
            G=[zeros(1,PAT_NUMBER),ones(1,CON_NUMBER)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('IncoerCoer');
        end       
end




if(val_N3)
    figure('Name','N3');
    bx3=0;
        if(val_LF)
            global LF_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LF_N3_Ready=zeros(PAT_NUMBER,3);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);                   
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)=0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_N3_mean = B(j+2,1);      
                LF_N3_Ready(i,1)=LF_N3_mean;
            end

            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_N3_mean = B(j+2,1);      
                LF_N3_Ready(i,2)=LF_N3_mean;
            end
            
            %3 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LF_N3_mean = B(j+2,1);      
                LF_N3_Ready(i,3)=LF_N3_mean;
            end
            S=0;
            S=[LF_N3_Ready(1:PAT_NUMBER,1)' LF_N3_Ready(1:PAT_NUMBER,2)' LF_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('LF');
        end   
        
        if(val_HF)
            global HF_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            HF_N3_Ready=zeros(PAT_NUMBER,3);                      

            %1 patologici
            for(i=1:PAT_NUMBER)               
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_N3_mean = B(j+2,2);      
                HF_N3_Ready(i,1)=HF_N3_mean;
            end

            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_N3_mean = B(j+2,2);      
                HF_N3_Ready(i,2)=HF_N3_mean;
            end
            
            %3 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                   k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                HF_N3_mean = B(j+2,2);      
                HF_N3_Ready(i,3)=HF_N3_mean;
            end        
            S=0;
            S=[HF_N3_Ready(1:PAT_NUMBER,1)' HF_N3_Ready(1:PAT_NUMBER,2)' HF_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('HF');
        end 
        
      
        if(val_LFHF)
            global LFHF_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            LFHF_N3_Ready=zeros(PAT_NUMBER,3);                      
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_N3_mean = B(j+2,3);      
                LFHF_N3_Ready(i,1)=LFHF_N3_mean;
            end

            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_N3_mean = B(j+2,3);      
                LFHF_N3_Ready(i,2)=LFHF_N3_mean;
            end
            
            %3 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                LFHF_N3_mean = B(j+2,3);      
                LFHF_N3_Ready(i,3)=LFHF_N3_mean;
            end        
            S=0;
            S=[LFHF_N3_Ready(1:PAT_NUMBER,1)' LFHF_N3_Ready(1:PAT_NUMBER,2)' LFHF_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('HF');
        end          

        if(val_nLF)
            global nLF_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLF_N3_Ready=zeros(PAT_NUMBER,3);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_N3_mean = B(j+2,5);      
                nLF_N3_Ready(i,1)=nLF_N3_mean;
            end

            
            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_N3_mean = B(j+2,5);      
                nLF_N3_Ready(i,2)=nLF_N3_mean;
            end  
            
            %3 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLF_N3_mean = B(j+2,5);      
                nLF_N3_Ready(i,3)=nLF_N3_mean;
            end        
            S=0;
            S=[nLF_N3_Ready(1:PAT_NUMBER,1)' nLF_N3_Ready(1:PAT_NUMBER,2)' nLF_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLF');
        end          

        if(val_nHF)
            global nHF_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nHF_N3_Ready=zeros(PAT_NUMBER,2);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_N3_mean = B(j+2,6);      
                nHF_N3_Ready(i,1)=nHF_N3_mean;
            end

            
            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_N3_mean = B(j+2,6);      
                nHF_N3_Ready(i,2)=nHF_N3_mean;
            end
            
            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nHF_N3_mean = B(j+2,6);      
                nHF_N3_Ready(i,3)=nHF_N3_mean;
            end        
            S=0;
            S=[nHF_N3_Ready(1:PAT_NUMBER,1)' nHF_N3_Ready(1:PAT_NUMBER,2)' nHF_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nHF');
        end          
        
        if(val_nLFHF)
            global nLFHF_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            nLFHF_N3_Ready=zeros(PAT_NUMBER,3);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_N3_mean = B(j+2,7);      
                nLFHF_N3_Ready(i,1)=nLFHF_N3_mean;
            end

            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_N3_mean = B(j+2,7);      
                nLFHF_N3_Ready(i,2)=nLFHF_N3_mean;
            end

            %3 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                nLFHF_N3_mean = B(j+2,7);      
                nLFHF_N3_Ready(i,3)=nLFHF_N3_mean;
            end        
            S=0;
            S=[nLFHF_N3_Ready(1:PAT_NUMBER,1)' nLFHF_N3_Ready(1:PAT_NUMBER,2)' nLFHF_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('nLFHF');
        end          

        if(val_PCoer)
            global PCoer_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            PCoer_N3_Ready=zeros(PAT_NUMBER,3);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_N3_mean = B(j+2,9);      
                PCoer_N3_Ready(i,1)=PCoer_N3_mean;
            end
            
            
            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_N3_mean = B(j+2,9);      
                PCoer_N3_Ready(i,2)=PCoer_N3_mean;
            end
            
            %3 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PCoer_N3_mean = B(j+2,9);      
                PCoer_N3_Ready(i,3)=PCoer_N3_mean;
            end        
            S=0;
            S=[PCoer_N3_Ready(1:PAT_NUMBER,1)' PCoer_N3_Ready(1:PAT_NUMBER,2)' PCoer_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PCoer');
        end          
     
         if(val_PIncoer)
             global PIncoer_N3_Ready;
             bx3=bx3+1;
            %la matrice pronta per i boxplot
            PIncoer_N3_Ready=zeros(PAT_NUMBER,3);                      
            
            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_N3_mean = B(j+2,10);      
                PIncoer_N3_Ready(i,1)=PIncoer_N3_mean;
            end

            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_N3_mean = B(j+2,10);      
                PIncoer_N3_Ready(i,2)=PIncoer_N3_mean;
            end
            
            %2 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                PIncoer_N3_mean = B(j+2,10);      
                PIncoer_N3_Ready(i,3)=PIncoer_N3_mean;
            end       
            S=0;
            S=[PIncoer_N3_Ready(1:PAT_NUMBER,1)' PIncoer_N3_Ready(1:PAT_NUMBER,2)' PIncoer_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('PIncoer');
         end         
 
        
        if(val_IncoerCoer)
            global IncoerCoer_N3_Ready;
            bx3=bx3+1;
            %la matrice pronta per i boxplot
            IncoerCoer_N3_Ready=zeros(PAT_NUMBER,3);                      

            %1 patologici
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_N3_mean = B(j+2,11);      
                IncoerCoer_N3_Ready(i,1)=IncoerCoer_N3_mean;
            end

            %2 eventi
            for(i=1:PAT_NUMBER)
                temp_path = strcat(main_path,'/PATOLOGICI/Paziente %d/Export_pheel/EVENT');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_N3_mean = B(j+2,11);      
                IncoerCoer_N3_Ready(i,2)=IncoerCoer_N3_mean;
            end

            %3 controlli
            for(i=1:CON_NUMBER)
                temp_path = strcat(main_path,'/CONTROLLI/Paziente %d/Export_pheel/S3');
                now_path = sprintf(temp_path,i);
                filePattern = fullfile(now_path, '*.mat');
                matFiles   = dir(filePattern);
                k=1;
                for j=1:length(matFiles)
                    baseFileName = matFiles(j).name;
                    fullFileName = fullfile(now_path, baseFileName);
                    control = strncmpi(baseFileName,string_point,1);
                    if (control==0)                    
                        fprintf('Now reading %s\n', fullFileName);                   
                        load(fullFileName);
                        B(k,1:34) = table2array(DATA_EXPORT);
                        k=k+1;
                    end
                end
                k=k-1;
                j=k;
                B(j+1,1:34)= 0;
                B(j+2,1:34) = mean(B(1:j,1:34));          
                IncoerCoer_N3_mean = B(j+2,11);      
                IncoerCoer_N3_Ready(i,3)=IncoerCoer_N3_mean;
            end        
            S=0;
            S=[IncoerCoer_N3_Ready(1:PAT_NUMBER,1)' IncoerCoer_N3_Ready(1:PAT_NUMBER,2)' IncoerCoer_N3_Ready(1:CON_NUMBER,3)'];
            G=[zeros(1,PAT_NUMBER),ones(1,PAT_NUMBER),(ones(1,CON_NUMBER).*2)];
            subplot(bx1,bx2,bx3);boxplot(S,G);hold on;set(boxplot(S,G),'linewidth',2); title('IncoerCoer');
        end    
    
end



if(val2==0) 
    run(['STATISTICAL_TOOLS_ERROR_1.m']);
end


% --- Executes on button press in pushbutton2.--------STATISTICAL ANALYSIS
function pushbutton2_Callback(hObject, eventdata, handles)

global PAT_NUMBER;
global CON_NUMBER;

global val_LF;
global val_HF;
global val_LFHF;
global val_nLF;
global val_nHF;
global val_nLFHF;
global val_PCoer;
global val_PIncoer;
global val_IncoerCoer;
global val_WAKE;
global val_REM;
global val_N1;
global val_N2;
global val_N3;


global val1;
global val2;

val1=0;
val2=0;

val1=val_LF+val_HF+val_LFHF+val_nLF+...
    +val_nHF+val_nLFHF+val_PCoer+val_PIncoer+...
    +val_IncoerCoer;

val2=val_WAKE+val_REM+val_N1+...
    +val_N2+val_N3;

if(val1==1) ciccio=1; end
if(val1==2) ciccio=2; end
if(val1==3) ciccio=3; end
if(val1==4) ciccio=4; end
if(val1==5) ciccio=5; end
if(val1==6) ciccio=6; end
if(val1==7) ciccio=7; end
if(val1==8) ciccio=8; end
if(val1==9) ciccio=9; end

DATA_PAT=zeros(PAT_NUMBER,ciccio);
DATA_CON=zeros(CON_NUMBER,ciccio);
DATA_EVE=zeros(PAT_NUMBER,ciccio);
STAT_PAT=zeros(9,6);
STAT_CON=zeros(9,6);
STAT_EVE=zeros(9,6);
TEST=zeros(ciccio,1);
TEST2=zeros(ciccio,1);


if(val_WAKE)

    if(val_LF)
        global LF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,1)=LF_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(1,1)=mean(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,2)=std(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,3)=median(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,4)=var(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,5)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.25);
        STAT_PAT(1,6)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.75);
        
        STAT_CON(1,1)=mean(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,2)=std(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,3)=median(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,4)=var(DATA_CON(1:CON_NUMBER,1));  
        STAT_CON(1,5)=quantile(DATA_CON(1:CON_NUMBER,1),0.25);
        STAT_CON(1,6)=quantile(DATA_CON(1:CON_NUMBER,1),0.75);
        
        TEST(1,1)=ranksum(DATA_PAT(:,1),DATA_CON(:,1));
        TEST2(1,1)=kruskalwallis(LF_WAKE_Ready(:,[1 2]),[],'off');
    end
    
    if(val_HF)
        global HF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,2)=HF_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(2,1)=mean(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,2)=std(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,3)=median(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,4)=var(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,5)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.25);
        STAT_PAT(2,6)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.75);
        
        STAT_CON(2,1)=mean(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,2)=std(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,3)=median(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,4)=var(DATA_CON(1:CON_NUMBER,2));  
        STAT_CON(2,5)=quantile(DATA_CON(1:CON_NUMBER,2),0.25);
        STAT_CON(2,6)=quantile(DATA_CON(1:CON_NUMBER,2),0.75);
        
        TEST(2,1)=ranksum(DATA_PAT(:,2),DATA_CON(:,2));
        TEST2(2,1)=kruskalwallis(HF_WAKE_Ready(:,[1 2]),[],'off');
    end
    
    if(val_LFHF)
        global LFHF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,3)=LFHF_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(3,1)=mean(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,2)=std(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,3)=median(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,4)=var(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,5)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.25);
        STAT_PAT(3,6)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.75);
        
        STAT_CON(3,1)=mean(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,2)=std(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,3)=median(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,4)=var(DATA_CON(1:CON_NUMBER,3));  
        STAT_CON(3,5)=quantile(DATA_CON(1:CON_NUMBER,3),0.25);
        STAT_CON(3,6)=quantile(DATA_CON(1:CON_NUMBER,3),0.75);
        
        TEST(3,1)=ranksum(DATA_PAT(:,3),DATA_CON(:,3));
        TEST2(3,1)=kruskalwallis(LFHF_WAKE_Ready(:,[1 2]),[],'off');
    end
    
    if(val_nLF)
        global nLF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,4)=nLF_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(4,1)=mean(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,2)=std(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,3)=median(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,4)=var(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,5)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.25);
        STAT_PAT(4,6)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.75);
        
        STAT_CON(4,1)=mean(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,2)=std(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,3)=median(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,4)=var(DATA_CON(1:CON_NUMBER,4));  
        STAT_CON(4,5)=quantile(DATA_CON(1:CON_NUMBER,4),0.25);
        STAT_CON(4,6)=quantile(DATA_CON(1:CON_NUMBER,4),0.75);
        
        TEST(4,1)=ranksum(DATA_PAT(:,4),DATA_CON(:,4));
        TEST2(4,1)=kruskalwallis(nLF_WAKE_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_nHF)
        global nHF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,5)=nHF_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(5,1)=mean(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,2)=std(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,3)=median(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,4)=var(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,5)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.25);
        STAT_PAT(5,6)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.75);
        
        STAT_CON(5,1)=mean(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,2)=std(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,3)=median(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,4)=var(DATA_CON(1:CON_NUMBER,5));  
        STAT_CON(5,5)=quantile(DATA_CON(1:CON_NUMBER,5),0.25);
        STAT_CON(5,6)=quantile(DATA_CON(1:CON_NUMBER,5),0.75);
        
        TEST(5,1)=ranksum(DATA_PAT(:,5),DATA_CON(:,5));
        TEST2(5,1)=kruskalwallis(nHF_WAKE_Ready(:,[1 2]),[],'off');
    end
    
    if(val_nLFHF)
        global nLFHF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(6,1)=mean(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,2)=std(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,3)=median(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,4)=var(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,5)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.25);
        STAT_PAT(6,6)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.75);
        
        STAT_CON(6,1)=mean(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,2)=std(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,3)=median(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,4)=var(DATA_CON(1:CON_NUMBER,6));  
        STAT_CON(6,5)=quantile(DATA_CON(1:CON_NUMBER,6),0.25);
        STAT_CON(6,6)=quantile(DATA_CON(1:CON_NUMBER,6),0.75);
        
        TEST(6,1)=ranksum(DATA_PAT(:,6),DATA_CON(:,6));
        TEST2(6,1)=kruskalwallis(nLFHF_WAKE_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_PCoer)
        global PCoer_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,7)=PCoer_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(7,1)=mean(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,2)=std(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,3)=median(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,4)=var(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,5)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.25);
        STAT_PAT(7,6)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.75);
        
        STAT_CON(7,1)=mean(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,2)=std(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,3)=median(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,4)=var(DATA_CON(1:CON_NUMBER,7));  
        STAT_CON(7,5)=quantile(DATA_CON(1:CON_NUMBER,7),0.25);
        STAT_CON(7,6)=quantile(DATA_CON(1:CON_NUMBER,7),0.75);
        
        TEST(7,1)=ranksum(DATA_PAT(:,7),DATA_CON(:,7));
        TEST2(7,1)=kruskalwallis(PCoer_WAKE_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_PIncoer)
        global PIncoer_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(8,1)=mean(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,2)=std(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,3)=median(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,4)=var(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,5)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.25);
        STAT_PAT(8,6)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.75);
        
        STAT_CON(8,1)=mean(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,2)=std(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,3)=median(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,4)=var(DATA_CON(1:CON_NUMBER,8));  
        STAT_CON(8,5)=quantile(DATA_CON(1:CON_NUMBER,8),0.25);
        STAT_CON(8,6)=quantile(DATA_CON(1:CON_NUMBER,8),0.75);
        
        TEST(8,1)=ranksum(DATA_PAT(:,8),DATA_CON(:,8));
        TEST2(8,1)=kruskalwallis(PIncoer_WAKE_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_WAKE_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(9,1)=mean(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,2)=std(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,3)=median(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,4)=var(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,5)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.25);
        STAT_PAT(9,6)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.75);
        
        STAT_CON(9,1)=mean(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,2)=std(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,3)=median(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,4)=var(DATA_CON(1:CON_NUMBER,9));  
        STAT_CON(9,5)=quantile(DATA_CON(1:CON_NUMBER,9),0.25);
        STAT_CON(9,6)=quantile(DATA_CON(1:CON_NUMBER,9),0.75);
        
        TEST(9,1)=ranksum(DATA_PAT(:,9),DATA_CON(:,9));
        TEST2(9,1)=kruskalwallis(IncoerCoer_WAKE_Ready(:,[1 2]),[],'off'); 
    end    

    figure('Name','WAKE: Stats','pos',[10 10 790 620]);
    uitable('Position',[30 330 730 260],'data',STAT_PAT,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    uitable('Position',[30 30 730 260],'data',STAT_CON,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    

    figure('Name','WAKE: Wilcoxon Test');
    uitable('Position',[30 120 730 170],'data',TEST,'columnname',{'PAT_CON'},...
        'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    
    figure('Name','WAKE: K-W Test');
    uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_EVE','PAT_CON','EVE_CON'},...
    'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});

    
    %----levene test
    %figure('Name','WAKE: Levene Test');
    %uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_CON'},...
    %    'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'}); 
    
end


if(val_REM) 

    if(val_LF)
        global LF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,1)=LF_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(1,1)=mean(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,2)=std(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,3)=median(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,4)=var(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,5)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.25);
        STAT_PAT(1,6)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.75);
        
        STAT_CON(1,1)=mean(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,2)=std(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,3)=median(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,4)=var(DATA_CON(1:CON_NUMBER,1));  
        STAT_CON(1,5)=quantile(DATA_CON(1:CON_NUMBER,1),0.25);
        STAT_CON(1,6)=quantile(DATA_CON(1:CON_NUMBER,1),0.75);
        
        TEST(1,1)=ranksum(DATA_PAT(:,1),DATA_CON(:,1));
        TEST2(1,1)=kruskalwallis(LF_REM_Ready(:,[1 2]),[],'off');
    end
    
    if(val_HF)
        global HF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,2)=HF_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(2,1)=mean(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,2)=std(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,3)=median(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,4)=var(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,5)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.25);
        STAT_PAT(2,6)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.75);
        
        STAT_CON(2,1)=mean(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,2)=std(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,3)=median(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,4)=var(DATA_CON(1:CON_NUMBER,2));  
        STAT_CON(2,5)=quantile(DATA_CON(1:CON_NUMBER,2),0.25);
        STAT_CON(2,6)=quantile(DATA_CON(1:CON_NUMBER,2),0.75);
        
        TEST(2,1)=ranksum(DATA_PAT(:,2),DATA_CON(:,2));
        TEST2(2,1)=kruskalwallis(HF_REM_Ready(:,[1 2]),[],'off');
    end
    
    if(val_LFHF)
        global LFHF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,3)=LFHF_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(3,1)=mean(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,2)=std(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,3)=median(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,4)=var(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,5)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.25);
        STAT_PAT(3,6)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.75);
        
        STAT_CON(3,1)=mean(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,2)=std(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,3)=median(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,4)=var(DATA_CON(1:CON_NUMBER,3));  
        STAT_CON(3,5)=quantile(DATA_CON(1:CON_NUMBER,3),0.25);
        STAT_CON(3,6)=quantile(DATA_CON(1:CON_NUMBER,3),0.75);
        
        TEST(3,1)=ranksum(DATA_PAT(:,3),DATA_CON(:,3));
        TEST2(3,1)=kruskalwallis(LFHF_REM_Ready(:,[1 2]),[],'off');
    end
    
    if(val_nLF)
        global nLF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,4)=nLF_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(4,1)=mean(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,2)=std(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,3)=median(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,4)=var(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,5)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.25);
        STAT_PAT(4,6)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.75);
        
        STAT_CON(4,1)=mean(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,2)=std(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,3)=median(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,4)=var(DATA_CON(1:CON_NUMBER,4));  
        STAT_CON(4,5)=quantile(DATA_CON(1:CON_NUMBER,4),0.25);
        STAT_CON(4,6)=quantile(DATA_CON(1:CON_NUMBER,4),0.75);
        
        TEST(4,1)=ranksum(DATA_PAT(:,4),DATA_CON(:,4));
        TEST2(4,1)=kruskalwallis(nLF_REM_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_nHF)
        global nHF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,5)=nHF_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(5,1)=mean(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,2)=std(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,3)=median(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,4)=var(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,5)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.25);
        STAT_PAT(5,6)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.75);
        
        STAT_CON(5,1)=mean(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,2)=std(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,3)=median(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,4)=var(DATA_CON(1:CON_NUMBER,5));  
        STAT_CON(5,5)=quantile(DATA_CON(1:CON_NUMBER,5),0.25);
        STAT_CON(5,6)=quantile(DATA_CON(1:CON_NUMBER,5),0.75);
        
        TEST(5,1)=ranksum(DATA_PAT(:,5),DATA_CON(:,5));
        TEST2(5,1)=kruskalwallis(nHF_REM_Ready(:,[1 2]),[],'off');
    end
    
    if(val_nLFHF)
        global nLFHF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(6,1)=mean(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,2)=std(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,3)=median(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,4)=var(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,5)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.25);
        STAT_PAT(6,6)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.75);
        
        STAT_CON(6,1)=mean(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,2)=std(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,3)=median(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,4)=var(DATA_CON(1:CON_NUMBER,6));  
        STAT_CON(6,5)=quantile(DATA_CON(1:CON_NUMBER,6),0.25);
        STAT_CON(6,6)=quantile(DATA_CON(1:CON_NUMBER,6),0.75);
        
        TEST(6,1)=ranksum(DATA_PAT(:,6),DATA_CON(:,6));
        TEST2(6,1)=kruskalwallis(nLFHF_REM_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_PCoer)
        global PCoer_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,7)=PCoer_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(7,1)=mean(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,2)=std(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,3)=median(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,4)=var(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,5)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.25);
        STAT_PAT(7,6)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.75);
        
        STAT_CON(7,1)=mean(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,2)=std(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,3)=median(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,4)=var(DATA_CON(1:CON_NUMBER,7));  
        STAT_CON(7,5)=quantile(DATA_CON(1:CON_NUMBER,7),0.25);
        STAT_CON(7,6)=quantile(DATA_CON(1:CON_NUMBER,7),0.75);
        
        TEST(7,1)=ranksum(DATA_PAT(:,7),DATA_CON(:,7));
        TEST2(7,1)=kruskalwallis(PCoer_REM_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_PIncoer)
        global PIncoer_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(8,1)=mean(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,2)=std(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,3)=median(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,4)=var(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,5)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.25);
        STAT_PAT(8,6)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.75);
        
        STAT_CON(8,1)=mean(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,2)=std(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,3)=median(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,4)=var(DATA_CON(1:CON_NUMBER,8));  
        STAT_CON(8,5)=quantile(DATA_CON(1:CON_NUMBER,8),0.25);
        STAT_CON(8,6)=quantile(DATA_CON(1:CON_NUMBER,8),0.75);
        
        TEST(8,1)=ranksum(DATA_PAT(:,8),DATA_CON(:,8));
        TEST2(8,1)=kruskalwallis(PIncoer_REM_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_REM_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(9,1)=mean(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,2)=std(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,3)=median(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,4)=var(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,5)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.25);
        STAT_PAT(9,6)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.75);
        
        STAT_CON(9,1)=mean(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,2)=std(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,3)=median(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,4)=var(DATA_CON(1:CON_NUMBER,9));  
        STAT_CON(9,5)=quantile(DATA_CON(1:CON_NUMBER,9),0.25);
        STAT_CON(9,6)=quantile(DATA_CON(1:CON_NUMBER,9),0.75);
        
        TEST(9,1)=ranksum(DATA_PAT(:,9),DATA_CON(:,9));
        TEST2(9,1)=kruskalwallis(IncoerCoer_REM_Ready(:,[1 2]),[],'off'); 
    end    

    figure('Name','REM: Stats','pos',[10 10 790 620]);
    uitable('Position',[30 330 730 260],'data',STAT_PAT,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    uitable('Position',[30 30 730 260],'data',STAT_CON,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    

    figure('Name','REM: Wilcoxon Test');
    uitable('Position',[30 120 730 170],'data',TEST,'columnname',{'PAT_CON'},...
     'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    
    figure('Name','REM: K-W Test');
    uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_EVE','PAT_CON','EVE_CON'},...
    'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});

 
    %-----levene test
    %figure('Name','REM: Levene Test');
    %uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_CON'},...
    %    'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'}); 
    
end


if(val_N2)

    if(val_LF)
        global LF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,1)=LF_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(1,1)=mean(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,2)=std(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,3)=median(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,4)=var(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,5)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.25);
        STAT_PAT(1,6)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.75);
        
        STAT_CON(1,1)=mean(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,2)=std(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,3)=median(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,4)=var(DATA_CON(1:CON_NUMBER,1));  
        STAT_CON(1,5)=quantile(DATA_CON(1:CON_NUMBER,1),0.25);
        STAT_CON(1,6)=quantile(DATA_CON(1:CON_NUMBER,1),0.75);
        
        TEST(1,1)=ranksum(DATA_PAT(:,1),DATA_CON(:,1));
        TEST2(1,1)=kruskalwallis(LF_N2_Ready(:,[1 2]),[],'off');
    end
    
    if(val_HF)
        global HF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,2)=HF_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(2,1)=mean(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,2)=std(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,3)=median(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,4)=var(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,5)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.25);
        STAT_PAT(2,6)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.75);
        
        STAT_CON(2,1)=mean(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,2)=std(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,3)=median(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,4)=var(DATA_CON(1:CON_NUMBER,2));  
        STAT_CON(2,5)=quantile(DATA_CON(1:CON_NUMBER,2),0.25);
        STAT_CON(2,6)=quantile(DATA_CON(1:CON_NUMBER,2),0.75);
        
        TEST(2,1)=ranksum(DATA_PAT(:,2),DATA_CON(:,2));
        TEST2(2,1)=kruskalwallis(HF_N2_Ready(:,[1 2]),[],'off');
    end
    
    if(val_LFHF)
        global LFHF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,3)=LFHF_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(3,1)=mean(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,2)=std(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,3)=median(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,4)=var(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,5)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.25);
        STAT_PAT(3,6)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.75);
        
        STAT_CON(3,1)=mean(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,2)=std(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,3)=median(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,4)=var(DATA_CON(1:CON_NUMBER,3));  
        STAT_CON(3,5)=quantile(DATA_CON(1:CON_NUMBER,3),0.25);
        STAT_CON(3,6)=quantile(DATA_CON(1:CON_NUMBER,3),0.75);
        
        TEST(3,1)=ranksum(DATA_PAT(:,3),DATA_CON(:,3));
        TEST2(3,1)=kruskalwallis(LFHF_N2_Ready(:,[1 2]),[],'off');
    end
    
    if(val_nLF)
        global nLF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,4)=nLF_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(4,1)=mean(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,2)=std(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,3)=median(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,4)=var(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,5)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.25);
        STAT_PAT(4,6)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.75);
        
        STAT_CON(4,1)=mean(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,2)=std(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,3)=median(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,4)=var(DATA_CON(1:CON_NUMBER,4));  
        STAT_CON(4,5)=quantile(DATA_CON(1:CON_NUMBER,4),0.25);
        STAT_CON(4,6)=quantile(DATA_CON(1:CON_NUMBER,4),0.75);
        
        TEST(4,1)=ranksum(DATA_PAT(:,4),DATA_CON(:,4));
        TEST2(4,1)=kruskalwallis(nLF_N2_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_nHF)
        global nHF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,5)=nHF_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(5,1)=mean(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,2)=std(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,3)=median(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,4)=var(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,5)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.25);
        STAT_PAT(5,6)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.75);
        
        STAT_CON(5,1)=mean(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,2)=std(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,3)=median(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,4)=var(DATA_CON(1:CON_NUMBER,5));  
        STAT_CON(5,5)=quantile(DATA_CON(1:CON_NUMBER,5),0.25);
        STAT_CON(5,6)=quantile(DATA_CON(1:CON_NUMBER,5),0.75);
        
        TEST(5,1)=ranksum(DATA_PAT(:,5),DATA_CON(:,5));
        TEST2(5,1)=kruskalwallis(nHF_N2_Ready(:,[1 2]),[],'off');
    end
    
    if(val_nLFHF)
        global nLFHF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(6,1)=mean(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,2)=std(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,3)=median(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,4)=var(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,5)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.25);
        STAT_PAT(6,6)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.75);
        
        STAT_CON(6,1)=mean(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,2)=std(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,3)=median(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,4)=var(DATA_CON(1:CON_NUMBER,6));  
        STAT_CON(6,5)=quantile(DATA_CON(1:CON_NUMBER,6),0.25);
        STAT_CON(6,6)=quantile(DATA_CON(1:CON_NUMBER,6),0.75);
        
        TEST(6,1)=ranksum(DATA_PAT(:,6),DATA_CON(:,6));
        TEST2(6,1)=kruskalwallis(nLFHF_N2_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_PCoer)
        global PCoer_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,7)=PCoer_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(7,1)=mean(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,2)=std(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,3)=median(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,4)=var(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(7,5)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.25);
        STAT_PAT(7,6)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.75);
        
        STAT_CON(7,1)=mean(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,2)=std(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,3)=median(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,4)=var(DATA_CON(1:CON_NUMBER,7));  
        STAT_CON(7,5)=quantile(DATA_CON(1:CON_NUMBER,7),0.25);
        STAT_CON(7,6)=quantile(DATA_CON(1:CON_NUMBER,7),0.75);
        
        TEST(7,1)=ranksum(DATA_PAT(:,7),DATA_CON(:,7));
        TEST2(7,1)=kruskalwallis(PCoer_N2_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_PIncoer)
        global PIncoer_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(8,1)=mean(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,2)=std(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,3)=median(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,4)=var(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,5)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.25);
        STAT_PAT(8,6)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.75);
        
        STAT_CON(8,1)=mean(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,2)=std(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,3)=median(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,4)=var(DATA_CON(1:CON_NUMBER,8));  
        STAT_CON(8,5)=quantile(DATA_CON(1:CON_NUMBER,8),0.25);
        STAT_CON(8,6)=quantile(DATA_CON(1:CON_NUMBER,8),0.75);
        
        TEST(8,1)=ranksum(DATA_PAT(:,8),DATA_CON(:,8));
        TEST2(8,1)=kruskalwallis(PIncoer_N2_Ready(:,[1 2]),[],'off');
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_N2_Ready(1:CON_NUMBER,2);
        
        STAT_PAT(9,1)=mean(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,2)=std(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,3)=median(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,4)=var(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,5)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.25);
        STAT_PAT(9,6)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.75);
        
        STAT_CON(9,1)=mean(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,2)=std(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,3)=median(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,4)=var(DATA_CON(1:CON_NUMBER,9));  
        STAT_CON(9,5)=quantile(DATA_CON(1:CON_NUMBER,9),0.25);
        STAT_CON(9,6)=quantile(DATA_CON(1:CON_NUMBER,9),0.75);
        
        TEST(9,1)=ranksum(DATA_PAT(:,9),DATA_CON(:,9));
        TEST2(9,1)=kruskalwallis(IncoerCoer_N2_Ready(:,[1 2]),[],'off'); 
    end    

    figure('Name','N2: Stats','pos',[10 10 790 620]);
    uitable('Position',[30 330 730 260],'data',STAT_PAT,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    uitable('Position',[30 30 730 260],'data',STAT_CON,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    

    figure('Name','N2: Wilcoxon Test');
    uitable('Position',[30 120 730 170],'data',TEST,'columnname',{'PAT_CON'},...
        'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    
    figure('Name','N2: K-W Test');
    uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_EVE','PAT_CON','EVE_CON'},...
    'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});

    %------levene test
    %figure('Name','N2: Levene Test');
    %uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_CON'},...
    %   'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'}); 
    
end


if(val_N3)
   
    if(val_LF)
        global LF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,1)=LF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,1)=LF_N3_Ready(1:CON_NUMBER,3);
        
        STAT_PAT(1,1)=mean(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,2)=std(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,3)=median(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,4)=var(DATA_PAT(1:PAT_NUMBER,1));
        STAT_PAT(1,5)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.25);
        STAT_PAT(1,6)=quantile(DATA_PAT(1:PAT_NUMBER,1),0.75);
        
        STAT_EVE(1,1)=mean(DATA_EVE(1:PAT_NUMBER,1));
        STAT_EVE(1,2)=std(DATA_EVE(1:PAT_NUMBER,1));
        STAT_EVE(1,3)=median(DATA_EVE(1:PAT_NUMBER,1));
        STAT_EVE(1,4)=var(DATA_EVE(1:PAT_NUMBER,1)); 
        STAT_EVE(1,5)=quantile(DATA_EVE(1:PAT_NUMBER,1),0.25);
        STAT_EVE(1,6)=quantile(DATA_EVE(1:PAT_NUMBER,1),0.75);
        
        STAT_CON(1,1)=mean(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,2)=std(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,3)=median(DATA_CON(1:CON_NUMBER,1));
        STAT_CON(1,4)=var(DATA_CON(1:CON_NUMBER,1));  
        STAT_CON(1,5)=quantile(DATA_CON(1:CON_NUMBER,1),0.25);
        STAT_CON(1,6)=quantile(DATA_CON(1:CON_NUMBER,1),0.75);
        
        TEST(1,1)=ranksum(DATA_PAT(:,1),DATA_EVE(:,1));
        TEST(1,2)=ranksum(DATA_PAT(:,1),DATA_CON(:,1));
        TEST(1,3)=ranksum(DATA_EVE(:,1),DATA_CON(:,1));
        
        DATA_TEST2_PAT_EVE(:,1)=LF_N3_Ready(:,1);
        DATA_TEST2_PAT_EVE(:,2)=LF_N3_Ready(:,2);
        
        TEST2(1,1)=kruskalwallis(LF_N3_Ready(:,[1 2]),[],'off');
        TEST2(1,2)=kruskalwallis(LF_N3_Ready(:,[1 3]),[],'off');
        TEST2(1,3)=kruskalwallis(LF_N3_Ready(:,[2 3]),[],'off');
        
    end
    
    if(val_HF)
        global HF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,2)=HF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,2)=HF_N3_Ready(1:CON_NUMBER,3);
        
        STAT_PAT(2,1)=mean(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,2)=std(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,3)=median(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,4)=var(DATA_PAT(1:PAT_NUMBER,2));
        STAT_PAT(2,5)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.25);
        STAT_PAT(2,6)=quantile(DATA_PAT(1:PAT_NUMBER,2),0.75);
        
        STAT_EVE(2,1)=mean(DATA_EVE(1:PAT_NUMBER,2));
        STAT_EVE(2,2)=std(DATA_EVE(1:PAT_NUMBER,2));
        STAT_EVE(2,3)=median(DATA_EVE(1:PAT_NUMBER,2));
        STAT_EVE(2,4)=var(DATA_EVE(1:PAT_NUMBER,2)); 
        STAT_EVE(2,5)=quantile(DATA_EVE(1:PAT_NUMBER,2),0.25);
        STAT_EVE(2,6)=quantile(DATA_EVE(1:PAT_NUMBER,2),0.75);
        
        STAT_CON(2,1)=mean(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,2)=std(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,3)=median(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,4)=var(DATA_CON(1:CON_NUMBER,2));
        STAT_CON(2,5)=quantile(DATA_CON(1:CON_NUMBER,2),0.25);
        STAT_CON(2,6)=quantile(DATA_CON(1:CON_NUMBER,2),0.75);
        
        TEST(2,1)=ranksum(DATA_PAT(:,2),DATA_EVE(:,2));
        TEST(2,2)=ranksum(DATA_PAT(:,2),DATA_CON(:,2));
        TEST(2,3)=ranksum(DATA_EVE(:,2),DATA_CON(:,2));
        
        TEST2(2,1)=kruskalwallis(HF_N3_Ready(:,[1 2]),[],'off');
        TEST2(2,2)=kruskalwallis(HF_N3_Ready(:,[1 3]),[],'off');
        TEST2(2,3)=kruskalwallis(HF_N3_Ready(:,[2 3]),[],'off');
        
    end
    
    if(val_LFHF)
        global LFHF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,3)=LFHF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,3)=LFHF_N3_Ready(1:CON_NUMBER,3); 
        
        STAT_PAT(3,1)=mean(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,2)=std(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,3)=median(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,4)=var(DATA_PAT(1:PAT_NUMBER,3));
        STAT_PAT(3,5)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.25);
        STAT_PAT(3,6)=quantile(DATA_PAT(1:PAT_NUMBER,3),0.75);
        
        STAT_EVE(3,1)=mean(DATA_EVE(1:PAT_NUMBER,3));
        STAT_EVE(3,2)=std(DATA_EVE(1:PAT_NUMBER,3));
        STAT_EVE(3,3)=median(DATA_EVE(1:PAT_NUMBER,3));
        STAT_EVE(3,4)=var(DATA_EVE(1:PAT_NUMBER,3)); 
        STAT_EVE(3,5)=quantile(DATA_EVE(1:PAT_NUMBER,3),0.25);
        STAT_EVE(3,6)=quantile(DATA_EVE(1:PAT_NUMBER,3),0.75);
        
        STAT_CON(3,1)=mean(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,2)=std(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,3)=median(DATA_CON(1:CON_NUMBER,3));
        STAT_CON(3,4)=var(DATA_CON(1:CON_NUMBER,3)); 
        STAT_CON(3,5)=quantile(DATA_CON(1:CON_NUMBER,3),0.25);
        STAT_CON(3,6)=quantile(DATA_CON(1:CON_NUMBER,3),0.75);
        
        TEST(3,1)=ranksum(DATA_PAT(:,3),DATA_EVE(:,3));
        TEST(3,2)=ranksum(DATA_PAT(:,3),DATA_CON(:,3));
        TEST(3,3)=ranksum(DATA_EVE(:,3),DATA_CON(:,3));
        
        TEST2(3,1)=kruskalwallis(LFHF_N3_Ready(:,[1 2]),[],'off');
        TEST2(3,2)=kruskalwallis(LFHF_N3_Ready(:,[1 3]),[],'off');
        TEST2(3,3)=kruskalwallis(LFHF_N3_Ready(:,[2 3]),[],'off');
        
    end
    
    if(val_nLF)
        global nLF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,4)=nLF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,4)=nLF_N3_Ready(1:CON_NUMBER,3); 
        
        STAT_PAT(4,1)=mean(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,2)=std(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,3)=median(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,4)=var(DATA_PAT(1:PAT_NUMBER,4));
        STAT_PAT(4,5)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.25);
        STAT_PAT(4,6)=quantile(DATA_PAT(1:PAT_NUMBER,4),0.75);
        
        STAT_EVE(4,1)=mean(DATA_EVE(1:PAT_NUMBER,4));
        STAT_EVE(4,2)=std(DATA_EVE(1:PAT_NUMBER,4));
        STAT_EVE(4,3)=median(DATA_EVE(1:PAT_NUMBER,4));
        STAT_EVE(4,4)=var(DATA_EVE(1:PAT_NUMBER,4));   
        STAT_EVE(4,5)=quantile(DATA_EVE(1:PAT_NUMBER,4),0.25);
        STAT_EVE(4,6)=quantile(DATA_EVE(1:PAT_NUMBER,4),0.75);
        
        STAT_CON(4,1)=mean(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,2)=std(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,3)=median(DATA_CON(1:CON_NUMBER,4));
        STAT_CON(4,4)=var(DATA_CON(1:CON_NUMBER,4));  
        STAT_CON(4,5)=quantile(DATA_CON(1:CON_NUMBER,4),0.25);
        STAT_CON(4,6)=quantile(DATA_CON(1:CON_NUMBER,4),0.75);
        
        TEST(4,1)=ranksum(DATA_PAT(:,4),DATA_EVE(:,4));
        TEST(4,2)=ranksum(DATA_PAT(:,4),DATA_CON(:,4));
        TEST(4,3)=ranksum(DATA_EVE(:,4),DATA_CON(:,4));
        
        TEST2(4,1)=kruskalwallis(nLF_N3_Ready(:,[1 2]),[],'off');
        TEST2(4,2)=kruskalwallis(nLF_N3_Ready(:,[1 3]),[],'off');
        TEST2(4,3)=kruskalwallis(nLF_N3_Ready(:,[2 3]),[],'off');
    end    
    
    if(val_nHF)
        global nHF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,5)=nHF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,5)=nHF_N3_Ready(1:CON_NUMBER,3); 
        
        STAT_PAT(5,1)=mean(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,2)=std(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,3)=median(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,4)=var(DATA_PAT(1:PAT_NUMBER,5));
        STAT_PAT(5,5)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.25);
        STAT_PAT(5,6)=quantile(DATA_PAT(1:PAT_NUMBER,5),0.75);
        
        STAT_EVE(5,1)=mean(DATA_EVE(1:PAT_NUMBER,5));
        STAT_EVE(5,2)=std(DATA_EVE(1:PAT_NUMBER,5));
        STAT_EVE(5,3)=median(DATA_EVE(1:PAT_NUMBER,5));
        STAT_EVE(5,4)=var(DATA_EVE(1:PAT_NUMBER,5));  
        STAT_EVE(5,5)=quantile(DATA_EVE(1:PAT_NUMBER,5),0.25);
        STAT_EVE(5,6)=quantile(DATA_EVE(1:PAT_NUMBER,5),0.75);
        
        STAT_CON(5,1)=mean(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,2)=std(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,3)=median(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,4)=var(DATA_CON(1:CON_NUMBER,5));
        STAT_CON(5,5)=quantile(DATA_CON(1:CON_NUMBER,5),0.25);
        STAT_CON(5,6)=quantile(DATA_CON(1:CON_NUMBER,5),0.75);
        
        TEST(5,1)=ranksum(DATA_PAT(:,5),DATA_EVE(:,5));
        TEST(5,2)=ranksum(DATA_PAT(:,5),DATA_CON(:,5));
        TEST(5,3)=ranksum(DATA_EVE(:,5),DATA_CON(:,5));
        
        TEST2(5,1)=kruskalwallis(nHF_N3_Ready(:,[1 2]),[],'off');
        TEST2(5,2)=kruskalwallis(nHF_N3_Ready(:,[1 3]),[],'off');
        TEST2(5,3)=kruskalwallis(nHF_N3_Ready(:,[2 3]),[],'off');
    end
    
    if(val_nLFHF)
        global nLFHF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,6)=nLFHF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_N3_Ready(1:CON_NUMBER,3);
        
        STAT_PAT(6,1)=mean(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,2)=std(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,3)=median(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,4)=var(DATA_PAT(1:PAT_NUMBER,6));
        STAT_PAT(6,5)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.25);
        STAT_PAT(6,6)=quantile(DATA_PAT(1:PAT_NUMBER,6),0.75);
        
        STAT_EVE(6,1)=mean(DATA_EVE(1:PAT_NUMBER,6));
        STAT_EVE(6,2)=std(DATA_EVE(1:PAT_NUMBER,6));
        STAT_EVE(6,3)=median(DATA_EVE(1:PAT_NUMBER,6));
        STAT_EVE(6,4)=var(DATA_EVE(1:PAT_NUMBER,6));  
        STAT_EVE(6,5)=quantile(DATA_EVE(1:PAT_NUMBER,6),0.25);
        STAT_EVE(6,6)=quantile(DATA_EVE(1:PAT_NUMBER,6),0.75);
        
        STAT_CON(6,1)=mean(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,2)=std(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,3)=median(DATA_CON(1:CON_NUMBER,6));
        STAT_CON(6,4)=var(DATA_CON(1:CON_NUMBER,6));  
        STAT_CON(6,5)=quantile(DATA_CON(1:CON_NUMBER,6),0.25);
        STAT_CON(6,6)=quantile(DATA_CON(1:CON_NUMBER,6),0.75);
        
        TEST(6,1)=ranksum(DATA_PAT(:,6),DATA_EVE(:,6));
        TEST(6,2)=ranksum(DATA_PAT(:,6),DATA_CON(:,6));
        TEST(6,3)=ranksum(DATA_EVE(:,6),DATA_CON(:,6));
        
        TEST2(6,1)=kruskalwallis(nLFHF_N3_Ready(:,[1 2]),[],'off');
        TEST2(6,2)=kruskalwallis(nLFHF_N3_Ready(:,[1 3]),[],'off');
        TEST2(6,3)=kruskalwallis(nLFHF_N3_Ready(:,[2 3]),[],'off');
    end    
    
    if(val_PCoer)
        global PCoer_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,7)=PCoer_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,7)=PCoer_N3_Ready(1:CON_NUMBER,3); 
        
        STAT_PAT(7,1)=mean(DATA_PAT(1:PAT_NUMBER,7));
        STAT_PAT(7,2)=std(DATA_PAT(1:PAT_NUMBER,7));
        STAT_PAT(7,3)=median(DATA_PAT(1:PAT_NUMBER,7));
        STAT_PAT(7,4)=var(DATA_PAT(1:PAT_NUMBER,7));
        STAT_PAT(7,5)=quantile(DATA_PAT(1:PAT_NUMBER,7),0.25);
        STAT_PAT(7,6)=quantile(DATA_PAT(1:PAT_NUMBER,7),0.75);
        
        STAT_EVE(7,1)=mean(DATA_EVE(1:PAT_NUMBER,7));
        STAT_EVE(7,2)=std(DATA_EVE(1:PAT_NUMBER,7));
        STAT_EVE(7,3)=median(DATA_EVE(1:PAT_NUMBER,7));
        STAT_EVE(7,4)=var(DATA_EVE(1:PAT_NUMBER,7)); 
        STAT_EVE(7,5)=quantile(DATA_EVE(1:PAT_NUMBER,7),0.25);
        STAT_EVE(7,6)=quantile(DATA_EVE(1:PAT_NUMBER,7),0.75);
        
        STAT_CON(7,1)=mean(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,2)=std(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,3)=median(DATA_CON(1:CON_NUMBER,7));
        STAT_CON(7,4)=var(DATA_CON(1:CON_NUMBER,7));  
        STAT_CON(7,5)=quantile(DATA_CON(1:CON_NUMBER,7),0.25);
        STAT_CON(7,6)=quantile(DATA_CON(1:CON_NUMBER,7),0.75);
        
        TEST(7,1)=ranksum(DATA_PAT(:,7),DATA_EVE(:,7));
        TEST(7,2)=ranksum(DATA_PAT(:,7),DATA_CON(:,7));
        TEST(7,3)=ranksum(DATA_EVE(:,7),DATA_CON(:,7));
        
        TEST2(7,1)=kruskalwallis(PCoer_N3_Ready(:,[1 2]),[],'off');
        TEST2(7,2)=kruskalwallis(PCoer_N3_Ready(:,[1 3]),[],'off');
        TEST2(7,3)=kruskalwallis(PCoer_N3_Ready(:,[2 3]),[],'off');
    end    
    
    if(val_PIncoer)
        global PIncoer_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,8)=PIncoer_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_N3_Ready(1:CON_NUMBER,3); 
        
        STAT_PAT(8,1)=mean(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,2)=std(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,3)=median(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,4)=var(DATA_PAT(1:PAT_NUMBER,8));
        STAT_PAT(8,5)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.25);
        STAT_PAT(8,6)=quantile(DATA_PAT(1:PAT_NUMBER,8),0.75);
        
        STAT_EVE(8,1)=mean(DATA_EVE(1:PAT_NUMBER,8));
        STAT_EVE(8,2)=std(DATA_EVE(1:PAT_NUMBER,8));
        STAT_EVE(8,3)=median(DATA_EVE(1:PAT_NUMBER,8));
        STAT_EVE(8,4)=var(DATA_EVE(1:PAT_NUMBER,8));  
        STAT_EVE(8,5)=quantile(DATA_EVE(1:PAT_NUMBER,8),0.25);
        STAT_EVE(8,6)=quantile(DATA_EVE(1:PAT_NUMBER,8),0.75);
        
        STAT_CON(8,1)=mean(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,2)=std(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,3)=median(DATA_CON(1:CON_NUMBER,8));
        STAT_CON(8,4)=var(DATA_CON(1:CON_NUMBER,8));  
        STAT_CON(8,5)=quantile(DATA_CON(1:CON_NUMBER,8),0.25);
        STAT_CON(8,6)=quantile(DATA_CON(1:CON_NUMBER,8),0.75);
        
        TEST(8,1)=ranksum(DATA_PAT(:,8),DATA_EVE(:,8));
        TEST(8,2)=ranksum(DATA_PAT(:,8),DATA_CON(:,8));
        TEST(8,3)=ranksum(DATA_EVE(:,8),DATA_CON(:,8));
        
        TEST2(8,1)=kruskalwallis(PIncoer_N3_Ready(:,[1 2]),[],'off');
        TEST2(8,2)=kruskalwallis(PIncoer_N3_Ready(:,[1 3]),[],'off');
        TEST2(8,3)=kruskalwallis(PIncoer_N3_Ready(:,[2 3]),[],'off');
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,9)=IncoerCoer_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_N3_Ready(1:CON_NUMBER,3); 
        
        STAT_PAT(9,1)=mean(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,2)=std(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,3)=median(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,4)=var(DATA_PAT(1:PAT_NUMBER,9));
        STAT_PAT(9,5)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.25);
        STAT_PAT(9,6)=quantile(DATA_PAT(1:PAT_NUMBER,9),0.75);
        
        STAT_EVE(9,1)=mean(DATA_EVE(1:PAT_NUMBER,9));
        STAT_EVE(9,2)=std(DATA_EVE(1:PAT_NUMBER,9));
        STAT_EVE(9,3)=median(DATA_EVE(1:PAT_NUMBER,9));
        STAT_EVE(9,4)=var(DATA_EVE(1:PAT_NUMBER,9));
        STAT_EVE(9,5)=quantile(DATA_EVE(1:PAT_NUMBER,9),0.25);
        STAT_EVE(9,6)=quantile(DATA_EVE(1:PAT_NUMBER,9),0.75);
        
        STAT_CON(9,1)=mean(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,2)=std(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,3)=median(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,4)=var(DATA_CON(1:CON_NUMBER,9));
        STAT_CON(9,5)=quantile(DATA_CON(1:CON_NUMBER,9),0.25);
        STAT_CON(9,6)=quantile(DATA_CON(1:CON_NUMBER,9),0.75);
        
        TEST(9,1)=ranksum(DATA_PAT(:,9),DATA_EVE(:,9));
        TEST(9,2)=ranksum(DATA_PAT(:,9),DATA_CON(:,9));
        TEST(9,3)=ranksum(DATA_EVE(:,9),DATA_CON(:,9));
        
        TEST2(9,1)=kruskalwallis(IncoerCoer_N3_Ready(:,[1 2]),[],'off')
        TEST2(9,2)=kruskalwallis(IncoerCoer_N3_Ready(:,[1 3]),[],'off')
        TEST2(9,3)=kruskalwallis(IncoerCoer_N3_Ready(:,[2 3]),[],'off')
    end    
      
    figure('Name','N3: Stats','pos',[10 10 790 620]);
    uitable('Position',[30 420 730 170],'data',STAT_PAT,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    uitable('Position',[30 220 730 170],'data',STAT_EVE,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    uitable('Position',[30 20 730 170],'data',STAT_CON,'columnname',{'MEAN','STD','MEDIAN',...
        'VAR','Q1','Q3'},'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    

    figure('Name','N3: Wilcoxon Test');
    uitable('Position',[30 120 730 170],'data',TEST,'columnname',{'PAT_EVE','PAT_CON','EVE_CON'},...
        'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    
    figure('Name','N3: K-W Test');
    uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_EVE','PAT_CON','EVE_CON'},...
        'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    
    %-----levene test
    %figure('Name','N3: Levene Test');
    %uitable('Position',[30 120 730 170],'data',TEST2,'columnname',{'PAT_EVE','PAT_CON','EVE_CON'},...
    %    'rowname',{'LF','HF','LF/HF','nLF','nHF','nLF/nHF','PCoer','PIncoer','Incoer/Coer'});
    
end    
   

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- HF
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton1

global val_HF;
val_HF=get(handles.radiobutton1,'value');


% --- LF
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton2

global val_LF;
val_LF=get(handles.radiobutton2,'value');


% --- LF/HF
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton3

global val_LFHF;
val_LFHF=get(handles.radiobutton3,'value');


% --- nLF
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton4

global val_nLF;
val_nLF=get(handles.radiobutton4,'value');

% --- nHF
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton5

global val_nHF;
val_nHF=get(handles.radiobutton5,'value');

% --- nLFHF
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton6

global val_nLFHF;
val_nLFHF=get(handles.radiobutton6,'value');

% --- P Coer
function radiobutton7_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton7

global val_PCoer;
val_PCoer=get(handles.radiobutton7,'value');

% --- P Incoer
function radiobutton8_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton8

global val_PIncoer;
val_PIncoer=get(handles.radiobutton8,'value');

% --- PIncoer/PCoer
function radiobutton9_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton9

global val_IncoerCoer;
val_IncoerCoer=get(handles.radiobutton9,'value');

% --- Wake
function radiobutton10_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton10

global val_WAKE;
val_WAKE=get(handles.radiobutton10,'value');

% --- REM
function radiobutton11_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton11

global val_REM;
val_REM=get(handles.radiobutton11,'value');

% --- N1
function radiobutton12_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton12

global val_N1;
val_N1=get(handles.radiobutton12,'value');

% --- N2
function radiobutton13_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton13

global val_N2;
val_N2=get(handles.radiobutton13,'value');

% --- N3
function radiobutton14_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of radiobutton14

global val_N3;
val_N3=get(handles.radiobutton14,'value');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)

close all

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- TABLE
function pushbutton5_Callback(hObject, eventdata, handles)

global PAT_NUMBER;
global CON_NUMBER;


global val_LF;
global val_HF;
global val_LFHF;
global val_nLF;
global val_nHF;
global val_nLFHF;
global val_PCoer;
global val_PIncoer;
global val_IncoerCoer;
global val_WAKE;
global val_REM;
global val_N1;
global val_N2;
global val_N3;


global val1;
global val2;

val1=0;
val2=0;

val1=val_LF+val_HF+val_LFHF+val_nLF+...
    +val_nHF+val_nLFHF+val_PCoer+val_PIncoer+...
    +val_IncoerCoer;

val2=val_WAKE+val_REM+val_N1+...
    +val_N2+val_N3;

if(val1==1) ciccio=1; end
if(val1==2) ciccio=2; end
if(val1==3) ciccio=3; end
if(val1==4) ciccio=4; end
if(val1==5) ciccio=5; end
if(val1==6) ciccio=6; end
if(val1==7) ciccio=7; end
if(val1==8) ciccio=8; end
if(val1==9) ciccio=9; end

DATA_PAT=zeros(PAT_NUMBER,ciccio);
DATA_CON=zeros(CON_NUMBER,ciccio);
DATA_EVE=zeros(PAT_NUMBER,ciccio);


if(val_WAKE)

    if(val_LF)
        global LF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,1)=LF_WAKE_Ready(1:CON_NUMBER,2);
    end
    
    if(val_HF)
        global HF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,2)=HF_WAKE_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_LFHF)
        global LFHF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,3)=LFHF_WAKE_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_nLF)
        global nLF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,4)=nLF_WAKE_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_nHF)
        global nHF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,5)=nHF_WAKE_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_nLFHF)
        global nLFHF_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_WAKE_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_PCoer)
        global PCoer_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,7)=PCoer_WAKE_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_PIncoer)
        global PIncoer_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_WAKE_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_WAKE_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_WAKE_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_WAKE_Ready(1:CON_NUMBER,2); 
    end    

    figure('Name','WAKE','pos',[10 10 790 620]);
    uitable('Position',[30 330 730 260],'data',DATA_PAT,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
    uitable('Position',[30 30 730 260],'data',DATA_CON,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
end

if(val_REM) 

    if(val_LF)
        global LF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,1)=LF_REM_Ready(1:CON_NUMBER,2);
    end
    
    if(val_HF)
        global HF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,2)=HF_REM_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_LFHF)
        global LFHF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,3)=LFHF_REM_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_nLF)
        global nLF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,4)=nLF_REM_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_nHF)
        global nHF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,5)=nHF_REM_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_nLFHF)
        global nLFHF_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_REM_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_PCoer)
        global PCoer_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,7)=PCoer_REM_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_PIncoer)
        global PIncoer_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_REM_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_REM_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_REM_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_REM_Ready(1:CON_NUMBER,2); 
    end    

    figure('Name','REM','pos',[10 10 790 620]);
    uitable('Position',[30 330 730 260],'data',DATA_PAT,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
    uitable('Position',[30 30 730 260],'data',DATA_CON,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
     
end


if(val_N2)

    if(val_LF)
        global LF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,1)=LF_N2_Ready(1:CON_NUMBER,2);
    end
    
    if(val_HF)
        global HF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,2)=HF_N2_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_LFHF)
        global LFHF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,3)=LFHF_N2_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_nLF)
        global nLF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,4)=nLF_N2_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_nHF)
        global nHF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,5)=nHF_N2_Ready(1:CON_NUMBER,2); 
    end
    
    if(val_nLFHF)
        global nLFHF_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_N2_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_PCoer)
        global PCoer_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,7)=PCoer_N2_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_PIncoer)
        global PIncoer_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_N2_Ready(1:CON_NUMBER,2); 
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_N2_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_N2_Ready(1:PAT_NUMBER,1);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_N2_Ready(1:CON_NUMBER,2); 
    end    

    figure('Name','N2','pos',[10 10 790 620]);
    uitable('Position',[30 330 730 260],'data',DATA_PAT,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
    uitable('Position',[30 30 730 260],'data',DATA_CON,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
end


if(val_N3)
   
    if(val_LF)
        global LF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,1)=LF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,1)=LF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,1)=LF_N3_Ready(1:CON_NUMBER,3);
    end
    
    if(val_HF)
        global HF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,2)=HF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,2)=HF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,2)=HF_N3_Ready(1:CON_NUMBER,3);
    end
    
    if(val_LFHF)
        global LFHF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,3)=LFHF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,3)=LFHF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,3)=LFHF_N3_Ready(1:CON_NUMBER,3); 
    end
    
    if(val_nLF)
        global nLF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,4)=nLF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,4)=nLF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,4)=nLF_N3_Ready(1:CON_NUMBER,3); 
    end    
    
    if(val_nHF)
        global nHF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,5)=nHF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,5)=nHF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,5)=nHF_N3_Ready(1:CON_NUMBER,3); 
    end
    
    if(val_nLFHF)
        global nLFHF_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,6)=nLFHF_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,6)=nLFHF_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,6)=nLFHF_N3_Ready(1:CON_NUMBER,3); 
    end    
    
    if(val_PCoer)
        global PCoer_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,7)=PCoer_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,7)=PCoer_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,7)=PCoer_N3_Ready(1:CON_NUMBER,3); 
    end    
    
    if(val_PIncoer)
        global PIncoer_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,8)=PIncoer_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,8)=PIncoer_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,8)=PIncoer_N3_Ready(1:CON_NUMBER,3); 
    end    
    
    if(val_IncoerCoer)
        global IncoerCoer_N3_Ready;
        DATA_PAT(1:PAT_NUMBER,9)=IncoerCoer_N3_Ready(1:PAT_NUMBER,1);
        DATA_EVE(1:PAT_NUMBER,9)=IncoerCoer_N3_Ready(1:PAT_NUMBER,2);
        DATA_CON(1:CON_NUMBER,9)=IncoerCoer_N3_Ready(1:CON_NUMBER,3); 
    end    

    figure('Name','N3','pos',[10 10 790 620]);
    uitable('Position',[30 420 730 170],'data',DATA_PAT,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
    uitable('Position',[30 220 730 170],'data',DATA_EVE,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
    uitable('Position',[30 20 730 170],'data',DATA_CON,'columnname',{'LF','HF','LFHF',...
        'nLF','nHF','nLFHF','PCoer','PIncoer','IncoerCoer'});
end    
    

% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
