function [EI] = indice_engagement_new(dati,fs,canaliEI)

% INPUT:
% dati = segnale EEG (righe=canali, colonne=campioni)
% fs = frequenza di campionamento
% canaliEI = canali per il calcolo di EI

% OUTPUT:
% EI = indice di engagement

% bande per il filtraggio dei segnali EEG
alfa=[8 13];
beta=[13 22];

% calcolo dei coefficienti dei filtri FIR
mags=[0 1 0];
devs = [0.05 0.5 0.05];

% banda alfa
fcuts=[alfa(1)-.2 alfa(1) alfa(2) alfa(2)+.2];
[n,Wn,be,ftype] = kaiserord(fcuts,mags,devs,fs); %estrae coefficienti per reare un filtro di kaiser
n = n + rem(n,2); %calcola il resto della divisione
coef_alfa = fir1(n,Wn,ftype,kaiser(n+1,be),'noscale');

% banda beta
fcuts=[beta(1)-.2 beta(1) beta(2) beta(2)+.2];
[n,Wn,be,ftype] = kaiserord(fcuts,mags,devs,fs);
n = n + rem(n,2);
coef_beta = fir1(n,Wn,ftype,kaiser(n+1,be),'noscale');

% verifica della risposta in frequenza dei filtri OK
%         figure
%         [h1,w1] = freqz(coef_alfa);
%         [h2,w2] = freqz(coef_beta);
%         plot((w1/pi)*fs/2,abs(h1),(w1/pi)*fs/2,abs(h2),'r')

% filtraggio segnali EEG
EEG_alfa=filtfilt(coef_alfa,1,double(dati)');
dati_alfa=EEG_alfa'; 
EEG_beta=filtfilt(coef_beta,1,double(dati)');
dati_beta=EEG_beta';

% quadratura del segnale per ottenre la potenza
dati_alfa=dati_alfa.^2;
dati_beta=dati_beta.^2;

% somma della potenza per i diversi canali
coef= ones(1, 1*(fs/2))/(1*(fs/2)); %finestra media mobile larga fs/2
% pow_alfa=sum(dati_alfa(canaliEI,:),1);
% pow_beta=sum(dati_beta(canaliEI,:),1);
pow_alfa=filtfilt(coef ,1, sum(dati_alfa(canaliEI,:),1) );
pow_beta=filtfilt(coef,1,sum(dati_beta(canaliEI,:),1));

EI = pow_beta ./ pow_alfa;





