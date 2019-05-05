function [PI,MI,AI] = indici_gfp(dati,fs,canaliPI_dx ,canaliPI_sx,canaliMI,canaliAI)

% INPUT:
% dati = segnale EEG (righe=canali, colonne=campioni)
% fs = frequenza di campionamento
% canaliPI_dx = canali per il calcolo di PI (elettrodi a dx)
% canaliPI_sx = canali per il calcolo di PI (elettrodi a sx)
% canaliMI = canali per il calcolo di MI
% canaliAI = canali per il calcolo di AI

% OUTPUT:
% PI = indice di piacevolezza
% MI = indice di memorizzazione
% AI = indice di attenzione

% bande per il filtraggio dei segnali EEG
teta=[4 7];
lalfa=[8 10];
halfa=[10 13];

% calcolo dei coefficienti dei filtri FIR
mags=[0 1 0];
devs = [0.05 0.5 0.05];

% banda teta
fcuts=[teta(1)-.2 teta(1) teta(2) teta(2)+.2];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fs);
n = n + rem(n,2);
coef_teta = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

% banda lower alpha
fcuts=[lalfa(1)-.2 lalfa(1) lalfa(2) lalfa(2)+.2];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fs);
n = n + rem(n,2);
coef_lalfa = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

% banda upper alpha
fcuts=[halfa(1)-.2 halfa(1) halfa(2) halfa(2)+.2];
[n,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,fs);
n = n + rem(n,2);
coef_halfa = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');

% filtraggio segnali EEG
EEG_teta=filtfilt(coef_teta,1,double(dati)');
dati_teta=EEG_teta'; 
EEG_lalfa=filtfilt(coef_lalfa,1,double(dati)');
dati_lalfa=EEG_lalfa';
EEG_halfa=filtfilt(coef_halfa,1,double(dati)');
dati_halfa=EEG_halfa';

% calcolo GFP e ne estraggio inviluppo tramite filtraggio passabasso
[b,a] = butter(5, 5/(fs/2), 'low'); %passabasso a 5Hz butterworth
% filtraggio a media mobile per smoothare i segnali (in modo
% analogo a quanto fatto per indice di engagement)
coef= ones(1, 1*(fs/2))/(1*(fs/2)); %finestra media mobile larga fs/2

% indice MI
[gfp_mem,gd] = eeg_gfp(dati_teta(canaliMI,:)',0);
MI=filtfilt(b,a,gfp_mem);
MI=filtfilt(coef,1,MI);

% indice AI
[gfp_att,gd] = eeg_gfp(dati_lalfa(canaliAI,:)',0);
AI=filtfilt(b,a,gfp_att);
AI= -AI;
AI=filtfilt(coef,1,AI); 

% indice PI
[gfp_pdx,gd] = eeg_gfp(dati_halfa(canaliPI_dx,:)',0);
[gfp_psx,gd] = eeg_gfp(dati_halfa(canaliPI_sx,:)',0);
PIdx=filtfilt(b,a,gfp_pdx);
PIdx=filtfilt(coef,1,PIdx);
PIsx=filtfilt(b,a,gfp_psx);
PIsx=filtfilt(coef,1,PIsx);
PI=PIdx-PIsx;
