function varargout = GUI_ECG_Windows(varargin)
% GUI_ECG_WINDOWS MATLAB code for GUI_ECG_Windows.fig
%      GUI_ECG_WINDOWS, by itself, creates a new GUI_ECG_WINDOWS or raises the existing
%      singleton*.
%MIA
%      H = GUI_ECG_WINDOWS returns the handle to a new GUI_ECG_WINDOWS or the handle to
%      the existing singleton*.
%
%      GUI_ECG_WINDOWS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ECG_WINDOWS.M with the given input arguments.
%
%      GUI_ECG_WINDOWS('Property','Value',...) creates a new GUI_ECG_WINDOWS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_ECG_Windows_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_ECG_Windows_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_ECG_Windows

% Last Modified by GUIDE v2.5 14-Mar-2018 10:43:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct(...
	'gui_Name',       mfilename, ...
	'gui_Singleton',  gui_Singleton, ...
	'gui_OpeningFcn', @GUI_ECG_Windows_OpeningFcn, ...
	'gui_OutputFcn',  @GUI_ECG_Windows_OutputFcn, ...
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


% --- Executes just before GUI_ECG_Windows is made visible.
function GUI_ECG_Windows_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_ECG_Windows (see VARARGIN)

% Choose default command line output for GUI_ECG_Windows
handles.output = hObject;

%##########################################################################
% INIZIALIZZAZIONI VARIE

% Legenda eventi:
handles.events_panel.Visible = 'off';
handles.legend_flag = false;

% Win da mostrare
global T_Windows;
handles.nWin = -1;
if nargin > 3
	if isnumeric(varargin{1})
		handles.nWin = round(varargin{1});
		if handles.nWin < 1
			handles.nWin = -1;
		elseif handles.nWin > size(T_Windows,1)
			handles.nWin = size(T_Windows,1);
		end
	end
else
	% JUST FOR DEBUG
	handles.nWin = 1;
end

setBands(handles);
setTabelle(handles);
plotGrafici(handles);

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_ECG_Windows_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
if handles.nWin == -1
	close(hObject);
end


% --- Executes on button press in Full_Screen_PSD.
function Full_Screen_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to Full_Screen_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Full Screen di tutto il segnale
global VG_taco;
global VG_S1;
global VG_S2;
global VG_MSC;
global VG_S1_coer;
global VG_S2_coer;
global P_LF_Taco;
global P_HF_Taco;
global VG_fr_dec;
global T_Windows;
global VG_fs;
global VG_PSD11;
global VG_PSD12;
global VG_PSD21;
global VG_PSD22;

global VG_fullscreenStruct;
global VG_projectPath;

nWin = handles.nWin;

winS = find( VG_taco(:,1) >= T_Windows(nWin, 1), 1);
winE = find( VG_taco(:,1) <= T_Windows(nWin, 2), 1, 'last');
potWin = winS:winE;

SelectedObject = handles.DomainSelection.SelectedObject;
SelectedObjectTag = SelectedObject.Tag;
switch SelectedObjectTag
	case 'timeRadioBtn'
		potAreaCoer = sum(VG_PSD12(potWin, :), 2)*VG_fr_dec(2);
		myPlot = newFullscreenStruct();
		myPlot.data(1).signal = P_HF_Taco(potWin);
		myPlot.data(1).time = VG_taco(potWin, 1);
		myPlot.data(1).info = '';
		myPlot.data(2).signal = potAreaCoer;
		myPlot.data(2).time = VG_taco(potWin, 1);
		myPlot.data(2).info = '';
		myPlot.fs = VG_fs;
		myPlot.title = 'Componenti Respiro dipendenti';
		myPlot.xlabel = '';
		myPlot.ylabel = 'Power [s^2]';
		myPlot.events = true;
		myPlot.nParts = 5;
		VG_fullscreenStruct(1) = myPlot;

		potAreaIncoer = sum(VG_PSD11(potWin, :), 2)*VG_fr_dec(2);
		myPlot = newFullscreenStruct();
		myPlot.data(1).signal = P_LF_Taco(potWin);
		myPlot.data(1).time = VG_taco(potWin, 1);
		myPlot.data(1).info = '';
		myPlot.data(2).signal = potAreaIncoer;
		myPlot.data(2).time = VG_taco(potWin, 1);
		myPlot.data(2).info = '';
		myPlot.fs = VG_fs;
		myPlot.title = 'Componenti Respiro indipendenti';
		myPlot.xlabel = '';
		myPlot.ylabel = 'Power [s^2]';
		myPlot.events = true;
		myPlot.nParts = 5;
		VG_fullscreenStruct(2) = myPlot;

		potAreaRatio = potAreaIncoer./potAreaCoer;
		potBandRatio = P_LF_Taco./P_HF_Taco;
		myPlot = newFullscreenStruct();
		myPlot.data(1).signal = potBandRatio(potWin);
		myPlot.data(1).time = VG_taco(potWin, 1);
		myPlot.data(1).info = '';
		myPlot.data(2).signal = potAreaRatio;
		myPlot.data(2).time = VG_taco(potWin, 1);
		myPlot.data(2).info = '';
		myPlot.fs = VG_fs;
		myPlot.title = 'Bilancia Simpato-Vagale';
		myPlot.xlabel = 'Tempo [s]';
		myPlot.ylabel = 'A.U.';
		myPlot.events = true;
		myPlot.nParts = 5;
		VG_fullscreenStruct(3) = myPlot;
		
	case 'freqRadioBtn'
		myPlot = newFullscreenStruct();
		myPlot.data(1).signal = mean(VG_S1(potWin, :), 1);
		myPlot.data(1).time = VG_fr_dec;
		myPlot.data(1).info = '';
		myPlot.data(2).signal = mean(VG_PSD12(potWin, :), 1);
		myPlot.data(2).time = VG_fr_dec;
		myPlot.data(2).info = '';
		myPlot.fs = 1/diff(VG_fr_dec(1:2));
		myPlot.title = 'Potenza Tacogramma Media';
		myPlot.xlabel = '';
		myPlot.ylabel = 'PSD [s^2/Hz]';
		myPlot.events = false; %sarebbe figo mettere le bande come eventi
		myPlot.nParts = 5;
		VG_fullscreenStruct(1) = myPlot;
		
		myPlot = newFullscreenStruct();
		myPlot.data(1).signal = mean(VG_S2(potWin, :), 1);
		myPlot.data(1).time = VG_fr_dec;
		myPlot.data(1).info = '';
		myPlot.data(2).signal = mean(VG_PSD22(potWin, :), 1);
		myPlot.data(2).time = VG_fr_dec;
		myPlot.data(2).info = '';
		myPlot.fs = 1/diff(VG_fr_dec(1:2));
		myPlot.title = 'Potenza Respirogramma Media';
		myPlot.xlabel = '';
		myPlot.ylabel = 'PSD [s^2/Hz]';
		myPlot.events = false; %sarebbe figo mettere le bande come eventi
		myPlot.nParts = 5;
		VG_fullscreenStruct(2) = myPlot;
		
		myPlot = newFullscreenStruct();
		myPlot.data(1).signal = mean(VG_MSC(potWin, :), 1);
		myPlot.data(1).time = VG_fr_dec;
		myPlot.data(1).info = '';
		myPlot.fs = 1/diff(VG_fr_dec(1:2));
		myPlot.title = 'Coerenza Media';
		myPlot.xlabel = 'Freq [Hz]';
		myPlot.ylabel = 'A.U.';
		myPlot.events = false; %sarebbe figo mettere le bande come eventi
		myPlot.nParts = 5;
		VG_fullscreenStruct(3) = myPlot;
		
	otherwise
		return;
end
run([VG_projectPath, '/GUI_FullScreen']);


function plotGrafici(handles)
global VG_taco;
global VG_S1;
global VG_S2;
global VG_MSC;
global VG_S1_coer;
global VG_S2_coer;
global P_LF_Taco;
global P_HF_Taco;
global VG_fr_dec;
global T_Windows;
global VG_BandLimits;
global VG_PSD11;
global VG_PSD12;
global VG_PSD21;
global VG_PSD22;

global VG_eventi;
global etichette_ev;
global VG_fs;

nWin = handles.nWin;

winS = find( VG_taco(:,1) >= T_Windows(nWin, 1), 1);
winE = find( VG_taco(:,1) <= T_Windows(nWin, 2), 1, 'last');
potWin = winS:winE;

SelectedObject = handles.DomainSelection.SelectedObject;
SelectedObjectTag = SelectedObject.Tag;
switch SelectedObjectTag
	case 'timeRadioBtn'
		% Componenti Respiro-dipendenti
		axes(handles.RespDepAxes);
		cla;
		potAreaCoer = sum(VG_PSD12(potWin, :), 2)*(VG_fr_dec(2)-VG_fr_dec(1)); %metodo dei rettangoli

		% Coherent power
		yyaxis right;
		plot(VG_taco(potWin, 1), potAreaCoer);
		ylabel('PSDtaco/resp [s^2]');
		ylim([min(potAreaCoer) max(potAreaCoer)]);
		% HF power
		yyaxis left;
		plot(VG_taco(potWin, 1), P_HF_Taco(potWin));
		ylabel('HF [s^2]');
		ylim([min(P_HF_Taco(potWin)) max(P_HF_Taco(potWin))]);

		if nWin == 0
			xlim([0 VG_taco(end,1)]);
		else
			xlim([VG_taco(potWin(1), 1) VG_taco(potWin(end), 1)]);
		end
		title('Componenti Respiro dipendenti');

		% Componenti Respiro-indipendenti
		axes(handles.RespIndepAxes);
		cla;
		potAreaIncoer = sum(VG_PSD11(potWin, :), 2)*(VG_fr_dec(2)-VG_fr_dec(1)); %metodo dei rettangoli

		% Incoherent power
		yyaxis right;
		plot(VG_taco(potWin, 1), potAreaIncoer);
		ylabel('PSDtaco/taco [s^2]');
		ylim([min(potAreaIncoer) max(potAreaIncoer)]);
		% LF power
		yyaxis left;
		plot(VG_taco(potWin, 1), P_LF_Taco(potWin));
		ylabel('LF [s^2]');
		ylim([min(P_LF_Taco(potWin)) max(P_LF_Taco(potWin))]);

		if nWin == 0
			xlim([0 VG_taco(end,1)]);
		else
			xlim([VG_taco(potWin(1), 1) VG_taco(potWin(end), 1)]);
		end
		title('Componenti Respiro indipendenti');

		% Rapporto indipendenti/dipendendti
		axes(handles.RatioAxes);
		cla;
		potAreaRatio = potAreaIncoer./potAreaCoer;
		potBandRatio = P_LF_Taco./P_HF_Taco;

		% Coherence based power
		yyaxis right;
		plot(VG_taco(potWin, 1), potAreaRatio);
		ylabel('ratio partial spectra [s^2]');
		ylim([min(potAreaRatio) max(potAreaRatio)]);
		% Band based power
		yyaxis left;

		plot(VG_taco(potWin, 1), potBandRatio(potWin));
		ylabel('LF/HF [s^2]');
		ylim([min(potBandRatio(potWin)) max(potBandRatio(potWin))]);

		if nWin == 0
			xlim([0 VG_taco(end,1)]);
		else
			xlim([VG_taco(potWin(1), 1) VG_taco(potWin(end), 1)]);
		end
		title('Rapporto Simpato-Vagale');
		xlabel('Time [s]');

		%%% EVENTI
		handles.legend_flag = plot_eventi(handles.events_panel,handles.RespDepAxes,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
		%--------------------------------------------------------------
		handles.legend_flag = plot_eventi(handles.events_panel,handles.RespIndepAxes,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
		%--------------------------------------------------------------
		handles.legend_flag = plot_eventi(handles.events_panel,handles.RatioAxes,VG_eventi,etichette_ev,VG_fs,handles.legend_flag);
		%--------------------------------------------------------------
		guidata(handles.DomainSelection, handles);

	case 'freqRadioBtn'
		resetGrafici(handles);

		axes(handles.RespDepAxes);
		hold on;
		pTotTaco = area(VG_fr_dec, mean(VG_S1(potWin,:), 1), 'FaceColor', 'w');
		pCoerTaco = area(VG_fr_dec, mean(VG_PSD12(potWin,:), 1), 'FaceColor', 'k');
		title('Taco Spectrum');
		ylabel('PSD [s^2/Hz]');
		xlim([VG_fr_dec(1), VG_fr_dec(end)]);
		yLimits = get(handles.RespDepAxes,'ylim');
		area([VG_BandLimits(1,1) VG_BandLimits(1,2)], [1.1 1.1]*max(yLimits), 'FaceColor','g', 'FaceAlpha',0.2);
		area([VG_BandLimits(2,1) VG_BandLimits(2,2)], [1.1 1.1]*max(yLimits), 'FaceColor','b', 'FaceAlpha',0.2);
		area([VG_BandLimits(3,1) VG_BandLimits(3,2)], [1.1 1.1]*max(yLimits), 'FaceColor','r', 'FaceAlpha',0.2);
		legend([pTotTaco pCoerTaco], {'PSDtaco','PSDtaco/resp'}, 'Location','northeast');
        ylim(yLimits);
		hold off;
		ch = handles.RespDepAxes.Children;
		handles.RespDepAxes.Children = [ch(4:5); ch(1:3)];

		axes(handles.RespIndepAxes);
		hold on;
		pTotResp = area(VG_fr_dec, mean(VG_S2(potWin,:), 1), 'FaceColor', 'w');
		pCoerResp = area(VG_fr_dec, mean(VG_PSD22(potWin,:), 1), 'FaceColor', 'k');
		title('Resp Spectrum');
		ylabel('PSD [s^2/Hz]');
		xlim([VG_fr_dec(1), VG_fr_dec(end)]);
		yLimits = get(handles.RespIndepAxes,'ylim');
		area([VG_BandLimits(1,1) VG_BandLimits(1,2)], [1.1 1.1]*max(yLimits), 'FaceColor','g', 'FaceAlpha',0.2);
		area([VG_BandLimits(2,1) VG_BandLimits(2,2)], [1.1 1.1]*max(yLimits), 'FaceColor','b', 'FaceAlpha',0.2);
		area([VG_BandLimits(3,1) VG_BandLimits(3,2)], [1.1 1.1]*max(yLimits), 'FaceColor','r', 'FaceAlpha',0.2);
		legend([pTotResp pCoerResp], {'PSDresp','PSDresp/resp'}, 'Location','northeast');
        ylim(yLimits);
		hold off;
		ch = handles.RespIndepAxes.Children;
		handles.RespIndepAxes.Children = [ch(4:5); ch(1:3)];

		axes(handles.RatioAxes);
		hold on;
		area(VG_fr_dec, mean(VG_MSC(potWin,:), 1), 'FaceColor', 'w');
		xlim([VG_fr_dec(1), VG_fr_dec(end)]);
		title('Coherence');
		xlabel('Freq [Hz]');
		ylabel('A.U.');
		yLimits = get(handles.RatioAxes,'ylim');
		area([VG_BandLimits(1,1) VG_BandLimits(1,2)], [1.1 1.1]*max(yLimits), 'FaceColor','g', 'FaceAlpha',0.2);
		area([VG_BandLimits(2,1) VG_BandLimits(2,2)], [1.1 1.1]*max(yLimits), 'FaceColor','b', 'FaceAlpha',0.2);
		area([VG_BandLimits(3,1) VG_BandLimits(3,2)], [1.1 1.1]*max(yLimits), 'FaceColor','r', 'FaceAlpha',0.2);
		ylim(yLimits);
		hold off;
		ch = handles.RatioAxes.Children;
		handles.RatioAxes.Children = [ch(4); ch(1:3)];
		
	otherwise % non dovrebbe mai succedere
		resetGrafici(handles)
end


function resetGrafici(handles)
cla(handles.RespDepAxes, 'reset');
cla(handles.RespIndepAxes, 'reset');
cla(handles.RatioAxes, 'reset');


function setBands(handles)
global VG_BandLimits;
handles.VLF_startEdit.String = num2str(VG_BandLimits(1,1),3);
handles.LF_startEdit.String = num2str(VG_BandLimits(2,1),3);
handles.HF_startEdit.String = num2str(VG_BandLimits(3,1),3);
handles.VLF_endEdit.String = num2str(VG_BandLimits(1,2),3);
handles.LF_endEdit.String = num2str(VG_BandLimits(2,2),3);
handles.HF_endEdit.String = num2str(VG_BandLimits(3,2),3);


function setTabelle(handles)
global P_LF_NU_Taco
global P_HF_NU_Taco
global VG_taco
global T_Windows
global P_LF_Taco
global P_HF_Taco
global P_TOT_Taco;
global P_Coer;
global P_Incoer;
global PSD_parz_LF;
global PSD_parz_HF;
global PSD_parz_LF_NU;
global PSD_parz_HF_NU;

nWin = handles.nWin;

t_start = find(VG_taco(:,1) >= T_Windows(nWin,1), 1, 'first');
t_end = find(VG_taco(:,1) <= T_Windows(nWin,2), 1, 'last');
P = (10^6);
% P=1;

%%MODIFICHE SAVERIO ********************************************

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MEDIA ********* modificato
%handles.TableBand.Data{1,1} = round(mean(P_LF_Taco(t_start:t_end,1))*P, 3);
%handles.TableBand.Data{1,2} = round(mean(P_HF_Taco_new(t_start:t_end,1))*P, 3);
%handles.TableBand.Data{1,3} = round(mean(P_LF_Taco(t_start:t_end,1)./P_HF_Taco_new(t_start:t_end,1)), 3);
%handles.TableBand.Data{1,4} = round(mean(P_TOT_Taco(t_start:t_end,1))*P, 3);

%handles.TableBand.Data{2,1} = round(mean(P_LF_NU_Taco(t_start:t_end,1)), 3);
%handles.TableBand.Data{2,2} = round(mean(P_HF_NU_Taco_new(t_start:t_end,1)), 3);
%handles.TableBand.Data{2,3} = round(mean(P_LF_NU_Taco(t_start:t_end,1)./P_HF_NU_Taco_new(t_start:t_end,1)), 3);
%handles.TableBand.Data{2,4} = 100;


%handles.TableCoher.Data{1,1} = round(mean(P_Coer_new(t_start:t_end,1))*P, 3);
%handles.TableCoher.Data{1,2} = round(mean(P_Incoer(t_start:t_end,1))*P, 3);
%handles.TableCoher.Data{1,3} = round(mean(P_Incoer(t_start:t_end,1)./P_Coer_new(t_start:t_end,1)),3);

%handles.TableCoher.Data{2,1} = round(mean(PSD_parz_HF_new(t_start:t_end,1))*P, 3);
%handles.TableCoher.Data{2,2} = round(mean(PSD_parz_LF(t_start:t_end,1))*P, 3);
%handles.TableCoher.Data{2,3} = round(mean(PSD_parz_LF(t_start:t_end,1)./PSD_parz_HF_new(t_start:t_end,1)),3);

%handles.TableCoher.Data{3,1} = round(mean(PSD_parz_HF_NU_new(t_start:t_end,1)), 3);
%handles.TableCoher.Data{3,2} = round(mean(PSD_parz_LF_NU(t_start:t_end,1)), 3);
%handles.TableCoher.Data{3,3} = round(mean(PSD_parz_LF_NU(t_start:t_end,1)./PSD_parz_HF_NU_new(t_start:t_end,1)),3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MEDIANA
handles.TableBand.Data{1,1} = round(median(P_LF_Taco(t_start:t_end,1))*P, 3);
handles.TableBand.Data{1,2} = round(median(P_HF_Taco_new(t_start:t_end,1))*P, 3);
handles.TableBand.Data{1,3} = round(median(P_LF_Taco(t_start:t_end,1)./P_HF_Taco_new(t_start:t_end,1)), 3);
handles.TableBand.Data{1,4} = round(median(P_TOT_Taco(t_start:t_end,1))*P, 3);
 
handles.TableBand.Data{2,1} = round(median(P_LF_NU_Taco(t_start:t_end,1)), 3);
handles.TableBand.Data{2,2} = round(median(P_HF_NU_Taco_new(t_start:t_end,1)), 3);
handles.TableBand.Data{2,3} = round(median(P_LF_NU_Taco(t_start:t_end,1)./P_HF_NU_Taco_new(t_start:t_end,1)), 3);
handles.TableBand.Data{2,4} = 100;
 
handles.TableCoher.Data{1,1} = round(median(P_Coer_new(t_start:t_end,1))*P, 3);
handles.TableCoher.Data{1,2} = round(median(P_Incoer(t_start:t_end,1))*P, 3);
handles.TableCoher.Data{1,3} = round(median(P_Incoer(t_start:t_end,1)./P_Coer_new(t_start:t_end,1)),3);
 
handles.TableCoher.Data{2,1} = round(median(PSD_parz_HF(t_start:t_end,1))*P, 3);
handles.TableCoher.Data{2,2} = round(median(PSD_parz_LF(t_start:t_end,1))*P, 3);
handles.TableCoher.Data{2,3} = round(median(PSD_parz_LF(t_start:t_end,1)./PSD_parz_HF(t_start:t_end,1)),3);
 
handles.TableCoher.Data{3,1} = round(median(PSD_parz_HF_NU_new(t_start:t_end,1)), 3);
handles.TableCoher.Data{3,2} = round(median(PSD_parz_LF_NU(t_start:t_end,1)), 3);
handles.TableCoher.Data{3,3} = round(median(PSD_parz_LF_NU(t_start:t_end,1)./PSD_parz_HF_NU_new(t_start:t_end,1)),3);


% --- Executes on button press in ResetBandsBtn.
function ResetBandsBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ResetBandsBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_BandLimits;
global VG_defaultBandLimits;
VG_BandLimits = VG_defaultBandLimits;

setBands(handles);

plotGrafici(handles);


% --- Executes on button press in SaveBandsBtn.
function SaveBandsBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SaveBandsBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pfGUIECG;
global VG_BandLimits;
bandLimits = VG_BandLimits; %#ok<NASGU>
save(pfGUIECG, 'bandLimits', '-append');
BandExtrapolation();
plotGrafici(handles);
setTabelle(handles);


function VLF_endEdit_Callback(hObject, eventdata, handles)
% hObject    handle to VLF_endEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VLF_endEdit as text
%        str2double(get(hObject,'String')) returns contents of VLF_endEdit as a double
global VG_BandLimits;
global VG_fr_dec;

newValue = round(str2double(hObject.String),3);
if newValue < VG_BandLimits(1,1)
	newValue = VG_BandLimits(1,1);
end
if newValue > VG_fr_dec(end)
	newValue = VG_fr_dec(end);
end
VG_BandLimits(1,2) = newValue;
hObject.String = num2str(VG_BandLimits(1,2),3);

plotGrafici(handles);


function LF_endEdit_Callback(hObject, eventdata, handles)
% hObject    handle to LF_endEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LF_endEdit as text
%        str2double(get(hObject,'String')) returns contents of LF_endEdit as a double
global VG_BandLimits;
global VG_fr_dec;

newValue = round(str2double(hObject.String),3);
if newValue < VG_BandLimits(2,1)
	newValue = VG_BandLimits(2,1);
end
if newValue > VG_fr_dec(end)
	newValue = VG_fr_dec(end);
end
VG_BandLimits(2,2) = newValue;
hObject.String = num2str(VG_BandLimits(2,2),3);

plotGrafici(handles);


function HF_endEdit_Callback(hObject, eventdata, handles)
% hObject    handle to HF_endEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HF_endEdit as text
%        str2double(get(hObject,'String')) returns contents of HF_endEdit as a double
global VG_BandLimits;
global VG_fr_dec;

newValue = round(str2double(hObject.String),3);
if newValue < VG_BandLimits(3,1)
	newValue = VG_BandLimits(3,1);
end
if newValue > VG_fr_dec(end)
	newValue = VG_fr_dec(end);
end
VG_BandLimits(3,2) = newValue;
hObject.String = num2str(VG_BandLimits(3,2),3);

plotGrafici(handles);


function VLF_startEdit_Callback(hObject, eventdata, handles)
% hObject    handle to VLF_startEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of VLF_startEdit as text
%        str2double(get(hObject,'String')) returns contents of VLF_startEdit as a double
global VG_BandLimits;
global VG_fr_dec;

newValue = round(str2double(hObject.String),3);
if newValue < VG_fr_dec(1)
	newValue = VG_fr_dec(1);
end
if newValue > VG_BandLimits(1,2)
	newValue = VG_BandLimits(1,2);
end
VG_BandLimits(1,1) = newValue;
hObject.String = num2str(VG_BandLimits(1,1),3);

plotGrafici(handles);


function LF_startEdit_Callback(hObject, eventdata, handles)
% hObject    handle to LF_startEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LF_startEdit as text
%        str2double(get(hObject,'String')) returns contents of LF_startEdit as a double
global VG_BandLimits;
global VG_fr_dec;

newValue = round(str2double(hObject.String),3);
if newValue < VG_fr_dec(1)
	newValue = VG_fr_dec(1);
end
if newValue > VG_BandLimits(2,2)
	newValue = VG_BandLimits(2,2);
end
VG_BandLimits(2,1) = newValue;
hObject.String = num2str(VG_BandLimits(2,1),3);

plotGrafici(handles);


function HF_startEdit_Callback(hObject, eventdata, handles)
% hObject    handle to HF_startEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of HF_startEdit as text
%        str2double(get(hObject,'String')) returns contents of HF_startEdit as a double
global VG_BandLimits;
global VG_fr_dec;

newValue = round(str2double(hObject.String),3);
if newValue < VG_fr_dec(1)
	newValue = VG_fr_dec(1);
end
if newValue > VG_BandLimits(3,2)
	newValue = VG_BandLimits(3,2);
end
VG_BandLimits(3,1) = newValue;
hObject.String = num2str(VG_BandLimits(3,1),3);

plotGrafici(handles);


% --- Executes when selected object is changed in DomainSelection.
function DomainSelection_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in DomainSelection 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch hObject.Tag
	case 'freqRadioBtn'
		handles.events_panel.Visible = 'off';
	case 'timeRadioBtn'
		handles.events_panel.Visible = 'on';
	otherwise
end
resetGrafici(handles);
plotGrafici(handles);










%% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function VLF_endEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VLF_endEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function LF_endEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LF_endEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit20_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function HF_endEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HF_endEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function VLF_startEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to VLF_startEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function LF_startEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LF_startEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function HF_startEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to HF_startEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%% MODIFICHE SAVERIO
% --- Executes on button press in pushbutton17.--------------**************
function pushbutton17_Callback(hObject, eventdata, handles)

global P_LF_NU_Taco
global P_HF_NU_Taco
global VG_taco
global T_Windows
global P_LF_Taco
global P_HF_Taco
global P_TOT_Taco;
global P_Coer;
global P_Incoer;
global PSD_parz_LF;
global PSD_parz_HF;
global PSD_parz_LF_NU;
global PSD_parz_HF_NU;

nWin = handles.nWin;
t_start = find(VG_taco(:,1) >= T_Windows(nWin,1), 1, 'first');
t_end = find(VG_taco(:,1) <= T_Windows(nWin,2), 1, 'last');
P = (10^6);

DATA_EXPORT=zeros(1,17);

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

%MEAN
%DATA_EXPORT(1,1) = round(mean(P_LF_Taco(t_start:t_end,1))*P, 3);
%DATA_EXPORT(1,2) = round(mean(P_HF_Taco_new(t_start:t_end,1))*P, 3);
%DATA_EXPORT(1,3) = round(mean(P_LF_Taco(t_start:t_end,1)./P_HF_Taco_new(t_start:t_end,1)), 3);
%DATA_EXPORT(1,4) = round(mean(P_TOT_Taco(t_start:t_end,1))*P, 3);
%DATA_EXPORT(1,5) = round(mean(P_LF_NU_Taco(t_start:t_end,1)), 3);
%DATA_EXPORT(1,6) = round(mean(P_HF_NU_Taco_new(t_start:t_end,1)), 3);
%DATA_EXPORT(1,7) = round(mean(P_LF_NU_Taco(t_start:t_end,1)./P_HF_NU_Taco_new(t_start:t_end,1)), 3);
%DATA_EXPORT(1,8) = 100;

%DATA_EXPORT(1,9) = round(mean(P_Coer_new(t_start:t_end,1))*P, 3);
%DATA_EXPORT(1,10) = round(mean(P_Incoer(t_start:t_end,1))*P, 3);
%DATA_EXPORT(1,11) = round(mean(P_Incoer(t_start:t_end,1)./P_Coer_new(t_start:t_end,1)),3);
%DATA_EXPORT(1,12) = round(mean(PSD_parz_HF_new(t_start:t_end,1))*P, 3);
%DATA_EXPORT(1,13) = round(mean(PSD_parz_LF(t_start:t_end,1))*P, 3);
%DATA_EXPORT(1,14) = round(mean(PSD_parz_LF(t_start:t_end,1)./PSD_parz_HF_new(t_start:t_end,1)),3);
%DATA_EXPORT(1,15) = round(mean(PSD_parz_HF_NU_new(t_start:t_end,1)), 3);
%DATA_EXPORT(1,16) = round(mean(PSD_parz_LF_NU(t_start:t_end,1)), 3);
%DATA_EXPORT(1,17) = round(mean(PSD_parz_LF_NU(t_start:t_end,1)./PSD_parz_HF_NU_new(t_start:t_end,1)),3);

%MEDIAN
DATA_EXPORT(1,1) = round(median(P_LF_Taco(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,2) = round(median(P_HF_Taco_new(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,3) = round(median(P_LF_Taco(t_start:t_end,1)./P_HF_Taco_new(t_start:t_end,1)), 3);
DATA_EXPORT(1,4) = round(median(P_TOT_Taco(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,5) = round(median(P_LF_NU_Taco(t_start:t_end,1)), 3);
DATA_EXPORT(1,6) = round(median(P_HF_NU_Taco_new(t_start:t_end,1)), 3);
DATA_EXPORT(1,7) = round(median(P_LF_NU_Taco(t_start:t_end,1)./P_HF_NU_Taco_new(t_start:t_end,1)), 3);
DATA_EXPORT(1,8) = 100;

DATA_EXPORT(1,9) = round(median(P_Coer_new(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,10) = round(median(P_Incoer(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,11) = round(median(P_Incoer(t_start:t_end,1)./P_Coer_new(t_start:t_end,1)),3);
DATA_EXPORT(1,12) = round(median(PSD_parz_HF_new(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,13) = round(median(PSD_parz_LF(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,14) = round(median(PSD_parz_LF(t_start:t_end,1)./PSD_parz_HF_new(t_start:t_end,1)),3);
DATA_EXPORT(1,15) = round(median(PSD_parz_HF_NU_new(t_start:t_end,1)), 3);
DATA_EXPORT(1,16) = round(median(PSD_parz_LF_NU(t_start:t_end,1)), 3);
DATA_EXPORT(1,17) = round(median(PSD_parz_LF_NU(t_start:t_end,1)./PSD_parz_HF_NU_new(t_start:t_end,1)),3);


%STD
DATA_EXPORT(1,18) = round(std(P_LF_Taco(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,19) = round(std(P_HF_Taco_new(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,20) = round(std(P_LF_Taco(t_start:t_end,1)./P_HF_Taco_new(t_start:t_end,1)), 3); 
DATA_EXPORT(1,21) = round(std(P_TOT_Taco(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,22) = round(std(P_LF_NU_Taco(t_start:t_end,1)), 3);
DATA_EXPORT(1,23) = round(std(P_HF_NU_Taco_new(t_start:t_end,1)), 3);
DATA_EXPORT(1,24) = round(std(P_LF_NU_Taco(t_start:t_end,1)./P_HF_NU_Taco_new(t_start:t_end,1)), 3);
DATA_EXPORT(1,25) = 100;

DATA_EXPORT(1,26) = round(std(P_Coer_new(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,27) = round(std(P_Incoer(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,28) = round(std(P_Incoer(t_start:t_end,1)./P_Coer_new(t_start:t_end,1)),3);
DATA_EXPORT(1,29) = round(std(PSD_parz_HF_new(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,30) = round(std(PSD_parz_LF(t_start:t_end,1))*P, 3);
DATA_EXPORT(1,31) = round(std(PSD_parz_LF(t_start:t_end,1)./PSD_parz_HF_new(t_start:t_end,1)),3);
DATA_EXPORT(1,32) = round(std(PSD_parz_HF_NU_new(t_start:t_end,1)), 3);
DATA_EXPORT(1,33) = round(std(PSD_parz_LF_NU(t_start:t_end,1)), 3);
DATA_EXPORT(1,34) = round(std(PSD_parz_LF_NU(t_start:t_end,1)./PSD_parz_HF_NU_new(t_start:t_end,1)),3);


DATA_EXPORT=array2table(DATA_EXPORT, 'VariableNames',{'LF_TACO','HF_TACO',...
        'LFHF_TACO','TOT_TACO','NLF_TACO','NHF_TACO',...
        'NLFNHF_TACO','NTOT_TACO','POT_COER','POT_INCOER','COER_INCOER',...
        'PSD_HF','PSD_LF','PSD_LFHF','PSD_NHF','PSD_NLF','PSD_NLFNHF',...
        'std_LF_TACO','std_HF_TACO',...
        'std_LFHF_TACO','std_TOT_TACO','std_NLF_TACO','std_NHF_TACO',...
        'std_NLFNHF_TACO','std_NTOT_TACO','std_POT_COER','std_POT_INCOER','std_COER_INCOER',...
        'std_PSD_HF','std_PSD_LF','std_PSD_LFHF','std_PSD_NHF','std_PSD_NLF','std_PSD_NLFNHF'});
    
[file,path]=uiputfile('*.mat','Export');

if (file==0)
    return;
end
        
file=fullfile(path,file);
save(file,'DATA_EXPORT');

    
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in TableBand.
function TableBand_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to TableBand (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
