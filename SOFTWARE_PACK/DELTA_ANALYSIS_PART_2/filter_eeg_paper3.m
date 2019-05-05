function [delta, DELTA,theta,alpha,beta,BETA,Y,sigma]=filter_eeg_paper3(signal,order,fs)

% Filter which separates an eeg signal in its different frequencial
% components delta = 0-4, theta = 4-8, alpha = 8-12, sigma = 12.5-14.5 and
% beta 15-30 Hz

%% Low-pass antialiasing
cut1=30; 
B=fir1(order,cut1/(fs/2));
Y=filter(B,1,signal);


%% Bandpass delta wave 1-2 Hz
cut2b=1;
cut2a=2;
B2=fir1(order,[cut2b/(fs/2) cut2a/(fs/2)],'bandpass',kaiser(order+1,1));
delta=filter(B2,1,Y);

%% Band-pass high delta wave 2-4 Hz
cut8b=2;
cut8a=4;
B8=fir1(order,[cut8b/(fs/2) cut8a/(fs/2)],'bandpass',kaiser(order+1,1));
DELTA=filter(B8,1,Y);

%% Band-pass theta wave 4-8 Hz
cut3b=4;
cut3a=8;
B3=fir1(order,[cut3b/(fs/2) cut3a/(fs/2)],'bandpass',kaiser(order+1,1));
theta=filter(B3,1,Y);

%% Band-pass alpha wave 8-12 Hz

cut4b=8;
cut4a=12;
B4=fir1(order,[cut4b/(fs/2) cut4a/(fs/2)],'bandpass',kaiser(order+1,1));
alpha=filter(B4,1,Y);

%% Band-pass sigma wave 12-16 Hz

cut5b=12;
cut5a=16;
B5=fir1(order,[cut5b/(fs/2) cut5a/(fs/2)],'bandpass',kaiser(order+1,1));
sigma=filter(B5,1,Y);

%% Band-pass beta1 wave 16-18 Hz

cut6b=16;
cut6a=18;
B6=fir1(order,[cut6b/(fs/2) cut6a/(fs/2)],'bandpass',kaiser(order+1,1));
beta=filter(B6,1,Y);
%% High-pass beta2 wave 18-30 Hz

cut7=18;
B7=fir1(order,cut7/(fs/2),'high');
BETA=filter(B7,1,Y);

