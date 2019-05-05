function [EF_PS_NORM_LATENCY]=maling_respiro_beta1(ECG)


Fs=250;
xx=linspace(1,length(ECG),length(ECG));

%rileva picchi e cree un respirogramma
[pks,locs]=pan_tompkin(ECG,Fs,0);

respiro_invertito = max(abs(pks)) - abs(pks);  

start_time = 4.8828e-04;
tempo_auto = linspace(start_time,length(ECG)/250,length(ECG));
sig_respirogramma(:,1) = tempo_auto(locs(2:end));
sig_respirogramma(:,2) = respiro_invertito(2:end);

%%interpolazione
x=sig_respirogramma(:,1).*250;
y=sig_respirogramma(:,2)';
xq=linspace(1,length(ECG),length(ECG));
yq1 = interp1(x,y,xq);
ECG_peaks=yq1';

ECG_peaks(isnan(ECG_peaks))=0;


%% comincia analisi vera

%[EF]=butter_filt(ECG,0.2,0.4,2); %passabanda sulla banda del respiro con selezione ordine
%[EF]=filer_gain_no_selection_order2(ECG,0.2,0.6,1); %alto guadagno senza selezione ordine
%EF_PASSH=butter_filt_passH(EF,0.10,2); %un altro filtro per togliere le fq basse
%EF_PASSH=filer_gain_no_selection_order2(EF,0.15,0.6,1);
%[EF_NOTCH]=notch(EF_PASSH,45,70,2); %notch filter


[EF_PS]=butter_filt(ECG_peaks,0.12,0.52,2);

%figure(1);%stampa PSD tutti i segnali

%subplot(2,2,1); [PSD_E]=plot_PSD(ECG,Fs); %PSD ECG
%hold on; [PSD_R]=plot_PSD(RESP,Fs); title('tot'); %PSD RESP
%hold on; [PSD_EF_PS]=plot_PSD(EF_PS,Fs); title('tot'); %PSD peaks + butt
%hold on; [PSD_EF]=plot_PSD(EF,Fs); title('tot'); %PSD EF1
%hold on; [PSD_EF2]=plot_PSD(EF_PASSH,Fs); title('tot'); %PSD EF2
%hold on; [PSD_NOTCH]=plot_PSD(EF_NOTCH,Fs); title('tot'); %PSD NOTCH

%subplot(2,2,2); [PSD_E]=plot_PSD(ECG,Fs); title('ECG'); %PSD ECG

%subplot(2,2,3); [PSD_EF_PS]=plot_PSD(EF_PS,Fs); title('P+B'); %PSD peaks + butt
%subplot(2,2,3); [PSD_EF]=plot_PSD(EF,Fs); title('ECG_filt1/filt_2'); %PSD EF1
%hold on; [PSD_EF2H]=plot_PSD(EF_PASSH,Fs); title('ECG_filt1/filt_2'); %PSD EF2
%hold on; [PSD_NOTCH]=plot_PSD(EF_NOTCH,Fs); title('ECG_filt1/filt_2_notch'); %PSD NOTCH

%subplot(2,2,4); [PSD_R]=plot_PSD(RESP,Fs); title('RESP'); %PSD RESP


%figure(2); %stampa segnale RESP vero ed estratto in dominio tempo

%plot(RESP);
%hold on; plot(EF);
%EFH_GAIN(:)=EF_PASSH(:).*(1/0.02);
%EFH_GAIN(:)=EF_NOTCH(:).*(1/0.02); %gain per segnale troppo debole
%normalizzazione sulla mediana
%MEDIAN=median(EFH_GAIN);
%EFH_NORM=manorm(EFH_GAIN);
%EFH_GAIN2(:)=EFH_NORM(:).*(1/0.1); %sfasamento
%hold on; plot(EFH_GAIN,'color','g');


EF_PS_NORM=manorm(EF_PS);
EF_PS_NORM(:)=EF_PS_NORM(:).*0.0001;


%provare a compensare la latenza
EF_PS_NORM_LATENCY=zeros(length(EF_PS),1);

i=1; while(ECG_peaks(i)==0) i=i+1; end
dly=i;
%dly=1;

%sistemo latenza
for(i=dly:length(EF_PS))
    EF_PS_NORM_LATENCY(i)=EF_PS_NORM(i-dly+1);
end



clearvars -except EF_PS_NORM_LATENCY;
end


