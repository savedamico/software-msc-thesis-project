function [filtered_signal]=filer_gain_no_selection_order2(signal,b1,b2,gain);


Fs = 250;
Fn = Fs/2;
Wp = [b1 b2]/Fn;
Ws = [0.1*0.95 1/0.95]/Fn;
Rp =   gain;     %selezionato all'inizio                                              % Passband Ripple (dB)
Rs = 20;                                                   % stopband ripple (dB)
[n,Wn] = buttord(Wp,Ws,Rp,Rs);  
[z,p,k] = butter(n,Wn); 
[sosbp,gbp] = zp2sos(z,p,k);                %zp2sos(z,p,k); 
%Fcp_low=0.2;  %lower cutoff frequency
%Fcp_high=0.4;  %higher cutoff frequency
%[z,p,k]=butter(1,[Fcp_low Fcp_high]/(fs_ecg/2),'bandpass');
%[sos,g]=zp2sos(z,p,k);
%fvtool(sos,'Analysis','freq')
filtered_signal=filtfilt(sosbp,gbp,signal);


end