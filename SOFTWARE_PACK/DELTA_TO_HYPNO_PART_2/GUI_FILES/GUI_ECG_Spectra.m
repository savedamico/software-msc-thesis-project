function varargout = GUI_ECG_Spectra(varargin)
% GUI_ECG_SPECTRA MATLAB code for GUI_ECG_Spectra.fig
%      GUI_ECG_SPECTRA, by itself, creates a new GUI_ECG_SPECTRA or raises the existing
%      singleton*.
%
%      H = GUI_ECG_SPECTRA returns the handle to a new GUI_ECG_SPECTRA or the handle to
%      the existing singleton*.
%
%      GUI_ECG_SPECTRA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ECG_SPECTRA.M with the given input arguments.
%
%      GUI_ECG_SPECTRA('Property','Value',...) creates a new GUI_ECG_SPECTRA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_ECG_Spectra_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_ECG_Spectra_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_ECG_Spectra

% Last Modified by GUIDE v2.5 21-Dec-2017 14:42:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_ECG_Spectra_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_ECG_Spectra_OutputFcn, ...
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


% --- Executes just before GUI_ECG_Spectra is made visible.
function GUI_ECG_Spectra_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_ECG_Spectra (see VARARGIN)

% Choose default command line output for GUI_ECG_Spectra
handles.output = hObject;

handles.temp = -1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_ECG_Spectra wait for user response (see UIRESUME)
% uiwait(handles.figure1);

plotImageAxes(handles);
plotTimeAxes(handles);

global VG_eventi;
global etichette_ev;
global VG_fs;
global VG_taco;
plot_eventi([] ,handles.eventAxes,VG_eventi,etichette_ev,VG_fs, true);
handles.eventAxes.XLim = [0 VG_taco(end,1)];
handles.eventAxes.YTick = [];

global VG_BandLimits;
handles.endVLF.String = num2str(VG_BandLimits(1,2),3);
handles.endLF.String = num2str(VG_BandLimits(2,2),3);
handles.endHF.String = num2str(VG_BandLimits(3,2),3);
handles.startVLF.String = num2str(VG_BandLimits(1,1),3);
handles.startLF.String = num2str(VG_BandLimits(2,1),3);
handles.startHF.String = num2str(VG_BandLimits(3,1),3);


function plotImageAxes(handles)
global VG_S1;
global VG_taco;
global VG_S2;
global VG_resp;
global VG_MSC;
global VG_fr_dec;
global VG_BandLimits;


cla(handles.TacoSpectrumAxes, 'reset');
cla(handles.RespSpectrumAxes, 'reset');
cla(handles.QuadraticCoherenceAxes, 'reset');

axes(handles.TacoSpectrumAxes);
sigmaTacoLimit = std(VG_taco(:,2))/2;
TacoSpectrum = min(VG_S1, sigmaTacoLimit);
imagesc('XData',VG_taco(:,1),'YData',VG_fr_dec, 'CData',TacoSpectrum');
axis([0 VG_taco(end,1) 0 VG_fr_dec(end)]);
ylabel('Freq [Hz]');
title('Taco Spectrum');
hold on;
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(2,1), 'r');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(2,2), 'r');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(3,1), 'w');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(3,2), 'w');

axes(handles.RespSpectrumAxes);
sigmaRespLimit = std(VG_resp(:,2));
RespSpectrum = min(VG_S2, sigmaRespLimit);
imagesc('XData',VG_resp(:,1),'YData',VG_fr_dec, 'CData',RespSpectrum');
axis([0 VG_resp(end,1) 0 VG_fr_dec(end)]);
ylabel('Freq [Hz]');
title('Resp Spectrum');
hold on;
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(2,1), 'r');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(2,2), 'r');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(3,1), 'w');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(3,2), 'w');

axes(handles.QuadraticCoherenceAxes);
imagesc('XData',VG_taco(:,1),'YData',VG_fr_dec, 'CData',VG_MSC');
axis([0 VG_taco(end,1) 0 VG_fr_dec(end)]);
xlabel('Time [s]');
ylabel('Freq [Hz]');
title('Coherence');
hold on;
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(2,1), 'r');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(2,2), 'r');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(3,1), 'w');
plot(VG_taco(:,1), ones(1, size(TacoSpectrum, 1))*VG_BandLimits(3,2), 'w');


function plotTimeAxes(handles)
global VG_S1;
global VG_S2;
global VG_MSC;
global VG_S1_coer;
global VG_S2_coer;
global VG_fr_dec;
global VG_taco;
global VG_BandLimits;
global VG_PSD11;
global VG_PSD12;
global VG_PSD21;
global VG_PSD22;

cla(handles.TacoSpectrumTimeAxes, 'reset');
cla(handles.RespSpectrumTimeAxes, 'reset');
cla(handles.QuadraticCoherenceTimeAxes, 'reset');

if handles.temp>0 && handles.temp<=length(VG_taco(:,1))
    handles.panelTimeAxes.Title = ['T = ', num2str(round(VG_taco(handles.temp, 1))), 's'];
    
    axes(handles.TacoSpectrumTimeAxes);
    hold on;
    pTotTaco = area(VG_fr_dec, VG_S1(handles.temp,:), 'FaceColor', 'w');
    pCoerTaco = area(VG_fr_dec, VG_PSD12(handles.temp,:), 'FaceColor', 'k');
    title('Taco Spectrum');
    ylabel('PSD [s^2/Hz]');
    xlim([VG_fr_dec(1), VG_fr_dec(end)]);
    yLimits = get(handles.TacoSpectrumTimeAxes,'ylim');
    area([VG_BandLimits(1,1) VG_BandLimits(1,2)], [1.1 1.1]*max(yLimits), 'FaceColor','g', 'FaceAlpha',0.2);
    area([VG_BandLimits(2,1) VG_BandLimits(2,2)], [1.1 1.1]*max(yLimits), 'FaceColor','b', 'FaceAlpha',0.2);
    area([VG_BandLimits(3,1) VG_BandLimits(3,2)], [1.1 1.1]*max(yLimits), 'FaceColor','r', 'FaceAlpha',0.2);
	legend([pTotTaco pCoerTaco], {'PSDtaco','PSDtaco/resp'}, 'Location','northeast');
    ylim(yLimits);
    hold off;
	ch = handles.TacoSpectrumTimeAxes.Children;
	handles.TacoSpectrumTimeAxes.Children = [ch(4:5); ch(1:3)];

    axes(handles.RespSpectrumTimeAxes);
    hold on;
    pTotResp = area(VG_fr_dec, VG_S2(handles.temp,:), 'FaceColor', 'w');
    pCoerResp = area(VG_fr_dec, VG_PSD22(handles.temp,:), 'FaceColor', 'k');
    title('Resp Spectrum');
    ylabel('PSD [s^2/Hz]');
    xlim([VG_fr_dec(1), VG_fr_dec(end)]);
    yLimits = get(handles.RespSpectrumTimeAxes,'ylim');
    area([VG_BandLimits(1,1) VG_BandLimits(1,2)], [1.1 1.1]*max(yLimits), 'FaceColor','g', 'FaceAlpha',0.2);
    area([VG_BandLimits(2,1) VG_BandLimits(2,2)], [1.1 1.1]*max(yLimits), 'FaceColor','b', 'FaceAlpha',0.2);
    area([VG_BandLimits(3,1) VG_BandLimits(3,2)], [1.1 1.1]*max(yLimits), 'FaceColor','r', 'FaceAlpha',0.2);
 	legend([pTotResp pCoerResp], {'PSDresp','PSDresp/resp'}, 'Location','northeast');
    ylim(yLimits);
    hold off;
	ch = handles.RespSpectrumTimeAxes.Children;
	handles.RespSpectrumTimeAxes.Children = [ch(4:5); ch(1:3)];

    axes(handles.QuadraticCoherenceTimeAxes);
    hold on;
    area(VG_fr_dec, VG_MSC(handles.temp,:), 'FaceColor', 'w');
    xlim([VG_fr_dec(1), VG_fr_dec(end)]);
    title('Coherence');
    xlabel('Freq [Hz]');
    ylabel('A.U.');
    yLimits = get(handles.QuadraticCoherenceTimeAxes,'ylim');
    area([VG_BandLimits(1,1) VG_BandLimits(1,2)], [1.1 1.1]*max(yLimits), 'FaceColor','g', 'FaceAlpha',0.2);
    area([VG_BandLimits(2,1) VG_BandLimits(2,2)], [1.1 1.1]*max(yLimits), 'FaceColor','b', 'FaceAlpha',0.2);
    area([VG_BandLimits(3,1) VG_BandLimits(3,2)], [1.1 1.1]*max(yLimits), 'FaceColor','r', 'FaceAlpha',0.2);
    ylim(yLimits);
    hold off;
	ch = handles.QuadraticCoherenceTimeAxes.Children;
	handles.QuadraticCoherenceTimeAxes.Children = [ch(4); ch(1:3)];
end


% --- Outputs from this function are returned to the command line.
function varargout = GUI_ECG_Spectra_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ViewTimeBtn.
function ViewTimeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to ViewTimeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_Ts;

askUser = true;
while askUser
	[x,~, btn] = ginput(1);
	if (btn == 2) || (btn == 3)
		%se l'utente ha premuto il tasto destro termina (la risposta di ginput cambia in base al numero di bottoni del mouse)
		askUser = false;
	elseif btn == 1
		%se l'utente ha premuto il tasto sinistro plotta il punto, negli altri casi ignora l'input ricevuto
		handles.temp = round(x/VG_Ts);
        guidata(hObject, handles);
        plotTimeAxes(handles);
	end
end


% --- Executes on button press in TimeGraphBtn.
function TimeGraphBtn_Callback(hObject, eventdata, handles)
% hObject    handle to TimeGraphBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_taco;
global VG_S1;
global VG_S1_coer;
global P_LF_Taco;
global P_HF_Taco;
global VG_fr_dec;
global VG_PSD11;
global VG_PSD12;
global VG_PSD21;
global VG_PSD22;

global VG_eventi;
global etichette_ev;
global VG_fs;

figure;

potWin = 1:size(VG_S1, 1);

% Componenti Respiro-dipendenti
x1 = subplot(3,1,1);
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
xlim([0 VG_taco(end,1)]);
title('Componenti Respiro dipendenti');

% Componenti Respiro-indipendenti
x2 = subplot(3,1,2);
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
	xlim([0 VG_taco(end,1)]);
title('Componenti Respiro indipendenti');

% Rapporto indipendenti/dipendendti
x3 = subplot(3,1,3);
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
xlim([0 VG_taco(end,1)]);
title('Rapporto Simpato-Vagale');
xlabel('Time [s]');

%%% EVENTI
plot_eventi([],x1,VG_eventi,etichette_ev,VG_fs,true);
plot_eventi([],x2,VG_eventi,etichette_ev,VG_fs,true);
plot_eventi([],x3,VG_eventi,etichette_ev,VG_fs,true);


% --- Executes on button press in bandResetBtn.
function bandResetBtn_Callback(hObject, eventdata, handles)
% hObject    handle to bandResetBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global VG_BandLimits;
global VG_defaultBandLimits;
VG_BandLimits = VG_defaultBandLimits;

handles.endVLF.String = num2str(VG_BandLimits(1,2),3);
handles.endLF.String = num2str(VG_BandLimits(2,2),3);
handles.endHF.String = num2str(VG_BandLimits(3,2),3);
handles.startVLF.String = num2str(VG_BandLimits(1,1),3);
handles.startLF.String = num2str(VG_BandLimits(2,1),3);
handles.startHF.String = num2str(VG_BandLimits(3,1),3);

plotImageAxes(handles);
plotTimeAxes(handles);


% --- Executes on button press in bandSaveBtn.
function bandSaveBtn_Callback(hObject, eventdata, handles)
% hObject    handle to bandSaveBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pfGUIECG;
global VG_BandLimits;
bandLimits = VG_BandLimits; %#ok<NASGU>
save(pfGUIECG, 'bandLimits', '-append');
BandExtrapolation();


function endVLF_Callback(hObject, eventdata, handles)
% hObject    handle to endVLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endVLF as text
%        str2double(get(hObject,'String')) returns contents of endVLF as a double
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

plotImageAxes(handles);
plotTimeAxes(handles);


function endLF_Callback(hObject, eventdata, handles)
% hObject    handle to endLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endLF as text
%        str2double(get(hObject,'String')) returns contents of endLF as a double
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

plotImageAxes(handles);
plotTimeAxes(handles);


function endHF_Callback(hObject, eventdata, handles)
% hObject    handle to endHF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of endHF as text
%        str2double(get(hObject,'String')) returns contents of endHF as a double
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

plotImageAxes(handles);
plotTimeAxes(handles);


function startVLF_Callback(hObject, eventdata, handles)
% hObject    handle to startVLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startVLF as text
%        str2double(get(hObject,'String')) returns contents of startVLF as a double
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

plotImageAxes(handles);
plotTimeAxes(handles);


function startLF_Callback(hObject, eventdata, handles)
% hObject    handle to startLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startLF as text
%        str2double(get(hObject,'String')) returns contents of startLF as a double
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

plotImageAxes(handles);
plotTimeAxes(handles);


function startHF_Callback(hObject, eventdata, handles)
% hObject    handle to startHF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of startHF as text
%        str2double(get(hObject,'String')) returns contents of startHF as a double
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

plotImageAxes(handles);
plotTimeAxes(handles);


% --- Executes during object creation, after setting all properties.
function endVLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endVLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function endLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function endHF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to endHF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function startVLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startVLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function startLF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startLF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function startHF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startHF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function textStart_Callback(hObject, eventdata, handles)
% hObject    handle to textStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of textStart as text
%        str2double(get(hObject,'String')) returns contents of textStart as a double


% --- Executes during object creation, after setting all properties.
function textStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function textEnd_Callback(hObject, eventdata, handles)
% hObject    handle to textEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of textEnd as text
%        str2double(get(hObject,'String')) returns contents of textEnd as a double


% --- Executes during object creation, after setting all properties.
function textEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
