function [delta,theta,alpha,beta,Y,sigma]=filter_eeg_paper(signal,order,fs)

% Filter which separates an eeg signal in its different frequencial
% components delta = 0-4, theta = 4-8, alpha = 8-12, sigma = 12.5-14.5 and beta 15-30 Hz



%% Low-pass antialiasing
cut1=30; 
B=fir1(order,cut1/(fs/2));
Y=filter(B,1,signal);


%% Lowpass delta wave 0-4 Hz
cut2=4;
B2=fir1(order,[0.001 cut2/(fs/2)]);
delta=filter(B2,1,Y);

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

%% Band-pass sigma wave 12.5-14.5 Hz

cut4b=12.5;
cut4a=14.5;
B6=fir1(order,[cut4b/(fs/2) cut4a/(fs/2)],'bandpass',kaiser(order+1,1));
sigma=filter(B6,1,Y);

%% High-pass beta wave 15-30 Hz

cut5=15;
B5=fir1(order,cut5/(fs/2),'high');
b5=roots(B5);
beta=filter(B5,1,Y);

